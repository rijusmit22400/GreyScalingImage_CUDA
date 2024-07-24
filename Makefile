# Variables
NVCC = nvcc
SRCDIR = src
BINDIR = bin
DATADIR = data
LIBDIR = lib
TARGET = $(BINDIR)/image_to_gray
SRC = $(SRCDIR)/main.cu
INCLUDES = -I$(LIBDIR)

# Default target
all: build

# Clean up the binary files
clean:
	rm -f $(TARGET)

# Compile and link the CUDA code
$(TARGET): $(SRC)
	$(NVCC) $(SRC) -o $(TARGET) $(INCLUDES)

# Build target
build: $(TARGET)

# Run the executable to process the image
run: $(TARGET)
	$(TARGET)
