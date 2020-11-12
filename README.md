# Experiments in ns3-gym

## References

# Doker Image
```
docker pull slyad/ns3-gym
```

# Docker file
A docker file is included to setup the environment. 

## To build the image:
```
docker build --tag ns3-gym:0.0 .
```

## Run the image
Once built run the image as by:
```
docker run -v $(pwd):/usr/work --detach --name ns3gym ns3-gym:0.0
```

## Interact with the running container 
Interact with the container:
```
docker exec -it ns3gym /bin/bash
```