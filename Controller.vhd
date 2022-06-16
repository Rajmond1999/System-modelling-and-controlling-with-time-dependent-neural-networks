library IEEE;
library IEEE_PROPOSED;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
use ieee_proposed.fixed_float_types.all;
use ieee.fixed_pkg.all;



entity Controller is
    Generic (NI: integer := 1;
             NN: integer := 5;
             NNI: integer := NI+NN);

    Port ( clk : in STD_LOGIC;
           clk_en : in STD_LOGIC;
           Start : in STD_LOGIC;
           Reset : in STD_LOGIC;
           State : out STD_LOGIC_VECTOR (3 downto 0);
           Index : out unsigned (15 downto 0);
           Ready : out STD_LOGIC);
end Controller;

architecture Behavioral of Controller is

--type States is (Strt, Rdy,SetUp1, AddAndMultiply,CompareAndCopy, LReLuAndOut) ;
--signal Act_State, Next_State :States := Strt;

constant Strt : std_logic_vector(3 downto 0) := 0x"0";
constant Rdy : std_logic_vector(3 downto 0) := 0x"1";
constant AddAndMultiply : std_logic_vector(3 downto 0) := 0x"2";
constant CompareAndCopy : std_logic_vector(3 downto 0) := 0x"3";
constant LReLuAndOut : std_logic_vector(3 downto 0) := 0x"4";

signal Act_State, Next_State : std_logic_vector(3 downto 0) := 0x"0";

signal Index_next : unsigned(15 downto 0):=0x"0000";
 
begin

State_Reg: process(clk,reset)
begin
    if(reset='1') then
        Act_State <= Strt;
    else
        if(rising_edge(clk) and clk_en = '1') then
            Act_State <= Next_State;
        end if;
    end if;
end process State_Reg;



Next_State_Logic: process(Act_State, Start, clk)
begin
 case Act_State is 
    when Strt => 
        if(start = '1') then
            Next_State <= AddAndMultiply;
        else
            Next_State <= Strt;
        end if;
    when Rdy => 
        if(start = '1') then
            Next_State <= AddAndMultiply;
        else
            Next_State <= Rdy;
        end if;
    when AddAndMultiply => 
        if(Index<NNI) then
            Next_State <= AddAndMultiply;
        else
            Next_State <= CompareAndCopy;
        end if;    
    when CompareAndCopy =>
        Next_State <= LReLuAndOut;
    when LReLuAndOut =>
        Next_State <= Rdy;
    when others => 
        Next_State <= Strt;    
 end case;
end process Next_State_Logic;

WITH Act_State SELECT Index_next <= 
    x"0000" WHEN Strt,
    x"0000" WHEN Rdy,
    Index+1 WHEN AddAndMultiply,
    x"0000" WHEN others;

Index_reg: process(clk)
    begin
        if (rising_edge(clk)) then
            Index<=Index_next;
        end if;
    end process Index_reg;

WITH Act_State SELECT Ready <= 
    '1' WHEN Strt,
    '1' WHEN Rdy,
    '0' WHEN others;
    

State <= Act_State;

end Behavioral;
