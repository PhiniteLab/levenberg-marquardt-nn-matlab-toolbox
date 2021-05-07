function [d_W] = updating_gradient_W(input_y, input_y_train, input_z, input_x, V_weights,d_W_weights, learning_rate)
%% activation function

d_W_int = d_W_weights;

    for h = 1 : 1 : length(d_W_int(:,1))

        for in = 1 : 1 : length(d_W_int(1,:))

            d_W_int(h,in) = d_W_int(h,in) + learning_rate*(input_y_train(:,1) - input_y(:,1))'*V_weights(:,h)*input_z(h,1)*(1 - input_z(h,1))*input_x(in,1);

        end

    end

d_W = d_W_int;

end