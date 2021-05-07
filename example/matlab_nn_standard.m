%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MATLAB NN Algorithm

% % ex1
% t = [0:0.1:20];                 % input values
% 
% Y_general = sin(t);             % target values
% 
% net = feedforwardnet(6);
% net = train(net,t,Y_general);
% y = net(t);
% plot(t,Y_general,'o',t,y,'x')


% ex 2
inputDataNN = inputData';
outputDataNN = outputData';

net = feedforwardnet(4);
net = train(net,inputDataNN,outputDataNN);
y = net(inputDataNN);

figure
plot(outputDataNN)
hold on
plot(y)



%% MATLAB NN Algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%