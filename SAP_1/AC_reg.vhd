library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity accumulator_register is
    Port ( clock : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           load : in  STD_LOGIC;
           input_data : in  STD_LOGIC_VECTOR (7 downto 0);
           output_data : out  STD_LOGIC_VECTOR (7 downto 0);
	   output_data_alu : out  STD_LOGIC_VECTOR (7 downto 0));
end accumulator_register;

architecture Behavioral of accumulator_register is
signal data_ac :std_logic_vector(7 downto 0);
begin
    process(clock)
    begin
           if rising_edge(clock) then
                if load = '1' then
                    data_ac <= input_data; -- load input into register
                end if;
        end if;
    end process;
output_data <= data_ac when enable = '1' else (others => 'Z');
output_data_alu <=data_ac;

end Behavioral;