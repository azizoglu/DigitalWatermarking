%% Gaussian Noise Attack
function GaussNoiseImageAttacked = NoiseGauss(watermarked_image,var)
GaussNoiseImageAttacked = imnoise(watermarked_image, 'gaussian', 0,var);
end