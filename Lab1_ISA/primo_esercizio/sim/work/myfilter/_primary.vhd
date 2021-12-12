library verilog;
use verilog.vl_types.all;
entity myfilter is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        VIN             : in     vl_logic;
        VOUT            : out    vl_logic;
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
        DIN             : in     vl_logic_vector(10 downto 0);
        DOUT            : out    vl_logic_vector(10 downto 0)
    );
end myfilter;
