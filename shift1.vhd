library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift1 is
port(
 clk, arst: in std_logic; 
 F1,F2,F3 : in std_logic_vector(3 downto 0);
 A : in std_logic_vector(7 downto 0);
 F1s,F2s,F3s : out std_logic_vector(3 downto 0);
 As : out std_logic_vector(7 downto 0)

 );
end entity;
architecture myimp of shift1 is
signal Ftotal, Ftotalout : std_logic_vector(19 downto 0);
begin
Ftotal <= F1&F2&F3&A;
	process (clk,arst) is
	begin
		if arst = '1' then
			Ftotalout <= "00000000000000000000";
		elsif rising_edge(clk) then
			Ftotalout <= Ftotal(18 downto 0) & '0';
		end if;
	end process;
F1s <= Ftotalout(19 downto 16);
F2s <= Ftotalout(15 downto 12);
F3s <= Ftotalout(11 downto 8);
As <= Ftotalout(7 downto 0);

end myimp;