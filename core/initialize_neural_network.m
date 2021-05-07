function [W,W_previous,V,V_previous] = initialize_neural_network(number_of_hidden_layer_node, number_of_output_layer_node, number_of_input_layer_node,minVal,maxVal)

    I = number_of_input_layer_node;
    
    H = number_of_hidden_layer_node;
    
    K = number_of_output_layer_node;

    W = randi([minVal maxVal],H,I)./100;

    W_previous = randi([minVal maxVal],H,I)./100;

    V = randi([minVal maxVal],K,H+1)./100;

    V_previous = randi([minVal maxVal],K,H+1)./100;


end