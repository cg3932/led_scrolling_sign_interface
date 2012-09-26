library IEEE;
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.all;

entity g30_Flasher_Timer is
	port (	fsel : 		in std_logic_vector (1 downto 0);
			clock_FP : 	in std_logic;
			reset : in std_logic;
			Flasher_Pulse : out Std_logic
		);
end g30_Flasher_Timer;

architecture A_FT of g30_Flasher_Timer is
	signal CNST : std_logic_vector (23 downto 0);
	signal eq : std_logic_vector (23 downto 0);
	signal ORF : std_logic;
	signal cycle_complete : std_logic;
	
	COMPONENT lpm_counter0 
	PORT (
		clock : in std_logic;
		data : in std_logic_vector (23 DOWNTO 0);
		sload		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (23 DOWNTO 0)
	);
	END COMPONENT;
begin
	FT1 : lpm_counter0 port map (clock => clock_FP, data => CNST, sload => ORF, q => eq);

	CNST <= "000000000011010010111100" when fsel = "00" else -- 13500000
			"000000000001101001101000" when fsel = "01" else -- 6760000
			"000000000000110100110100" when fsel = "10" else -- 3380000
			"000000000000011010011010" when fsel = "11" else -- 1690000
			"000000000000000000000000"; -- Other
			
	cycle_complete <= '1' when eq = "000000000000000000000000" else
	'0';
	
	Flasher_Pulse <= cycle_complete;
	
	ORF <= reset OR cycle_complete;
end A_FT;