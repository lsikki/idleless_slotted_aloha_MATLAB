
drones = [Drone(1), Drone(2), Drone(3), Drone(4), Drone(5)];
gcs = IdlelessGCStation();
slots_per_frame = 5;
total_frames = 3;
number_sessions = 10;

throughputs = zeros(number_sessions, 1);
probabilities = linspace(0, 1.5, number_sessions); % Varying access probabilities from 0 to 1.5

for i = 1:number_sessions
    
    for j = 1:length(drones)
        drones(j) = drones(j).set_access_probability(probabilities(i));
    end
    
    
    [throughput, ~] = IdlelessSlottedALOHA(gcs, drones, slots_per_frame, total_frames);
    
 
    throughputs(i) = throughput;
end


figure;  
scatter(probabilities, throughputs, 100, 'filled', 'MarkerEdgeColor', 'k'); 
xlabel('Access Probability');
ylabel('Throughput');
title('Throughput vs Access Probability for Slotted ALOHA');
grid on;
