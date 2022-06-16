library IEEE;
library IEEE_PROPOSED;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
use ieee_proposed.fixed_float_types.all;
use ieee.fixed_pkg.all;


entity IOController is
    Generic (n_width: natural :=16;
             n_width_act_func: natural :=16);
     Port ( Index : in STD_LOGIC_VECTOR (15 downto 0);
            Input1 : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Neuron1Output : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Neuron2Output : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Neuron3Output : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Neuron4Output : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Neuron5Output : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            OutputToNeurons : out STD_LOGIC_VECTOR (n_width-1 downto 0)); 
end IOController;

architecture Behavioral of IOController is


begin


WITH Index SELECT OutputToNeurons <= 
    Input1 WHEN STD_LOGIC_VECTOR(to_unsigned(0,n_width)),
    Neuron1Output WHEN STD_LOGIC_VECTOR(to_unsigned(1,n_width)),
    Neuron2Output WHEN STD_LOGIC_VECTOR(to_unsigned(2,n_width)),
    Neuron3Output WHEN STD_LOGIC_VECTOR(to_unsigned(3,n_width)),
    Neuron4Output WHEN STD_LOGIC_VECTOR(to_unsigned(4,n_width)),
    Neuron5Output WHEN STD_LOGIC_VECTOR(to_unsigned(5,n_width)),
    STD_LOGIC_VECTOR(to_unsigned(0,n_width)) WHEN others;

end Behavioral;
