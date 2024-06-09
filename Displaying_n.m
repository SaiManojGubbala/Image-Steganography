% Order of Running These Codes
% 1) EncodingImage.m
% 2) Converting.m
% 3) Embedding.m
% 4) Decoding.m
% 5) Displaying.m
figure 
tiledlayout(3,3)

nexttile
imshow(Input_Image)
title("Image To be Hidden");

nexttile
imshow(Cover_Image)
title("Cover Image");

nexttile
imshow(round(Quantized_Image)/255)
title("Quantized Image");

nexttile
imshow(Final_Steganographed_Image)
title("Steganographed Image");

nexttile
imshow(Obtained_Image)
title('Decoded Hidden Image');

 mse = double(Red_Part) - Steganographed_Image1;
 mse = double(mse);
  Mse = [];
 for i = 1 : DCT_Block_Size : n3
    for j = 1 : DCT_Block_Size : n4
        Block_Matrix = mse(i:i+DCT_Block_Size-1,j:j+DCT_Block_Size-1);
        Mse = [Mse zigzag(Block_Matrix)];
    end
 end

 sum = 0.00;
 N = 1024*1024;
 
 for j = 1:Embedding_Length
         sum = sum + (Mse(i)^2)/N;
 end

MAX = 255*255; 
PSNR = 10*log10(double(MAX/sum))
