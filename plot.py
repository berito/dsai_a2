# import matplotlib.pyplot as plt
# import pandas as pd

# # Read the CSV data into a pandas DataFrame
# data_serial = pd.read_csv('data/data_serial.csv')
# data_parallel = pd.read_csv('data/data_parallel.csv')
# # Set up the plot
# plt.figure(figsize=(10, 6))

# # Iterate over each unique thread value and plot the corresponding data
# for thread in data_parallel['Num_Threads'].unique():
#     # Filter the data for the current thread
#     thread_data = data_parallel[data_parallel['Num_Threads'] == thread]
    
#     # Plot the data (Iterations vs Time)
#     plt.plot(thread_data['Num_Iterations'], thread_data['Time_Taken(seconds)'], marker='o', label=f'Num_Threads = {thread}')

# # Customize the plot
# plt.title('Time vs Iterations (Grouped by Threads)')
# plt.xlabel('Iterations')
# plt.ylabel('Time (ms)')
# plt.legend(title='Thread Counts')
# plt.grid(True)

# # Show the plot
# plt.show()
import matplotlib.pyplot as plt
import pandas as pd
import sys

def plot_serial(data):
    """Plot data for serial execution."""
    plt.figure(figsize=(10, 6))
    plt.plot(data['Num_Iterations'], data['Time_Taken(seconds)'], marker='o', color='b', label='Serial Execution')
    plt.title('Time vs Iterations (Serial Execution)')
    plt.xlabel('Iterations')
    plt.ylabel('Time (seconds)')
    plt.legend()
    plt.grid(True)
    plt.show()

def plot_parallel(data):
    """Plot data for parallel execution."""
    plt.figure(figsize=(10, 6))
    for thread in data['Num_Threads'].unique():
        thread_data = data[data['Num_Threads'] == thread]
        plt.plot(thread_data['Num_Iterations'], thread_data['Time_Taken(seconds)'], marker='o', label=f'Num_Threads = {thread}')
    plt.title('Time vs Iterations (Grouped by Threads)')
    plt.xlabel('Iterations')
    plt.ylabel('Time (seconds)')
    plt.legend(title='Thread Counts')
    plt.grid(True)
    plt.show()

if __name__ == "__main__":
    # Check for the mode input
    if len(sys.argv) != 2:
        print("Usage: python plot.py <mode>")
        print("<mode> can be 'serial' or 'parallel'")
        sys.exit(1)

    mode = sys.argv[1].lower()

    if mode == "serial":
        try:
            data_serial = pd.read_csv('data/data_serial.csv')
            plot_serial(data_serial)
        except FileNotFoundError:
            print("Error: 'data/data_serial.csv' not found.")
            sys.exit(1)
    elif mode == "parallel":
        try:
            data_parallel = pd.read_csv('data/data_parallel.csv')
            plot_parallel(data_parallel)
        except FileNotFoundError:
            print("Error: 'data/data_parallel.csv' not found.")
            sys.exit(1)
    else:
        print("Invalid mode. Use 'serial' or 'parallel'.")
        sys.exit(1)
