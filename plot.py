import matplotlib.pyplot as plt
import pandas as pd

# Read the CSV data into a pandas DataFrame
data_serial = pd.read_csv('data/data_serial.csv')
data_parallel = pd.read_csv('data/data_parallel.csv')
# Set up the plot
plt.figure(figsize=(10, 6))

# Iterate over each unique thread value and plot the corresponding data
for thread in data_parallel['Num_Threads'].unique():
    # Filter the data for the current thread
    thread_data = data_parallel[data_parallel['Num_Threads'] == thread]
    
    # Plot the data (Iterations vs Time)
    plt.plot(thread_data['Num_Iterations'], thread_data['Time_Taken(seconds)'], marker='o', label=f'Num_Threads = {thread}')

# Customize the plot
plt.title('Time vs Iterations (Grouped by Threads)')
plt.xlabel('Iterations')
plt.ylabel('Time (ms)')
plt.legend(title='Thread Counts')
plt.grid(True)

# Show the plot
plt.show()
