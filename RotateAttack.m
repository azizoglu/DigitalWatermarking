%% Rotating Attack 2 degree
function rotatImageAttacked = RotateAttack(watermarked_image,param)
rotatImageAttacked = imrotate(watermarked_image, param,'crop');
end


