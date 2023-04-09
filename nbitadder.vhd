Library ieee;
use ieee.std_logic_1164.all;

entity nbitadder is 
generic(n: integer :=8);

port (
  
  A,B: in std_logic_vector (n-1 downto 0);
  Cin: in std_logic;
  S: out std_logic_vector(n-1 downto 0);
  Cout: out std_logic

);
end entity;

architecture myImp of nbitadder is  

component FA is 
port (
  
  A,B,Cin: in std_logic ;
  S,Cout: out std_logic

);
end component;


signal temp: std_logic_vector (n downto 0);

begin

temp(0) <= Cin;

Cout <= temp(n);

lopp: for i in 0 to n-1 generate

fx: FA port map( A=>A(i), B=>B(i), Cin=>temp(i), S=>S(i), Cout=>temp(i+1));

end generate;



end myImp;
