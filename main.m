% Here we are initializing all parameters
drones = [Drone(1), Drone(2), Drone(3), Drone(4), Drone(5)];
gcs = GCStation();
slots_per_frame = 5;
total_frames = 3;
number_sessions = 10;

throughputs= zeros(number_sessions);
probabilities = zeros(number_sessions);
for i = 1:number_sessions
    [throughput, probability] = IdlelessSlottedALOHA(gcs, drones, slots_per_frame, total_frames);
    throughputs(i) = throughput;
    probabilities(i) = probability;
end


figure;  
scatter(probabilities, throughputs, 100, 'filled', 'MarkerEdgeColor', 'k'); 
xlabel('Access Probability');
ylabel('Throughput');
title('Throughput vs Access Probability for Slotted ALOHA');
grid on;  







%% TO DO:
%% 1- add max number of attempts + backoff strategy
%% 2- in idle slots, the ground station should send ACKS (best to make a new Idleless GCS class so that we can compare performance)
%% 3- drones should wait for a certain period, if no ACK then state=0 and then retry
%% 4- compare simulation results for regular slotted aloha and idleless version
%% DONE:
%% Beacon to initiate random access session
%% Throughput vs Access Probability simulation for regular slotted ALOHA