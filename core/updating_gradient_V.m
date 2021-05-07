function [d_V] = updating_gradient_V(input_y, input_y_train, input_z, weights,learning_rate)
%% activation function

d_V_int = weights;

    for k = 1 : 1 : length(d_V_int(:,1))

        for h = 1 : 1 : length(d_V_int(1,:))

            d_V_int(k,h) = d_V_int(k,h) + learning_rate*(input_y_train(k,1) - input_y(k,1))*input_z(h,1);

        end

    end

d_V = d_V_int;

end