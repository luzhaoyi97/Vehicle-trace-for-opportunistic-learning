# Vehicle-trace-for-opportunistic-learning
- This project is used to generate the vehicle trace for opportunistic learning. You can modify the parameters of the vehicles and environments to match your experiment requiements. For instance, different vehicle speed and the size of the neighborhood map influence the model performance and convergence. 

## Requirements
- matlab

## Content
- main.m
- test.m
- normalizedHistGram.m
- GenerateVeMobilitySquare.m
- chooseDirection.m
- chechDirectionFeasible.m
- checkIfIntersection.m
- calV2VOnOffDurationforOneUser.m
- moveDir.m
- plotVehicleTraj.m
- WorldX.txt, WorldY.txt: instance of generated trace

## Usage
You can modify the parameters in test.m, such as block number, block size, speed range and sample rate.
