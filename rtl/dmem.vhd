library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity dmem is -- data memory
  generic(
    ESP32_OUT: integer := 254;
    ESP32_IN: integer := 255;
    addr_width: integer := 8
  );
  port(clk_25mhz: in  STD_ULOGIC;
       we:  in  STD_ULOGIC;
       sel: in  STD_ULOGIC_VECTOR(1 downto 0);
       a:   in  STD_ULOGIC_VECTOR(31 downto 0);
       wd:  in  STD_ULOGIC_VECTOR(31 downto 0);
       rd:  out STD_ULOGIC_VECTOR(31 downto 0);
       rioc:  in STD_ULOGIC;
       wioc:  out STD_ULOGIC;
       led_dbg: out STD_ULOGIC);
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

          -- forward least significant byte from wd signal to gpio pin if a designated memory location has been written
          if (to_integer(a(addr_width-1 downto 0))=ESP32_OUT) then
            -- wioc <= wd(0);
          end if;
        end if;

        -- write bit from gpio pin to a designated position in memory
        dmem_s(ESP32_IN)(0) := rioc;
        -- additionally light up led to verify that we recieved data
        -- led_dbg <= rioc;
      end if;

      rd <= (others => '0');
      wioc <= '1';
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
  end process;
end;
