
#Bootstrap Injector
Single user mode is ready to use on all macs out of the box. You could type out a script to enroll your mac, but that would take a while. Enter the usb rubber ducky. The ducky shows up as a keyboard and can be programed to type what ever you want, using its 60mhz micro processor.


##Getting Started
* Buy yourself a USB rubber ducky from [here](http://usbrubberducky.com).  
* Install [homebrew](http://brew.sh/) if you don't have it already.  
* Install dfu-programmer.
```#!bash
brew install dfu-programmer
```
* Clone this project
```#!bash
git clone https://github.com/waderobson/bootstrap-injector.git
```

This project relies on a custom [firmware][firmware] and [encoder][encoder] tool created by USB rubber ducky community member [midnitesnake](https://github.com/midnitesnake). This firmware enables us to mount the contents of the SD card, as well as inject keystrokes. We'll need to grab those files and put them in our working directory.

[encoder]:	https://github.com/midnitesnake/USB-Rubber-Ducky/raw/master/Encoder/encoder.jar
[firmware]:	https://github.com/midnitesnake/USB-Rubber-Ducky/raw/master/Firmware/Images/c_duck_v2.1.hex
```!#bash
curl -L -O https://github.com/midnitesnake/USB-Rubber-Ducky/raw/master/Firmware/Images/c_duck_v2.1.hex
curl -L -O https://github.com/midnitesnake/USB-Rubber-Ducky/raw/master/Encoder/encoder.jar
```


##Flash the firmware

To flash the firmware plug the ducky in with the button down. You'll know if your in dfu mode because it will be plugged in and the light will be off. Now issue the following commands;  

Erase the firmware  
```
sudo dfu-programmer at32uc3b1256 erase
```
Flash the new firmware
```
sudo dfu-programmer at32uc3b1256 flash \
 --suppress-bootloader-mem <path to firmware hex file>
```
Reset the ducky
```#!bash
sudo dfu-programmer at32uc3b1256 reset
```

##Create inject.bin

The inject.bin file is the file that does the typing.  
To create it we need at least java 7.
We use the [encoder][encoder] and the DUCKSCRIPT.TXT file.

```#!bash
java -jar encoder.jar -i DUCKSCRIPT.TXT -o usb/inject.bin
```

##Edit bootstrap.sh

Open bootstrap.sh in your favourite text editor and fill in whatever your going to use for your environment. If your using munki don't worry about the casper section and vice versa. 

##Copy to ducky

Now you should have everything you need to start playing. Copy the contents from the `usb` folder to the ducky's SD card. I use rsync.

```#!bash
rsync -a usb/ /Volumes/Untitled/
```
The ducky should have come with a SD card reader so you can use that. I find its easier to just plug the ducky in with my cursor ready in a text editor, wait until its done typing and then copy the files over. Pulling the SD card in and out all the time can be a pain.

