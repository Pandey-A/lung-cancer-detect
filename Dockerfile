# Use an official lightweight Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies if required by Pillow or TF
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file explicitly
COPY requirements.txt .

# Install dependencies (No cache to save memory overhead in images)
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose port 8000
EXPOSE 8000

# Run the FastAPI server via Uvicorn (Render default command logic)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
