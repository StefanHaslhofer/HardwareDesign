library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity dmem is -- data memory
  generic(addr_width: integer := 8);
  port(clk_25mhz: in  STD_ULOGIC;
       we:  in  STD_ULOGIC;
       sel: in  STD_ULOGIC_VECTOR(1 downto 0);
       a:   in  STD_ULOGIC_VECTOR(31 downto 0);
       wd:  in  STD_ULOGIC_VECTOR(31 downto 0);
       rd:  out STD_ULOGIC_VECTOR(31 downto 0);
       rioc:  in STD_ULOGIC;
       wioc:  out STD_ULOGIC;
       led: out STD_ULOGIC_VECTOR(7 downto 0));
end;

architecture behave of dmem is
begin
  process (clk_25mhz, we, sel, wd, rioc) is
    -- 256 byte
    type ramtype is array (2**(addr_width)-1 downto 0) of STD_ULOGIC_VECTOR(7 downto 0);
    variable dmem_s: ramtype := (others => (others => '0'));
  begin
    -- read or write memory
      if rising_edge(clk_25mhz) then
        if (we='1') then
          if (sel="00") then  -- 8 bit data width
            dmem_s(to_integer(a(addr_width-1 downto 0))) := wd(7 downto 0);
          elsif (sel="01") then -- 16 bit data width
            dmem_s(to_integer(a(addr_width-1 downto 0)))   := wd(7 downto 0);
            dmem_s(to_integer(a(addr_width-1 downto 0))+1) := wd(15 downto 8);
            -- assert (a(0) = '0') report "memory address alignment missmatch for half word access" severity error;
          else   -- 32 bit data width
            dmem_s(to_integer(a(addr_width-1 downto 0)))   := wd(7 downto 0);
            dmem_s(to_integer(a(addr_width-1 downto 0))+1) := wd(15 downto 8);
            dmem_s(to_integer(a(addr_width-1 downto 0))+2) := wd(23 downto 16);
            dmem_s(to_integer(a(addr_width-1 downto 0))+3) := wd(31 downto 24);
            -- assert (a(1 downto 0) = "00") report "memory address alignment missmatch for word access" severity error;
          end if;
        end if;

        -- read 8 bit of data from gpio pin and store it at certain position
        dmem_s(255)(0) := rioc;
        led(3) <= rioc;
      end if;
      rd <= (others => '0');
      if (sel="00") then  -- 8 bit data width
        rd(7 downto 0)   <= dmem_s(to_integer(a(addr_width-1 downto 0)));
      elsif (sel="01") then -- 16 bit data width
        rd(7 downto 0)   <= dmem_s(to_integer(a(addr_width-1 downto 0)));
        rd(15 downto 8)  <= dmem_s(to_integer(a(addr_width-1 downto 0))+1);
      else
        rd(7 downto 0)   <= dmem_s(to_integer(a(addr_width-1 downto 0)));
        rd(15 downto 8)  <= dmem_s(to_integer(a(addr_width-1 downto 0))+1);
        rd(23 downto 16) <= dmem_s(to_integer(a(addr_width-1 downto 0))+2);
        rd(31 downto 24) <= dmem_s(to_integer(a(addr_width-1 downto 0))+3);
      end if;

      -- read 8 bit of data and write to gpio pin if stored at certain position
      if (to_integer(a(addr_width-1 downto 0))=254) then
        -- wioc(7 downto 0) <= dmem_s(to_integer(a(addr_width-1 downto 0)));
      end if;
  end process;
end;
