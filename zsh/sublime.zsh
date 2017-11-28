SUBL_PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"

if ! type subl > /dev/null && [[ -f $SUBL_PATH ]]; then
   alias subl="'$SUBL_PATH'";
fi
