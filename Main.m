function Main()
%% Reading Cover Image and Watermark Image

% First we will read lena image, this image will be our cover image and we will hide a watermark in it
coverImagePath = 'TestImages/lena_gray.jpg';
coverImage = imread(coverImagePath);
% and than we will convert this image to gray image
coverImage = rgb2gray(coverImage);

% now lets read our watermark
watermarkImagePath = 'TestImages/watermark.jpg';
watermarkImage = imread(watermarkImagePath);
% Converting watermark image to gray scale image
watermarkImage = rgb2gray(watermarkImage);
% Converting watermark image to binary
watermarkImage = imbinarize(watermarkImage);

% Here you can see the cover image and watermark image 
% we will hide this watermark into the cover image
figure(1);
subplot(1,2,1)
imshow(coverImage)
title('Cover Image')

subplot(1,2,2)
imshow(watermarkImage)
title('Watermark Image')

%% Embedding Watermark

% The next step is embedding watermark with Least Significant Bit method 
% for this purpose lets write a function called embedWatermark
watermarkedImage = embedWatermark(watermarkImage,coverImage);

% After embedding watermark we can measure the imperceptibility of this watermarked image
% I have already told you about two metrics PSNR and MSE
% i have two function for this metrics 
PSNR = PeakSignaltoNoiseRatio(coverImage, watermarkedImage);
MSE = MeanSquareError(coverImage, watermarkedImage);
fprintf('WatermarkedImage PSNR: %f MSE: %f\n\n',PSNR,MSE);

% Showing watermarked and cover image
%as you can see here we cant recognize the watermark which embedded into cover image
figure(2);
subplot(1,2,1)
imshow(coverImage)
title('Cover Image')

subplot(1,2,2)
imshow(watermarkedImage)
title('Watermarked Image')

%% Attacking the watermarked image
% by opening this section, you can attack the watermarked image and observe
% the change in the extracted watermark

% for applying Average Filter Attack
% watermarkedImage = AverageFilter(watermarkedImage,3);

% Gaussian low-pass filter Attack
% watermarkedImage = GlowpassFilter(watermarkedImage,3)

% Histogram Equalization Attack
% watermarkedImage = HistAttack(watermarkedImage);

% JPEG2000 compression Attack
% watermarkedImage = Jp2Attack(watermarkedImage,12);

% JPEG compression Attack
% watermarkedImage = JpegAttack(watermarkedImage,20);

% Median Attack for size 3
% watermarkedImage = MedianAttack(watermarkedImage,3);

% Motion Blur Attack theta = 4 len = 7
% watermarkedImage = MotionAttack(watermarkedImage,7);

% Gaussian Noise Attack
% watermarkedImage = NoiseGauss(watermarkedImage,0.001);

% Salt and Pepper Noise Attack
% watermarkedImage = NoiseSaltPepper(watermarkedImage,0.001);

% Speckle Noise Attack
% watermarkedImage = NoiseSpeckle(watermarkedImage,0.001);

% Rotating Attack 5 degree
% watermarkedImage = RotateAttack(watermarkedImage,5);

%% Extract Watermark

% now lets extract the watermark from watermarked image
[extractedWatermark] = extractWatermark(watermarkedImage,size(watermarkImage,1),size(watermarkImage,2));

% Similarity between original watermark and extracted watermark
PSNR = PeakSignaltoNoiseRatio(watermarkImage, extractedWatermark);
MSE = MeanSquareError(watermarkImage, extractedWatermark);
fprintf('Watermark PSNR: %f MSE: %f\n\n',PSNR,MSE);

figure(3);
subplot(1,2,1)
imshow(watermarkImage)
title('Original Watermark')

subplot(1,2,2)
imshow(extractedWatermark)
title('Extracted Watermark')
end

% Embedding watermark into cover image
function [watermarkedImage] = embedWatermark(watermark,coverImage)

    %i am creating a for loop to call each bit of the watermark one by one
    for x=1:size(watermark,1)
        for y=1:size(watermark,2)
           
            %now let's take the original image pixel in which we will embed the watermark
            % after that we will convert it to eight bit binary
            B = de2bi(coverImage(x,y),'left-msb');
            % we will change our bit with least significant bit of cover image
            B(1,size(B,2)) = watermark(x,y);
            % now let's get our watermarked pixel by converting this number back to decimal. 
            coverImage(x,y) = bi2de(B,'left-msb');
        end
        %finally we have a watermarkedImage
        watermarkedImage = coverImage;
    end
end

% we will provide the watermarkedImage and the size of watermark as input
% and this function will give us a extracted watermark
% If I had chosen a watermark that I would embed in the entire image, 
%I would not have needed to give the size of the watermark.
% but in this example we need size of watermark as input
function [extractedWatermark] = extractWatermark(watermarkedImage,sizeX,sizeY)

    % first i will create a pattern for watermark
    extractedWatermark = zeros(sizeX,sizeY);
    %we will create a for loops again for getting pixels from watermarked image
    for x=1:sizeX
        for y=1:sizeY
            %now let's take the watermarked image pixel in 
            %which we will embed the watermark 
            % after that we will convert it to eight bit binary
            B = de2bi(watermarkedImage(x,y),'left-msb');
            % now we will fill our pattern with the bits we got from the watermarked image
            extractedWatermark(x,y) = B(1,size(B,2));
        end
    end
end



