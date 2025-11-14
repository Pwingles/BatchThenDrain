# Main Makefile for priority-queue-study project

CXX = g++
CXXFLAGS = -std=c++20 -Wall -Wextra
INCLUDES = -Iutils -Isrc/harness -Isrc/implementations/BinaryHeapInVector -Isrc/implementations/BinomialQueues -Isrc/implementations/LinearBaseLine -Isrc/implementations/Oracle

# Directories
TRACE_DIR = traces
CSV_DIR = csvs
UTILS_DIR = utils
HARNESS_DIR = src/harness
IMPL_DIR = src/implementations
GEN_DIR = src/trace-generators

# Default target
all: generator harness

# Generator targets
generator: batch_generator

run-generator: batch_generator

# Removed huffman_generator - no longer needed

batch_generator: $(GEN_DIR)/batch_then_drain/main.cpp $(UTILS_DIR)/TraceConfig.cpp $(UTILS_DIR)/TraceConfig.hpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(GEN_DIR)/batch_then_drain/main.cpp $(UTILS_DIR)/TraceConfig.cpp -o batch_generator

# Harness target
harness: $(HARNESS_DIR)/main.cpp $(HARNESS_DIR)/Operation.hpp $(HARNESS_DIR)/RunResults.hpp $(HARNESS_DIR)/RunMetaData.hpp \
	$(IMPL_DIR)/BinaryHeapInVector/BinaryHeapInVector.cpp $(IMPL_DIR)/BinaryHeapInVector/BinaryHeapInVector.hpp \
	$(IMPL_DIR)/BinomialQueues/BinomialQueue.cpp $(IMPL_DIR)/BinomialQueues/BinomialQueue.hpp \
	$(IMPL_DIR)/BinomialQueues/BQnode.cpp $(IMPL_DIR)/BinomialQueues/BQnode.hpp \
	$(IMPL_DIR)/LinearBaseLine/LinearBaseLine.cpp $(IMPL_DIR)/LinearBaseLine/LinearBaseLine.hpp \
	$(IMPL_DIR)/Oracle/QuadraticOracle.cpp $(IMPL_DIR)/Oracle/QuadraticOracle.hpp \
	$(UTILS_DIR)/comparator.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(HARNESS_DIR)/main.cpp $(IMPL_DIR)/BinaryHeapInVector/BinaryHeapInVector.cpp \
	$(IMPL_DIR)/BinomialQueues/BinomialQueue.cpp $(IMPL_DIR)/BinomialQueues/BQnode.cpp \
	$(IMPL_DIR)/LinearBaseLine/LinearBaseLine.cpp $(IMPL_DIR)/Oracle/QuadraticOracle.cpp \
	$(UTILS_DIR)/comparator.cpp -o harness

# Run targets
# Removed run-huffman - no longer needed

run-generator: batch_generator
	./batch_generator

run-harness: harness
	./harness > $(CSV_DIR)/batch_then_drain_profile.csv

# Combined targets
# Removed generate-huffman-traces - no longer needed

generate-batch-traces: run-generator

run-all: generate-batch-traces run-harness

# Clean target
clean:
	rm -f batch_generator harness
	rm -f $(CSV_DIR)/*.csv

# Create directories if they don't exist
setup:
	mkdir -p $(TRACE_DIR)/batch_then_drain
	mkdir -p $(CSV_DIR)

.PHONY: all generator harness run-generator run-harness generate-batch-traces run-all clean setup
