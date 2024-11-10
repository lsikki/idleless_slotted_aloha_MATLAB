%% Step 1: Initialize Ground Control Station and drones
total_drones = 5; % total number of drones --> need to change this to a random number from 5-100
gcs = GCStation(total_drones);
drones = [Drone(1, 0.2), Drone(2, 0.2), Drone(3, 0.2), Drone(4, 0.2), Drone(5, 0.2)]; % so far they all have the same transmit probability, we can expperiment with this later and maybe compare

%% Step 2: Initialize number of slots
T_total = 1000; % need to check what number thet use in the paper

%% Step 3: Go through each slot, and simulate behaviour of drones and ground station
for t = 1:T_total
    % Here we define a list to keep track of the drones that are attempting to send in this slot
    % For now, we initialize to zeros but will replace with 1s in the
    % positions of the drones that are sending in this slot e.g., If drones 3 and 5 are sending in this slot, then transmitting_drones = [0,0,1,0,1]
    transmitting_drones = zeros(1, length(drones)); 

    % Here we go through all the drones and add them to the above list if they decide to send in this slot
    for i = 1:length(drones)
        drones(i) = drones(i).transmit_or_not(); % each drone checks if it can send or not (based on randomly generated value)
        if drones(i).has_transmitted_in_this_slot
            transmitting_drones(i) = 1;  % adding the drone to the list of transmitting drones
        end
    end

    % Here we attempt to receive data from drones - possible collision
    gcs = gcs.receive_ids(transmitting_drones);
    
    %If there is a collision and if the max number of attempts is reached, then the drones need to back off --> need to add this
    %If there is an idle slot then then ground station needs to send out acknowledgments to the drones whose IDs have been received --> need to add this

    
    % Here we check if all the drones have been identified yet
    if gcs.check_all_identified()
        disp('All drones have successfully transmitted.');
        break;  % Here we end the simulation if all drones have been identified
    end
end

disp('Successfully received data from drones:');
disp(gcs.received_ids);
disp('Number of collisions:');
disp(gcs.collision_count);
