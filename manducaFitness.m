% ES93 Computational Modeling and Design
% Department of Computer Scinece
% Tufts University

% this function returns the distance covered by Manduca, and it is negative
% when indicating forward motion.

% the parameter here is a current Solution XXXX.  This infomration must be 
% organized in a 10x5 matrix called actuation pattern, and a 10x5 matrix called
% legPattern
function distanceCovered = manducaFitness( gaitPattern )


% Setup the actuation pattern:
actuationPattern = gaitPattern ( 1 : 10 , 1 : 5 ) ;

% Setup the pattern for the legs:
legPattern = gaitPattern ( 1 : 10 , 6 : 10 ) ;


% setup initial conditions for each simuulation
timeInterval =[0 100];
x0 = [0; 500; 1000; 1500; 2000];
xprime0 = zeros(5, 1);

% the distance covered by Manduca will be the difference between the head
% of Manduca @2000 at time =0 and at time = finalSimulation time.
manducaHeadT0 = x0(5);
timesteps = size(actuationPattern, 1);
tis = timeInterval(1):timesteps:timeInterval(2);
endL = length(tis)-1;
for i = 1:endL
    timeInterval_ode = [tis(i), tis(i+1)];
    lockedLegs_ode = legPattern(i, :);
    actuationPattern_ode = actuationPattern(i, :);
    [t x] = fivePointManduca(x0, xprime0, actuationPattern_ode, lockedLegs_ode, timeInterval_ode);
    x0 = x(end, 1:5)';
    xprime0 = x(end, 6:10)';
end
distanceCovered = -(x(end, 5) - manducaHeadT0);

end

function [t x] = fivePointManduca(initialPositions, initialVelocities, actuationPattern, legCond2, timeInterval)
% initial positions and velocities are column indices.
% a-b-c-d-e
global Aab Abc Acd Ade legCond
legCond=legCond2;
Aab = actuationPattern(1);
Abc = actuationPattern(2);
Acd = actuationPattern(3);
Ade = actuationPattern(4);
[t,x] = ode45(@dfile, timeInterval,[initialPositions; initialVelocities]);
end

function xprime = dfile(t, x)
c = 2;
m = 1;
k = 1;
L0 = 500;
global  Aab Abc Acd Ade legCond
xprime = zeros(10,1);
if ~(legCond(1))
    xprime(1) = x(6); 
else
    xprime(1) = 0;
end
if ~(legCond(2))
    xprime(2) = x(7); 
else
    xprime(2) = 0;
end
if ~(legCond(3))
    xprime(3) = x(8); 
else
    xprime(3) = 0;
end
if ~(legCond(4))
    xprime(4) = x(9); 
else
    xprime(4) = 0;
end
if ~(legCond(5))
    xprime(5) = x(10); 
else
    xprime(5) = 0;
end

xprime(6)= (1/m) * (- k * x(1) + k * x(2) - c * x(6) + c * x(7) - k* L0  + Aab);

xprime(7)= (1/m)* ( -k *x(2) + k * x(3) - c * x(7) + c * x(8) - k * L0 + Abc) +...
     (1/m) * (k * x(1) - k * x(2) + c * x(6) - c * x(7) +  k * L0  - Aab);
    
xprime(8)= (1/m)* ( -k *x(3) + k * x(4) - c * x(8) + c * x(9) - k * L0 + Acd) +...
     (1/m) * (k * x(2) - k * x(3) + c * x(7) - c * x(8) +  k * L0  - Abc);
    
xprime(9)= (1/m)* ( -k *x(4) + k * x(5) - c * x(9) + c * x(10) - k * L0 + Ade) +...
     (1/m) * (k * x(3) - k * x(4) + c * x(8) - c * x(9) +  k * L0  - Acd);
    
xprime(10)= (1/m)* (-k * x(5) + k * x(4) - c * x(10) + c * x(9) + k * L0 - Ade);
    
end