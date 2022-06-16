library IEEE;
library IEEE_PROPOSED;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
use ieee_proposed.fixed_float_types.all;
use ieee.fixed_pkg.all;
 

entity NeuralNetwork is
    Generic (n_width: natural :=16;
             n_width_act_func: natural :=16;
             n_az: integer :=n_width/2;
             n_bz: integer :=-n_width/2 +1;
             n_az_act_func: integer :=n_width_act_func/2;
             n_bz_act_func: integer :=-n_width_act_func/2+1;
             NI: integer := 1;
             NN: integer := 5;
             NNI: integer := NI+NN);
     Port ( src_clk : in STD_LOGIC;
            src_ce : in STD_LOGIC;
            Start : in STD_LOGIC;
            Reset : in STD_LOGIC;
            Input1 : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Output1 : out STD_LOGIC_VECTOR (n_width-1 downto 0);
            Ready : out STD_LOGIC); 
end NeuralNetwork;

architecture Behavioral of NeuralNetwork is
component StateController
    Generic (NI: integer;
             NN: integer;
             NNI: integer);
    Port ( clk : in STD_LOGIC;
           clk_en : in STD_LOGIC;
           Start : in STD_LOGIC;
           Reset : in STD_LOGIC;
           State : out STD_LOGIC_VECTOR (3 downto 0);
           Index : out STD_LOGIC_VECTOR (15 downto 0);
           Ready : out STD_LOGIC);
end component;

component IOController is
    Generic (n_width: natural;
             n_width_act_func: natural);
     Port ( Index : in STD_LOGIC_VECTOR (15 downto 0);
            Input1 : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Neuron1Output : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Neuron2Output : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Neuron3Output : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Neuron4Output : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Neuron5Output : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            OutputToNeurons : out STD_LOGIC_VECTOR (n_width-1 downto 0)); 
end component;

component Neuron1
    Generic (n_width: natural ;
             n_width_act_func: natural ;
             n_az: integer ;
             n_bz: integer ;
             n_az_act_func: integer;
             n_bz_act_func: integer);
     Port ( clk : in STD_LOGIC;
            State : in STD_LOGIC_VECTOR (3 downto 0);
            Index : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Input : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Output : out STD_LOGIC_VECTOR (n_width-1 downto 0)); 
end component;

component Neuron2
    Generic (n_width: natural ;
             n_width_act_func: natural ;
             n_az: integer ;
             n_bz: integer ;
             n_az_act_func: integer;
             n_bz_act_func: integer);
     Port ( clk : in STD_LOGIC;
            State : in STD_LOGIC_VECTOR (3 downto 0);
            Index : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Input : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Output : out STD_LOGIC_VECTOR (n_width-1 downto 0)); 
end component;

component Neuron3
    Generic (n_width: natural ;
             n_width_act_func: natural ;
             n_az: integer ;
             n_bz: integer ;
             n_az_act_func: integer;
             n_bz_act_func: integer);
     Port ( clk : in STD_LOGIC;
            State : in STD_LOGIC_VECTOR (3 downto 0);
            Index : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Input : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Output : out STD_LOGIC_VECTOR (n_width-1 downto 0)); 
end component;

component Neuron4
    Generic (n_width: natural ;
             n_width_act_func: natural ;
             n_az: integer ;
             n_bz: integer ;
             n_az_act_func: integer;
             n_bz_act_func: integer);
     Port ( clk : in STD_LOGIC;
            State : in STD_LOGIC_VECTOR (3 downto 0);
            Index : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Input : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Output : out STD_LOGIC_VECTOR (n_width-1 downto 0)); 
end component;

component Neuron5
    Generic (n_width: natural ;
             n_width_act_func: natural ;
             n_az: integer ;
             n_bz: integer ;
             n_az_act_func: integer;
             n_bz_act_func: integer);
     Port ( clk : in STD_LOGIC;
            State : in STD_LOGIC_VECTOR (3 downto 0);
            Index : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Input : in STD_LOGIC_VECTOR (n_width-1 downto 0);
            Output : out STD_LOGIC_VECTOR (n_width-1 downto 0)); 
