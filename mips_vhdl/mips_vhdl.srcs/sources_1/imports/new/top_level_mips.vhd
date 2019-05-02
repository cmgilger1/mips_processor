--------------------------------------------------------------------------------
-- Title: top_level_mips.vhd
-- By: Caroline Gilger
-- Description: This program acts as the top level of the mips control and 
--              datapath created in this project.
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

--------------------------------------------------------------------------------
-- Declaration
--------------------------------------------------------------------------------
entity top_level_mips is
    port ( ck       : in std_logic;
           out_led : out std_logic_vector (15 downto 0)
        );
end top_level_mips;

--------------------------------------------------------------------------------
-- Description
--------------------------------------------------------------------------------
architecture Structural of top_level_mips is

component main_control is
    port (  instr      : in  std_logic_vector(5 downto 0);
            funct      : in  std_logic_vector(5 downto 0);
            regDst     : out std_logic_vector(1 downto 0);
            branch     : out std_logic;
            memRead    : out std_logic;
            memToReg   : out std_logic_vector(1 downto 0);
            aluOp      : out std_logic_vector(1 downto 0);
            memWrite   : out std_logic;
            aluSrc     : out std_logic;
            regWrite   : out std_logic;
            jump       : out std_logic_vector(1 downto 0)
            );
end component;

component alu is
    port (  control    : in std_logic_vector (1 downto 0);
            a          : in std_logic_vector (31 downto 0);
            b          : in std_logic_vector (31 downto 0);
            funct      : in std_logic_vector (5 downto 0);
            shamt      : in std_logic_vector (4 downto 0);
            result     : out std_logic_vector (31 downto 0);
            oflow      : out std_logic;
            zflag      : out std_logic;
            cout       : out std_logic
            );
end component;   

component adder is
    port (  val_a : in std_logic_vector (31 downto 0);
            val_b : in std_logic_vector (31 downto 0);
            res   : out std_logic_vector (31 downto 0);
            cout  : out std_logic     
            );
end component;

component data_mem is
    port (  in_addr  : in std_logic_vector (31 downto 0);
            in_data  : in std_logic_vector (31 downto 0);
            writeEn  : in std_logic;
            readEn   : in std_logic;
            clock    : in std_logic;
            out_data : out std_logic_vector (31 downto 0)
            );
end component;

component instr_mem is
    port (  in_addr   : in std_logic_vector (31 downto 0);
            out_instr : out std_logic_vector (31 downto 0)
            );
end component;

component shift_logic is
    port (  val_a :  in std_logic_vector (31 downto 0);
            val_b : out std_logic_vector (31 downto 0)
            );
end component;

component register_file is
    port (  r_addr1  : in std_logic_vector (4 downto 0);
            r_addr2  : in std_logic_vector (4 downto 0);
            w_addr   : in std_logic_vector (4 downto 0);
            w_data   : in std_logic_vector (31 downto 0);
            clk      : in std_logic;
            w_en     : in std_logic;
            r_data1  : out std_logic_vector (31 downto 0);
            r_data2  : out std_logic_vector (31 downto 0)
            );
end component;

component mux2 is
    port (  switch : in std_logic;
            in1 : in std_logic_vector (31 downto 0);
            in2 : in std_logic_vector (31 downto 0);
            out1 : out std_logic_vector (31 downto 0)       
            );
end component;

component mux3 is
    port (  switch : in std_logic_vector (1 downto 0);
            in1 : in std_logic_vector (31 downto 0);
            in2 : in std_logic_vector (31 downto 0);
            in3 : in std_logic_vector (31 downto 0);
            out1 : out std_logic_vector (31 downto 0)           
            );
end component;

component reg_mux is
    port (  switch : in std_logic_vector (1 downto 0);
		    in1 : in std_logic_vector (4 downto 0);
            in2 : in std_logic_vector (4 downto 0);
		    in3 : in std_logic_vector (4 downto 0);
            out1 : out std_logic_vector (4 downto 0)	
            );
end component;
	   
component pc_buffer is
    port (  in_pc : in std_logic_vector (31 downto 0);
            clk   : in std_logic;
            out_pc: out std_logic_vector (31 downto 0)
            );
end component;

component clk_divider is
    port (  clk_in : in std_logic;
            clk_out : out std_logic
            );
end component;

