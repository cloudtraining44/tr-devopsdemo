import pandas as pd

# Create a DataFrame
data = {'Name': ['Alice', 'Bob'], 'Age': [25, 30]}
df = pd.DataFrame(data)
df.index
# Save DataFrame to a CSV file
df.to_csv("output.csv", index=False)
