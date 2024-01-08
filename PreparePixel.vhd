
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PreparePixel is
	port(
		data_a : in std_logic_vector(31 downto 0);
		data_b : in std_logic_vector(31 downto 0);
		result : out std_logic_vector(31 downto 0)
	);
end entity;

-- For 30 bit color, XOffset = 2
-- For 30 bit color, YOffset = 11

architecture rtl of PreparePixel is
begin
	result(1 downto 0) <= (others => '0');
	result(10 downto 2) <= data_a(8 downto 0);
	result(19 downto 11) <= data_b(8 downto 0);
	result(31 downto 20) <= (others => '0');
end architecture;
