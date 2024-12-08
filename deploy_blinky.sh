yosys -m ghdl -p 'ghdl --std=08 --ieee=synopsys blinky.vhd -e top; synth_ecp5 -json ../riscv.json'         
nextpnr-ecp5 --85k --json blinky.json --lpf ulx3s_v20.lpf --textcfg ulx3s_out.config --package CABGA381
ecppack ulx3s_out.config ulx3s.bit
fujprog ulx3s.bit