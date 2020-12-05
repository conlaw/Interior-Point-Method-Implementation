function [x,y,s] = find_initial_point(A, b, c)
    L = chol(A*A','lower');
    
    s = ones(size(c));
    y = L'\(L\(A*(c-s)));
    x = A'*(L'\(L\b));
end
