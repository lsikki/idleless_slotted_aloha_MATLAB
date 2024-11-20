classdef Drone
    properties
        ID
        transmit_probability
        state % 0 = idle, 1 = transmitted this slot, 1.5 = transmitted before this slot, 2 = success
        data_rate
        packet_size
    end

    methods
        % Constructor
        function drone = Drone(ID)
            drone.ID = ID;
            drone.state = 0; % idle to start
            drone.data_rate = 10000; % bps
            drone.packet_size = 1000; % bits
            drone.transmit_probability = 0 ; % unknown at this stage
        end

        function drone = set_transmit_probability(drone, probability)
            drone.transmit_probability = probability;
        end

        function drone = decide_to_transmit(drone)
           %disp(['Drone ', num2str(drone.ID), ' is in state ', num2str(drone.state)]);
           if (drone.state == 0) % only send if you aren't waiting for an acknowledgement or if you have not successfully transmitted
            random_prob = rand(); % generate random probability between 0-1
                if random_prob < drone.transmit_probability
                   drone = drone.send_data();
                end
           elseif (drone.state == 1) % means that drone has already sent before
                drone.state = 1.5; % makes sure that it does not transmit this slot again
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
