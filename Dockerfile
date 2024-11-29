# Use the official Python base image
FROM python:3.10-slim
 
# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
 
# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
&& rm -rf /var/lib/apt/lists/*
 
# Set the working directory
WORKDIR /app
 
# Copy requirements if needed (optional)
# If you have a requirements.txt file, uncomment the next lines and make sure to include it in the same directory as the Dockerfile
# COPY requirements.txt /app/
# RUN pip install --no-cache-dir -r requirements.txt
 
# Install Jupyter
RUN pip install --no-cache-dir jupyter
 
# Expose the default Jupyter Notebook port
EXPOSE 8888
 
# Start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

COPY requirements.txt /digital_tools/
RUN pip install --no-cache-dir -r requirements.txt
COPY Jupyter_notebook.ipynb /digital_tools/main.ipynb
COPY announcements.xlsx /digital_tools/
COPY Stock_Prices.xlsx /digital_tools/