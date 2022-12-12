%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Takes in a data matrix Xrun, mean vector mu, eigenvector matrix V, and
% eigenvalues D, and dimension k.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Xrun_reduced = Dimensionality_reduction(Xrun,mu,V,D,k)
    [~, sortedindices] = sort(-diag(D));
    Vk = V(:,sortedindices(1:k));
    Xrun_reduced = (Xrun - mu) * Vk;
end