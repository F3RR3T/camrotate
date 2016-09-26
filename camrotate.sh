#! /bin/bash

#  SJP 19 Sept 2014
#  grab a pic from paddock cam and post it to a website.
#  v1 = cumquat
#  v2 = st33v.com

#cd ~/web/cam

pixdir=/home/camera/ftp/cam
webdir=/var/www/webcam/paddock
maxpix=24

cd $webdir

# remove small (nightshots) files from paddock cam folder
# use with care:  find / delete is recursive down the tree
find $pixdir/ -type f -size -9k -delete

# find the most recent photo
latest=$(ls $pixdir/ -t | head -1)
cp $pixdir/$latest latest.jpg  # copy changes owner to st33v
chmod 644 latest.jpg

# is it a noisy nightshot?
# High kurtosis means predominantly one level of intensity
# in our case I assume this means black. A normal pic ~~ 1
# convert to integer (BASH can't do floating point)
kurt=$(identify -format %[kurtosis] latest.jpg | sed s/[.].*//)
# And get the mean. Some nightshots are so noisy they bring the kurtosis down
mean=$(identify -format %[mean] latest.jpg | sed s/[.].*//)

#if [ $kurt -gt 50 ]; then
#	rm $pixdir/$latest
#	echo kurtosis of $kurt is too high.
#	exit 13
#fi

# too dark
if [ $mean -lt 9000 ]; then
	rm $pixdir/$latest
	echo mean of $mean is too low.
	exit 13
fi

# Is it a new photo?
a=$(md5sum latest.jpg | awk '{print $1}')
b=$(md5sum 1.jpg | awk '{print $1}')

[ $a == $b ] && exit

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



# now make a html page
#done already





