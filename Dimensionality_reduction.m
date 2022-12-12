%This function takes in a data matrix Xrun, mean vector mu, 
%eigenvector matrix V, and eigenvalues D, and dimension k. 
%It selects the k eigenvectors corresponding to the k largest
%eigenvalues, centers the data by subtracting mu, and projects
%the centered data to k dimensions by multiplying by the matrix
%of k eigenvectors.
function Xrun_reduced = Dimensionality_reduction(Xrun,mu,V,D,k)
%    [r, ~] = size(Xrun);
%    Vk = V(:, 1:k);
%    eigvals = abs(sum(D));

%    for i = 1:k
%        [~, maxi] = max(eigvals);
%        eigvals(maxi) = 0;
%        Vk(:, i) = V(:, maxi);
%    end
    
%    Xcentered = Xrun - (ones(r, 1) * mu);
%    Xrun_reduced = Xcentered * Vk;

%[~, sortedindices] = sort(diag(D));     % diagonal matrices

%i = sortedindices(k);                   % max eigenvalue
%j = sortedindices(k-1);                 % second top eigenvalue
%Vk = V(:,[j, i]);

%Xcentered = Xrun - mu;                  % center i by subtracting the sample mean vector from each row
%Xrun_reduced = Xcentered * Vk;

[~, sortedindices] = sort(-diag(D));
Vk = V(:,sortedindices(1:k));
Xrun_reduced = (Xrun - mu) * Vk;
end