classdef IdlelessGCStation
    properties
        ACK_delay = 1;  
    end
    
    methods
        function obj = IdlelessGCStation()
            
        end
        
        function obj = receive_incoming_data(obj, transmitting_drones)
            
            disp('Receiving data from drones...');
            for i = 1:length(transmitting_drones)
                drone = transmitting_drones(i);
                disp(['Drone ', num2str(drone.ID), ' transmitting.']);
            end
        end
        
        function obj = send_ACKs(obj)
           
            disp('Idle slot detected. Sending ACKs.');
        end
    end
end
