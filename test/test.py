# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

# --- Configuration ---
# Input Masks (mapped to ui_in[7:0] for morse_top instance inside tt_um_morse)
DOT_MASK = 0x01         # ui_in[0] -> dot_inp
CHAR_SPACE_MASK = 0x04  # ui_in[2] -> char_space_inp
WORD_SPACE_MASK = 0x08

DASH_MASK = 0x02        # ui_in[1] -> dash_inp (Not used in this test)

# Output Codes (assuming the output code for 'e' is 0x65 from previous context)
CODE_E = 0x65           # The expected output code for 'e'
CODE_A = 0x61           # The expected output code for 'a'
CODE_T = 0x74           # The expected output code for 't'
CODE_M = 0x6D          # The expected output code for 'm'
CODE_SPACE = 0x20       # The expected output code for 'space'
CODE_NO_OUTPUT = 0xFF   # Default output when decoding is in progress or FSM is reset

# --- Helper Function ---

async def init(dut):
    # Set the clock period (using positional arguments for maximum compatibility)
    clock = Clock(dut.clk, 10, "us")
    cocotb.start_soon(clock.start())

    # --- Initialize Inputs ---
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    
    # --- Apply Reset (Active-LOW 'rst_n') ---
    dut.rst_n.value = 0 # Active Low Reset
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1 # End Reset
    await RisingEdge(dut.clk)
    dut._log.info("Reset complete (rst_n transitioned 0 -> 1).")

    # Wait one cycle for the receiver FSM to settle into 0xFF
    await ClockCycles(dut.clk, 1)
    # Check the standard output signal name 'uo_out'
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, f"Output uo_out should be {hex(CODE_NO_OUTPUT)} after reset."


async def send_pulse(dut, mask):
    """
    Sets the input 'ui_in' high based on the mask for exactly one clock cycle,
    then sets it back to zero.
    """
    dut.ui_in.value = mask
    await RisingEdge(dut.clk)
    dut.ui_in.value = 0
    await RisingEdge(dut.clk) # Wait one extra cycle to ensure timing stability

async def tx_serial_dot(dut):
    dut.ui_in.value = "10000000"
    await ClockCycles(dut.clk, 3)
    dut.ui_in.value = "00000000"

async def tx_serial_dash(dut):
    dut.ui_in.value = "10000000"
    await ClockCycles(dut.clk, 6)
    dut.ui_in.value = "00000000"

async def tx_serial_val_space(dut):
    dut.rx_cw.value = 0
    await ClockCycles(dut.clk, 7)
    dut.rx_cw.value = 0

async def tx_serial_T_space_T(dut):
    await tx_serial_dash(dut)
    await ClockCycles(dut.clk, 5)
    await tx_serial_dash(dut)

async def send_T_space_T_manually(dut):
    await send_pulse(dut, DASH_MASK)
    await send_pulse(dut, CHAR_SPACE_MASK)

    await send_pulse(dut, WORD_SPACE_MASK)

    await send_pulse(dut, DASH_MASK)
    await send_pulse(dut, CHAR_SPACE_MASK)


async def tx_M_x2(dut):
    dut._log.info("Sending DASH DASH")
    await tx_serial_dash(dut)
    await ClockCycles(dut.clk, 2)
    await tx_serial_dash(dut)

    await ClockCycles(dut.clk, 4)

    dut._log.info("Sending DASH DASH 2")
    await tx_serial_dash(dut)
    await ClockCycles(dut.clk, 2)
    await tx_serial_dash(dut)

async def tx_MA(dut):
    dut._log.info("Sending DASH DASH")
    await tx_serial_dash(dut)
    await ClockCycles(dut.clk, 2)
    await tx_serial_dash(dut)

    await ClockCycles(dut.clk, 4)

    dut._log.info("Sending DASH DASH 2")
    await tx_serial_dot(dut)
    await ClockCycles(dut.clk, 2)
    await tx_serial_dash(dut)

