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

function randname() {
    local -a words=(
        # Qualities
        ancient bold bright calm clever crispy daring deep deft eager
        elegant fierce fluent frosty gentle golden grand hardy hidden
        humble hushed icy jolly kind lively lone lucky mighty misty
        muted noble odd pale plain proud quiet rapid raspy rugged
        rustic serene sharp silent silver sleek slim slow smooth soft
        solid sonic spare steady still stout strong subtle swift tall
        tender thin tidy tiny tough true vast vivid warm wild windy
        wise witty woven young
        # Nature
        amber ash birch brook cedar cliff cloud coast coral creek dale
        dawn delta dew drift dune dust echo ember fern field fjord
        flame flint fog forest frost gale glade glen grove gulf haven
        heath hill inlet isle jade kelp knoll lake larch leaf ledge
        marsh mesa mist moon moor moss oak opal peak pine pond pool
        quartz rain reed ridge rift river rock root rush sage sand
        shore sky slate snow soil spring stone stream summit
        surf thicket tide timber tundra vale vapor wave willow wind
        # Objects
        anchor anvil arrow axle beacon bell blade bolt bridge buckle
        candle canvas chain charm chisel cipher cog coil compass
        copper crown crystal dial dome drum engine feather flare flask
        forge fulcrum gear hammer harbor helm hull iron jar key
        keystone lantern latch lever lock loom mast mill mirror needle
        node oar orbit piston pivot plank prism pulley rafter rail
        relay rivet rudder rune sail scale seal shaft signal socket
        spoke spur staff stamp steel striker torch tower truss valve
        vault vane vessel wheel wrench
    )

    local usage="Usage: randname [N]
  N  number of words (default: 3, minimum: 2)
  -h, --help  show this help"

    # Handle -h/--help before positional args
    if [[ $# -gt 0 && ( $1 == -h || $1 == --help ) ]]; then
        print "$usage"
        return 0
    fi

    # Handle -- (stop option parsing)
    if [[ $# -gt 0 && $1 == -- ]]; then
        shift
    fi

    local n=${1:-3}

    # Validate: must be all digits
    if [[ $n != <-> ]]; then
        print "N must be a positive integer" >&2
        print "$usage" >&2
        return 1
    fi

    # Validate: must be >= 2
    if (( n < 2 )); then
        print "N must be at least 2" >&2
        print "$usage" >&2
        return 1
    fi

    # Validate: must not exceed pool
    if (( n > ${#words} )); then
        print "N exceeds word pool size (max: ${#words})" >&2
        print "$usage" >&2
        return 1
    fi

    local -a pool=("${words[@]}")
    local -a result=()
    local idx

    for (( i = 0; i < n; i++ )); do
        idx=$(( RANDOM % ${#pool} + 1 ))
        result+=("$pool[$idx]")
        pool[$idx]=()
    done

    print "${(j:-:)result}"
}
