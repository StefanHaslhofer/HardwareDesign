#!/bin/bash
cd rtl
yosys -m ghdl -p 'ghdl --std=08 --ieee=synopsys wallMtoW.vhd wallFtoD.vhd wallEtoM.vhd wallDtoE.vhd top.vhd testbench.vhd signext.vhd riscvpipeline.vhd regfile.vhd mux4.vhd mux3.vhd mux2.vhd maindec.vhd imem.vhd hazardunit.vhd hazardunitext.vhd flopr.vhd extend.vhd enflopr.vhd dmem.vhd datapath.vhd controller.vhd banchunit.vhd alu.vhd aludec.vhd adder.vhd -e top; synth_ecp5 -json ../riscv.json'
cd ..
nextpnr-ecp5 --85k --json riscv.json --lpf ulx3s_v20.lpf --textcfg ulx3s_out.config --package CABGA381 --lpf-allow-unconstrained
ecppack ulx3s_out.config ulx3s.bit
fujprog ulx3s.bit

