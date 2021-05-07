function [cost_value] = cost_function(nn_value,training_value)
%%% This file includes simple gradient descent algortihm to train model function by using derivation of cost function.

    cost_value = sum( 1/2 .* ( training_value - nn_value ).^2 );
    
    %cost_value = training_value - nn_value;


end