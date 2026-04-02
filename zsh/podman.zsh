# Podman Desktop
# DMG installed version
#

local PODMAN_ROOT="/opt/podman"

if [[ -d "$PODMAN_ROOT" ]];
then
  typeset -U path
  typeset -U manpath
  path=("$PODMAN_ROOT/bin" $path)
  manpath=("$PODMAN_ROOT/docs/man" $manpath)
fi
