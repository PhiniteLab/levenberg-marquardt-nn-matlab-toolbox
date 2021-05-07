%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% creating dataset for NN toolbox

clear all;
close all;
clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% creating input variables with the specific length and numbers

% specificy the constants of random numbers
inputNumber = 2;
lengthOfInput = 100;

outputNumber = 1;
lengthOfOutput = lengthOfInput;

% define input matrices
inputData = double(zeros(lengthOfInput,inputNumber+1));
% define output matrices
outputData = double(zeros(lengthOfOutput,outputNumber));

% define time series data
timeData = double([1:1:lengthOfInput]');


%% generating inputMatrices with specific outputValues

for i = 1 : 1 : length(inputData(:,1)) % for length search
   
    for j = 1 : 1 : length(inputData(1,:)) % for different input search
        
        if i <= length(inputData(:,1))/2   % only the half of data assigned to one class
        
            if j == 1
                % bias section is added to the code
                inputData(i,j) = 1;
            
            else
            
                % these values can be changed to represent the different
                % set of input variables
                
                % max-min values
                maxVal = 13;
                minVal = 4;

                inputData(i,j) = minVal + (maxVal - minVal)*rand(1,1);
            
            end
            
        else
   
            if j == 1
                % bias section is added to the code
                inputData(i,j) = 1;
            
            else
                        
                % these values can be changed to represent the different
                % set of input variables
                
                % max-min values
                maxVal = 17;
                minVal = 13;

                inputData(i,j) = minVal + (maxVal - minVal)*rand(1,1);
            
            end
            
        end
    
    end
    
end

for i = 1 : 1 : length(outputData(:,1))  % for length search 
    
    if i <= length(outputData(:,1))/2    % only the half of data assigned to one class

        outputData(i,1) = 0;
        outputData(i,2) = 1;

    else

        outputData(i,1) = 1;
        outputData(i,2) = 0;

    end
        
    
end


%% plotting the results
figure

for i = 1 : 1 : length(inputData(1,:))
    
    plot(timeData, inputData(:,i))
    hold on

end

for i = 1 : 1 : length(outputData(1,:))
    hold on
    plot(timeData, outputData(:,i))
    
end
legend('Bias Term','First Input','Second Input','Third input','OutputData')
xlabel('Time Data (no units)')
ylabel('Output Data (no units)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% generating one matrices to store the whole data

InOutMatrices = [inputData,outputData];

infoSection = [length(InOutMatrices(:,1)), length(inputData(1,:)), length(outputData(1,:)),zeros(1, length(InOutMatrices(1,:)) - 3)]; 
InOutMatrices = [infoSection;InOutMatrices];


%% creating input variables with the specific length and numbers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% writing the whole data to the text or excel files!

%% creating the proper file

fid = fopen('nnInputOutputFile.txt','wt');

% establishing writing format
writeFormat = "";

for i = 1 : 1 : length(InOutMatrices(1,:))
   
    writeFormat = writeFormat + "%f ";
    
    if i == length(InOutMatrices(1,:))
        
         writeFormat = writeFormat + "\n";
         
     end


end

% converting the right format to use in fprintf
writeFormat = char(writeFormat);

% writing the whole data to the text file
for i = 1 : 1 : length(InOutMatrices(:,1))
   
    fprintf(fid, writeFormat,InOutMatrices(i,:));
    
end



fclose(fid);

%% writing the whole data to the text or excel files!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%










%% creating dataset for NN toolbox
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
