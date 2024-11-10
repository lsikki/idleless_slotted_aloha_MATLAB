classdef GCStation
    properties
        received_ids
        collision_count
        total_drones
        idle_slot_count
    end

    methods
        function gcstation = GCStation(total_drones)
            gcstation.received_ids = [];
            gcstation.collision_count = 0;
            gcstation.total_drones = total_drones; 
            gcstation.idle_slot_count = 0;
        end   

        function gcstation = receive_ids(gcstation, transmitting_drones)
            num_transmitting = sum(transmitting_drones);  
            if num_transmitting == 0
                gcstation.idle_slot_count = gcstation.idle_slot_count + 1;
            elseif num_transmitting == 1
                transmitted_drone = find(transmitting_drones == 1);  
                gcstation.received_ids = [gcstation.received_ids, transmitted_drone];
            else
                gcstation.collision_count = gcstation.collision_count + 1;
            end
        end

        function all_identified = check_all_identified(gcstation)
            all_identified = length(gcstation.received_ids) == gcstation.total_drones;  
        end
    end
end