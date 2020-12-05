function [step_x, step_y, step_s] = solve_IPM(A,x,s,r1, r2, r3)
    L = chol(A*diag( x./ s)*A', 'lower');
    r = r1 + A*( (x .* r2 - r3)./s);
    
    step_y = L'\(L\r);
    step_s = r2 - A' * step_y;
    step_x = (r3 - x .* step_s)./ s;
end
