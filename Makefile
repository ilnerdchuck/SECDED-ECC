# Tools
IVERILOG = iverilog
VVP      = vvp
WAVES    = gtkwave

# Directories
SRC_DIR  = src
BUILD_DIR = build

# Files
HEADERS   = $(shell find $(SRC_DIR) -type f -name "*.svh")
SRC_FILES = $(shell find $(SRC_DIR) -type f -name "*.sv")
TOP_seq   = tb_SECDED_ECC_seq
TOP_comb   = tb_SECDED_ECC_comb

# Output
OUT_seq       = $(BUILD_DIR)/simv_seq
OUT_comb       = $(BUILD_DIR)/simv_comb
WAVE_FILE_seq = $(BUILD_DIR)/tb_SECDED_seq.vcd
WAVE_FILE_comb = $(BUILD_DIR)/tb_SECDED_comb.vcd

# Default target
all: run

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)


#### Sequential Module ####
# Compile the sequential module
$(OUT_seq): $(HEADERS) $(SRC_FILES) | $(BUILD_DIR)
	$(IVERILOG) -g2012 -Wall -o $@ -s $(TOP_seq) $(HEADERS) $(SRC_FILES)

# Run simulation and write waveform
run_seq: $(OUT_seq)
	$(VVP) $< +vcdfile=$(WAVE_FILE_seq)

# Run and open waveform
wave_seq: run
	$(WAVES) $(WAVE_FILE) &

#### Combinational Module ####
# Compile the combinational module
$(OUT_comb): $(HEADERS) $(SRC_FILES) | $(BUILD_DIR)
	$(IVERILOG) -g2012 -Wall -o $@ -s $(TOP_comb) $(HEADERS) $(SRC_FILES)

# Run simulation and write waveform
run_comb: $(OUT_comb)
	$(VVP) $< +vcdfile=$(WAVE_FILE_comb)

# Run and open waveform
wave_comb: run
	$(WAVES) $(WAVE_FILE_comb) &

#### Utility Targets ####
# Run both simulations
run: run_seq run_comb

# Clean generated files
clean:
	rm -rf $(BUILD_DIR)

# Phony targets
.PHONY: all run wave clean
