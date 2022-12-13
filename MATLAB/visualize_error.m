function visualize_error(folder1_elements, folder2_elements)

    %[folder1_elements, folder2_elements] = read_folders(foldername1, foldername2);
    %{
    num_folder1_elements = size(folder1_elements,1);
    num_folder2_elements = size(folder2_elements,1);
    %}
    % Determine size of datasets.
    [n0, d0] = size(folder1_elements);
    [n1, d1] = size(folder2_elements);

    n = n0 + n1;
%{
    if (d0 == d1)
        d = d0;
    else
        error("folder1_elements and folder2_elements have a different number of columns.")
    end
%}
    % Split the data into numfolds equal-sized segments. 
    numfolds = 5;
    kvalues = [10 25 50 100 250 500]; 
    numkvalues = length(kvalues);

    % Create data matrix and label vector.
    datamatrix = [folder1_elements;folder2_elements];
    labelvector = [zeros(n0,1);ones(n1,1)];

    % Randomly permute dataset
    permutation = randperm(n);

    % Initialize arrays to store error rate estimates.
    % LDA Train Error
    train_error_LDA = zeros(numfolds,length(kvalues));
    test_error_LDA = zeros(numfolds,length(kvalues));

    % QDA Train Error
    train_error_QDA = zeros(numfolds,length(kvalues));
    test_error_QDA = zeros(numfolds,length(kvalues));

    for m = 1:numfolds
        permshift = circshift(permutation,floor(n*m/numfolds));
        dataperm = datamatrix(permshift,:);
        labelperm = labelvector(permshift,:);

        % Split dataset into training and test data.
        Xtrain = dataperm(1:floor(n*(numfolds-1)/numfolds),:);
        Xtest = dataperm(floor(n*(numfolds-1)/numfolds)+1:n,:);
        Ytrain = labelperm(1:floor(n*(numfolds-1)/numfolds),:);
        Ytest = labelperm(floor(n*(numfolds-1)/numfolds)+1:n,:);
        ntrain = size(Xtrain,1);
        ntest = size(Xtest,1);

        % Estimate mean vector and covariance matrix from Xtrain.
        mu = mean(Xtrain);
        sigma = cov(Xtrain);

        % Determine eigenvalues and eigenvectors. 
        [V, D] = eig(sigma);

        for j = 1:numkvalues
            k = kvalues(j);     % Dimensionality reduction parameter.

            % Reduce dataset from d to k dimensions using PCA.
            Xtrain_reduced = Dimensionality_reduction(Xtrain,mu,V,D,k);
            Xtest_reduced = Dimensionality_reduction(Xtest,mu,V,D,k);

            % Determine number of samples, mean vector, and covariance matrix for each label.
            [n0train, mu0, sigma0] = Labeled_mean_cov(Xtrain_reduced,Ytrain,0);
            [n1train, mu1, sigma1] = Labeled_mean_cov(Xtrain_reduced,Ytrain,1);

            % Using the LDA algorithm
            % Produce guesses for the training and testing data.
            sigmapooled = 1/(n0train+n1train-2)*((n0train-1)*sigma0+(n1train-1)*sigma1);
            trainguesses_LDA = LDA(Xtrain_reduced,mu0,mu1,sigmapooled);
            testguesses_LDA = LDA(Xtest_reduced,mu0,mu1,sigmapooled);

            % Store resulting LDA error rates.
            train_error_LDA(m,j) = Error_rate_2(trainguesses_LDA,Ytrain);
            test_error_LDA(m,j) = Error_rate_2(testguesses_LDA,Ytest);

            % Using the QDA algorithm
            % Produce guesses for the training and testing data.
            trainguesses_QDA = QDA(Xtrain_reduced,mu0,mu1,sigma0,sigma1);
            testguesses_QDA = QDA(Xtest_reduced,mu0,mu1,sigma0,sigma1);

            % Store resulting QDA error rates.
            train_error_QDA(m,j) = Error_rate_2(trainguesses_QDA,Ytrain);
            test_error_QDA(m,j) = Error_rate_2(testguesses_QDA,Ytest);
        end
    end
    
    %Plot average training and testing error rates for LDA and QDA.
    figure(1)
    hold off
    plot(kvalues,mean(train_error_LDA),'ro-','linewidth',2,'MarkerSize',10)
    hold on
    plot(kvalues,mean(test_error_LDA),'rx-','linewidth',2,'MarkerSize',10)
    plot(kvalues,mean(train_error_QDA),'bo-','linewidth',2,'MarkerSize',10)
    plot(kvalues,mean(test_error_QDA),'bx-','linewidth',2,'MarkerSize',10)
    xlabel('Dimension k')
    ylabel('Error Rate')
    legend('LDA Training Error','LDA Testing Error','QDA Training Error','QDA Testing Error')
    set(gca,'FontSize',16)
    exportgraphics(figure(1), 'ErrorRate.png', 'Resolution', 300);
    
end