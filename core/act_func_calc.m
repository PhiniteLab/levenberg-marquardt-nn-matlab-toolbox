function [act_output] = act_func_calc(inputs, weights, hidden_layer_number)
%% activation function

act_int = zeros(hidden_layer_number+1,1);

for h = 1 : 1 : (length(weights(:,1)) + 1)
    

    if h == (length(weights(:,1)) + 1)
       
        act_int(h,1) = 1;
        
    else
        
        act_int(h,1) = 1 / (1 + exp(-weights(h,:)*inputs));
    
    end
    
end

act_output = act_int;

end