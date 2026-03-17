function httpless {
    # `httpless example.org'
    http --pretty=all --verbose "$@" | less -R;
}

# mdls is a macOS application for listing file metadata attributes
# mdid for easily getting bundle identifiers, useful with `open` cmd
function mdid() {
    if [[ -e "$1" ]]; then
        local cmd=(mdls -raw -attr kMDItemCFBundleIdentifier "$1")
        print "\e[2m${(j: :)${(q-)cmd[@]}}\e[0m"
        "${cmd[@]}"
        echo
    else
        echo "Please supply a filepath as an argument"
    fi
}

# Core Kagi service bangs — Kagi's own features, not site-specific searches.
# Shared between kagi() and _kagi completion.
_kagi_core_bangs=(
    # Search modes
    'i:Kagi Images'
    'n:Kagi News'
    'v:Kagi Videos'
    'm:Kagi Maps'
    # AI / answers
    'ai:Kagi AI Assistant'
    'chat:Kagi AI Assistant'
    'fgpt:FastGPT quick answer'
    'quick:Quick Answer'
    # Translation
    'tr:Translate (auto-detect language)'
    'kt:Kagi Translate'
    'kdic:Kagi Translate — Dictionary'
    'kpr:Kagi Translate — Proofread'
    # Summarizer
    'sum:Summarize a URL'
    'summ:Summarize a URL (paragraph summary)'
    'sumt:Summarize a URL (key moments / takeaways)'
    # Time filters
    '24:Results from the past 24 hours'
    'week:Results from the past week'
    'month:Results from the past month'
    'year:Results from the past year'
    # Search options
    'safe:Safe search on'
    'safeoff:Safe search off'
    'html:No-JavaScript search'
    # Help
    'help:Kagi Knowledgebase'
    'orion:Orion browser knowledgebase'
)

function kagi() {
    local bang=""
    local print_url=0
    local -a args

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -b|--bang)
                bang="$2"
                shift 2
                ;;
            -p|--print)
                print_url=1
                shift
                ;;
            -h|--help)
                echo "Usage: kagi [-b <bang>] [-p] <search terms>"
                echo "       kagi -l"
                echo ""
                echo "Options:"
                echo "  -b, --bang <bang>  Bang shortcut for Kagi or external site"
                echo "  -p, --print        Print the URL instead of opening it"
                echo "  -h, --help         Show this help"
                echo "  -l, --list         List core Kagi bangs"
                return 0
                ;;
            -l|--list)
                echo "Core Kagi bangs:"
                for entry in $_kagi_core_bangs; do
                    printf "  %-12s %s\n" "${entry%%:*}" "${entry#*:}"
                done
                return 0
                ;;
            --)
                shift
                args+=("$@")
                break
                ;;
            *)
                args+=("$1")
                shift
                ;;
        esac
    done

    local query=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote_plus(sys.argv[1]),end='')" "${(j: :)args}")
    if [[ -z "$query" && -z "$bang" ]]; then
        echo "Usage: kagi [-b <bang>] <search terms>"
        echo "Run 'kagi -h' for help or 'kagi -l' to list core bangs."
        return 1
    fi

    local url
    if [[ -n "$bang" ]]; then
        url="https://kagi.com/search?q=!${bang}+${query}"
    else
        url="https://kagi.com/search?q=${query}"
    fi

    if [[ $print_url -eq 1 ]]; then
        print "$url"
    else
        open "$url"
    fi
}

# What's running on a port
function wop() {
    local cmd=(lsof -P -i ":$1" -n)
    print "\e[2m${(j: :)${(q-)cmd[@]}}\e[0m"
    "${cmd[@]}"
    local exitcode=$?
    if [[ $exitcode -ne 0 ]]; then
        echo "Nothing listening on port $1"
    fi
    return $exitcode
}
