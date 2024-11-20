
% Here we are initializing all parameters
drones = [Drone(1), Drone(2), Drone(3), Drone(4), Drone(5)];
access_probabilities = 0.3 * rand() * ones(1, length(drones)); % all have the same transmission probability
gcs = GCStation();
slots_per_frame = 5;
total_frames = 1;
successful_drones = [];
total_successful_transmissions = 0;

% Now we will initiate a random access session 
% Part of the beacon is the access probability for each drone (the same for all)
drones = gcs.send_beacon(drones, access_probabilities);

for f = 1:total_frames
    disp(['-----------FRAME: ', num2str(f), '-----------']);
    for t = 1:slots_per_frame
        disp(['---SLOT: ', num2str(t), '---']);
        transmitting_drones = [];
    
        for i = 1:length(drones)
           drones(i) = drones(i).decide_to_transmit(); 
           if drones(i).state == 1
            transmitting_drones = [transmitting_drones, drones(i)]; 
           end
        end

        disp('Drones attempting to transmit: ')
        for d=transmitting_drones
           disp(d.ID)
        end

        % keeping track of successful cases to compute throughput later
        if(length(transmitting_drones)==1)
            total_successful_transmissions = total_successful_transmissions + 1;
        end

        gcs = gcs.receive_incoming_data(transmitting_drones);
    end
    
    successful_drones = gcs.send_acks();
end

total_slots = total_frames * slots_per_frame;
throughput = total_successful_transmissions / total_slots;
disp('----------------------------------');
disp('--------Session throughput--------');
disp(num2str(throughput));

%% TO DO:
%% 1- add max number of attempts + backoff strategy
%% 2- in idle slots, the ground station should send ACKS 
%% 3- compute key statistics e.g., throughput and compare with regular slotted ALOHA
%% 4- visualize simulation results
%% 5- drones should wait for a certain period, if no ACK then state=0 and then retry

%% DONE:
%% Beacon to initiate random access session

