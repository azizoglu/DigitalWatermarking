%% Speckle Noise Attack
function SpeckleNoiseImageAttacked = NoiseSpeckle(watermarked_image,param)
SpeckleNoiseImageAttacked = imnoise(watermarked_image, 'speckle', param);
end