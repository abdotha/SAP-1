library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity controller2_1 is 
port(
	clk,clr:in std_logic;
	opcode:in std_logic_vector(3 downto 0);
	IR_in:out std_logic;
	B_in:out std_logic;
	AC_in:out std_logic;
	MAR_in:out std_logic;
	PC_inc:out std_logic;
	out_in:out std_logic;
	m_read:out std_logic;
	sub:out std_logic;
    Ep:out std_logic;
    Ea:out std_logic;
    Eu:out std_logic;
    Ei:out std_logic;
    HLT:out std_logic);
end controller2_1 ;

architecture cu of controller2_1 is 

    signal t: std_logic_vector(2 downto 0);
    signal d: std_logic_vector(4 downto 0);
    signal t_sig: std_logic_vector(5 downto 0);

    begin 
    process(clk,clr)
    begin
        
    if (clr='1') then t<="001";
        elsif (rising_edge(clk))then

            -- sequence counter --
            if (t="110")then --start at t1 and end at t6
                t<="001";
            elsif(t_sig="000100" and d="10000")then
                t<="011";
            else
                t<=t+1;
            end if;

            -- sequence counter decoding --
            case t is 
            when "001" => t_sig<="000001";
            when "010" => t_sig<="000010";
            when "011" => t_sig<="000100";
            when "100" => t_sig<="001000";
            when "101" => t_sig<="010000";
            when "110" => t_sig<="100000";
            when others => t_sig<="000000";
            end case;

            -- opcode decoding --
            case opcode is 
            when "0001" => d<="00001"; --LAD
            when "0010" => d<="00010"; --ADD
            when "0011" => d<="00100"; --SUB
            when "0100" => d<="01000"; --OUT
            when "0101" => d<="10000"; --HLT
            when others => d<="00000";
            end case;

            -- clr sequence counter --
            if(t_sig(2)='1' and (d(0)='1' or d(3)='1')) then
                t<="001";
            elsif(t_sig(3)='1' and (d(1)='1' or d(2)='1'))then
                t<="001";
            end if;
    end if;
    end process;
        out_in <= d(3) and t_sig(2);
        mar_in <= t_sig(0) or (t_sig(2) and (d(0) or d(1) or d(2)));
        b_in <= t_sig(3) and (d(1) or d(2));
        ac_in <= (t_sig(3) and d(0)) or ((d(1) or d(2)) and t_sig(4));
        ir_in <= t_sig(1);
        pc_inc <= t_sig(1);
        sub <= (t_sig(4) and d(2));
        m_read <=t_sig(1) or (t_sig(3) and (d(0) or d(1) or d(2)));
        Ep <= t_sig(0);
        Ea <= t_sig(2) and d(3);
        Eu <= t_sig(4) and (d(1) or d(2));
        Ei <= t_sig(2) and (d(0) or d(1) or d(2));
        HLT <= not((t_sig(2) or t_sig(3) or t_sig(4) or t_sig(5))and d(4));
end cu;
    



