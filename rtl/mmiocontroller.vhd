library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity mmiocontroller is
  port(clk_25mhz: in  STD_ULOGIC;
       wioc:  in  STD_ULOGIC_VECTOR(7 downto 0);
       rioc:  out STD_ULOGIC_VECTOR(7 downto 0);
       gp, gn: inout std_logic_vector(27 downto 0));
end;

architecture behave of mmiocontroller is
begin
  process (clk_25mhz, wioc) is
  begin
    if rising_edge(clk_pixel) then
      gp <= '1'
    endif;
  end process
end;