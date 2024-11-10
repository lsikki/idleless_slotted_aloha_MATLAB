
drones = [Drone(1, 0.2), Drone(2, 0.2), Drone(3, 0.2), Drone(4, 0.2), Drone(5, 0.2)];
gcs = GCStation();
slots_per_frame = 5;
total_frames = 3;

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

        gcs = gcs.receive_incoming_data(transmitting_drones);
    end
    
    gcs = gcs.send_acks();
end

%% TO DO:
%% 1- add max number of attempts + backoff strategy
%% 2- in idle slots, the ground station should send ACKS (in addition to end of frame)
%% 3- compute key statistics e.g., throughput and compare with regular slotted ALOHA
%% 4- visualize simulation results

