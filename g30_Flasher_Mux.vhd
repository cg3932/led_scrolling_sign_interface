library IEEE;
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.all;

entity g30_Flasher_Mux is
	port (	clock_FM : 	in std_logic;
			enable_FM : in std_logic;
			MUXOUT1 : OUT std_logic_vector (6 downto 0);
			MUXOUT2 : OUT std_logic_vector (6 downto 0)
		);
end g30_Flasher_Mux;

architecture A_FM of g30_Flasher_Mux is
	signal t_out : std_logic;
			
	COMPONENT lpm_tff0
	PORT (
		clock		: IN STD_LOGIC ;
		enable		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC 
	);
	END COMPONENT;
BEGIN
	FM1 : lpm_tff0 port map (clock => clock_FM, enable => enable_FM, q => t_out);

	MUXOUT1 <= "0000000" when t_out = '0' else
			"0001110" when t_out = '1' else -- E
			"0000000";
	
	MUXOUT2 <= "0000000" when t_out = '0' else
			"0011101" when t_out = '1' else -- R
			"0000000"; 
end A_FM;