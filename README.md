
#Bootstrap Injector
Single user mode is ready to use on all macs out of the box. You could type out a script to enroll your mac, but that would take a while. Enter the usb rubber ducky. The ducky shows up as a keyboard and can be programed to type what ever you want, using its 60mhz micro processor.


##Getting Started
* Buy yourself a USB rubber ducky from [here](http://usbrubberducky.com).  
* Install [homebrew](http://brew.sh/) if you don't have it already.  

Install dfu-programmer.
```#!bash
brew install dfu-programmer
```
Clone this project

```#!bash
git clone https://github.com/waderobson/bootstrap-injector.git
```

This project relies on a custom [firmware][firmware] and [encoder][encoder] tool created by USB rubber ducky community member [midnitesnake](https://github.com/midnitesnake). We'll need to grab those files and put them in our working directory.

[encoder]:	https://github.com/midnitesnake/USB-Rubber-Ducky/raw/master/Encoder/encoder.jar
[firmware]:	https://github.com/midnitesnake/USB-Rubber-Ducky/raw/master/Firmware/Images/c_duck_v2.1.hex
```!#bash
curl -L -O https://github.com/midnitesnake/USB-Rubber-Ducky/raw/master/Firmware/Images/c_duck_v2.1.hex
curl -L -O https://github.com/midnitesnake/USB-Rubber-Ducky/raw/master/Encoder/encoder.jar
```


##Flashing the firmware

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

##Creating inject.bin

The inject.bin file is the file that does the typing.  
To create it we need at least java 7.
We use the [encoder][encoder] and the DUCKSCRIPT.TXT file.

```#!bash
java -jar encoder.jar -i DUCKSCRIPT.TXT -o usb/inject.bin
```


