library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Empty for now.

entity Main is
	port(	
		CLOCK_50 : in std_logic;
		LEDR : out std_logic_vector(17 downto 0)
	);
end entity;

architecture rtl of Main is
	component ClockDivider is
	port(
		clk : in std_logic;
		target_freq : in unsigned(31 downto 0);
		output : out std_logic
	);
	end component;
begin
	divider : ClockDivider port map(
		clk => CLOCK_50,
		target_freq => to_unsigned(1, 32),
		output => LEDR(0)
	);
end architecture;
