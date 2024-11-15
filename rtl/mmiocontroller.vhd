library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity mmiocontroler is -- data memory
  generic(addr_width: integer := 8);
  port(clk_25mhz: in  STD_ULOGIC;
       we:  in  STD_ULOGIC;
       sel: in  STD_ULOGIC_VECTOR(1 downto 0);
       a:   in  STD_ULOGIC_VECTOR(31 downto 0);
       wd:  in  STD_ULOGIC_VECTOR(31 downto 0);
       rd:  out STD_ULOGIC_VECTOR(31 downto 0);
       -- read vector from esp32
       resp:  out STD_ULOGIC_VECTOR(7 downto 0);
       -- write vector to esp32
       wesp:  out STD_ULOGIC_VECTOR(7 downto 0));
end;

architecture behave of dmem is
begin

end;