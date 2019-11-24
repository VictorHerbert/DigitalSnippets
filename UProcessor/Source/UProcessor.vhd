library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Uprocessor is
generic(
		n : integer := 8
	);
	port (
		HEX0 		: out std_logic_vector(6 downto 0);
		HEX1 		: out std_logic_vector(6 downto 0);
		HEX2 		: out std_logic_vector(6 downto 0);
		HEX3 		: out std_logic_vector(6 downto 0);
		
		LEDR	 	: out std_logic_vector(9 downto 0);
		LEDG	 	: out std_logic_vector(7 downto 0);
		SW		 	: in std_logic_vector(9 downto 0);
		KEY	 	: in std_logic_vector(3 downto 0);
		CLOCK_50 : in std_logic;
		
		FL_ADDR	: out std_logic_vector(21 downto 0);
		FL_DQ		: in std_logic_vector(7 downto 0);
		FL_OE_N	: out std_logic;
		FL_RST_N	: out std_logic;
		FL_WE_N	: out std_logic;
		
		PS2_CLK 		: in std_logic;
		PS2_DAT		: in std_logic
	);
end uProcessor;

architecture arch of uProcessor is
	component PS2_KEYBOARD is
		port(
			PS2_CLK 		: in std_logic;
			PS2_DAT		: in std_logic;
			ps2_code		: out std_logic_vector(7 downto 0);
			has_data		: out std_logic
		);
	end component;
	
	component KEY_register is
		port(
			data_bus_in	: in std_logic_vector(7 downto 0);
			data_bus_out: out std_logic_vector(7 downto 0);
			data_in		: in std_logic;
			data_out		: in std_logic;
			has_data		: out std_logic;
			clk			: in std_logic;
			reset			: in std_logic
		);
	end component;

	component clk_divider is
		generic(
			multiplier 	: integer
		);
		port(
			clk_in	: in std_logic;
			clk_out	: out std_logic
		);
	end component;

------------------------------------------------------------------------------------------
	
	component Displays_7seg_decoder is
		port (
			number	: in std_logic_vector(7 downto 0);
			hasSigBit: in std_logic;
			HEX0 		: out std_logic_vector(6 downto 0);
			HEX1	 	: out std_logic_vector(6 downto 0);
			HEX2 		: out std_logic_vector(6 downto 0);
			HEX3 		: out std_logic_vector(6 downto 0)
		);
	end component;
	
------------------------------------------------------------------------------------------
	
	component Program_counter is
		generic(
			n : integer
		);
		port(
			reset_address 	: in std_logic_vector(n-1 downto 0);
			data_bus_in		: in std_logic_vector(n-1 downto 0);
			data_bus_out	: out std_logic_vector(n-1 downto 0);
			data_in			: in std_logic;
			data_out			: in std_logic;
			clk				: in std_logic;
			count_inc		: in std_logic;
			reset				: in std_logic
		);
	end component;
	
	component Instruction_Register is
		generic(
			n 					: integer;
			cpu_inst_size 	: integer
		);
		port(
			data_bus_in	: in std_logic_vector(n-1 downto 0);
			data_bus_out: out std_logic_vector(n-1 downto 0);
			CPU_inst		: out std_logic_vector (cpu_inst_size-1 downto 0) ;
			data_in		: in std_logic;
			data_out		: in std_logic;
			reset			: in std_logic
		);
	end component;

------------------------------------------------------------------------------------------

	component main_bus_parser is
		generic(n : integer);
		port(
			bus1 : in std_logic_vector(n-1 downto 0);
			bus2 : in std_logic_vector(n-1 downto 0);
			bus3 : in std_logic_vector(n-1 downto 0);
			bus4 : in std_logic_vector(n-1 downto 0);
			bus5 : in std_logic_vector(n-1 downto 0);
			bus6 : in std_logic_vector(n-1 downto 0);
			bus7 : in std_logic_vector(n-1 downto 0);
			bus8 : in std_logic_vector(n-1 downto 0);
			bus9 : in std_logic_vector(n-1 downto 0);
			bus10 : in std_logic_vector(n-1 downto 0);
			bus11 : in std_logic_vector(n-1 downto 0);
			bus12 : in std_logic_vector(n-1 downto 0);
			bus_out : out std_logic_vector(n-1 downto 0)
		);
	end component;
	
