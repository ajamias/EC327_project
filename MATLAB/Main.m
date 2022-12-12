% Read cats and dogs data.
userpath("Users/austin/Desktop/EC327_project")
[cats, dogs] = Read_cats_dogs;
num_cats = size(cats,1);
num_dogs = size(dogs,1);

% Determine size of datasets.
[n0, d0] = size(cats);
[n1, d1] = size(dogs);

n = n0 + n1;

if (d0 == d1)
    d = d0;
else
    error("cats and dogs have a different number of columns.")
end

% Split the data into numfolds equal-sized segments. 
numfolds = 5;
kvalues = [10 25 50 100 250 500]; 
numkvalues = length(kvalues);

% Create data matrix and label vector.
datamatrix = [cats;dogs];
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

% Split dataset into training and test data.
cats_train = cats(1:floor(num_cats/2),:);
cats_test = cats(floor(num_cats/2)+1:num_cats,:);
dogs_train = dogs(1:floor(num_dogs/2),:);
dogs_test = dogs(floor(num_dogs/2)+1:num_dogs,:);
num_cats_test = size(cats_test,1);
num_dogs_test = size(dogs_test,1);

% Calculate average cat and dogs images on the training data.
avg_cat = Vector_average(cats_train);
avg_dog = Vector_average(dogs_train);

f = figure;

figure(1)
Show_image(avg_cat,1);
title('Average Cat');
exportgraphics(f, 'AvgCat.png', 'Resolution', 300);
hold off

figure(2)
Show_image(avg_dog,1);
title('Average Dog');
exportgraphics(f, 'AvgDog.png', 'Resolution', 300);
hold off

% Plot average training and testing error rates for LDA and QDA.
figure(3)
plot(kvalues,mean(train_error_LDA),'ro-','linewidth',2,'MarkerSize',10)
hold on
plot(kvalues,mean(test_error_LDA),'rx-','linewidth',2,'MarkerSize',10)
plot(kvalues,mean(train_error_QDA),'bo-','linewidth',2,'MarkerSize',10)
plot(kvalues,mean(test_error_QDA),'bx-','linewidth',2,'MarkerSize',10)
xlabel('Dimension k')
ylabel('Error Rate')
legend('LDA Training Error','LDA Testing Error','QDA Training Error','QDA Testing Error')
set(gca,'FontSize',16)
exportgraphics(f, 'ErrorRate.png', 'Resolution', 300);
hold off

% Classify test images.
cat_test_guesses = zeros(num_cats_test,1);
dog_test_guesses = zeros(num_dogs_test,1);

for i = 1:num_cats_test
    current_cat = cats_test(i,:);
    cat_test_guesses(i) = Classifier(current_cat,avg_cat,avg_dog);
end

for i = 1:num_dogs_test
    current_dog = dogs_test(i,:);
    dog_test_guesses(i) = Classifier(current_dog,avg_cat,avg_dog);
end

% Calculate the fraction of cat and dog images that are misclassified by our simple "closest-average" classifier.
[cat_error_rate, dog_error_rate] = Error_rate(cat_test_guesses,dog_test_guesses);

% Display error rate
catstring = sprintf('The fraction of cat images misclassified by the closest average is %.2g.',cat_error_rate);
dogstring = sprintf('The fraction of dog images misclassified by the closest average is %.2g.',dog_error_rate);


userpath('reset')
