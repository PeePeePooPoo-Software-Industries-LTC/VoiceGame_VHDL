
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IncMaxShorts is
	port(
		data_a : in std_logic_vector(31 downto 0);
		data_b : in std_logic_vector(31 downto 0);
		result : out std_logic_vector(31 downto 0)
	);
end entity;

-- A:
-- 	X: (31 downto 16)
-- 	Y: (15 downto 0)
-- B:
-- 	W: (31 downto 0)

architecture rtl of IncMaxShorts is
begin
	process(data_a, data_b)
	begin
		if (unsigned(data_a(31 downto 16)) + 1 = unsigned(data_b(15 downto 0))) then
			result(31 downto 16) <= (others => '0');
			result(15 downto 0) <= std_logic_vector(unsigned(data_a(15 downto 0)) + 1);
		else
			result(31 downto 16) <= std_logic_vector(unsigned(data_a(31 downto 16)) + 1);
			result(15 downto 0) <= data_a(15 downto 0);
		end if;
	end process;
end architecture;
