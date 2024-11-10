classdef Drone
    properties
        ID
        transmit_probability
        state % 0 = idle, 1 = transmitted and waiting for ACK, 2 = success
        data_rate
        packet_size
    end

    methods
        % Constructor
        function drone = Drone(ID, transmit_probability)
            drone.ID = ID;
            drone.transmit_probability = transmit_probability;
            drone.state = 0; % idle to start
            drone.data_rate = 10000; % bps
            drone.packet_size = 1000; % bits
        end

        function drone = decide_to_transmit(drone)
            if ~(drone.state == 1) % only send if ack has not been received
                if rand() < drone.transmit_probability
                    drone = drone.send_data();
                end
            end
        end

        function drone = send_data(drone)
            drone.state = 1;
            %pause(drone.data_rate / drone.packet_size) % simulate transmission time
        end

        function drone = receive_ack(drone)
            drone.state = 2;
            disp(['Drone ', num2str(drone.ID), ' has received ACK.']);
        end
    end
end
