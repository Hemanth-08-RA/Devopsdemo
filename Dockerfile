# Use a lightweight Python runtime
FROM python:3.11-slim

# Execute the Hello World inline python command
CMD ["python", "-c", "print('Hello, World!')"]
