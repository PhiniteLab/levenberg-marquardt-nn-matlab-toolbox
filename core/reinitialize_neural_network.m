function [W,W_previous,V,V_previous] = reinitialize_neural_network(number_of_hidden_layer_node, number_of_output_layer_node, number_of_input_layer_node,W_pre,V_pre)

    I = number_of_input_layer_node;
    
    H = number_of_hidden_layer_node;
    
    K = number_of_output_layer_node;

    W = randi([-100 100],H,I)./100;
    %W = zeros(H,I);
    
    W(1:H-1,:) = W_pre;

    W_previous = randi([-100 100],H,I)./100;

    V = randi([-100 100],K,H+1)./100;
    %V = zeros(K,H);

    V(:,1:H) = V_pre;

    V_previous = randi([-100 100],K,H+1)./100;


end