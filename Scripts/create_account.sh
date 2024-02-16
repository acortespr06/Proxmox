#!/bin/bash

# Default password for the user
DEFAULT_PASSWORD="ChangeMe123!"

# Get list of all running container IDs
container_ids=$(pct list | awk '{if(NR>1)print $1}')

# Iterate through each container ID
for id in $container_ids; do
    echo "Processing container ID: $id"
    
    # Add the user 'mando' with a home directory and a comment
    pct exec $id -- useradd -m -c "Admin User" mando

    # Set the user's password
    echo "mando:$DEFAULT_PASSWORD" | pct exec $id -- chpasswd

    # Add the user to the 'sudo' group
    pct exec $id -- usermod -aG sudo mando
done

echo "User 'mando' added and configured in all containers."
