library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity mem is 
  Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
        dataout : out STD_LOGIC_VECTOR (7 downto 0);
        RD : in STD_LOGIC);
end mem;

architecture Behavioral of mem is 
type memory is array(0 to 15) of STD_LOGIC_VECTOR (7 downto 0);
signal ram :memory := ( 
0 => "00011001" , --LDA 9H
1 => "00101010" , --ADD AH
2 => "01001111" , --OUT
3 => "00111011" , --SUB BH
4 => "01001111" , --OUT
5 => "01011111" , --HLT
9 => "00000100" , --04H
10 =>"00000011" , --03H
11 =>"00000010" , --02H
others=>"11111111");
begin
  dataout <=  ram(conv_integer((address))) when RD='1' else (others => 'Z');
end Behavioral;