------------------------------------------------------------------------------------------

	component GP_register is
		generic(
			n : integer
		);
		port(
			data_bus_in	: in std_logic_vector(n-1 downto 0);
			data_bus_out: out std_logic_vector(n-1 downto 0);
			data_in		: in std_logic;
			data_out		: in std_logic;
			clk			: in std_logic;
			reset			: in std_logic
		);
	end component;
	
------------------------------------------------------------------------------------------

	component ALU is
		generic(
			n : integer
		);
		port(
			a,b 			: in std_logic_vector(n-1 downto 0);
			s 				: out std_logic_vector(n-1 downto 0);
			op_code 		: in std_logic_vector(7 downto 0);
			flags			: out std_logic_vector(7 downto 0)
		);
	end component;
	
------------------------------------------------------------------------------------------
------- Memory
------------------------------------------------------------------------------------------
	
	component RAM is
		port(
			address 			: in std_logic_vector(7 downto 0);
			data_bus_in 	: in std_logic_vector(7 downto 0);
			data_bus_out	: out std_logic_vector(7 downto 0);
			data_in 			: in std_logic;
			data_out 		: in std_logic;
			data_write 		: in std_logic
		);
	end component;
	
	component flash is
		port(
			FL_ADDR	: out std_logic_vector(20 downto 0);
			FL_DQ		: out std_logic_vector(8 downto 0);
			FL_OE_N	: out std_logic;
			FL_RST_N	: out std_logic;
			FL_WE_N	: out std_logic
		);
	end component;


------------------------------------------------------------------------------------------
------- CPU
------------------------------------------------------------------------------------------
	

	component CPU is
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
	end component;

------------------------------------------------------------------------------------------
------- Signals
------------------------------------------------------------------------------------------

	signal main_bus 				: std_logic_vector(n-1 downto 0) := (others => '0');
	signal sw_bus 					: std_logic_vector(n-1 downto 0) := (others => '0');

------------------------------------------------------------------------------------------	
	
	signal cpu_inst_data : std_logic_vector(7 downto 0);
	signal cpu_halt 		: std_logic := '0';
	
------------------------------------------------------------------------------------------	
	
	signal clk_out, clk_ext, clk_int, clk: std_logic;
	signal reset: std_logic;
------------------------------------------------------------------------------------------	
	
	signal ir_bus_out 		: std_logic_vector(n-1 downto 0) := (others => '0');
	signal ir_data_in 		: std_logic;
	signal ir_data_out 		: std_logic;
	signal ir_clk 				: std_logic;
	signal ir_reset 			: std_logic;
	
------------------------------------------------------------------------------------------		

	signal pg_bus_out 	: std_logic_vector(n-1 downto 0) := (others => '0');	
	signal pg_data_in 				: std_logic;
	signal pg_data_out 				: std_logic;
	signal pg_clk 				: std_logic;
	signal pg_reset 			: std_logic;
	signal pg_data_inc 				: std_logic;
	
------------------------------------------------------------------------------------------
	
	signal led_bus_out : std_logic := '0';
	signal led_out_reg_bus_out : std_logic_vector(n-1 downto 0); 
	signal led_out_reg_data_in : std_logic;
	signal led_out_reg_data_out: std_logic;
	signal led_out_reg_reset	: std_logic;
			
	signal seg_out_reg_bus_out : std_logic_vector(7 downto 0); 
	signal seg_out_reg_data_in : std_logic;
	signal seg_out_reg_data_out: std_logic;
	signal seg_out_reg_reset	: std_logic;

