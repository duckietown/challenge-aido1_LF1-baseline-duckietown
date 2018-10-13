# Definition of Submission container

# We start from Duckietown ROS image
FROM duckietown/rpi-duckiebot-base:master18

# DO NOT MODIFY: your submission won't run if you do
RUN apt-get update -y && apt-get install -y --no-install-recommends \
         gcc \
         libc-dev\
         git \
         bzip2 \
         python-tk && \
     rm -rf /var/lib/apt/lists/*

# let's create our workspace, we don't want to clutter the container
RUN mkdir /workspace

# here, we install the requirements, some requirements come by default
# you can add more if you need to in requirements.txt
COPY requirements.txt /workspace
RUN pip install -r /workspace/requirements.txt

# let's copy all our solution files to our workspace
# if you have more file use the COPY command to move them to the workspace
COPY solution.py /workspace

# we make the workspace our working directory
WORKDIR /workspace

# DO NOT MODIFY: your submission won't run if you do
ENV DUCKIETOWN_SERVER=evaluator

# For ROS Agent - pulls the default configuration files
ENV HOSTNAME=default

# let's see what you've got there...
CMD /bin/bash -c "roslaunch lf_slim.launch & && python solution.py"