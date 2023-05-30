
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity programcounter is
	port(pc_inc :in STD_LOGIC;
	     clk :in STD_LOGIC;
	     clr :in STD_LOGIC;
	     Ep :in STD_LOGIC;
	    adder_out : out STD_LOGIC_VECTOR(3 downto 0));
end programcounter	;

architecture Behavioral of programcounter is

signal PC_content : STD_LOGIC_VECTOR (3 downto 0) := (others => '0' );

begin
process (clk,clr)
begin
	if clr ='1' then
	   PC_content <= ( others => '0' );
	elsif rising_edge(clk) then
		if pc_inc = '1' then
		   PC_content <= PC_content + 1;
	
	end if;

end if;
end process;
adder_out <= PC_content when Ep = '1' else ( others => 'Z');
end Behavioral;