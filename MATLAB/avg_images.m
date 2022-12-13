%%Note that you must run this script in a directory that contains folder1folder
%%and folder2folder as subdirectories.
function avg_images(folder1, folder2)
    %Read folder1 and folder2 data.
    %[folder1, folder2] = read_folders(foldername1, foldername2);
    n_folder1 = size(folder1,1);
    n_folder2 = size(folder2,1);

    %Split dataset into training and test data.
    folder1_train = folder1(1:floor(n_folder1/2),:);
    folder1_test = folder1(floor(n_folder1/2)+1:n_folder1,:);
    folder2_train = folder2(1:floor(n_folder2/2),:);
    folder2_test = folder2(floor(n_folder2/2)+1:n_folder2,:);
    n_folder1_test = size(folder1_test,1);
    n_folder2_test = size(folder2_test,1);


    %Calculate average folder1 and folder2 images on the training data.
    avg_img1 = Vector_average(folder1_train);
    avg_img2 = Vector_average(folder2_train);
    figure(1)
    Show_image(avg_img1,1);
    exportgraphics(figure(1), 'avg1.png', 'Resolution', 300);
    hold off
    figure(2)
    Show_image(avg_img2,1);
    exportgraphics(figure(2), 'avg2.png', 'Resolution', 300);
    hold off

    %Classify test images.
    guesses1 = zeros(n_folder1_test,1);
    guesses2 = zeros(n_folder2_test,1);
    for i = 1:n_folder1_test
        current_img1 = folder1_test(i,:);
        guesses1(i) = Classifier(current_img1,avg_img1,avg_img2);
    end

    for i = 1:n_folder2_test
        current_img2 = folder2_test(i,:);
        guesses2(i) = Classifier(current_img2,avg_img1,avg_img2);
    end

    %Calculate the fraction of folder1 and folder2 images that are misclassified by our
    %simple "closest-average" classifier.
    [error_rate1, error_rate2] = Error_rate_3(guesses1,guesses2);
    %Print fractions to the display.
    
    folder1tring = sprintf('echo "The fraction of folder1 images misclassified by the closest average is %.2g."',error_rate1);
    system(folder1tring);
    folder2tring = sprintf('echo "The fraction of folder2 images misclassified by the closest average is %.2g."',error_rate2);
    system(folder2tring);
    
end
