# RISC-V-32I-5-Stage-Pipeline
This project is a 5-stage pipelined RV32I processor implemented in Verilog. I built it to gain a deeper understanding of pipelined processor design and the hardware mechanisms involved in executing instructions efficiently.
Before starting the project, to understand ISA, pipelining, hazards and all technicalities, involved in this project, I used the book-'Digital Design and Computer Architecture Risc-V edition', as my primary resource.
The processor follows the classic IF–ID–EX–MEM–WB pipeline and includes data forwarding, load-use hazard detection, and control hazard handling for branch and jump instructions. The design was verified using custom test programs and simulated using Icarus Verilog with GTKWave.

Features involved are:

- RTL Design with seperate files for each element
- Data forwarding for dependent instructions
- Load use hazard detection with pipeline stalling 
- Branch and jump handling using pipeline flushing 
- Verified using multiple test programs and waveform analysis in GTKWave

It supports Arithmetic Instructions(add,sub,and,or,addi), Memory instructions(lw,sw),Branch instructions(beq) and Jump instructions(jal).

The processor follows the classic 5-stage RISC-V pipeline: - 

- Instruction Fetch (IF) 
- Instruction Decode (ID) 
- Execute (EX) 
- Memory Access (MEM) 
- Write Back (WB)

To maintain correct execution in the pipeline, the processor includes a hazard unit that handles both data and control hazards. – 

- Data forwarding from the EX/MEM and MEM/WB stages to reduce unnecessary stalls. 
- Detection of load-use hazards with automatic pipeline stalling. 
- Pipeline flushing for taken branches and jump instructions.

The processor was verified using custom test programs in Icarus Verilog and GTKWave.

Some possible extensions to this processor include:

- Support for the complete RV32I instruction set
- Branch prediction
- Instruction and data caches
- Exception and interrupt handling
- FPGA implementation
- SystemVerilog-based verification
