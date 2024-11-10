classdef GCStation
    properties
        received_drones
    end

    methods
        function gcStation = GCStation()
            gcStation.received_drones = {};
        end

        function gcStation = send_acks(gcStation)
            for drone = gcStation.received_drones
                if drone.state == 1
                    drone.receive_ack();
                end
            end
        end

        function gcStation = receive_incoming_data(gcStation, transmitting_drones)
            number_drones_attempting_to_transmit = length(transmitting_drones);
            if number_drones_attempting_to_transmit == 0
                disp('Idle slot detected.');
            elseif number_drones_attempting_to_transmit > 1
                disp('Collision detected.');
            elseif number_drones_attempting_to_transmit == 1
                drone = transmitting_drones(1);
                gcStation.received_drones = [gcStation.received_drones, drone];
                disp(['ID packet successfully received from Drone ', num2str(drone.ID), '.']);
            end
        end
    end
end


