library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity d_bus is 
port(
	Ep:in std_logic;
	Ea:in std_logic;
	Eu:in std_logic;
	Ei:in std_logic;
	m_read:in std_logic;

	data_pc:in std_logic_vector(3 downto 0);
	data_ac:in std_logic_vector(7 downto 0);
	data_alu:in std_logic_vector(7 downto 0);
	data_ir:in std_logic_vector(3 downto 0);
	data_mem:in std_logic_vector(7 downto 0);

	data_out:out std_logic_vector(7 downto 0));
end d_bus;

architecture data_bus of d_bus is 
signal bus_s :std_logic_vector(2 downto 0);
begin
	bus_s<="001" when Ep='1' else
	"010" when Ea ='1' else
	"011" when Eu ='1' else
	"100" when Ei ='1' else
	"101" when m_read ='1' else
	(others => '0');
process(bus_s)
begin
	if (bus_s="001")then
		data_out(3 downto 0) <= data_pc;
	elsif (bus_s="010") then 
		data_out <= data_ac;
	elsif (bus_s="011") then 
		data_out <=data_alu;
	elsif (bus_s="100") then 
		data_out(3 downto 0) <= data_ir;
	elsif (bus_s="101") then 
		data_out <=data_mem;
	end if;
end process;
end data_bus;
