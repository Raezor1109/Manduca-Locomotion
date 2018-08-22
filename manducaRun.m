%RAIYAN ISHMAM
%HW8
%%
x0 = zeros ( 10 , 10 ) ;  %all legs are unlocked. no actuation forces.
                          %first four columns represent actuationPattern, the last five columns represent legPattern. 
                          %fifth column ALWAYS contains only zeros.

myfun = @manducaFitness ;

options = saoptimset ( 'simulannealbnd' ) ;
options = saoptimset ( options, 'MaxIter', Inf, 'InitialTemperature', 100, 'ReannealInterval', 100, 'TimeLimit', Inf, 'PlotFcns', {@saplotbestx, @saplotbestf, @saplotx, @saplotf}, 'DataType' , 'custom' , 'AnnealingFcn' , @manducaPermute ) ;  %other options set to default

global initial_temperature
initial_temperature = options.InitialTemperature ;

[ x, fval, exitflag, output ] = simulannealbnd ( myfun, x0, [], [], options )