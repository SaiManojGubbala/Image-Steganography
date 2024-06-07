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