------------------------------------------------------------------------------------------
	
	signal reg_a_bus_out : std_logic_vector(n-1 downto 0) := (others => '0');	
	signal reg_a_data_in	: std_logic;
	signal reg_a_data_out: std_logic;
	signal reg_a_reset	: std_logic;
	
	signal reg_b_bus_out : std_logic_vector(n-1 downto 0) := (others => '0');	
	signal reg_b_data_in	: std_logic;
	signal reg_b_data_out: std_logic;
	signal reg_b_reset	: std_logic;
	
	signal reg_c_bus_in : std_logic_vector(n-1 downto 0) := (others => '0');	
	signal reg_c_bus_out : std_logic_vector(n-1 downto 0) := (others => '0');	
	signal reg_c_data_in	: std_logic;
	signal reg_c_data_out: std_logic;
	signal reg_c_reset	: std_logic;
	
	signal alu_op_code : std_logic_vector(7 downto 0) := "00000110";--(others => '0');	
	signal alu_flags : std_logic_vector(7 downto 0) := (others => '0');

------------------------------------------------------------------------------------------

	signal mar_ram_bus_out : std_logic_vector(n-1 downto 0) := (others => '0');	
	signal mar_ram_data_in	: std_logic;
	signal mar_ram_data_out: std_logic;
	signal mar_ram_reset	: std_logic;	
	
	signal ram_bus_out : std_logic_vector(n-1 downto 0) := (others => '0');	
	signal ram_data_in	: std_logic;
	signal ram_data_out,ram_data_write: std_logic;
	signal ram_reset	: std_logic;
	
	signal mar_flash_bus_out : std_logic_vector(n-1 downto 0) := (others => '0');	
	signal mar_flash_data_in	: std_logic;
	signal mar_flash_data_out: std_logic;
	signal mar_flash_reset	: std_logic;	
	
	signal flash_bus_out : std_logic_vector(n-1 downto 0) := (others => '0');	
	signal flash_data_in	: std_logic;
	signal flash_data_out: std_logic;
	signal flash_reset	: std_logic;
	signal flash_inst_t	: std_logic;
	
	signal fl_out_en : std_logic;
	signal flash_data_bus : std_logic_vector(n-1 downto 0);
	
	signal key_out_reg_bus_out, ps2_code : std_logic_vector(7 downto 0);
	signal key_out_reg_data_out : std_logic;
	signal ps2_has_data,key_reg_has_data : std_logic;
	
	signal counter : std_logic_vector(7 downto 0) := x"00";
	

	
------------------------------------------------------------------------------------------
------- Teclado
------------------------------------------------------------------------------------------
begin

	keyboard : PS2_KEYBOARD
		port map(
			PS2_CLK,
			PS2_DAT,
			ps2_code,
			ps2_has_data
		);
		
	keyboard_register : KEY_register
		port map(
			ps2_code,
			key_out_reg_bus_out,
			'1',
			key_out_reg_data_out,
			key_reg_has_data,
			not ps2_has_data,
			reset
		);
		
	
	process(ps2_has_data)
	begin
		if(rising_edge(ps2_has_data)) then
			counter <= counter + x"01";
		end if;
	end process;
	
------------------------------------------------------------------------------------------
------- Barramento
------------------------------------------------------------------------------------------

	bus_manager : main_bus_parser
		generic map(n)
		port map(
			pg_bus_out,			
			reg_c_bus_out,		
			flash_data_bus,
			ram_bus_out,
			key_out_reg_bus_out,
			(others => '0'),
			(others => '0'),
			(others => '0'),
			(others => '0'),
			(others => '0'),
			(others => '0'),
			(others => '0'),
			main_bus
		);

------------------------------------------------------------------------------------------
------- Clock
------------------------------------------------------------------------------------------

	CLOK_1HZ_GEN : clk_divider
		generic map(400_000)
		port map(
			CLOCK_50,
			clk_int
		);
--		
clk_out <= (clk or cpu_halt);

clk <=  clk_int when SW(9) = '1' else
	clk_ext;

clk_ext <= KEY(0);

------------------------------------------------------------------------------------------
------- Displays
------------------------------------------------------------------------------------------,,	

LEDR(9) <= clk;


LEDG(7 downto 0) <= main_bus(7 downto 0);

