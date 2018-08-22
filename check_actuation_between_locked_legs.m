%RAIYAN ISHMAM
%HW8
%%
function invalidity = check_actuation_between_locked_legs ( current_pattern, leg_location_to_flip )
%this function first checks whether the current leg and any of its adjacent ones
%will both be locked after flipping. it then checks whether there will be
%an actuation force between the two locked legs. 'Invalidity' of 1 means that
%there is an actuation force between the locked legs. This is not a
%desirable scenario for the movement of the Manduca.

%'leg_location_to_flip - 50'  and 'leg_location_to_flip - 60'  refer to the
%locations of the actuation force between the current force and one of its
%neighbors

%first we change the current leg status

if current_pattern ( leg_location_to_flip ) == 1
    
    current_pattern ( leg_location_to_flip ) = 0 ;
    
else
    
    current_pattern ( leg_location_to_flip ) = 1 ;
    
end
%%
%we now check if both legs are locked, and whether there is an actuation
%force between two locked legs

if leg_location_to_flip >= 90
    
    both_legs_locked = current_pattern ( leg_location_to_flip ) == 1 & current_pattern ( leg_location_to_flip - 10 ) == 1 ;
    
    invalidity = both_legs_locked && current_pattern ( leg_location_to_flip - 60 ) == 100 ;
    %if actuation force present between locked legs
    
elseif leg_location_to_flip <= 60
    
    both_legs_locked = current_pattern ( leg_location_to_flip ) == 1 & current_pattern ( leg_location_to_flip + 10 ) == 1 ;
    
    invalidity = both_legs_locked && current_pattern ( leg_location_to_flip - 50 ) == 100 ;
    %if actuation force present between locked legs
    
elseif  leg_location_to_flip > 60 && leg_location_to_flip < 90
    
    left_neighbor_locked_with_current = current_pattern ( leg_location_to_flip ) == 1 && ...
        current_pattern ( leg_location_to_flip - 10 ) == 1 ;
    
    right_neighbor_locked_with_current = current_pattern ( leg_location_to_flip ) == 1 && ...
        current_pattern ( leg_location_to_flip + 10 ) == 1 ;
    
    invalidity = ( right_neighbor_locked_with_current && current_pattern ( leg_location_to_flip - 50 ) == 100 ) || ...
        ( left_neighbor_locked_with_current && current_pattern ( leg_location_to_flip - 60 ) == 100 ) ;
    %if actuation force present between the locked legs
    
end
end