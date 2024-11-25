classdef Drone
    properties 
        ID
        state % 0 = no transmission, 1 = transmission
        access_probability
    end
    
    methods
        function obj = Drone(ID)
            obj.ID = ID;
            obj.state = 0;
            obj.access_probability = 0.3; 
        end
        
        function obj = set_access_probability(obj, prob)
            obj.access_probability = prob; 
        end

        function obj = decide_to_transmit(obj)
            if rand() < obj.access_probability
                obj.state = 1; 
            else
                obj.state = 0;
            end
        end
    end
end
