%% Median Attack for size m
function medianImageAttacked = MedianAttack(watermarked_image,m)
medianImageAttacked = medfilt2(watermarked_image,[m m]);
end

