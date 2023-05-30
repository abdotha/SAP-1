library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Register is
    port (
        clk,clr,enable,load: in  std_logic;
        data_in: in std_logic_vector(7 downto 0);
        data_out_op,data_out_bus: out std_logic_vector(3 downto 0)
    );
end Instruction_Register;

architecture data of Instruction_Register is
    signal reg : std_logic_vector(7 downto 0);
begin
    process (clk, clr)
    begin
        if clr = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            
                if load = '1' then
                    reg <= data_in;
                end if;
 
        end if;
    end process;
    data_out_op <= reg (7 downto 4);
    data_out_bus <= reg (3 downto 0) when enable = '1' else (others => 'Z');
end data;