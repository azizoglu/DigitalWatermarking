%% Sharpening attack strength
function sharpenImageAttacked = SharpenAttack(watermarked_image,strength)
sharpenImageAttacked = imsharpen(watermarked_image,'Amount',strength);
end

