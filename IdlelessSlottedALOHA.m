
function [throughput, access_probability] = IdlelessSlottedALOHA(gcs, drones, slots_per_frame, total_frames)
    access_probabilities = 0.3 * rand() * ones(1, length(drones)); % all have the same transmission probability    
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
    access_probability = access_probabilities(1); % all drones have the same ap for now

end


