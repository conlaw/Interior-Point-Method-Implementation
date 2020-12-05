function [x,y,s,k] = short_path(x,y,s,A,eps)
    fprintf('*** SHORT PATH ALGORITHM **** \n')

    mu = x'*s/size(x,1);
    k = 0;
    sigma = 1 - 0.4/sqrt(size(x,1));
    
    while mu > eps
        fprintf('***ITERATION %d **** \n', k)
        fprintf('mu = %f\n', mu)

        r3 = - (x .* s) + sigma*mu*ones(size(x));
        [step_x, step_y, step_s] = solve_IPM(A,x,s,zeros(size(y)),zeros(size(x)), r3);
        
        %Added alpha to get away with needing strictly feasible solution
        alpha = min(compute_alpha(x, step_x), compute_alpha(s, step_s));
        alpha = min([1, 0.99*alpha]);

        x = x + alpha*step_x;
        y = y + alpha*step_y;
        s = s + alpha*step_s;
        k = k + 1;
        mu = x'*s/size(x,1);

    end
    fprintf('***Algorithm Terminated after %d iterations **** \n', k)
    fprintf('FINAL :mu = %f\n', mu)
    
end

