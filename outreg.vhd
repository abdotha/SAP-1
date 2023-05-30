library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity out_reg is
    Port ( clk : in  STD_LOGIC;
           load : in  STD_LOGIC;
           datain : in  STD_LOGIC_VECTOR (7 downto 0);
           dataout : out  STD_LOGIC_VECTOR (7 downto 0));
end out_reg;
architecture Behavioral of out_reg is
	signal out_cont:std_logic_vector(7 downto 0);

begin
process(clk,load)
begin
  
	if(rising_edge(clk))then
		if(load='1')then
			 out_cont <= datain;
		 end if;
	end if;

end process;
dataout <=out_cont;
end Behavioral;

  
