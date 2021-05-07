function [JacobianTerm] = phiLm(nnOutput,trainingOutput, activationOutput, inputData, V_weights, K, H, I)

%%y(:,i), Y_general(:,i), z(:,i),X_general(:,i),V,K,H,I

J_int = [];

for k = 1 : 1 : K

    for h = 1 : 1 : H + 1

        J_int = [J_int,-activationOutput(h,1)];

    end

end


for k = 1 : 1 : K
    
    for h = 1 : 1 : H

        for in = 1 : 1 : I

            J_int = [J_int,(-1)*V_weights(k,h)*activationOutput(h,1)*(1 - activationOutput(h,1))*inputData(in,1)];

        end

    end

end

JacobianTerm = J_int;

end
