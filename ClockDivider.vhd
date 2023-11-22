
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ClockDivider is
	port(
		clk : in std_logic; -- This should be connected to a 50MHz clock, on the DE2-115 that's CLOCK_50
		target_freq : in unsigned(31 downto 0);
		output : out std_logic
	);
end entity;

architecture rtl of ClockDivider is
	constant FREQ_50 : unsigned(target_freq'range) := to_unsigned(25_000_000, target_freq'length);
	
	signal toggle : std_logic := '0';
begin
	process(clk)
		variable counter : unsigned(target_freq'range) := to_unsigned(0, target_freq'length);
	begin
		if rising_edge(clk) then
			counter := counter + 1;
		end if;
		
		if counter > (FREQ_50 / target_freq) then
			counter := to_unsigned(0, target_freq'length);
			toggle <= not toggle;
		end if;
	end process;
	
	output <= toggle;
end architecture;
