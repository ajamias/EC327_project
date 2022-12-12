% Takes in a pet image currentpet (as a row vector) and two additional row vectors, avg_cat and avg_dog, corresponding to the average cat and dog images.
function guess = Classifier(currentpet,avg_cat,avg_dog)
    % using euclidean to find the distance
    dis_cat = sqrt(sum((currentpet-avg_cat).^2));
    dis_dog = sqrt(sum((currentpet-avg_dog).^2));

    % compares
    if dis_cat > dis_dog
        guess = 1;              % Dog
    else
        guess = 0;              % Cat
    end

    if (guess~=0 && guess~=1) 
        error("The variable guess is not 0 or 1.")
    end
end
