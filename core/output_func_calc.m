function [out_output] = output_func_calc(inputs, weights,output_number)
%% activation function

out_int = zeros(output_number,1);

for k = 1 : 1 : length(weights(:,1))
    
    out_int(k,1) = weights(k,:)*inputs;
    
end

out_output = out_int;

end