async def a_SPACE(dut):
    await dut.uo_out.value_change
    await dut.clk.value_change
    await dut.clk.value_change
    assert dut.uo_out.value.integer == CODE_SPACE, f"Failed to decode 'SPACE'. Expected {hex(CODE_SPACE)}, Got {hex(dut.uo_out.value.integer)}"


async def a_NOP(dut):
    await dut.uo_out.value_change
    await dut.clk.value_change
    await dut.clk.value_change
    
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, f"Output uo_out should be {hex(CODE_NO_OUTPUT)} after reset."
    
async def a_T(dut):
    await dut.uo_out.value_change
    await dut.clk.value_change
    await dut.clk.value_change
    
    assert dut.uo_out.value.integer == CODE_T, f"Failed to decode 'T'. Expected {hex(CODE_T)}, Got {hex(dut.uo_out.value.integer)}"

async def a_M(dut):
    await dut.uo_out.value_change
    await dut.clk.value_change
    await dut.clk.value_change
    
    assert dut.uo_out.value.integer == CODE_M, f"Failed to decode 'M'. Expected {hex(CODE_M)}, Got {hex(dut.uo_out.value.integer)}"

async def a_E(dut):
    await dut.uo_out.value_change
    await dut.clk.value_change
    await dut.clk.value_change

    assert dut.uo_out.value.integer == CODE_E, f"Failed to decode 'E'. Expected {hex(CODE_E)}, Got {hex(dut.uo_out.value.integer)}"

async def a_A(dut):
    await dut.uo_out.value_change
    await dut.clk.value_change
    await dut.clk.value_change

    assert dut.uo_out.value.integer == CODE_A, f"Failed to decode 'A'. Expected {hex(CODE_A)}, Got {hex(dut.uo_out.value.integer)}"

@cocotb.test()
async def test_decode_e(dut):
    dut._log.info("Starting Morse Decoder Test for 'E' using ui_in masks.")
    await init(dut)

    dut._log.info("--- Test: Decoding 'E' (.) ---")

    await send_pulse(dut, DOT_MASK)
    
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, "Output should still be 0xFF after the dot pulse."

    dut._log.info("Sending CHAR_SPACE pulse (mask 0x04) on ui_in to complete the character...")
    await send_pulse(dut, CHAR_SPACE_MASK) # Consumes 2 cycles

    await a_E(dut)

    await a_NOP(dut)

    dut._log.info("Test for 'E' successfully passed using ui_in/uo_out interface.")

@cocotb.test()
async def test_decode_a(dut):
    dut._log.info("Starting Morse Decoder Test for 'A' using ui_in masks.")
    await init(dut)

    # --- TEST: Decode 'E' (.) ---
    dut._log.info("--- Test: Decoding 'A' (. -) ---")

    # 1. Send DOT pulse (ui_in[0] = 1)
    dut._log.info("Sending DOT DASH pulse")
    await send_pulse(dut, DOT_MASK)
    await ClockCycles(dut.clk, 2)
    await send_pulse(dut, DASH_MASK)
    
    # Check intermediate state: output should still be 0xFF after the dot pulse.
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, "Output should still be 0xFF after the dot pulse."

    # 2. Send Character Space pulse (ui_in[2] = 1)
    dut._log.info("Sending CHAR_SPACE pulse (mask 0x04) on ui_in to complete the character...")
    await send_pulse(dut, CHAR_SPACE_MASK) # Consumes 2 cycles

    await a_A(dut)
    await a_NOP(dut)

    dut._log.info("Test for 'A' successfully passed using ui_in/uo_out interface.")

