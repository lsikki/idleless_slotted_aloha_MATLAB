mean_throughputs = zeros(11, 1);
mean_idleless_throughputs = zeros(11, 1);
number_drones = zeros(11, 1);

max_throughput = 1; 

for a = 1:11
    drones = [];
    num_drones = round(100 * rand); 
    number_drones(a) = num_drones;

    for i = 1:num_drones
        drones = [drones, Drone(i)];
    end

    gcs = GCStation(0);
    idleless_gcs = GCStation(1);
    
    slots_per_frame = 5;
    total_frames = 4;
    number_sessions = 10;

    %% Slotted ALOHA
    throughputs = zeros(number_sessions, 1);
    probabilities = zeros(number_sessions, 1);
    for i = 1:number_sessions
        [throughput, probability] = IdlelessSlottedALOHA(gcs, drones, slots_per_frame, total_frames);
        throughputs(i) = throughput;
        probabilities(i) = probability;
    end

    %% Idleless Slotted ALOHA
    idleless_throughputs = zeros(number_sessions, 1);
    idleless_probabilities = zeros(number_sessions, 1);
    for i = 1:number_sessions
        [throughput, probability] = IdlelessSlottedALOHA(idleless_gcs, drones, slots_per_frame, total_frames);
        idleless_throughputs(i) = throughput;
        idleless_probabilities(i) = probability;
    end
    

    mean_throughputs(a) = mean(throughputs);
    mean_idleless_throughputs(a) = mean(idleless_throughputs);
end

p1 = polyfit(number_drones, mean_throughputs, 3); 
p2 = polyfit(number_drones, mean_idleless_throughputs, 3); 

x_fit = linspace(min(number_drones), max(number_drones), 100);
y_fit1 = polyval(p1, x_fit); 
y_fit2 = polyval(p2, x_fit);

figure;
hold on;
scatter(number_drones, mean_throughputs, 100, 'b', 'filled');
scatter(number_drones, mean_idleless_throughputs, 100, 'r', 'filled');

plot(x_fit, y_fit1, 'b-', 'LineWidth', 2); 
plot(x_fit, y_fit2, 'r-', 'LineWidth', 2); 

xlabel('Number of Drones');
ylabel('Throughput');
title('Throughput vs Number of Drones');
legend('Slotted ALOHA', 'Idleless Slotted ALOHA', 'Slotted ALOHA Fit', 'Idleless Slotted ALOHA Fit');
grid on;
hold off;

