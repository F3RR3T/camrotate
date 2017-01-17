#! /bin/bash

#  SJP 19 Sept 2014 --> 12 Jan 2017: gutted and renamed camfreshen.sh
#  grab a pic from paddock cam and post it to a website.
#  v1 = cumquat
#  v2 = st33v.com
#  V3 = utterly revised for F3rr3t.com

pixdir=/home/st33v/farm/cam
webpixrootdir=/data/pix
maxpix=24

declare -a camz=(neatherd lucerne)

for cam in "${camz[@]}"
do    
    thiscamdir=$pixdir/$cam
    cd $webpixrootdir/$cam

    #echo looking in $thiscamdir
    #echo pwd is $PWD "$webpixrootdir"/"$cam"

    # find the most recent photo
    latest=$(ls $thiscamdir/*.jpg -t 2>/dev/null | head -1)
    #echo latest is $latest 
    cp $latest latest.jpg  # copy changes owner to st33v
    chmod 644 latest.jpg

    # Is it a new photo?
    a=$(md5sum latest.jpg | awk '{print $1}')
    if (test -e 1.jpg) then
        b=$(md5sum 1.jpg | awk '{print $1}')
     #   echo found 1.jpg
    else b=zzz  # only happens if there is no file "1.jpg"
    fi
    if [ $a == $b ]; then
      #  echo nothing new here
        rm latest.jpg
        continue
    fi

    # move all existing pix along (let's have maxpix on display)
    i=$maxpix
    while [ $i -gt 1 ]
    do
        i=$[i-1]
        if (test -e $i.jpg) then
            mv $i.jpg $[i+1].jpg 
        fi
    done
    mv latest.jpg 1.jpg
done


