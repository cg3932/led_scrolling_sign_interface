library IEEE;
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.all;

entity g30_Flasher_Testbed is
	port (	clock : 	in std_logic;
			reset : in std_logic;
			fsel : 		in std_logic_vector (1 downto 0);
			LED1_SEGMENTS : out std_logic_vector(6 downto 0);
			LED2_SEGMENTS : out std_logic_vector(6 downto 0);
			LED3_SEGMENTS : out std_logic_vector(6 downto 0);
			LED4_SEGMENTS : out std_logic_vector(6 downto 0)
		);
end g30_Flasher_Testbed;

architecture A_F of g30_Flasher_Testbed is
	signal E_CODE : std_logic_vector(6 downto 0);
	signal R_CODE : std_logic_vector(6 downto 0);
	signal LED1_RB : std_logic;
	signal LED2_RB : std_logic;
	signal LED3_RB : std_logic;
	signal LED4_RB : std_logic;

	COMPONENT g30_Flasher
	PORT (
			clock : 	in std_logic;
			reset : in std_logic;
			fsel : 		in std_logic_vector (1 downto 0);
			MUXCODE1 : OUT std_logic_vector (6 downto 0);
			MUXCODE2 : OUT std_logic_vector (6 downto 0)
	);
	END COMPONENT;
	
	COMPONENT g30_LED_decoder
	PORT (
			code : in std_logic_vector(6 downto 0);
			RippleBlank_In : in std_logic;
			RippleBlank_Out : out std_logic;
			segments : out std_logic_vector(6 downto 0)
	);
	END COMPONENT;
BEGIN

FTB1_Flasher : g30_Flasher port map (fsel => fsel, clock => clock, reset => reset, MUXCODE1 => E_CODE, MUXCODE2 => R_CODE);

FTB_LED1 : g30_LED_decoder port map (code => E_CODE, RippleBlank_In => '1', RippleBlank_Out => LED1_RB, segments => LED1_SEGMENTS);
FTB_LED2 : g30_LED_decoder port map (code => R_CODE, RippleBlank_In => LED1_RB, RippleBlank_Out => LED2_RB, segments => LED2_SEGMENTS);
FTB_LED3 : g30_LED_decoder port map (code => R_CODE, RippleBlank_In => LED2_RB, RippleBlank_Out => LED3_RB, segments => LED3_SEGMENTS);
FTB_LED4 : g30_LED_decoder port map (code => "1111111", RippleBlank_In => LED3_RB, RippleBlank_Out => LED4_RB, segments => LED4_SEGMENTS);

END A_F;