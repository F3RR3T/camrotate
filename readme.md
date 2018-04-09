# camRotate: a shell script to keep web cam pictures up to date in a static website

## Introduction

A shell script is called by a `systemd` PATH service when new webcam picures land in a given directory.

## Files

File name | Description
----------|------------
camrotate.path| Systemd PATH unit, which watches the 'landing' directory that new images are copied to (by another process).
camrotate.service | Systemd service, activated by the PATH unit, that executes the shell script.
camfreshen.sh | Bash shell script that renames the image files so that the webpage loads the latest images.

## Example

The script powers the [webcams at F3rr3t.com](http://f3rr3t.com/cams/neatherd).
