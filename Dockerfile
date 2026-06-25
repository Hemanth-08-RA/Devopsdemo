# Use a lightweight Python image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy the Python script into the container
COPY app.py .

# Command to run the script
CMD ["python", "app.py"]
