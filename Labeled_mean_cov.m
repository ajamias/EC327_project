%This function takes in a data matrix X, corresponding vector 
%of labels Y, and a desired label. It outputs the the number 
%of samples with desiredlabel as n_label as well as the sample
%mean vector mu_label (as a row vector) and sample covariance 
%matrix sigma_label for the data in X whose labels in Y are equal
%to the desired label.
function [n_label,mu_label,sigma_label] = labeled_mean_cov(X,Y,desiredlabel)
    [n, d] = size(X);
    
    X_desired = zeros(1, d);
    n_label = 0;
    for i = 1:n
        if (Y(i, 1) == desiredlabel)
            n_label = n_label + 1;
            X_desired(n_label, :) = X(i, :);
        end
    end
    mu_label = sum(X_desired) / n_label;

    sigma_label = ((X_desired - (ones(n_label, 1) * mu_label))' * (X_desired - (ones(n_label, 1) * mu_label))) / (n_label - 1);
end