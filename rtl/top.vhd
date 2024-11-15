-----------------------------------------
-- Institute for Complex Systems (ICS)
-- ICS RV32I v1.0.0
-- based on Harris&Harris Implementation (see below **)
-- daniel.grosse@jku.at
-- lucas.klemmer@jku.at
-- thanks to Richard Feichtinger for his work on this core
--
-----------------------
-- **
-- RISC-V single-cycle processor
-- From Section 7.6 of Digital Design & Computer Architecture
-- 27 April 2020
-- David_Harris@hmc.edu 
-- Sarah.Harris@unlv.edu


Library IEEE;
Library work;
use IEEE.STD_LOGIC_1164.all;

entity top is -- top-level design for testing
  port(clk_25mhz: in     STD_ULOGIC;
       reset:     in     STD_ULOGIC;
       WriteData: buffer STD_ULOGIC_VECTOR(31 downto 0);
       DataAdr:   buffer STD_ULOGIC_VECTOR(31 downto 0);
       MemWrite:  buffer STD_ULOGIC;
       gp, gn: inout std_logic_vector(27 downto 0));
end;

architecture test of top is
  component riscvpipeline
    port(clk_25mhz: in  STD_ULOGIC;
         reset:     in  STD_ULOGIC;
         PC:        out STD_ULOGIC_VECTOR(31 downto 0);
         Instr:     in  STD_ULOGIC_VECTOR(31 downto 0);
         MemWrite:  out STD_ULOGIC;
         ALUResult: out STD_ULOGIC_VECTOR(31 downto 0);
         MemSel:    out STD_ULOGIC_VECTOR(1  downto 0);
         WriteData: out STD_ULOGIC_VECTOR(31 downto 0);
         ReadData:  in  STD_ULOGIC_VECTOR(31 downto 0));
  end component;
  
  component imem
    port(a:  in  STD_ULOGIC_VECTOR(31 downto 0);
         rd: out STD_ULOGIC_VECTOR(31 downto 0));
  end component;
  
  component dmem
    port(clk_25mhz: in  STD_ULOGIC;
         we:  in  STD_ULOGIC;
         sel: in  STD_ULOGIC_VECTOR(1 downto 0);
         a:   in  STD_ULOGIC_VECTOR(31 downto 0);
         wd:  in  STD_ULOGIC_VECTOR(31 downto 0);
         rd:  out STD_ULOGIC_VECTOR(31 downto 0);
         rioc:  in STD_ULOGIC;
         wioc:  out STD_ULOGIC);
  end component;
    
  signal PC:        STD_ULOGIC_VECTOR(31 downto 0);
  signal Instr:     STD_ULOGIC_VECTOR(31 downto 0);
  signal ReadData:  STD_ULOGIC_VECTOR(31 downto 0);
  signal MemSel:    STD_ULOGIC_VECTOR(1  downto 0);
  
begin
  -- instantiate processor and memories

  rvsingle: entity work.riscvpipeline(struct_neg) port map(clk_25mhz, reset, PC, Instr, MemWrite, DataAdr, MemSel, WriteData, ReadData);
  --rvsingle: riscvpipeline port map(clk, reset, PC, Instr, MemWrite, DataAdr, MemSel, WriteData, ReadData);
  imem1: imem port map(PC, Instr);
  dmem1: dmem port map(clk_25mhz, MemWrite, MemSel, DataAdr, WriteData, ReadData, gp(11));
end;
