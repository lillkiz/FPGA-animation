library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_div is
    generic(
		clk_in_freq  : natural;
        clk_out_freq : natural
	);
    port (
        clk_in  : in  std_logic;
        clk_out : out std_logic;
        rst     : in  std_logic
	);
end clk_div;

architecture clkdiv of clk_div is
	constant max: integer := clk_in_freq/clk_out_freq;
	signal count: integer;
begin
process(clk_in, rst)
begin
	if(rst='1') then
		clk_out<= '0';
	elsif (rising_edge(clk_in)) then
		if(count = max) then
			clk_out<= '1';
			count = 0;
		else
			count<= count + 1;
			clk_out<='0';
		end if;
	end if;
end process;
end clkdiv;
