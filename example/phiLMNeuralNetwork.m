%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Dynamic Neural Network Application with PHI-LM application
clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% update path

addpath(genpath('../core'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Writing the dataset on the graph
creationDatasetForNNtext

X_general = inputData';
Y_general = outputData';

training_number = length(Y_general(1,:)); % number of training dataset

%% Writing the dataset on the graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% defining error parameters

errorNow = ones(training_number,1);  % error vector for now value
errorNowJac = ones(training_number,1);  % error vector for now value
errorPre = ones(training_number,1);  % error vector for pre value

errorNowValue = sum(errorNow);       % error value for now value
errorPreValue = sum(errorPre);       % error value for pre value

epsilon = 1e-7;
epsilonReinitialize = epsilon*epsilon*epsilon;

%% defining error parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Neural Network parameters

number_of_input_layer_node = length(X_general(:,1));
number_of_hidden_layer_node = 4;
number_of_output_layer_node = length(Y_general(:,1));

I = number_of_input_layer_node;
H = number_of_hidden_layer_node;
K = number_of_output_layer_node;

%% training parameters

iteration_max = 5000;        % for maximum iteration number
iteration = 0;               % for internal iteration number
detInvMatrices = 0;          % Jacobian determinant parameters
mu = 0.08;                   % learning parameter mu value
nnTrainingCondition = 1;     % neural network condition to be trained process


%% Neural Network parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% creating neural network structure

minVal = -10;
maxVal = 10;

[W,W_previous,V,V_previous] = initialize_neural_network(H, K, I,minVal,maxVal);

[z,y] = creating_activation_function(H, K, training_number);

%% creating neural network structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% general information related to the process

disp('Neural Network is started!');
disp('Basic information can be given by...');

disp('  ')
displayMessage = ['Input Layer Node: ',num2str(I), ' Hidden Layer Node :', num2str(H),...
    ' Output Layer Node: ',num2str(K)];
disp(displayMessage)

disp('  ')
disp('Training neural network is started in five seconds')

disp('  ')
pause(1);

mkdir('Outputs')

nnOutputFileId = fopen('Outputs/nnTrainInfo.txt','w');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% basic info transfer to file

fprintf(nnOutputFileId, strcat('Neural Network is started!','\n'));
fprintf(nnOutputFileId, strcat('Basic information can be given by...','\n'));
fprintf(nnOutputFileId, strcat(displayMessage,'\n'));
fprintf(nnOutputFileId, strcat('Training neural network is started in five seconds','\n'));

%% basic info transfer to file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% general information related to the process
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TRAINING PROCESS

%% comparing with the total error
while (nnTrainingCondition ~= 0)

    iteration = iteration + 1;
    errorPre = errorNow;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    %% training session is started
    JacobianTotal = [];

    for i = 1 : 1 : training_number

        % z value calculation
        z(:,i) = act_func_calc(X_general(:,i),W,H);

        % y value calculation
        y(:,i) = output_func_calc(z(:,i),V,K);

        JacobianTerm = phiLm(y(:,i), Y_general(:,i), z(:,i),X_general(:,i),V,K,H,I);

        JacobianTotal = [JacobianTotal;JacobianTerm];

        errorNow(i,1) = cost_function(y(:,i),Y_general(:,i));
        
        errorNowJac(i,1) = cost_function_jac(y(:,i),Y_general(:,i));

    end

    %% training session is started
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    
    JacMul = JacobianTotal'*JacobianTotal + mu*eye(H*I + K*(H+1));
    
    internalTermJac = inv(JacMul);
    
    detInvMatrices = det(internalTermJac);
 
    coeffUpdate = internalTermJac*(JacobianTotal'*errorNowJac);

    [W_new,V_new] = phiLmUpdate(W,V,coeffUpdate,I,H,K);

     W = W_new;
     V = V_new;

    errorNowValue = sum(abs(errorNow))/training_number;
    errorPreValue = sum(abs(errorPre))/training_number;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if (errorPreValue - errorNowValue) > 0

        internalAssessmentMu = (errorPreValue - errorNowValue);

        if abs(internalAssessmentMu) > (1e-1/training_number)

            mu = mu + mu*0.01;

        else

            mu = mu - mu*0.01;

        end

    end


    
    if ((errorPreValue - errorNowValue) < epsilonReinitialize) && (iteration > 1)
        disp('Reinitialize!!!')
        
        minV = randi([-10000 0],1,1);
        maxV = randi([0 10000],1,1);
        
       [W,W_previous,V,V_previous] = initialize_neural_network(H, K, I,minV,maxV);
       
       iteration = 0;
       mu = 0.08;
      
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% displaying the whole results

    if (mod(iteration,1) == 0)
    
        displayMessage = ['Error: ',num2str(errorNowValue),' Iteration: ',...
            num2str(iteration), ' Jacobian Check: ',num2str(detInvMatrices),' Mu: ',num2str(mu)];

        fprintf(nnOutputFileId,strcat(displayMessage,'\n'));
        
        disp(displayMessage)

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% nn condition update
    
    %nnTrainingCondition = (errorNowValue > epsilon) && (iteration < iteration_max)...
    %&& (mu > 1e-7) && (detInvMatrices < 1e500);

    nnTrainingCondition = (errorNowValue > epsilon) && (iteration < iteration_max)...
    && (mu > 1e-7);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

end

%% TRAINING PROCESS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TEST PROCESS

z_test = zeros(size(z));
y_test = zeros(size(y));

for i = 1 : 1 : training_number

    % z value calculation
    z_test(:,i) = act_func_calc(X_general(:,i),W,H);

    % y value calculation

    y_test(:,i) = output_func_calc(z(:,i),V,K);
    
end

figure
Y_plot = Y_general;

plot(Y_plot)

y_model_plot = y_test;

hold on
plot(y_model_plot)

%% TEST PROCESS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fclose(nnOutputFileId)


%% Dynamic Neural Network Application
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%