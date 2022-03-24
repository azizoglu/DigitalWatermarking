%% Histogram Equalization attack
function histImageAttacked = HistAttack(watermarked_image)
histImageAttacked = histeq(watermarked_image);
end
