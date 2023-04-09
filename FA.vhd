Library ieee;
use ieee.std_logic_1164.all;

entity FA is 
port (
  
  A,B,Cin: in std_logic ;
  S,Cout: out std_logic

);
end entity;



architecture myImp of FA is  
begin


S <= A xor B xor Cin;

Cout <= (A and B) or ((A xor B) and Cin);


end myImp;