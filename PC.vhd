-- Bloco de controle do chafariz eletronico

library ieee;
use ieee.std_logic_1164.all;

entity PC is
port(
    c, clk, tot_lt_s, reset: in std_logic;
    tot_clr, tot_ld: out std_logic;
    led : out std_logic_vector (2 downto 0);
    d: out std_logic
    );
end PC;

architecture comportamento of PC is

    type estado is (inicio, espera, somar, fornecer);
    signal est_prox, est_atual: estado;

begin
    
    reg_estado : process (clk, reset)
    begin
        if (reset = '1') then est_atual <= inicio;
        elsif (rising_edge(clk)) then est_atual <= est_prox;
        end if;
    end process;

    log_comb : process (est_atual, c)
    begin
        case est_atual is

            when inicio =>
                tot_clr <= '1';
                d <= '0';
                tot_ld <= '0';
                est_prox <= espera;
            
            when espera => 
                tot_clr <= '0';
                    if (c = '1') then est_prox <= somar;
                    elsif (c = '0') then 
                        if (tot_lt_s = '1') then est_prox <= espera;
                        elsif (tot_lt_s = '0') then est_prox <= fornecer;
                        end if;
                    end if;

            when somar => 
                tot_ld <= '1';
                est_prox <= espera;
            
            when fornecer =>
                d <= '1';
                est_prox <= inicio;
        end case;
    end process; 

    with est_atual select 
    led <=  "001" when inicio,
            "010" when espera,
            "011" when somar,
            "100" when fornecer; 
end comportamento;