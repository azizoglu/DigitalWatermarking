function MSE = MeanSquareError(origImg, distImg)
    origImg = double(origImg);
    distImg = double(distImg);
    [M N] = size(origImg);
    error = origImg - distImg;
    MSE = sum(sum(error .* error)) / (M * N);
end