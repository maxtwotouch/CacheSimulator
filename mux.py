import matplotlib.pyplot as plt
import numpy as np

# Drawing a basic 2-to-1 multiplexor
fig, ax = plt.subplots(figsize=(6, 4))

# Drawing AND gates
ax.plot([1, 2], [3, 3], 'k-')  # Input A line
ax.plot([1, 2], [1, 1], 'k-')  # Input B line
ax.plot([1.5, 1.5], [1, 3], 'k-')  # Select line
ax.plot([2, 2.5], [3, 2.5], 'k-')  # Output of first AND gate
ax.plot([2, 2.5], [1, 1.5], 'k-')  # Output of second AND gate
ax.text(0.9, 3, "A", fontsize=12, verticalalignment='center')
ax.text(0.9, 1, "B", fontsize=12, verticalalignment='center')
ax.text(1.4, 2, "S", fontsize=12, verticalalignment='center')
ax.text(2.7, 2.5, "AND1", fontsize=12, verticalalignment='center')
ax.text(2.7, 1.5, "AND2", fontsize=12, verticalalignment='center')

# Drawing NOT gate for select line
ax.plot([1.5, 2], [2, 1.5], 'k-')  # Line from S to AND2
ax.plot([1.5, 2], [2, 3], 'k-')  # Line from S to AND1

# Drawing OR gate
ax.plot([2.5, 3], [2.5, 2], 'k-')  # Line from AND1 to OR
ax.plot([2.5, 3], [1.5, 2], 'k-')  # Line from AND2 to OR
ax.plot([3, 3.5], [2, 2], 'k-')  # Output line
ax.text(3.6, 2, "Output", fontsize=12, verticalalignment='center')

# Adding circles for AND, OR, NOT gates
ax.plot(2, 3, 'ko', markersize=12)  # AND gate 1
ax.plot(2, 1, 'ko', markersize=12)  # AND gate 2
ax.plot(3, 2, 'ko', markersize=12)  # OR gate
ax.plot(1.5, 2, 'ko', markersize=6)  # NOT gate

# Hiding axes
ax.set_axis_off()
plt.title("2-to-1 Multiplexor Gate Architecture", fontsize=14)
plt.show()
