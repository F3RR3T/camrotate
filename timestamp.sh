#!/usr/bin/bash
# Extract timestamp from exif data and write it on the photo.
# Called from another script (camfreshen.sh)
# SJP 6 Feb 2017

function timestamp {
	# Grab the timestamp
	timestamp=" $(identify -format '%[exif:datetime]' ${1})"
    echo ${1}: timestamp = [${timestamp}]

	# Add the text to the image
	# stolen from:
	# http://www.imagemagick.org/Usage/annotating/
	convert -font DejaVu-Sans-Mono -pointsize 36 -size 600x100 xc:none -gravity west\
		-stroke black -strokewidth 2 -annotate 0 "${timestamp}" \
		-background none -shadow 100x4+0+0 +repage \
		-stroke none -fill yellow -annotate 0 "${timestamp}" \
		${1} +swap -gravity southwest -geometry +1-3 \
		-composite ${1}
}