component sign_extend is
    port (  port_in  : in std_logic_vector(15 downto 0);
            port_out : out std_logic_vector(31 downto 0)
            );
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------  
signal pc_address   : std_logic_vector(31 downto 0);
signal instruction  : std_logic_vector(31 downto 0);
signal instr31_26   : std_logic_vector (5 downto 0);
signal instr25_21   : std_logic_vector (4 downto 0);
signal instr20_16   : std_logic_vector (4 downto 0);
signal instr15_11   : std_logic_vector (4 downto 0);
signal instr10_6    : std_logic_vector (4 downto 0);
signal instr5_0     : std_logic_vector (5 downto 0);
signal instr15_0    : std_logic_vector (15 downto 0);
signal instr25_0    : std_logic_vector (25 downto 0);
signal Jump         : std_logic_vector(1 downto 0);
signal Branch       : std_logic;
signal MemToReg     : std_logic_vector(1 downto 0);
signal ALUOp        : std_logic_vector(1 downto 0);
signal MemRead      : std_logic;
signal MemWrite     : std_logic;
signal ALUSrc       : std_logic;
signal RegWrite     : std_logic;
signal RegDst       : std_logic_vector(1 downto 0);
signal j_SL2_out    : std_logic_vector(31 downto 0);
signal sign_ex      : std_logic_vector(15 downto 0);
signal instr15_0_ex : std_logic_vector(31 downto 0);
signal instr25_0_ex : std_logic_vector(31 downto 0);
signal RegFileWR    : std_logic_vector(4 downto 0);
signal RegFile_A    : std_logic_vector(31 downto 0);
signal RegFile_B    : std_logic_vector(31 downto 0);
signal RegFileWD    : std_logic_vector(31 downto 0);
signal ALUResult    : std_logic_vector(31 downto 0);
signal oFlow        : std_logic;
signal zFlag        : std_logic;
signal cOutALU      : std_logic;
signal ALUfunct     : std_logic_vector(5 downto 0);
signal b_sl2_out    : std_logic_vector(31 downto 0);
signal ResBA        : std_logic_vector(31 downto 0);
signal cOutBA       : std_logic;
signal andGate      : std_logic;
signal ResPCA       : std_logic_vector(31 downto 0);
signal cOutPCA      : std_logic;
signal OutDataMem   : std_logic_vector (31 downto 0);
signal b_mux_out    : std_logic_vector(31 downto 0);
signal jmuxToPC     : std_logic_vector(31 downto 0);
signal SrcMuxOut    : std_logic_vector(31 downto 0);
signal clock        : std_logic;


begin
    
    clkdiv  : clk_divider port map(
        clk_in  => ck,
        clk_out => clock
        );


    pcBuffer : pc_buffer port map(
        in_pc  => jmuxToPC,
        clk    => clock,        
        out_pc => pc_address
        );

    out_led <= RegFileWD(15 downto 0); 

    instrMemory : instr_mem port map(
        in_addr   => pc_address,
        out_instr => instruction
        );

    instr31_26 <= instruction(31 downto 26);
    instr25_21 <= instruction(25 downto 21);
    instr20_16 <= instruction(20 downto 16);
    instr15_11 <= instruction(15 downto 11);
    instr10_6  <= instruction(10 downto 6);
    instr5_0   <= instruction(5 downto 0);
    instr25_0  <= instruction(25 downto 0);
    instr15_0  <= instruction(15 downto 0);

    signExtender : sign_extend port map(
        port_in  => instr15_0,
        port_out => instr15_0_ex
        ); 

    instr25_0_ex <= instruction(25) & instruction(25) & instruction(25) & instruction(25) & instruction(25) & instruction(25) & instr25_0;

    mainController : main_control port map(
        instr    => instr31_26,
        funct    => instr5_0,
        regDst   => RegDst,
        branch   => Branch,
        memRead  => MemRead,
        memToReg => MemToReg,
        aluOp    => ALUOp,
        memWrite => MemWrite,
        aluSrc   => ALUSrc,
        regWrite => RegWrite,
        jump     => Jump  
        );

    jshifter : shift_logic port map(
        val_a   => instr25_0_ex,
        val_b   => j_SL2_out
        );
    
    bshifter : shift_logic port map(
        val_a   => instr15_0_ex,
        val_b   => b_SL2_out
        );
  
    registerFile : register_file port map(
        r_addr1 => instr25_21,
        r_addr2 => instr20_16,
        w_addr  => RegFileWR,
        w_data  => RegFileWD,
        clk     => clock,
        w_en    => RegWrite,
        r_data1 => RegFile_A,
        r_data2 => RegFile_B
        );

    process(instr31_26, instr5_0, instr31_26)
    begin
        case instr31_26 is
            when "000000" => ALUfunct <= instr5_0;
            when others => ALUfunct <= instr31_26;
        end case;
    end process;

    ALUstruct : alu port map(
        control => ALUOp,
        a       => RegFile_A,
        b       => SrcMuxOut,
        funct   => ALUfunct,
        shamt   => instr10_6,
        result  => ALUResult,
        oflow   => oFlow,
        zflag   => zFlag,
        cout    => cOutALU
        );
    
    andGate <= zFlag AND Branch;
    
    pcAdder : adder port map(
        val_a => pc_address,
        val_b => x"00000004",
        res   => resPCA,
        cout  => cOutPCA
        );

    branchAdder : adder port map(
        val_a => resPCA,
        val_b => b_SL2_out,
        res   => ResBA,
        cout  => cOutBA
        );    

    dataMem : data_mem port map(
        in_addr  => ALUResult,
        in_data  => RegFile_B,
        writeEn  => MemWrite,
        readEn   => MemRead,
        clock    => clock,
        out_data => OutDataMem
        ); 
      
    jumpMux : mux3 port map(
        switch  => Jump,
        in1     => j_SL2_out,
        in2     => b_mux_out,
        in3     => RegFile_A,
        out1    => jmuxToPC
        );

    writeRegMux : reg_mux port map(
        switch  => RegDst,
        in1     => instr20_16,
        in2     => instr15_11,
        in3     => "11111",
        out1    => RegFileWR
        );

    writeDataMux : mux3 port map(
        switch  => MemToReg,
        in1     => OutDataMem,
        in2     => ALUResult,
        in3     => ResPCA,
        out1    => RegFileWD
        );

    branchMux : mux2 port map(
        switch  => andGate,
        in1     => ResPCA,
        in2     => ResBA,
        out1    => b_mux_out
        );

    srcMux : mux2 port map(
        switch  => ALUSrc,
        in1     => RegFile_B,
        in2     => instr15_0_ex,
        out1    => SrcMuxOut
        );
        

end Structural;
