library verilog;
use verilog.vl_types.all;
entity myfilter is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        VIN1            : in     vl_logic;
        VIN2            : in     vl_logic;
        VIN3            : in     vl_logic;
        VOUT1           : out    vl_logic;
        VOUT2           : out    vl_logic;
        VOUT3           : out    vl_logic;
        H0              : in     vl_logic_vector(10 downto 0);
        H1              : in     vl_logic_vector(10 downto 0);
        H2              : in     vl_logic_vector(10 downto 0);
        H3              : in     vl_logic_vector(10 downto 0);
        H4              : in     vl_logic_vector(10 downto 0);
        H5              : in     vl_logic_vector(10 downto 0);
        H6              : in     vl_logic_vector(10 downto 0);
        H7              : in     vl_logic_vector(10 downto 0);
        H8              : in     vl_logic_vector(10 downto 0);
        H9              : in     vl_logic_vector(10 downto 0);
        H10             : in     vl_logic_vector(10 downto 0);
        DIN1            : in     vl_logic_vector(10 downto 0);
        DIN2            : in     vl_logic_vector(10 downto 0);
        DIN3            : in     vl_logic_vector(10 downto 0);
        DOUT1           : out    vl_logic_vector(10 downto 0);
        DOUT2           : out    vl_logic_vector(10 downto 0);
        DOUT3           : out    vl_logic_vector(10 downto 0)
    );
end myfilter;
