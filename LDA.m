%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Takes in a data matrix Xrun as well the mean vectors mu0, mu1 and the
% covariance matrices sigma0, sigma1 estimated from the training data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Produces a column vector guesses, corresponding to the ML rule for
% Gaussian vectors with different means and the same covariance matrix.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function guesses = LDA(Xrun,mu0,mu1,sigmapooled)
sigmapooled_inv = pinv(sigmapooled);
b = 2 * sigmapooled_inv * transpose(mu1 - mu0);
c = mu1 * sigmapooled_inv * transpose(mu1) - mu0 * sigmapooled_inv * transpose(mu0);

[nrun, ~] = size(Xrun);
guesses = zeros(nrun, 1);

for i = 1:nrun
    xrow = Xrun(i,:);
    if (xrow * b >= c)
        guesses(i,1) = 1;
    elseif (xrow * b < c)
        guesses(i,1) = 0;
    end
end
end