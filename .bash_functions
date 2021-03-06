# Upgrade global (user) pip commands
# I don't install system wide global python packages via pip
# All my python packages go into my $HOME/.local/lib instead
# This way I avoid breaking packages installed by the OS packaging system
gpip2(){
   PIP_REQUIRE_VIRTUALENV="" pip2 "$@" --user
}
gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@" --user
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
  local port="${1:-8000}"
  echo "http://localhost:8000"
  python -m SimpleHTTPServer "$port"
}

# matrix fun
function hax0r() {
    perl -e '$|++; while (1) { print " " x (rand(35) + 1), int(rand(2)) }'
}

# get the process on a given port
function port() {
  lsof -i ":${1:-80}"
}

# show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
    if [ -z "${1}" ]; then
        echo "ERROR: No domain specified."
        return 1
    fi

    local domain="${1}"
    echo "Testing ${domain}…"
    echo # newline

    local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
        | openssl s_client -connect "${domain}:443" 2>&1);

    if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
        local certText=$(echo "${tmp}" \
            | openssl x509 -text -certopt "no_header, no_serial, no_version, \
            no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux");
            echo "Common Name:"
            echo # newline
            echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//";
            echo # newline
            echo "Subject Alternative Name(s):"
            echo # newline
            echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
                | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
            return 0
    else
        echo "ERROR: Certificate not found.";
        return 1
    fi
}

# compare original and gzipped file size
function gz() {
    local origsize=$(wc -c < "$1")
    local gzipsize=$(gzip -c "$1" | wc -c)
    local ratio=$(echo "$gzipsize * 100/ $origsize" | bc -l)
    printf "orig: %d bytes\n" "$origsize"
    printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# all the dig info
function digga() {
    dig +nocmd "$1" any +multiline +noall +answer
}

# escape UTF-8 characters into their 3-byte format
function escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo # newline
    fi
}

# decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo # newline
    fi
}

# get a character’s Unicode code point
function codepoint() {
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo # newline
    fi
}

# simple calculator
function calc() {
    local result=""
    result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
    #                       └─ default (when `--mathlib` is used) is 20
    #
    if [[ "$result" == *.* ]]; then
        # improve the output for decimal numbers
        printf "$result" |
        sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
            -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
            -e 's/0*$//;s/\.$//'   # remove trailing zeros
    else
        printf "$result"
    fi
    printf "\n"
}

# create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$@"
}

# create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
    local tmpFile="${@%/}.tar"
    tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1

    size=$(
        stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
        stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
    )

    local cmd=""
    if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
        # the .tar file is smaller than 50 MB and Zopfli is available; use it
        cmd="zopfli"
    else
        if hash pigz 2> /dev/null; then
            cmd="pigz"
        else
            cmd="gzip"
        fi
    fi

    echo "Compressing .tar using \`${cmd}\`…"
    "${cmd}" -v "${tmpFile}" || return 1
    [ -f "${tmpFile}" ] && rm "${tmpFile}"
    echo "${tmpFile}.gz created successfully."
}

# determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@"
    else
        du $arg .[^.]* *
    fi
}

# useful command for stripping whitespace
function remove_trailing_whitespace() {
  find . -name $* -exec sed -i '' -e's/[[:space:]]*$//' {} \;
}

# get the local vm ip
function vm-ip() {
  VM="$1"
  arp -an | grep "`virsh dumpxml $VM | grep "mac address" | sed "s/.*'\(.*\)'.*/\1/g"`" | awk '{ gsub(/[\(\)]/,"",$2); print $2 }'
}

function vm-uuid() {
    VM="$1"
    uuid=$(virsh dumpxml $VM | grep "<uuid" | sed "s/.*<uuid>\(.*\)<\/uuid>.*/\1/g" );
    echo $uuid
}

function vm-mem() {
    VM="$1"
    mem=$(virsh dumpxml $VM | grep "<memory" | sed "s/.*<memory unit='KiB'>\(.*\)<\/memory>.*/\1/g" );
    echo $( expr $mem / 1024 )
}

function vm-currmem() {
    VM="$1"
    mem=$(virsh dumpxml $VM | grep "<currentMemory" | sed "s/.*<currentMemory unit='KiB'>\(.*\)<\/currentMemory>.*/\1/g" );
    echo $( expr $mem / 1024 )
}

function vm-vcpu() {
    VM="$1"
    vcpu=$(virsh dumpxml $VM | grep "<vcpu" | sed "s/.*<vcpu[^>]*>\(.*\)<\/vcpu>.*/\1/g" );
    echo $vcpu
}

function vm-info() {
    echo "------------------------------------------------------------------------------------------------------------------------";
    printf "%-30s%-17s%-12s%-12s%-8s%-40s\n" "VM Name" "IP Address" "Memory" "Current" "VCPUs" "UUID";
    virsh list --all | grep -o '[0-9]* [a-z]*.*running' | while read -r line;
    do
        line_cropped=$(echo "$line" | sed 's/[0-9][ ]*\([-._0-9a-zA-Z]*\)[ ]*running/\1/' );
        printf "%-30s%-17s%-12s%-12s%-8s%-40s\n" "$line_cropped" $( vm-ip "$line_cropped" ) $( vm-mem $line ) $( vm-currmem $line ) $( vm-vcpu $line ) $( vm-uuid $line );
    done;
    echo "------------------------------------------------------------------------------------------------------------------------";
}
