%% JPEG compression Attack
function jpegImageAttacked = JpegAttack(watermarked_image,qualityFactor)
imwrite(watermarked_image,'jpegImageAttacked.jpg','jpg','quality',qualityFactor);
jpegImageAttacked = imread('jpegImageAttacked.jpg');
end
