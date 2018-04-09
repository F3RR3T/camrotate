#! /bin/bash

#  grab a pic from paddock cam and post it to a website.

moviedir=/home/st33v/farm/cam/mov
webpixrootdir=/data/pix

cd ${moviedir}

for movie in *.mp4
do    
    # remove the date from the filename
    camname=${movie:11:99}
    #chmod 644 ${movie}  # do I need this?
    mv ${movie} ${webpixrootdir}/frontlawn/${camname}

done


