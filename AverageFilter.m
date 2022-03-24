%% Average Filter Attack
function averageImageAttacked = AverageFilter(watermarked_image,param)
h = fspecial('average',[param param]);
averageImageAttacked = imfilter(watermarked_image,h,'replicate');
end
