# # include ./arch

# # OBJ	= life.o real_rand.o plot.o timer.o

# # LDLIBS = -lpthread 

# # CFLAGS = -g 

# # life:	        $(OBJ)
# # 		$(CC) $(LDFLAGS) -o $@ $(OBJ)  $(LDLIBS)



# # clean:	
# # 	$(RM) *.o life *~;
# # 	$(RM) core;
# # 	$(RM) PI*;
# # Build directory
# BUILD_DIR = build

# # Include file
# INCLUDE_FILE = arch

# # Source files
# SRC = real_rand.c plot.c timer.c life.c life_serial.c

# # Object files in the build directory
# OBJ = $(SRC:%.c=$(BUILD_DIR)/%.o)

# # Libraries and flags
# LDLIBS = -lpthread
# CFLAGS = -g
# CFLAGS = -O2 -fopenmp   # Enable OpenMP and optimization
# LDFLAGS = -fopenmp      # Link with OpenMP support (if needed)

# # Target binary
# TARGET = $(BUILD_DIR)/life

# # Default target
# all: $(TARGET)

# # Build the target binary
# $(TARGET): $(OBJ) | $(BUILD_DIR)
# 	$(CC) $(LDFLAGS) -o $@ $(OBJ) $(LDLIBS)

# # Compile source files into object files in the build directory
# $(BUILD_DIR)/%.o: %.c $(INCLUDE_FILE) | $(BUILD_DIR)
# 	$(CC) $(CFLAGS) -c $< -o $@

# # Ensure the build directory exists
# $(BUILD_DIR):
# 	mkdir -p $(BUILD_DIR)

# # Clean up the build directory and files
# clean:
# 	$(RM) -r $(BUILD_DIR)
# 	$(RM) core
# 	$(RM) PI*
# Build directory
BUILD_DIR = build

# Include file
INCLUDE_FILE = arch

# Source files
SRC = real_rand.c plot.c timer.c life_parallel.c life_serial.c

# Object files in the build directory
OBJ = $(SRC:%.c=$(BUILD_DIR)/%.o)

# Libraries and flags
LDLIBS = -lpthread
CFLAGS = -g
CFLAGS += -O2 -fopenmp   # Enable OpenMP and optimization
LDFLAGS = -fopenmp      # Link with OpenMP support (if needed)

# Target binaries
TARGET_LIFE = $(BUILD_DIR)/life_parallel
TARGET_LIFE_SERIAL = $(BUILD_DIR)/life_serial


# Default target
all: $(TARGET_LIFE) $(TARGET_LIFE_SERIAL) $(TARGET_PLOTCSV)

# Build the life executable
$(TARGET_LIFE): $(BUILD_DIR)/life_parallel.o $(BUILD_DIR)/real_rand.o $(BUILD_DIR)/plot.o $(BUILD_DIR)/timer.o | $(BUILD_DIR)
	$(CC) $(LDFLAGS) -o $@ $(BUILD_DIR)/life_parallel.o $(BUILD_DIR)/real_rand.o $(BUILD_DIR)/plot.o $(BUILD_DIR)/timer.o $(LDLIBS)

# Build the life_serial executable
$(TARGET_LIFE_SERIAL): $(BUILD_DIR)/life_serial.o $(BUILD_DIR)/real_rand.o $(BUILD_DIR)/plot.o $(BUILD_DIR)/timer.o | $(BUILD_DIR)
	$(CC) $(LDFLAGS) -o $@ $(BUILD_DIR)/life_serial.o $(BUILD_DIR)/real_rand.o $(BUILD_DIR)/plot.o $(BUILD_DIR)/timer.o $(LDLIBS)

# Compile source files into object files in the build directory
$(BUILD_DIR)/%.o: %.c $(INCLUDE_FILE) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Ensure the build directory exists
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Clean up the build directory and files
clean:
	$(RM) -r $(BUILD_DIR)
	$(RM) core
	$(RM) PI*
