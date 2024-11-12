# include ./arch

# OBJ	= life.o real_rand.o plot.o timer.o

# LDLIBS = -lpthread 

# CFLAGS = -g 

# life:	        $(OBJ)
# 		$(CC) $(LDFLAGS) -o $@ $(OBJ)  $(LDLIBS)



# clean:	
# 	$(RM) *.o life *~;
# 	$(RM) core;
# 	$(RM) PI*;
# Build directory
BUILD_DIR = build

# Include file
INCLUDE_FILE = arch

# Source files
SRC = life.c real_rand.c plot.c timer.c

# Object files in the build directory
OBJ = $(SRC:%.c=$(BUILD_DIR)/%.o)

# Libraries and flags
LDLIBS = -lpthread
CFLAGS = -g

# Target binary
TARGET = $(BUILD_DIR)/life

# Default target
all: $(TARGET)

# Build the target binary
$(TARGET): $(OBJ) | $(BUILD_DIR)
	$(CC) $(LDFLAGS) -o $@ $(OBJ) $(LDLIBS)

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
