#!/usr/bin/env bash
# Call this script with at least 1 parameter: the video code
# e.g. "uebInqG1pJI" from the URL: "http://www.youtube.com/watch?v=uebInqG1pJI"

# For all the arguments (IDs of youtube videos) download and generate a mp3 file
if [ $# -lt 1 ]; then
    echo "Usage: $0 url1 url2 ..."
    exit 1
fi

BASE_URL=http://www.youtube.com/watch?v

for arg in "$@"
do
    echo "- video ID:: $arg - "
    case $arg in
        $BASE_URL*)
            $echo "Complete URL"
            COMPLETE_URL=$arg
            VIDEO_NAME=`echo "$COMPLETE_URL" | cut --delimiter="=" --fields=2`
            ;;
        *)
            COMPLETE_URL=$BASE_URL=$arg
            VIDEO_NAME=$arg
    esac
    youtube-dl $COMPLETE_URL &&
        ffmpeg -i $VIDEO_NAME.flv $VIDEO_NAME.mp3 &&
            rm $VIDEO_NAME.flv
done 

# Normalize all the mp3 files in this folder
find . -type d -exec sh -c "cd \"{}\" && mp3gain -r -T *.mp3" \;

exit 0 
