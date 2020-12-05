function [alpha] = compute_alpha(var, var_pred)
    alphas = - var ./ var_pred;
    alphas(var_pred >= 0) = Inf;
    alpha = min(alphas);
end
