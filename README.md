# 💡 FSM Control for Electronic Fountain

This project implements a **Finite State Machine (FSM)** in VHDL to control an electronic fountain or a visual LED-based sequence using the **FPGA Cyclone IV EP4CE22F17C6N**. The FSM is based on a six-instruction processor control block, inspired by *Figure 8.13 from the book by Vahid*.

> **Author**: Carlos Henrique Dantas da Costa
> **File**: `fsm.vhd`  
> **Language**: VHDL  
> **Toolchain**: Quartus, ModelSim

## 📌 Project Overview

The FSM cycles through several operational states—each represented visually using a 4-bit output on LEDs. These states mimic a simple processor instruction set, and the visual behavior (via LEDs) can resemble a programmable LED fountain or indicator system.

## 🚦 State Description

The FSM includes the following states:

| State Name          | LED Output | Description                           |
|---------------------|------------|---------------------------------------|
| `inicio`            | `0000`     | Initialization                        |
| `busca`             | `0001`     | Instruction fetch                     |
| `decodificacao`     | `0010`     | Instruction decode                    |
| `carregar`          | `0011`     | Load                                  |
| `armazenar`         | `0100`     | Store                                 |
| `somar`             | `0101`     | Add                                   |
| `carregar_constante`| `0110`     | Load constant                         |
| `subtrair`          | `0111`     | Subtract                              |
| `saltar_se_zero`    | `1000`     | Jump if zero                          |
| `saltar`            | `1001`     | Jump                                  |

## 🧠 Architecture

The FSM operates in two main processes:

1. **Clock Divider**: Reduces the input clock (e.g., 50 MHz) to ~1 Hz using a prescaler, enabling human-visible LED transitions.
2. **FSM Logic**: Implements the state register and transition logic based on instruction codes (`op`) and a conditional flag (`rf_rp_zero`).

## 🧪 Inputs and Outputs

### Inputs
- `clk`: Clock signal
- `clr`: Asynchronous reset (active low)
- `rf_rp_zero`: Zero flag for conditional branching
- `op[3:0]`: Operation code input

### Outputs
- `led[3:0]`: Binary LED output representing current FSM state
- `clock`: Divided-down output clock (1 Hz)

## 📂 File Summary

- `fsm.vhd`: Main VHDL source file containing entity and architecture of the FSM controller.

## ✅ How to Simulate or Synthesize

1. Open your VHDL tool (Quartus, ModelSim, GHDL, etc.)
2. Add `fsm.vhd` to your project
3. Assign FPGA pins for:
   - `clk`, `clr`, `op`, `rf_rp_zero` (inputs)
   - `led[3:0]`, `clock` (outputs)
4. Compile and flash to your board
5. Observe the LEDs indicating the current FSM state

---

📘 *This FSM-based control logic can be adapted for educational processors, instruction decoders, or visual applications like LED fountains, signaling systems, or sequencers.*
