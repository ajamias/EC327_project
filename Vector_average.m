% Takes in a data matrix and outputs the average row vector.
function row_avg = Vector_average(datamatrix)
    [m,~] = size(datamatrix);       % m is a row, n is a column
    row_avg = sum(datamatrix)/m;    % sum(A) returns sum of each column in matrix
    
    if (size(row_avg,1)~=1) 
        error("The variable row_avg is not a row vector.")
    end
    if (size(row_avg,2)~=size(datamatrix,2))
        error("The variable row_avg does not have the same number of columns as the data matrix input.")
    end
end