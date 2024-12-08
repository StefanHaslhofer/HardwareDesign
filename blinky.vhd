library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top is
    Port (
        clk_25mhz : in std_logic;
        gp : out std_logic_vector(27 downto 0);
        gn : inout std_logic_vector(27 downto 0);
        led : out std_logic_vector(7 downto 0)
    );
end top;

architecture Behavioral of top is
begin
    -- Assign gp(12) to constant '1'
    gp(12) <= '1';

    process(clk_25mhz)
    begin
        if rising_edge(clk_25mhz) then
            led(6 downto 0) <= (others => '0');
            led(7) <= gn(12);
        end if;
    end process;

end Behavioral;