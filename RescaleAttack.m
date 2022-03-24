%% Rescaling (0.25) Attack
function rescaleImageAttacked = RescaleAttack(watermarked_image,param)
rescaleImageAttacked = imresize(watermarked_image,param);
end

