%This function takes in a data matrix Xrun as well the mean vectors mu0, mu1 
%and the covariance matrices sigma0, sigma1 estimated from the training data
%and produces a column vector guesses, corresponding to the ML rule for Gaussian vectors
%with different means and different covariance matrices, which is referred to as 
%Quadratic Discriminant Analysis (QDA) in machine learning.
function guesses = QDA(Xrun,mu0,mu1,sigma0,sigma1)
sigma0_inv = pinv(sigma0);
sigma1_inv = pinv(sigma1);
sum_log_eig0 = sum(log(eig(sigma0)));
sum_log_eig1 = sum(log(eig(sigma1)));

[nrun, ~] = size(Xrun);
guesses = zeros(nrun, 1);

for i = 1:nrun
    xrow = Xrun(i,:);
    loglikelihood0 = -0.5 * ((xrow - mu0) * sigma0_inv * transpose(xrow - mu0) + sum_log_eig0);
    loglikelihood1 = -0.5 * ((xrow - mu1) * sigma1_inv * transpose(xrow - mu1) + sum_log_eig1);
    if (loglikelihood0 <= loglikelihood1)
        guesses(i) = 1;
    elseif (loglikelihood0 > loglikelihood1)
        guesses(i) = 0;
    end
end
end