end component;



signal State : std_logic_vector(3 DOWNTO 0);  
signal Index : STD_LOGIC_VECTOR(15 downto 0);

signal Input : STD_LOGIC_VECTOR (n_width-1 downto 0);

signal Neuron1Output : STD_LOGIC_VECTOR (n_width-1 downto 0);
signal Neuron2Output : STD_LOGIC_VECTOR (n_width-1 downto 0);
signal Neuron3Output : STD_LOGIC_VECTOR (n_width-1 downto 0);
signal Neuron4Output : STD_LOGIC_VECTOR (n_width-1 downto 0);
signal Neuron5Output : STD_LOGIC_VECTOR (n_width-1 downto 0);

begin

c : StateController 
GENERIC MAP(
    NI=>NI,
    NN=>NN,
    NNI=>NNI
)
PORT MAP(
    clk =>src_clk,
    clk_en =>src_ce,
    Start =>Start,
    Reset =>Reset,
    State =>State,
    Index =>Index,
    Ready =>Ready
);

IOC : IOController 
GENERIC MAP(
    n_width =>n_width,
    n_width_act_func =>n_width_act_func
)
PORT MAP( 
    Index =>Index,
    Input1 =>Input1,
    Neuron1Output =>Neuron1Output,
    Neuron2Output =>Neuron2Output,
    Neuron3Output =>Neuron3Output,
    Neuron4Output =>Neuron4Output,
    Neuron5Output =>Neuron5Output,
    OutputToNeurons =>Input
);

n1 : Neuron1  
GENERIC MAP(
     n_width=> n_width,
     n_width_act_func=>n_width_act_func ,
     n_az=>n_az ,
     n_bz=> n_bz,
     n_az_act_func=>n_az_act_func,
     n_bz_act_func=> n_bz_act_func
)
PORT MAP(
    clk =>src_clk,
    State =>State,
    Index =>Index,
    Input =>Input,
    Output =>Neuron1Output
);

n2 : Neuron2 
GENERIC MAP(
     n_width=> n_width,
     n_width_act_func=>n_width_act_func ,
     n_az=>n_az ,
     n_bz=> n_bz,
     n_az_act_func=>n_az_act_func,
     n_bz_act_func=> n_bz_act_func
)
PORT MAP(
    clk =>src_clk,
    State =>State,
    Index =>Index,
    Input =>Input,
    Output =>Neuron2Output
);

n3 : Neuron3 
GENERIC MAP(
     n_width=> n_width,
     n_width_act_func=>n_width_act_func ,
     n_az=>n_az ,
     n_bz=> n_bz,
     n_az_act_func=>n_az_act_func,
     n_bz_act_func=> n_bz_act_func
)
PORT MAP(
    clk =>src_clk,
    State =>State,
    Index =>Index,
    Input =>Input,
    Output =>Neuron3Output
);

n4 : Neuron4 
GENERIC MAP(
     n_width=> n_width,
     n_width_act_func=>n_width_act_func ,
     n_az=>n_az ,
     n_bz=> n_bz,
     n_az_act_func=>n_az_act_func,
     n_bz_act_func=> n_bz_act_func
)
PORT MAP(
    clk =>src_clk,
    State =>State,
    Index =>Index,
    Input =>Input,
    Output =>Neuron4Output
);

n5 : Neuron5 
GENERIC MAP(
     n_width=> n_width,
     n_width_act_func=>n_width_act_func ,
     n_az=>n_az ,
     n_bz=> n_bz,
     n_az_act_func=>n_az_act_func,
     n_bz_act_func=> n_bz_act_func
)
PORT MAP(
    clk =>src_clk,
    State =>State,
    Index =>Index,
    Input =>Input,
    Output =>Neuron5Output
);


Output1 <=Neuron5Output;

end Behavioral;
