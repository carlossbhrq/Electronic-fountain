-- Parte operativa do chafariz eletronico

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PO is
port(
    tot_ld, tot_clr, clk: in std_logic;
    dip: in std_logic_vector (1 downto 0);
    tot_lt_s: out std_logic
);
end PO;

architecture dataflow of PO is

    signal a: std_logic_vector (7 downto 0);
    signal tot: std_logic_vector (7 downto 0);  
    constant S: std_logic_vector (7 downto 0) := "01100100";
begin 
    -- decodificador do valor da moeda
    moeda : process (dip)
    begin
    if (dip = "01") then a <= "00011001"; -- (01) 25 centavos
    elsif (dip = "10") then a <= "00110010"; -- (10) 50 centavos
    elsif (dip = "11") then a <= "01100100"; -- (11) 1 real
    else a <= "00000000"; -- qualquer outro valor nao soma
    end if;
    end process;

    -- somador e registrador
    logica : process(clk, tot_clr, tot_ld)
    begin
    if (tot_clr = '1') then 
        tot <= "00000000";
    elsif (rising_edge(clk)) then
        if (tot_ld = '1') then 
            tot <= std_logic_vector(unsigned(tot) + unsigned(a));
        end if;
    end if;
    end process;

    -- comparador
    comparador : process (tot)
            begin
            if (unsigned(tot) < unsigned(s)) then
                tot_lt_s <= '1';
            elsif (unsigned(tot) >= unsigned(s)) then
                tot_lt_s <= '0';
            end if;
    end process;

end dataflow;