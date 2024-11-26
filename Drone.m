classdef Drone
    properties
        ID
        transmit_probability
        state % 0 = idle, 1 = transmitted this slot, 1.5 = transmitted before this slot, 2 = success
        data_rate
        packet_size
        max_attempts
        initial_delay
        attempts
    end

    methods
        % Constructor
        function drone = Drone(ID, max_attempts, initial_delay)
            drone.ID = ID;
            drone.state = 0; % idle to start
            drone.data_rate = 10000; % bps
            drone.packet_size = 1000; % bits
            drone.transmit_probability = 0; % unknown at this stage
            drone.max_attempts = max_attempts;
            drone.initial_delay = initial_delay; % Delay in seconds
            drone.attempts = 0; % Number of attempts made
        end

        function drone = set_transmit_probability(drone, probability)
            drone.transmit_probability = probability;
        end

        function drone = decide_to_transmit(drone)
            if (drone.state == 0) % only send if you aren't waiting for an acknowledgement or if you have not successfully transmitted
                if drone.attempts < drone.max_attempts
                    random_prob = rand(); % generate random probability between 0-1
                    if random_prob < drone.transmit_probability
                        drone = drone.send_data();
                    else
                        % Increment attempts and apply backoff
                        drone.attempts = drone.attempts + 1;
                        backoff_time = drone.initial_delay * (2^(drone.attempts - 1));
                        pause(backoff_time); % Pause for backoff duration
                    end
                else
                    disp(['Drone ', num2str(drone.ID), ' has reached max transmission attempts.']);
                end
            elseif (drone.state == 1) % means that drone has already sent before
                drone.state = 1.5; % makes sure that it does not transmit this slot again
            end
        end

        function drone = send_data(drone)
            drone.state = 1;
            % Uncomment to simulate transmission time
            % pause(drone.data_rate / drone.packet_size);
        end

        function drone = receive_ack(drone)
            drone.state = 2;
            drone.attempts = 0; % Reset attempts on successful transmission
            disp(['Drone ', num2str(drone.ID), ' has received ACK.']);
        end
    end
end