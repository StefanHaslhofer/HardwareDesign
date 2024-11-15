library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity mmiocontroller is
  port(clk_25mhz: in  STD_ULOGIC;
       wesp:  in  STD_ULOGIC_VECTOR(7 downto 0);
       resp:  out STD_ULOGIC_VECTOR(7 downto 0));
end;

architecture behave of mmiocontroller is
begin
  process (clk_25mhz, wesp) is
  begin

  end process
end;