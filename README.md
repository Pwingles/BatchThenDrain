# Priority Queue Performance Analysis: Batch-Then-Drain Workload

## Student Information
- **Name:** Kevin Rodriguez
- **Student ID:** 008858727
- **Instructor:** Prof. Ali Kooshesh
- **Semester:** Fall 2025
- **Course:** CS 315 – Data Structures

- **Repository Link:** https://github.com/Pwingles/BatchThenDrain

## Collaboration & Sources
This project implements a batch-then-drain trace generator and performance analysis framework for priority queue data structures.

### Parts Created Independently:
- Batch-then-drain trace generator implementation
- Integration with existing priority queue implementations (Provided by my instructor )
- Performance analysis and CSV data generation
- Makefile for build automation
- Project documentation and README

### External Sources Used:
- **Framework Structure:** Existing priority queue implementations and harness provided by instructor
- **TraceConfig System:** Reused existing configuration system for N values and seeds
- **AI Assistance:** Used to Generate README, no reports were made using AI, all thoughts are my own.

### Attribution:
All reused components (priority queue implementations, harness framework, visualization tools) are part of the course-provided experimental analysis framework. New batch-then-drain implementation is original work.

## Implementation Details

### Overview
This project implements a **batch-then-drain trace generator** to analyze priority queue performance under a specific workload pattern. The batch-then-drain pattern models real-world scenarios like heapsort and offline task scheduling where all elements are inserted first, then extracted in priority order.

### Key Components

#### 1. Batch-Then-Drain Trace Generator
- **Location:** `src/trace-generators/batch_then_drain/main.cpp`
- **Pattern:** N insert operations followed by N extract operations
- **Key Distribution:** Full range [1, N] for diverse key values
- **Trace Sizes:** N = 13, 2^10, 2^11, ..., 2^20 (13 to 1,048,576 elements)

#### 2. Priority Queue Implementations Tested
- **Binary Heap:** Array-based heap-ordered complete tree
- **Binomial Queue:** Forest of binomial trees with good amortized performance  
- **Linear Baseline:** Unsorted array with linear search (reference implementation)
- **Quadratic Oracle:** O(N²) reference implementation for validation

#### 3. Performance Harness
- **Modified:** `src/harness/main.cpp` to use batch_then_drain profile
- **Timing Method:** 7 trials per implementation, median selected
- **Output:** CSV format with timing data and operation counts

#### 4. Build System
- **Makefile targets:** `make generator`, `make run-generator`, `make harness`, `make run-harness`
- **Dependencies:** C++20, existing priority queue implementations
- **Output Files:** Traces in `traces/batch_then_drain/`, CSV results in `csvs/`

### Algorithm Design
The batch-then-drain generator creates traces with two distinct phases:
1. **Batch Build Phase:** Insert N elements with random keys [1, N]
2. **Drain Phase:** Extract minimum N times (always returns elements in sorted order)

This contrasts with interleaved patterns (like Huffman coding) and allows analysis of how different priority queue implementations handle bulk operations vs. mixed operations.

## Testing & Status

### What Works:
✅ **Trace Generation:** Successfully generates all 12 trace files with correct batch-then-drain pattern  
✅ **Harness Integration:** Modified harness correctly processes batch-then-drain traces  
✅ **Performance Timing:** All 4 implementations run successfully with timing data  
✅ **CSV Output:** Clean timing data generated in proper format  
✅ **Build System:** Makefile targets work correctly for building and running  
✅ **Visualization:** HTML chart tool can load and display generated CSV data  

### How to Test:
```bash
# Setup directories
make setup

# Build and run trace generator (Creates trace files)
make generator
make run-generator

# Build and run performance analysis (Creates CSV files)
make harness  
make run-harness

# View results (Upload CSV to view chart) or just open the HTML file in the browser
open charts/pq_multi_impl_anchor_heap_tooltips.html
```

### Expected Output:
- **Trace Files:** 12 files in `traces/batch_then_drain/` with pattern `{profile}_N_{N}_S_{seed}.trace`
- **CSV Results:** `csvs/batch_then_drain_profile.csv` with timing data for all implementations
- **Visualization:** Interactive D3.js charts showing performance curves


### File Structure:
```
src/
├── trace-generators/batch_then_drain/main.cpp    # New trace generator
├── harness/main.cpp                              # Modified for batch profile  
└── implementations/                              # Existing PQ implementations
traces/batch_then_drain/                          # Generated trace files
csvs/batch_then_drain_profile.csv                 # Timing results
Makefile                                          # Build automation
```

## Performance Insights
The generated data allows analysis of:
- **Cache Performance:** Binary heap expected to excel due to locality
- **Amortized vs Worst-case:** Binomial queue amortized benefits in batch context
- **Operation Costs:** Linear baseline shows cost of naive approach
- **Scalability:** How performance scales from 13 to 1M+ elements

This experimental framework demonstrates that data structure selection depends on access patterns, not just asymptotic complexity.
