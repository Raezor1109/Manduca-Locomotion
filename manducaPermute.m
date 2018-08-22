%RAIYAN ISHMAM
%HW8
%%
function gaitPattern = manducaPermute ( optimValues , problemData )
%this function will return a gaitPattern whose first four columns represent
%the actuationPattern while the last five represent legPattern. The fifth
%column is irrelevant and contains only zeros

global initial_temperature

current_temperature = optimValues.temperature ;

current_pattern = optimValues.x ;

temperature_ratio = current_temperature / initial_temperature ;

number_of_locations_to_flip = ceil ( temperature_ratio * 90 / 2 ) ;     %current_pattern has 90 relevant matrix locations

for actuation_flips = 1 : ( number_of_locations_to_flip )        %actuationPattern has 4 columns out of the 9 relevant columns
    
    actuation_location_to_flip = randi( 40 )  ;    %to choose an index within the first 4 columns randomly
    
    if  current_pattern ( actuation_location_to_flip ) == 100
        
        current_pattern ( actuation_location_to_flip ) = 0 ;
        
    else
        
        current_pattern ( actuation_location_to_flip ) = 100 ;
        
    end
    
    for leg_flips = 1 : ( number_of_locations_to_flip )                %legPattern has 5 columns out of the 9 relevant columns
        
        leg_location_to_flip =  randi( 50 ) + 50   ;   %to choose an index within the last 5 columns randomly
        
        invalidity = check_actuation_between_locked_legs ( current_pattern, leg_location_to_flip ) ;
        
        if invalidity ~= 1   %i.e. validity = 1 ( resulting solution is acceptable according to decided rules )
            
            if current_pattern ( leg_location_to_flip ) == 1
                
                current_pattern ( leg_location_to_flip ) = 0 ;
                
            else
                
                current_pattern ( leg_location_to_flip ) = 1 ;
                
            end
            
        end
    end
    
end

gaitPattern = current_pattern ;

end