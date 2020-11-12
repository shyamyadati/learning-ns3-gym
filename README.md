# Experiments in ns3-gym

## References

# Docker Image
```
docker pull slyad/ns3-gym
```

# Building a Docker image
A docker file is included to setup the environment. 

## To build the image:
```
docker build --tag ns3-gym:0.0 .
```

# Run the image
Once built run the image as by:
```
docker run -v $(pwd):/usr/work -it --name ns3gym slyad/ns3-gym:0.0 /bin/bash
```

To run the image in detached mode:

```
docker run -v $(pwd):/usr/work --detach --name ns3gym slyad/ns3-gym:0.0 tail -f /dev/null
```

# Interact with the running container 
Interact with the container:
```
docker exec -it ns3gym /bin/bash
```

# Stop the container
To stop the container
```
docker stop ns3gym
```

# Remove the container
To remove the container
```
docker rm ns3gym
```