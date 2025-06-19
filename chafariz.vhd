-- Tarefa 1: Chafariz Eletronico
-- Autores: Saulo Gabryel Alves de Almeida e Carlos Henrique 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

entity chafariz is
port(
    c, reset, clk: in std_logic;
    dip: in std_logic_vector (1 downto 0);
    d : out std_logic;
    led: out std_logic_vector (2 downto 0);
    clock: out std_logic
);
end chafariz;

architecture comportamento of chafariz is
    component PC is
        port(
            c, clk, tot_lt_s, reset: in std_logic;
            tot_clr, tot_ld: out std_logic;
            led : out std_logic_vector (2 downto 0);
            d: out std_logic
            );
    end component;

    component PO is
        port(
    tot_ld, tot_clr, clk: in std_logic;
    dip: in std_logic_vector (1 downto 0);
    tot_lt_s: out std_logic
    );
    end component;
    
    signal sig_tot_ld, sig_tot_clr, sig_tot_lt_s, sig_clk: std_logic;
    signal sig_prescale : std_logic_vector (24 downto 0) := (others => '0');

begin
    process(reset,clk)
	begin
		if reset = '0' then
			sig_clk <= '0';
			sig_prescale <= (others => '0');
		elsif clk'event and clk = '1' then
			if sig_prescale = "1011111010111100001000000" then
				sig_prescale <= (others => '0');
				sig_clk <= not sig_clk;
			else
				sig_prescale <= sig_prescale + 1;
			end if;
		end if;
	end process;

	clock <= sig_clk;

    blocodecontrole : PC port map (
                    reset => reset,
                    clk => sig_clk,
                    c => c,
                    d => d,
                    led => led,
                    tot_lt_s => sig_tot_lt_s,
                    tot_clr => sig_tot_clr,
                    tot_ld => sig_tot_ld
                    );

    blocooperacional : PO port map (
                    dip => dip,
                    clk => sig_clk,
                    tot_ld => sig_tot_ld,
                    tot_clr => sig_tot_clr,
                    tot_lt_s => sig_tot_lt_s
                    );

end comportamento;