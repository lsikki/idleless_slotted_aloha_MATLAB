classdef GCStation
    properties
        received_drones
        idleless
    end

    methods
        function gcStation = GCStation(is_idleless)
            gcStation.received_drones = {}; 
            gcStation.idleless = is_idleless; % 0 = regular slotted ALOHA, 1 = idleless slotted ALOHA
        end

        function updated_drones = send_beacon(gcStation, drones, access_probabilities)
            disp('Initiating random access session.');
            if length(drones) ~= length(access_probabilities)
                error('Number of drones must match the number of access probabilities.');
            end
            for i = 1:length(drones)
                updated_drones(i) = drones(i).set_transmit_probability(access_probabilities(i));
            end            
            disp('Access probabilities have been sent to drones.');
        end

        function successful_drones = send_acks(gcStation)
            successful_drones = [];             
            received = gcStation.received_drones;
            for i = 1:length(received)
                if received(i).state == 1
                    successful_drones = [successful_drones, received(i).receive_ack()];
                end
            end
        end


        function gcStation = receive_incoming_data(gcStation, transmitting_drones)
            number_drones_attempting_to_transmit = length(transmitting_drones);
            if number_drones_attempting_to_transmit == 0
                disp('Idle slot detected.');
                if(gcStation.idleless == 1)
                    gcStation.send_acks()
                end
            elseif number_drones_attempting_to_transmit > 1
                disp('Collision detected.');
            elseif number_drones_attempting_to_transmit == 1
                drone = transmitting_drones(1);
                existing_drone_ids = arrayfun(@(d) d.ID, gcStation.received_drones);  
                if ~ismember(drone.ID, existing_drone_ids) 
                    gcStation.received_drones = [gcStation.received_drones, drone];  
                end
                disp(['ID packet successfully received from Drone ', num2str(drone.ID), '.']);

            end
        end
    end
end


