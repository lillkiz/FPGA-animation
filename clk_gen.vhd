library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_gen is
    generic (
        ms_period : positive   -- amount of ms for button to be
	);        				   -- pressed before creating clock pulse
                                       
    port (
        clk50MHz : in  std_logic;
        rst      : in  std_logic;
        button_n : in  std_logic;
        clk_out  : out std_logic
	);
		  
end clk_gen;

architecture clkgen of clk_gen is

component clk_div is 
	generic( 
		clk_in_freq : natural;
		clk_out_freq : natural
	);
	port(
		clk_in: in std_logic;
		clk_out: out std_logic;
		rst: in std_logic
	);
end component;
	signal count: integer:= 0;
	signal clk :std_logic;
begin
div : clk_div
	generic map( --assignments
		clk_in_freq  => 50000000,
		clk_out_freq => 1000
	)
    port map(
        clk_in => clk50MHz,
        clk_out => clk,
        rst     => rst
	);		  
process(rst, clk)
begin
	if(rst = '1') then
			count <= 0;
			malin <= 0;
			clk_out <= 0;
	elsif(rising_edge(clk)) then
			if(button_n = '0') then
				if(count = ms_period) then
					count <= 1;
					clk_out <= '1';
				else
					count <= count + 1;
					clk_out <= '0';
				end if;
			else
				count <= 0;
				clk_out <= '0';
			end if;
	end if;
end process;
end clkgen;