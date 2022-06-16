library IEEE;
library IEEE_PROPOSED;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
--use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee_proposed.fixed_float_types.all;
use ieee.fixed_pkg.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Neuron3 is
    Generic (n_width: natural :=16;
             n_width_act_func: natural :=16;
             n_az: integer :=n_width/2;
             n_bz: integer :=-n_width/2 +1;
             n_az_act_func: integer :=n_width_act_func/2;
             n_bz_act_func: integer :=-n_width_act_func/2+1);
             
     Port ( clk : in STD_LOGIC;
            State : in STD_LOGIC_VECTOR (3 downto 0);
            Index : in STD_LOGIC_VECTOR (15 downto 0);
            Input : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Output : out STD_LOGIC_VECTOR (n_width-1 downto 0)); 
end Neuron3;



architecture Behavioral of Neuron3 is

signal  Infx, S, S_Next, Y, Y_Next: sfixed(n_az downto n_bz);
constant az: sfixed(n_az_act_func downto n_bz_act_func):=to_sfixed(1, n_az_act_func,n_bz_act_func);--above zero
constant bz: sfixed(n_az_act_func downto n_bz_act_func):=to_sfixed(0.001, n_az_act_func,n_bz_act_func);--below zero
signal abz: sfixed(n_az_act_func downto n_bz_act_func);


type FixedPointArray is array(0 to 5) of sfixed(n_az downto n_bz);

constant W: FixedPointArray:=(to_sfixed(0, n_az,n_bz),to_sfixed(0, n_az,n_bz), to_sfixed(1, n_az,n_bz), to_sfixed(0, n_az,n_bz), to_sfixed(0, n_az,n_bz), to_sfixed(0, n_az,n_bz));
begin





------------------------------S


WITH State SELECT S_Next <= 
    to_sfixed(0, n_az,n_bz) WHEN 0x"0",
    to_sfixed(0, n_az,n_bz) WHEN 0x"1",
    resize((Infx*W(to_integer(unsigned(Index))))+S, S) WHEN 0x"2",
    S WHEN others;
    

S_Reg: process(clk)
    begin
        if (rising_edge(clk)) then
            S<=S_Next;
        end if;
    end process S_Reg;

------------------------------Y
WITH State SELECT Y_Next <= 
    to_sfixed(0, n_az,n_bz) WHEN 0x"0",
    Y WHEN 0x"1",
    resize(S*abz, S) WHEN 0x"4",
    Y WHEN others;
    
Y_Reg: process(clk)
    begin
        if (rising_edge(clk)) then
            Y<=Y_Next;
        end if;
    end process Y_Reg;
    
    
    
Act_Func: process(clk,State)
begin
    if (State = 0x"3") then
        if(S > to_sfixed(0, n_bz_act_func,n_bz_act_func)) then
            abz<=az;
        else
            abz<=bz;
        end if;
        
    end if;
end process Act_Func;

Output <= STD_LOGIC_VECTOR(Y);
Infx <= to_sfixed(Input, n_az,n_bz);
end Behavioral;