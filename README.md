# SECDED ECC implementation

This is an implementation of the SECDED by M. Y. Hsiao on 64 bits using the optimized table 2 (Fig. 6 of the doc).

## Dependencies 
- `make`
- `ghdl`
- `gtkwave`

## Project structure

- `./src`: folder containing the source files
    - `encoder.sv`: file describing the encoder
    - `decoder.sv`: file describing the decoder
    - `noise.sv`: module used to induce noise
    - `tb.sv`: testbench module
- ./Makefile: used to launch the simulation
    - `make build`: builds the modules
    - `make run`: runs the simulation
    - `make wave`: opens gtkwave to analyze the waveform

### Sources:
- [Communications Systems theory notes (Bachelor degree)](https://github.com/ilnerdchuck/CN-Appunti/blob/main/main.pdf)

- [M. Y. Hsiao](https://people.eecs.berkeley.edu/%7Eculler/cs252-s02/papers/hsiao70.pdf)

- [Single Error Correction and Double Error
Detection (SECDED) with CoolRunner-II™
CPLDs](https://docs.amd.com/v/u/en-US/xapp383)
