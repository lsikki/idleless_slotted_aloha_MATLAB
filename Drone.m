classdef Drone
    properties
        id
        transmit_probability
        has_successfully_transmitted
        attempts
        has_transmitted_in_this_slot
    end

    methods
        function drone = Drone(id, transmit_probability)
            drone.id = id;
            drone.transmit_probability = transmit_probability;
            drone.has_successfully_transmitted = false;
            drone.attempts = 0;
        end

        function drone = transmit_or_not(drone)
            if ~drone.has_successfully_transmitted
                if rand() < drone.transmit_probability
                    drone.has_transmitted_in_this_slot = true;
                    drone.attempts = drone.attempts + 1;
                end
            end
        end
    end
end