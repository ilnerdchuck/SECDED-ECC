# Tools
IVERILOG = iverilog
VVP      = vvp
WAVES    = gtkwave

# Directories
SRC_DIR  = src
BUILD_DIR = build

# Files
SRC_FILES = $(wildcard $(SRC_DIR)/*.sv)
TB        = $(SRC_DIR)/tb.sv
TOP       = tb

# Output
OUT       = $(BUILD_DIR)/simv
WAVE_FILE = $(BUILD_DIR)/waves.vcd

# Default target
all: run

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compile all sources
$(OUT): $(SRC_FILES) | $(BUILD_DIR)
	$(IVERILOG) -g2012 -Wall -o $@ -s $(TOP) $(SRC_FILES)

# Run simulation
run: $(OUT)
	$(VVP) $(OUT)

# Run and open waveform
wave: run
	$(WAVES) $(WAVE_FILE) &

# Clean generated files
clean:
	rm -rf $(BUILD_DIR)

# Phony targets
.PHONY: all run wave clean