LEDR(0) <= cpu_halt;
lEDR(1) <= pg_data_out;
lEDR(6) <= key_out_reg_data_out;
LEDR(7) <= ps2_has_data;


reset <= not KEY(1);
	
	led_bus_out <= '1';
	led_register : GP_register
		generic map(8)
		port map(
			main_bus(7 downto 0),
			led_out_reg_bus_out,
			'1',
			'1',
			clk_out,
			reset
		);
		
	seg_output_register : GP_register
		generic map(8)
		port map(
			main_bus,
			seg_out_reg_bus_out,
			'1',
			'1',
			clk_out,
			reset
		);

	Display : Displays_7seg_decoder
		port map(
			seg_out_reg_bus_out(7 downto 0),
			'0',-- Unsigned
			HEX0,
			HEX1,
			HEX2,
			HEX3
		);
------------------------------------------------------------------------------------------
------- ULA - Unidade Logico Aritmetica
------------------------------------------------------------------------------------------
	reg_a : GP_register
		generic map(n)
		port map(
			main_bus(n-1 downto 0),
			reg_a_bus_out,
			reg_a_data_in,
			'1',
			clk_out,
			reset
		);
		
	reg_b : GP_register
		generic map(n)
		port map(
			main_bus(n-1 downto 0),
			reg_b_bus_out,
			reg_b_data_in,
			'1',
			clk_out,
			reset
		);
			
	reg_c : GP_register
		generic map(n)
		port map(
			reg_c_bus_in,
			reg_c_bus_out,
			reg_c_data_in,
			reg_c_data_out,
			clk_out,
			reset
		);
		
	ULA : ALU
		generic map(n)
		port map(
			reg_a_bus_out,
			reg_b_bus_out,
			reg_c_bus_in,
			alu_op_code,
			alu_flags
		);
		
------------------------------------------------------------------------------------------
------- Memorias
------------------------------------------------------------------------------------------

	mar_ram : GP_register
		generic map(n)
		port map(
			main_bus,
			mar_ram_bus_out,
			mar_ram_data_in,
			'1',
			clk_out,
			reset
		);

		
	ram_mem : RAM
		port map(
			mar_ram_bus_out,
			main_bus,
			ram_bus_out,
			ram_data_in,
			ram_data_out,
			ram_data_write
		);
					
	mar_flash : GP_register
		generic map(n)
		port map(
			main_bus,
			mar_flash_bus_out,
			mar_flash_data_in,
			'1',
			clk_out,
			reset
		);
	
	flash_data_bus <=
			FL_DQ when flash_data_out = '1' else
			(others => 	'0');
	
	FL_ADDR	<= "0000000000000" & mar_flash_bus_out & flash_inst_t;
	
	FL_OE_N <= not flash_data_out;

	FL_RST_N	<= '1';
	FL_WE_N	<= '1';
	

------------------------------------------------------------------------------------------
------- Instrucoes e processamento
------------------------------------------------------------------------------------------	

	Prog_Counter : Program_counter
			generic map(n)
			port map(
				sw(7 downto 0),
				main_bus,
				pg_bus_out,
				pg_data_in,
				pg_data_out,
				clk_out,
				pg_data_inc,
				reset
			);

	Inst_Reg: GP_register
		generic map(n)
		port map(
			main_bus,
			ir_bus_out,
			ir_data_in,
			'1',
			clk_out,
			reset
		);
	
	central_process_unit : CPU 
		port map(
			clk_out,
			ir_bus_out(7 downto 0),
			cpu_halt,
			reset,
					
			reg_a_data_in,
			reg_b_data_in,
			reg_c_data_in,
			reg_c_data_out,
			
			key_out_reg_data_out,
			key_reg_has_data,
			
			seg_out_reg_data_in,
			
			alu_op_code,
			
			mar_ram_data_in,
			ram_data_in,
			ram_data_out,
			ram_data_write,
		
			mar_flash_data_in,			
			
			flash_data_out,
			flash_inst_t,
			
			pg_data_in,
			pg_data_out,
			pg_data_inc,
			
			ir_data_in,
			ir_data_out
		);
				

end arch;