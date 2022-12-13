%This function reads in all images in folder1/ and folder2/. 
%Each 64 x 64 image is reshaped into a length-4096 row vector. 
%These row vectors are stacked on top of one another to get two data
%matrices, each with 4096 columns. The first matrix folder1_elements consists of all
%the cat images as row vectors and the second matrix folder2_elements consists of all
%the dog images as row vectors.

function [folder1_elements, folder2_elements] = read_folders(folder1, folder2)
    folder1_files = dir(fullfile(folder1, '*.jpg')); 
    folder1_filenames = {folder1_files.name};
    num_folder1_files = length(folder1_filenames);
    
    folder1_elements = [];
    for i = 1:num_folder1_files
        folder1_temp_filename = folder1_filenames{i};
        folder1_temp_image = imread(strcat(folder1,folder1_temp_filename));
        folder1_vec_temp = reshape(folder1_temp_image,1,4096);
        folder1_elements = [folder1_elements ; folder1_vec_temp];
    end
          
    folder2_files = dir(fullfile(folder2, '*.jpg')); 
    folder2_filenames = {folder2_files.name};
    num_folder2_files = length(folder2_filenames);
    
    folder2_elements = [];
    for i = 1:num_folder2_files
        folder2_temp_filename = folder2_filenames{i};
        folder2_temp_image = imread(strcat(folder2,folder2_temp_filename));
        folder2_vec_temp = reshape(folder2_temp_image,1,4096);
        folder2_elements = [folder2_elements ; folder2_vec_temp];
    end
    
    folder1_elements = double(folder1_elements);
    folder2_elements = double(folder2_elements);

end
