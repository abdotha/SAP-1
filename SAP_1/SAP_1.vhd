----------------------------------------------------------------------------------
-- Company:  Benha Faculty of Engineering
-- Engineer: Abdelrhman Ayman Taha

-- Create Date:    20:39:28 30/05/2023 
-- Module Name:    SAP1 - Structural 
-- Project Name:   SAP_1
-- Version: 1.0 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SAP_1 is
    port (
        clk : in std_logic;
        clr : in std_logic;
        s_out:out std_logic_vector(7 downto 0)
       );
end SAP_1;

architecture rtl of SAP_1 is

    component controller2_1 is 
port(
	clk:in std_logic;
    clr:in std_logic;
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
end component ;

    component accumulator_register is
        Port( clock : in  STD_LOGIC;
        enable : in  STD_LOGIC;
        load : in  STD_LOGIC;
        input_data : in  STD_LOGIC_VECTOR (7 downto 0);
        output_data : out  STD_LOGIC_VECTOR (7 downto 0);
    output_data_alu : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component ALU is
        Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
               b : in  STD_LOGIC_VECTOR (7 downto 0);
                  Su : in STD_LOGIC;
                  Eu : in STD_LOGIC;
               dataout : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component BREG is
        Port ( Lb : in  STD_LOGIC;
               clk : in  STD_LOGIC;
               INPR : in  STD_LOGIC_VECTOR (7 downto 0);
               OUTBR : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component Instruction_Register is
        port (
            clk: in  std_logic;
            clr: in  std_logic;
            enable: in  std_logic;
            load: in  std_logic;
            data_in: in std_logic_vector(7 downto 0);
            data_out_op : out std_logic_vector(3 downto 0);
            data_out_bus: out std_logic_vector(3 downto 0)
        );
    end component;

    component out_reg is
        Port ( clk : in  STD_LOGIC;
               load : in  STD_LOGIC;
               datain : in  STD_LOGIC_VECTOR (7 downto 0);
               dataout : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component programcounter is
        port(pc_inc :in STD_LOGIC;
             clk :in STD_LOGIC;
             clr :in STD_LOGIC;
             Ep :in STD_LOGIC;
             adder_out : out STD_LOGIC_VECTOR(3 downto 0));
    end component	;

    component mar_reg8bit is 
    port (
        clk : in std_logic;
        load : in std_logic; 
        address_in : in std_logic_vector(3 downto 0); 
        data_out : out std_logic_vector(3 downto 0));

end component;
    --
    component mem is 
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
          dataout : out STD_LOGIC_VECTOR (7 downto 0);
          RD : in STD_LOGIC);
  end component;
  
    --
    component d_bus is 
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
end component;

    signal active_clk : STD_LOGIC :=  clk;
    signal IR_in,B_in,AC_in,MAR_in,PC_inc,out_in,m_read,sub,Ep,Ea,Eu,Ei,HLT:std_logic;
    signal opcode,data_pc,data_ir : std_logic_vector(3 downto 0);
    signal data_bus :std_logic_vector(7 downto 0);
    signal data_ac_alu,data_b_alu :std_logic_vector(7 downto 0);
    signal address : std_logic_vector(3 downto 0);
    signal data_ac,data_alu,data_mem :std_logic_vector(7 downto 0);
   
begin
    active_clk <= not(HLT and clk);
            cu :controller2_1 port map(clk,clr,opcode,IR_in,B_in,AC_in,MAR_in,PC_inc,out_in,m_read,sub,Ep,Ea,Eu,Ei,HLT);
            AC_reg :accumulator_register port map (active_clk,Ea,AC_in,data_bus,data_ac,data_ac_alu);
            ALU_unit:ALU port map(data_ac_alu,data_b_alu,sub,Eu,data_alu);
            B_reg:BREG port map (B_in,active_clk,data_bus,data_b_alu);
            IR:Instruction_Register port map(active_clk,clr,Ei,IR_in,data_bus,opcode,data_ir);
            o_reg:out_reg port map(active_clk,out_in,data_bus,s_out);
            PC_reg:programcounter port map (PC_inc,active_clk,clr,Ep,data_pc);
            AR_reg:mar_reg8bit port map(active_clk,MAR_in,data_bus(3 downto 0),address);
            memory:mem port map(address,data_mem,m_read);
            data_b:d_bus port map(Ep,Ea,Eu,Ei,m_read,data_pc,data_ac,data_alu,data_ir,data_mem,data_bus);
        
end architecture;
