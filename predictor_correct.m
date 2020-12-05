function [x,y,s,k] = predictor_correct(A,b,c,eps)
    fprintf('*** PREDICTOR CORRECT ALGORITHM **** \n')
    
    x = ones(size(A,2),1);
    s = ones(size(A,2),1);
    y = ones(size(A,1),1);
    
    rp = b - A*x;
    rd = c - A'*y - s;
    mu = x'*s/size(x,1);
    k = 0;
    
    while max([mu,norm(rp),norm(rd)]) > eps
        fprintf('***ITERATION %d **** \n', k)
        fprintf('mu = %f; rp = %f; rd = %f \n', mu, norm(rp), norm(rd))
        
        [x_pred, y_pred, s_pred] = solve_IPM(A,x,s,rp, rd, -x .* s);
        alpha = min(compute_alpha(x, x_pred), compute_alpha(s, s_pred));
        alpha = min([1, 0.99*alpha]);

        mu_pred = (x + alpha*x_pred)'*(s + alpha*s_pred)/size(x,1);
        sigma = (mu_pred/mu)^3;

        r3 = sigma*mu*ones(size(x)) -  (x .* s) - (x_pred .* s_pred);
        [step_x, step_y, step_s] = solve_IPM(A,x,s,rp, rd, r3);
        
        alpha = min(compute_alpha(x, step_x), compute_alpha(s, step_s));
        alpha = min([1, 0.99*alpha]);
        
        x = x + alpha*step_x;
        y = y + alpha*step_y;
        s = s + alpha*step_s;

        rp = b - A*x;
        rd = c - A'*y - s;
        mu = x'*s/size(x,1);
        k = k+1;

    end
    fprintf('***Algorithm Terminated after %d iterations **** \n', k)
    fprintf('FINAL :mu = %f; rp = %f; rd = %f \n', mu, norm(rp), norm(rd))

    
end

