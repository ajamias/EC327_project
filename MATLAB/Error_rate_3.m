function [error_rate1, error_rate2] = Error_rate_3(guesses1,guesses2);
[r1, c1] = size(guesses1);
[r2, c2] = size(guesses2);
error_rate1 = sum(guesses1)/r1;
error_rate2 = (r2 - sum(guesses2))/r2;


if (error_rate1 < 0 | error_rate1 > 1) 
    error("The variable error_rate1 is not between 0 and 1.")
end
if (error_rate1 < 0 | error_rate1 > 1) 
    error("The variable error_rate1 is not between 0 and 1.")
end
