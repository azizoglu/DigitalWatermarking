%% Salt and Pepper Noise Attack
function SaltPepperNoiseImageAttacked = NoiseSaltPepper(watermarked_image,param)
SaltPepperNoiseImageAttacked = imnoise(watermarked_image,'salt & pepper',param);
end