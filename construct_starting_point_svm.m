function [x0,y0,s0] = construct_starting_point_svm(X)
    hp_dim = size(X,2);
    n = size(X,1);
    
    x0 = [ones(hp_dim,1);ones(hp_dim,1);2*ones(n,1);ones(n,1)];
    y0 = zeros(n,1);
    s0 = [ones(2*hp_dim +n,1); 10e-8*ones(n,1)]; %Note the is epsilon infeasible but needed for PD matrix

end
