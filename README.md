# SECDED ECC implementation

This is an implementation of the SECDED by M. Y. Hsiao on 64 bits using the optimized table 2 (Fig. 6 of the doc).

The structure is divided in Encoder and Decoder with the addition of a noise 
module to add some bit flips to simulate a transmission

## Dependencies 
- `make`
- `iverilog`
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

## Timing analysis

A timing constraint was set: the Encoder/Decoder must stay in 1 clock cycle. 
This can be interpreted in two ways:

### Combinatorial case (not implemented maybe in the future)

The sum of the timings of both module must stay in a clock cycle, thus the modules must not contain any sequential statements and the timing diagram would look like this

//TODO: Comb image

This could be used for memories were both encoding and decoding must stay under one clock.

### Sequential case (implemented)

In this case the assumption is that each single module takes one clock cycle
and some sequential modules are present. The resulting timing diagram would be

//TODO: Seq timing image

And for the RTL schema 
//TODO: RTL image

This could be used in communications systems but maybe an hamming code (7,4)
could be more useful, but it depends as always.  

### Sources:
- [Communications Systems theory notes (Bachelor degree)](https://github.com/ilnerdchuck/CN-Appunti/blob/main/main.pdf)

- [M. Y. Hsiao](https://people.eecs.berkeley.edu/%7Eculler/cs252-s02/papers/hsiao70.pdf)

- [Single Error Correction and Double Error
Detection (SECDED) with CoolRunner-II™
CPLDs](https://docs.amd.com/v/u/en-US/xapp383)
