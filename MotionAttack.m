%% Motion Blur Attack theta = 4 len = 7
function motionImageAttacked = MotionAttack(watermarked_image,param)
h = fspecial('motion',param,4);
motionImageAttacked = imfilter(watermarked_image,h,'replicate');
end
