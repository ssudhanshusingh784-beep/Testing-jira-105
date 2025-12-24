FROM python:3.11-slim

WORKDIR /app

# Copy application files into the image (assumes static files or a simple app)
COPY . /app

# Expose port used by the simple HTTP server
EXPOSE 8000

# Simple, portable way to serve a folder for demo purposes
CMD ["python", "-m", "http.server", "8000"]
