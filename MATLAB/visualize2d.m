%This function takes in two datasets (which must have the same number of
%columns), and reduces them down to a two-dimensional representation via
%Principal Component Analysis. It outputs the reduced datasets and
%generates a two-dimensional scatter plot.
function visualize2d(dataset0, dataset1)
    %[dataset0, dataset1] = read_folders(foldername1, foldername2);
    X = [dataset0; dataset1];
    muX = mean(X);
    sigmaX = cov(X);
    %Your code starts here.
    [V D] = eig(sigmaX);
    D = sum(D);
    [M, N] = size(D);
    max0 = 1;
    max1 = 1;
    for k = 1:N
        if D(k) > D(max0)
            max0 = k;
        end
    end
    for l = 1:N
        if (D(l) > D(max1) && l ~= k)
            max1 = l;
        end
    end
    i = max0;
    j = max1;

    vi = V(:,i);
    vj = V(:,j);

    for m = 1:200
        dataset0_2d(m,:) = (dataset0(m,:) - muX) * [vi vj];
    end

    for n = 1:200
        dataset1_2d(n,:) = (dataset1(n,:) - muX) * [vi vj];
    end

    figure(1)
    scatter(dataset0_2d(:,1), dataset0_2d(:,2), "filled", 'b');
    hold on
    scatter(dataset1_2d(:,1), dataset1_2d(:,2), "filled", 'r');
    hold off
    exportgraphics(figure(1), '2D.png', 'Resolution', 300);
    %system("mv *.png ./../images");
end