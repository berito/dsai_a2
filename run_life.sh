#!/bin/bash

# Check if the user has provided the mode (parallel or serial)
if [ -z "$1" ]; then
    echo "Usage: $0 <mode>"
    echo "Mode options: parallel, serial"
    exit 1
fi

MODE=$1  # Accept 'parallel' or 'serial' from the user

# Validate the input mode
if [[ "$MODE" != "parallel" && "$MODE" != "serial" ]]; then
    echo "Invalid mode. Please use 'parallel' or 'serial'."
    exit 1
fi

# Loop over different numbers of threads and iterations
for threads in 1 2 4 8 16; do
    for iterations in 500 1000 1500 2000; do
        # Set OMP_NUM_THREADS for parallel execution
        if [ "$MODE" == "parallel" ]; then
            export OMP_NUM_THREADS=$threads
        fi
        
        # Choose the correct executable based on the mode
        if [ "$MODE" == "parallel" ]; then
            EXEC="./build/life_parallel"
        else
            EXEC="./build/life_serial"
        fi
        
        # Run the program with the specified parameters
        $EXEC -n 500 -i $iterations -p 0.2 -d
        
        # Optional: Print what the script is running
        echo "Running in $MODE mode with Threads: $threads, Iterations: $iterations"
    done
done

echo "All tests completed."
