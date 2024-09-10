#!/bin/bash

# Check if at least two arguments are passed
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <topic_name> <roslaunch_command>"
  echo "Example: $0 /rosout 'roslaunch your_package your_launch_file.launch'"
  exit 1
fi

# Extract the topic name and the launch command from the arguments
TOPIC_NAME=$1
ROSLAUNCH_COMMAND="${@:2}"

# Function to check if the topic exists
check_topic() {
  rostopic list | grep -q "$TOPIC_NAME"
}

# Wait for the topic to become available
until check_topic; do
  echo "Waiting for topic $TOPIC_NAME to be available..."
  sleep 1
done

# Topic is available, launch the desired ROS launch file
echo "Topic $TOPIC_NAME is available. Launching roslaunch..."
eval $ROSLAUNCH_COMMAND
