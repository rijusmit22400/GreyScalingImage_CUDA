# Makefile for CUDA grayscale image conversion

# Compiler
NVCC = nvcc

# Target executable
TARGET = ImageToGray

# Source files
SRCS = main.cu

# Compiler flags
CFLAGS = -O2

# Include directories
INCLUDES = -I/path/to/stb_image

# Libraries
LIBS = -L/path/to/libs -lstb_image

# Default rule
all: $(TARGET)

# Rule to build the target executable
$(TARGET): $(SRCS)
    $(NVCC) $(CFLAGS) $(INCLUDES) -o $(TARGET) $(SRCS) $(LIBS)

# Clean rule
clean:
    rm -f $(TARGET)

# Run rule
run: $(TARGET)
    ./$(TARGET) sample_data_color.jpg

.PHONY: all clean run