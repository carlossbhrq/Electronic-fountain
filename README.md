# 💧 Electronic Fountain with FSM Control in VHDL

This project implements an **electronic fountain** using a Finite State Machine (FSM) designed in VHDL. The system simulates a coin-operated fountain, activating LEDs based on an accumulated monetary value. The project is divided into two main components: the **Control Block (PC)** and the **Operational Block (PO)**.

> **Author**: Carlos Henrique Dantas da Costa  
> **Language**: VHDL  
> **Recommended tools**: Quartus, ModelSim, FPGA (e.g., Cyclone IV from the DE0-Nano board)

---

## 🎯 Objective

Simulate a fountain system that:

- Detects coin insertion (R$0.25, R$0.50, or R$1.00)
- Accumulates value until **R$1.00** is reached
- Activates the output (`d`) to turn on the fountain
- Displays the current FSM state using 3 LEDs

---

## 🧱 System Architecture

The project is composed of three main VHDL files:

### 🔹 `chafariz.vhd` – Top-Level Entity

- Integrates the control block (`PC`) and operational block (`PO`)
- Implements a **clock prescaler** (divides 50 MHz to ~1 Hz)
- Handles signal routing between blocks

### 🔹 `PC.vhd` – Control Block (FSM)

FSM with 4 states:

| State       | LEDs  | Description                                   |
|-------------|--------|-----------------------------------------------|
| `inicio`     | `001`  | Reset and clear total                        |
| `espera`     | `010`  | Wait for coin or total check                 |
| `somar`      | `011`  | Add coin value                               |
| `fornecer`   | `100`  | Activate output (`d`) and restart process    |

### 🔹 `PO.vhd` – Operational Block

- Decodes coin values based on `dip` input:
  - `"01"`: R$0.25
  - `"10"`: R$0.50
  - `"11"`: R$1.00
- Accumulates inserted values
- Compares total against the target (R$1.00)
- Signals the control block whether the total is sufficient (`tot_lt_s`)

---

## ⚙️ Inputs and Outputs

### 🔌 Inputs

- `clk`: Main clock (50 MHz)
- `reset`: Asynchronous reset (active-low)
- `c`: Coin insert trigger
- `dip[1:0]`: Coin value (via DIP switch)

### 💡 Outputs

- `led[2:0]`: Indicates the current FSM state
- `d`: Fountain activation signal (HIGH when R$1.00 is reached)
- `clock`: 1 Hz clock output from prescaler

---

## 📌 Notes

- The prescaler uses the binary constant `1011111010111100001000000` (25,000,000 decimal) to generate a 1 Hz clock from a 50 MHz source.
- The target value for comparison is `"01100100"` = **100 decimal**, representing **100 cents (R$1.00)**.

---

📘 *This educational project demonstrates FSM design, sequential control, registers, comparators, and modular integration in VHDL.*
