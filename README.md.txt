Overview

This project implements a parameterized single-clock FIFO (First-In First-Out) buffer in Verilog HDL, including a self-checking testbench for functional verification.

The FIFO is designed for FPGA-based digital systems, such as:

UART buffering

Data streaming pipelines

Producer–consumer architectures

Command or packet buffering

The design uses synchronous read and write operations driven by a single clock.


Übersicht

Dieses Projekt implementiert einen Single-Clock FIFO (First-In First-Out) Puffer in Verilog HDL, inklusive eines Testbenches zur funktionalen Verifikation.

Der FIFO ist geeignet für FPGA-basierte Designs, z. B.:

UART-Datenpuffer

Streaming-Architekturen

Producer-Consumer-Systeme

Kommando- und Datenpuffer

Lese- und Schreibzugriffe erfolgen synchron zu einem gemeinsamen Takt.

FIFO Architecture / Architektur
          ┌──────────┐
  buf_in ─▶             │
          │   FIFO       │ ──▶ buf_out
  wr_en  ─▶          	 │
  rd_en  ─▶          	 │
          └──────────┘
              ▲
        fifo_counter


Depth: 64 entries

Data width: 8 bit

Single clock domain

Circular buffer with read/write pointers

## Tools

- Verilog HDL
- Xilinx Vivado
- RTL Simulation & Post-Implementation Timing Analysis

---

## Autor / Author

**Dylann Kinfack**  
GitHub: https://github.com/DyKinfack