function [W_new,V_new] = phiLmUpdate(W,V,coeffUpdate,I,H,K)

counter = 1;

W_int = W;
V_int = V;

for k = 1 : 1 : K

    for h = 1 : 1 : H + 1

        V_int(k,h) = V_int(k,h) - coeffUpdate(counter,1);

        counter = counter + 1;
    end

end


for h = 1 : 1 : H

    for in = 1 : 1 : I

        W_int(h,in) = W_int(h,in) - coeffUpdate(counter,1);

        counter = counter + 1;

    end

end

W_new = W_int;
V_new = V_int;

end