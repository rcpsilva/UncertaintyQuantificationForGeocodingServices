import matplotlib.pyplot as plt
import numpy as np

# Create a figure and axis for the subplots
fig, axes = plt.subplots(nrows=2, ncols=2, figsize=(10, 8))

# Create a colormap for consistent color mapping
cmap = plt.get_cmap('viridis')  # You can choose any colormap you prefer

# Determine the global color limits based on the maximum and minimum error values across all DataFrames
all_errors = np.concatenate([df['error'] for df in [df1, df2, df3, df4]])  # Combine all error values
global_min_error = np.min(all_errors)
global_max_error = np.max(all_errors)

# Determine the global marker size limits based on the maximum and minimum error values across all DataFrames
global_min_size = 10  # Minimum marker size
global_max_size = 100  # Maximum marker size
min_error = np.min(all_errors)
max_error = np.max(all_errors)

# Iterate through the DataFrames and create scatter plots
for i, df in enumerate([df1, df2, df3, df4]):
    ax = axes[i // 2, i % 2]
    
    # Extract the data from the DataFrame
    x = df['x']
    y = df['y']
    error = df['error']
    
    # Calculate the marker size as a proportion of the error
    marker_size = (error - min_error) / (max_error - min_error) * (global_max_size - global_min_size) + global_min_size
    
    # Create a scatter plot with consistent color mapping and marker size
    scatter = ax.scatter(x, y, c=error, cmap=cmap, vmin=global_min_error, vmax=global_max_error, s=marker_size)
    
    # Add labels and a title
    ax.set_xlabel('X-axis')
    ax.set_ylabel('Y-axis')
    ax.set_title(f'Scatter Plot {i + 1}')
    
# Add a colorbar to one of the plots to show the error values
cbar = fig.colorbar(scatter, ax=axes.ravel().tolist(), label='Error')

# Adjust the layout and display the plots
plt.tight_layout()
plt.show()
