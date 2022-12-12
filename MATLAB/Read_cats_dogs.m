%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reads in all images in catsfolder/ and dogsfolder/.
% Each 64 x 64 image is reshaped into a length-4096 row vector.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [cats, dogs] = Read_cats_dogs
    catsfolder = 'catsfolder/'; 
    catfiles = dir(fullfile(catsfolder, '*.jpg')); 
    catfilenames = {catfiles.name};
    numcats = length(catfilenames);
    
    cats = [];
    for i = 1:numcats
        catfilenametemp = catfilenames{i};
        catimagetemp = imread(strcat(catsfolder,catfilenametemp));
        catvectemp = reshape(catimagetemp,1,4096);
        cats = [cats ; catvectemp];
    end
          
    dogsfolder = 'dogsfolder/'; 
    dogfiles = dir(fullfile(dogsfolder, '*.jpg')); 
    dogfilenames = {dogfiles.name};
    numdogs = length(dogfilenames);
    
    dogs = [];
    for i = 1:numdogs
        dogfilenametemp = dogfilenames{i};
        dogimagetemp = imread(strcat(dogsfolder,dogfilenametemp));
        dogvectemp = reshape(dogimagetemp,1,4096);
        dogs = [dogs ; dogvectemp];
    end
    
    cats = double(cats);
    dogs = double(dogs);

end
