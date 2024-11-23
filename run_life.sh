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

# Set the output file based on the mode
if [ "$MODE" == "parallel" ]; then
    OUTPUT_FILE="data/data_parallel.csv"
else
    OUTPUT_FILE="data/data_serial.csv"
fi
# Delete the file if it exists and create a new one with a header
if [ -f "$OUTPUT_FILE" ]; then
    rm "$OUTPUT_FILE"
fi
# Check if the file exists and create headers if it's empty
if [ ! -f "$OUTPUT_FILE" ] || [ ! -s "$OUTPUT_FILE" ]; then
    if [ "$MODE" == "parallel" ]; then
        echo "Num_Threads,Time_Taken(seconds),Num_Iterations" > "$OUTPUT_FILE"
    else
        echo "Time_Taken(seconds),Num_Iterations" > "$OUTPUT_FILE"
    fi
fi

# Loop for serial mode (only iterations)
if [ "$MODE" == "serial" ]; then
    for iterations in 1000 2000 4000 6000 8000 10000; do
        total_time=0
       
        # Run the program 5 times and calculate the average time for each iteration count
        for run in {1..5}; do
            EXEC="./build/life_serial"
            # Run the program with the specified parameters and capture the time output
            time_output=$($EXEC -n 500 -i $iterations -p 0.2 -d)
            
            # Extract the time taken from the program output
            time_taken=$(echo "$time_output" | grep -oP 'Running time for the iterations: \K[0-9.]+')
            # Add the time to the total time
            total_time=$(echo "$total_time + $time_taken" | bc)
        done

        # Calculate the average time for this iteration count
        average_time=$(echo "$total_time / 5" | bc -l)

        # Print the average time along with other details
        echo "Running in $MODE mode, Iterations: $iterations, Average Time: $average_time sec"

        # Append the performance data to the CSV file
        echo "$average_time, $iterations" >> "$OUTPUT_FILE"
    done
fi

# Loop for parallel mode (iterations and threads)
if [ "$MODE" == "parallel" ]; then
    for threads in 1 2 4 8 16; do
        for iterations in 1000 2000 4000 6000 8000 10000; do
            total_time=0

            # Run the program 5 times and calculate the average time for each combination of thread and iteration count
            for run in {1..5}; do
                # Set OMP_NUM_THREADS for parallel execution
                export OMP_NUM_THREADS=$threads
                EXEC="./build/life_parallel"

                # Run the program with the specified parameters and capture the time output
                time_output=$($EXEC -n 500 -i $iterations -p 0.2 -d)

                # Extract the time taken from the program output
                time_taken=$(echo "$time_output" | grep -oP 'Running time for the iterations: \K[0-9.]+')

                # Add the time to the total time
                total_time=$(echo "$total_time + $time_taken" | bc)
            done

            # Calculate the average time for this combination of threads and iterations
            average_time=$(echo "$total_time / 5" | bc -l)

            # Print the average time along with other details
            echo "Running in $MODE mode with Threads: $threads, Iterations: $iterations, Average Time: $average_time sec"

            # Append the performance data to the CSV file
            echo "$threads, $average_time, $iterations" >> "$OUTPUT_FILE"
        done
    done
fi

echo "All tests completed."
