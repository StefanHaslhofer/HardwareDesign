# Hardware Design: ESP32 communication

## Notes
In this section I will document findings and problems that occured during my work on this project.

### How to start?
My first big question mark was where I should start. My knowledge about hardware design and FPGAs is limited and I only have basic understanding of VHDL. I didn't even know how to write and compile code for the FPGA.

Therefore, I studied ulx3s' manual and subsequently the yosys toolchain documentation. In order to get a better understanding of the whole system and the toolchain, I tried implementing the "Hello world!" of hardware: blinky. I used Verilog, because I already knew VHDL (which I do not really like to put it mildly) and wanted to experience something new.

After implementing my [blinky](blinky.v)  I needed to compile it to a _.bit_-file. Therefore, I studied the _5.2_rtl_to_silicon_ slides. I watched a video on [HDL synthesis with Yosys](https://www.youtube.com/watch?v=rVftXFl5tHs) by Clifford Wolf and figured out I needed to use the synth command, which executes similar commands to the synthesis script descibed in the slides. It is also worth mentioning that the board uses a ECP5 series FPGA, for which yosys provides a specific synth command (_synth_ecp5_). Afterwards, I used nextpnr for place and route, which takes a JSON as input. After reading the _synth_ecp5_ commands help page, I generated the json via the _-json_ option.

However, I really struggeled while using nextpnr. I neither knew how to generate any output nor how to write a correct constraint file. I found a [Makefile](https://github.com/ulx3s/blink/blob/main/Makefile) which called the _nextpnr-ecp5_ correctly and I copied it to my [deployment script](deploy.bat). Furthermore, the constraint file can be found in the [ULX3S manual](https://github.com/emard/ulx3s/blob/master/doc/MANUAL.md). (Note: )

I programmed the FPGA over USB port "US1" and uploaded the _.bit_-files via _fujprog_.

Commands used to generate a _.bit_-file: [deploy.bat](deploy.bat). 