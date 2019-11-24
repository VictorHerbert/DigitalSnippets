library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity CPU is
	port(
		clk				: in std_logic;
		cpu_inst_data	: in std_logic_vector(7 downto 0);
		cpu_halt			: out std_logic;
		reset				: in std_logic;
				
		reg_a_data_in 	: out std_logic;
		reg_b_data_in 	: out std_logic;
		reg_c_data_in	: out std_logic;
		reg_c_data_out	: out std_logic;
		
		key_register_out : out std_logic;
		key_has_data : in std_logic;
		
		seg_out_reg_data_in : out std_logic;
		
		alu_op_code			: out std_logic_vector(7 downto 0);
		
		mar_ram_data_in	: out std_logic;
		ram_data_in 		: out std_logic;
		ram_data_out 		: out std_logic;
		ram_data_write 	: out std_logic;
		
		mar_flash_data_in	: out std_logic;		
	
		flash_data_out		: out std_logic;
		flash_inst_t		: out std_logic;
		
		pg_data_in			: out std_logic;
		pg_data_out			: out std_logic;
		pg_data_inc			: out std_logic;		
		
		ir_data_in			: out std_logic;
		ir_data_out			: out std_logic
	);
end CPU;

architecture arch of CPU is
	
	constant inst_LDA : std_logic_vector(7 downto 0) := x"00";
	constant inst_LDB: std_logic_vector(7 downto 0) := x"01";
	constant inst_AND: std_logic_vector(7 downto 0) := x"02";
	constant inst_OR: std_logic_vector(7 downto 0) := x"03";
	constant inst_XOR: std_logic_vector(7 downto 0) := x"04";
	constant inst_ADD: std_logic_vector(7 downto 0) := x"05";
	constant inst_SUB: std_logic_vector(7 downto 0) := x"06";
	constant inst_MUL: std_logic_vector(7 downto 0) := x"07";
	constant inst_STA: std_logic_vector(7 downto 0) := x"08";
	constant inst_JMP: std_logic_vector(7 downto 0) := x"09";
	constant inst_JMPIF: std_logic_vector(7 downto 0) := x"0A";
	constant inst_OUTLD: std_logic_vector(7 downto 0) := x"0B";
	constant inst_HALTOUT: std_logic_vector(7 downto 0) := x"0C";
	constant inst_CIN: std_logic_vector(7 downto 0) := x"0D";
	constant inst_MVK: std_logic_vector(7 downto 0) := x"0E";
	constant inst_MVB: std_logic_vector(7 downto 0) := x"0F";
	
	constant inst_HALT: std_logic_vector(7 downto 0) := x"FF";
	
begin

process(reset,clk)
	variable counter : integer range 0 to 10 := 0; 
begin
	if(reset = '1') then
		cpu_halt <= '0';
	elsif(rising_edge(clk)) then
		if(counter = 0) then
			pg_data_out <= '1';
			mar_flash_data_in <= '1';
			
			pg_data_inc <='0';		
			reg_a_data_in <='0';
			reg_c_data_out <='0';			
			flash_data_out <= '0';
			ir_data_in <= '0';
			flash_inst_t <= '0';
			pg_data_in <= '0';
			cpu_halt <= '0';
			key_register_out <= '0';
			reg_c_data_in <= '1';
			
		elsif(counter = 1) then
			mar_flash_data_in <= '0';	
		elsif(counter = 2) then
			pg_data_out <= '0';
			flash_data_out <= '1';
			ir_data_in <= '1';
			pg_data_inc <='1';
		elsif(counter = 3) then
			ir_data_in <= '0';
			pg_data_inc <='0';
		elsif(counter = 4) then
			flash_data_out <= '0';
		elsif(counter = 5) then	
			case cpu_inst_data is
				when inst_LDA =>
					flash_inst_t <= '1';
					flash_data_out <= '1';
					reg_a_data_in <= '1';
				when inst_LDB =>
					flash_inst_t <= '1';
					flash_data_out <= '1';
					reg_b_data_in <= '1';
				when inst_AND =>
					alu_op_code <= x"00";
					counter := 10;
				when inst_OR =>
					alu_op_code <= x"01";
					counter := 10;
				when inst_XOR =>
					alu_op_code <= x"02";
					counter := 10;
				when inst_ADD =>
					alu_op_code <= x"03";
					counter := 10;
				when inst_SUB =>
					alu_op_code <= x"04";
					counter := 10;
				when inst_MUL =>
					alu_op_code <= x"05";
					counter := 10;
				when inst_STA =>
					alu_op_code <= x"ff";
					flash_inst_t <= '1';
					flash_data_out <= '1';
					mar_ram_data_in <= '1';
				when inst_JMP =>
					flash_inst_t <= '1';
					flash_data_out <= '1';
					pg_data_in <= '1';
				when inst_JMPIF =>
				when inst_HALTOUT =>
					reg_c_data_out <= '1';
				when inst_CIN =>
					if(key_has_data = '0') then
						key_register_out <= '1';
						counter := 4;
					end if;
				when inst_MVK =>
					key_register_out <= '1';
					reg_a_data_in <= '1';
				when inst_MVB =>
					alu_op_code <= x"FF";
				when inst_HALT =>
					cpu_halt <= '1';
					counter := 10;
				when others =>
					counter := 10;
			end case;
		elsif(counter = 6) then
			case cpu_inst_data is
				when inst_LDA =>
					reg_a_data_in <= '0';
					counter := 10;					
				when inst_LDB =>
					reg_b_data_in <= '0';
					counter := 10;
				when inst_STA =>
					mar_ram_data_in <= '0';
				when inst_JMP =>
					pg_data_in <= '0';
				when inst_CIN =>
					if(key_has_data = '1') then
						counter := 5;
					else
						counter := 10;
					end if;
				when inst_MVK =>
					reg_a_data_in <= '0';
				when inst_MVB =>
					reg_c_data_out <= '1';
					reg_b_data_in <= '1';
				when inst_HALTOUT =>
					cpu_halt <= '1';
					if(key_has_data = '0') then
						counter := 5;
					else
						counter := 10;
					end if;
				when others =>
					counter := 10;
			end case;
		elsif(counter = 7) then
			case cpu_inst_data is				
				when inst_STA =>
					reg_c_data_out <= '1';
					ram_data_in <= '1';
				when inst_JMP =>
					counter := 10;
				when inst_JMPIF =>
				when inst_MVK =>
					key_register_out <= '0';
					counter := 10;
				when inst_MVB =>
					reg_b_data_in <= '0';
				when inst_HALTOUT =>
					if(key_has_data = '1') then
						counter := 5;
					else
						counter := 10;
					end if;
				when others =>
					counter := 10;
			end case;

		elsif(counter = 8) then
			case cpu_inst_data is
				when inst_STA =>
					ram_data_in <= '1';
				when inst_MVB =>
					reg_c_data_out <= '0';
					counter := 10;
				when inst_JMPIF =>
				when inst_HALTOUT =>
				when others =>
					counter := 10;
			end case;
		
		elsif(counter = 9) then
			case cpu_inst_data is
				when inst_STA =>
					ram_data_in <= '0';
					counter := 10;
				when inst_JMP =>
				when inst_JMPIF =>
				when others =>
					counter := 10;
			end case;		
		end if;
		
		if(counter < 10) then
			counter := counter+1;
		else
			counter := 0;
		end if;
	end if;
end process;


end arch;