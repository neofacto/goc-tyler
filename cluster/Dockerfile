# Use an official Python runtime as a parent image
# This image is based on the popular Alpine Linux project
FROM python:3.6

COPY ./* /cluster/

# Set the file requirement
ADD requirements.txt ./

# Install any needed packages specified in requirements.txt
RUN apt-get update && apt-get install -y python3-pip && pip3 install -r requirements.txt
RUN python /cluster/install_nltk.py

# Run app.py when the container launches
CMD ["python", "/cluster/rest-server.py"]