@cocotb.test()
async def test_decode_space(dut):
    dut._log.info("Starting Morse Decoder Test for 'A' using ui_in masks.")
    await init(dut)

    # --- TEST: Decode 'SPACE' (. -) ---
    dut._log.info("--- Test: Decoding 'SPACE' (. -) ---")

    # 1. Send DOT pulse (ui_in[0] = 1)
    dut._log.info("Sending SPACE pulse (mask 0x01) on ui_in...")
    await send_pulse(dut, WORD_SPACE_MASK)
    
    # Check intermediate state: output should still be 0xFF after the space pulse.
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, "Output should still be 0xFF after the dot pulse."


    await a_SPACE(dut)


    # Cycle 2 (Reset): The output should return to 0xFF.
    await dut.uo_out.value_change
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, f"Output should return to {hex(CODE_NO_OUTPUT)}."

    dut._log.info("Test for 'SPACE' successfully passed using ui_in/uo_out interface.")

@cocotb.test()
async def test_decode_T_space_T(dut):
    dut._log.info("Starting Morse Decoder Test for 'A' using ui_in masks.")
    await init(dut)

    # --- TEST: Decode 'SPACE' (. -) ---
    dut._log.info("--- Test: Decoding 'SPACE' (. -) ---")

    
    cocotb.start_soon(send_T_space_T_manually(dut))
    
    # Check intermediate state: output should still be 0xFF after the space pulse.
    assert dut.uo_out.value.integer == CODE_NO_OUTPUT, "Output should still be 0xFF after the dot pulse."


    await a_T(dut)
    await a_NOP(dut)
    await a_SPACE(dut)
    await a_NOP(dut)
    await a_T(dut)
    await a_NOP(dut)


    dut._log.info("Test for 'A' successfully passed using ui_in/uo_out interface.")

@cocotb.test()
async def test_decode_serial_e(dut):
    dut._log.info("Starting Morse Decoder Test for 'E' using serial CW TX.")
    await init(dut)

    dut._log.info("--- Test: Decoding 'E' ---")

    dut._log.info("Sending DOT")
    await tx_serial_dot(dut)

    await a_E(dut)
    await a_NOP(dut)

@cocotb.test()
async def test_decode_serial_t(dut):
    dut._log.info("Starting Morse Decoder Test for 'T' using serial CW TX.")
    await init(dut)

    dut._log.info("--- Test: Decoding 'T' ---")

    dut._log.info("Sending DASH")
    await tx_serial_dash(dut)

    await a_T(dut)
    await a_NOP(dut)

@cocotb.test()
async def test_decode_serial_M(dut):
    dut._log.info("Starting Morse Decoder Test for 'M' using serial CW TX.")
    await init(dut)

    dut._log.info("--- Test: Decoding 'M' ---")

    dut._log.info("Sending DASH DASH")
    await tx_serial_dash(dut)
    await ClockCycles(dut.clk, 2)
    await tx_serial_dash(dut)

    await a_M(dut)
    await a_NOP(dut)

@cocotb.test()
async def test_decode_serial_M_twice(dut):
    dut._log.info("Starting Morse Decoder Test for 'MM' using serial CW TX.")
    await init(dut)

    dut._log.info("--- Test: Decoding 'MM' ---")

    cocotb.start_soon(tx_M_x2(dut))

    await a_M(dut)
    await a_NOP(dut)
    await a_M(dut)

@cocotb.test()
async def test_decode_serial_MA(dut):
    dut._log.info("Starting Morse Decoder Test for 'MA' using serial CW TX.")
    await init(dut)

    dut._log.info("--- Test: Decoding 'MA' ---")

    cocotb.start_soon(tx_MA(dut))

    await a_M(dut)
    await a_NOP(dut)
    await a_A(dut)

@cocotb.test(skip=True)
async def test_decode_serial_SPACE(dut):
    dut._log.info("Starting Morse Decoder Test for 'M' using serial CW TX.")
    await init(dut)

    dut._log.info("--- Test: Decoding 'T SPACE T' (_ _) ---")

    cocotb.start_soon(tx_serial_T_space_T(dut))

    await a_T(dut)
    await a_NOP(dut)
    await a_SPACE(dut)
    await a_NOP(dut)
    await a_T(dut)
    await a_NOP(dut)
