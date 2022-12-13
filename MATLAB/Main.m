function main(foldername1, foldername2)
    [folder1_elements, folder2_elements, m1, n1, m2, n2] = read_folders(foldername1, foldername2);
    avg_images(folder1_elements, folder2_elements, m1, n1, m2, n2);
    visualize2d(folder1_elements, folder2_elements);
    visualize_error(folder1_elements, folder2_elements);
    system("mv *.png ./../images");
end