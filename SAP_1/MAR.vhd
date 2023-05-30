library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_ARITH.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mar_reg8bit is 
    port (
        clk : in std_logic;
        load : in std_logic; 
        address_in : in std_logic_vector(3 downto 0); 
        data_out : out std_logic_vector(3 downto 0));

end entity mar_reg8bit;

architecture behavioral of mar_reg8bit is
   
begin
    process(clk)
    begin

        if rising_edge(clk) then
            if load = '1' then
                data_out <= address_in; 
            end if;
        end if;
       
    end process;

end  behavioral;

