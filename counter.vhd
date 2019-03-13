library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        up_n   : in  std_logic;         -- active low
        load_n : in  std_logic;         -- active low
        input  : in  std_logic_vector(3 downto 0);
        output : out std_logic_vector(3 downto 0));
end counter;

architecture count of counter is
	signal counter: integer := 0;
begin
	process(rst, clk)
	begin
		if(rst='1') then
		counter <= 0;
		elsif(rising_edge(clk)) then
			if(load_n='0') then
				counter<= to_integer(unsigned('0' & input));
			elsif(up_n = '0') then
				counter<= counter+1;
				if(counter>=15) then
					counter<= 0;
				end if;
		else
		counter<= counter-1;
			if(counter=0) then
				counter<=15;
			end if;
		end if;
	end if;
end process;
	output<= std_logic_vector(to_unsigned(counter, output'length));
end count;