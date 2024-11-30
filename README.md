# Hardware Design: ESP32 communication

## How to start?
In this section I will document findings and problems that occured during my preparation work on this project.

My first big question mark was where I should start. My knowledge about hardware design and FPGAs is limited and I only have basic understanding of VHDL. I didn't even know how to write and compile code for the FPGA.

Therefore, I studied ulx3s' manual and subsequently the yosys toolchain documentation. In order to get a better understanding of the whole system and the toolchain, I tried implementing the "Hello world!" of hardware: blinky.

### Using the Toolchain
After implementing my [blinky](blinky.v)  I needed to compile it to a _.bit_-file. Therefore, I studied the _5.2_rtl_to_silicon_ slides. I watched a video on [HDL synthesis with Yosys](https://www.youtube.com/watch?v=rVftXFl5tHs) by Claire Wolf and figured out I needed to use the synth command, which executes similar commands to the synthesis script descibed in the slides. It is also worth mentioning that the board uses a ECP5 series FPGA, for which yosys provides a specific synth command (_synth_ecp5_). Afterwards, I used nextpnr for place and route, which takes a JSON as input. After reading the _synth_ecp5_ commands help page, I generated the json via the _-json_ option.

However, I really struggeled while using nextpnr. I neither knew how to generate any output nor how to write a correct constraint file. I found a [Makefile](https://github.com/ulx3s/blink/blob/main/Makefile) which called the _nextpnr-ecp5_ correctly and I copied it to my [deployment script](deploy.sh). Furthermore, the constraint file can be found in the [ULX3S manual](https://github.com/emard/ulx3s/blob/master/doc/MANUAL.md). (Note: The leds don't seem to correspond to the numbers on the curcuit board, but it still works? Am I misunderstanding the _.lpf_-file?)

I programmed the FPGA over USB port "US1" and uploaded the _.bit_-files via _fujprog_.

Commands used to generate a _.bit_-file: [deploy.sh](deploy.sh). 

### (Re)learning VHDL
To keep it short: very special thanks to [nandland.com](https://nandland.com/).

### Program the ESP32
The ULX3S' on-board ESP32 can be programmed using the passthru bitstream. The whole process is described in the [ULX3S manual](https://github.com/emard/ulx3s/blob/master/doc/MANUAL.md).

## Implementation
This section highlights the most important core concepts of my project implementation as well as encountered problems and how I solved them.

### Core Concept
I chose a memory mapped I/O approach for communication between a RISC-V core (running on the FPGA) and the on-board ESP32. I did not implement the RISC-V core by myself but rather used code provided in the lecture _Rechnerarchitektur_.

In contrast to my blinky example, the RISC-V core consists of multiple VHDL files, which can be handled by yosys. 

In order to establish communication between the ESP32 and the core I needed to find possible connection. Accordion to the [ULX3S manual](https://github.com/emard/ulx3s/blob/master/doc/MANUAL.md) J1 pins GP,GN 11-13 are shared with the ESP32. I then allocated a designated area in the [memory](rtl/dmem.vhd) for data sent/recieved via those pin connections.

TODO write about problems with programming esp32 (probably a power issue, also i "bricked" the ulx3s) and write about problem with PIN 26 ouput (was always high)
Programm on esp32 was only running when passthru is applied (probably because some ports GPIOs are undefined?)

Setting all leds to low hinders esp32 execution from starting

PIN11 is always high