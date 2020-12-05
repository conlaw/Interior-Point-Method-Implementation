function [A,b,c] = construct_svm_lp(X, Y)
    n = size(X,1);
    A_data = diag(Y)*X;
    A = [A_data, -A_data, eye(n), -eye(n)];
    b = ones(n, 1);
    c = [ones(size(A,2) - n,1); zeros(n,1)];
end
