library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Bin2BCD is
port(
 clk, arst: in std_logic; 
 A : in std_logic_vector(7 downto 0);
 F1s_out,F2s_out,F3s_out : out std_logic_vector(3 downto 0)

 );
end;
architecture myimp of Bin2BCD is
component shift1 is
port(
 clk, arst: in std_logic; 
 F1,F2,F3 : in std_logic_vector(3 downto 0);
 A : in std_logic_vector(7 downto 0);
 F1s,F2s,F3s : out std_logic_vector(3 downto 0);
 As : out std_logic_vector(7 downto 0)

 );
end component;

component nbitadder is 
generic(n: integer :=8);

port (
  
  A,B: in std_logic_vector (n-1 downto 0);
  Cin: in std_logic;
  S: out std_logic_vector(n-1 downto 0);
  Cout: out std_logic

);
end component;

TYPE shift_type IS ARRAY(0 TO 8) of std_logic_vector(3 DOWNTO 0);
TYPE shift2_type IS ARRAY(0 TO 8) of std_logic_vector(7 DOWNTO 0);

signal huns, hunsadd, hunshift,  tens, tensadd, tenshift, unts, untsadd, untshift: shift_type;
signal Ais: shift2_type;

begin

huns(0) <= "0000";
tens(0) <= "0000";
unts(0) <= "0000";
Ais(0) <= A;

loop1: FOR i IN 0 TO 7 GENERATE
sx: shift1 PORT MAP(clk,arst,huns(i),tens(i),unts(i), Ais(i),hunshift(i),tenshift(i),untshift(i), Ais(i+1));
fx1: nbitadder generic map(4) PORT MAP(hunshift(i),"0011",'0',hunsadd(i));
fx2: nbitadder generic map(4) PORT MAP(tenshift(i),"0011",'0',tensadd(i));
fx3: nbitadder generic map(4) PORT MAP(untshift(i),"0011",'0',untsadd(i));

huns(i+1) <= hunsadd(i) WHEN hunshift(i) >= "0101"
ELSE hunshift(i);

tens(i+1) <= tensadd(i) WHEN tenshift(i) >= "0101"
ELSE tenshift(i);

unts(i+1) <= untsadd(i) WHEN untshift(i) >= "0101"
ELSE untshift(i);

END GENERATE;

F1s_out <= huns(8);
F2s_out <= tens(8);
F3s_out <= unts(8);



end myimp;