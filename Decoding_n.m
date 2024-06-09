Extracted_Red_Image =Steganographed_Image1/255;
Extracted_Red_Image = (im2double(Extracted_Red_Image))*255;
[n3 n4] = size(Extracted_Red_Image);
DCT_Image_Recieved = zeros(n3,n4);
for i = 1:DCT_Block_Size:n3
    for j = 1:DCT_Block_Size:n4
        Block_Matrix = Extracted_Red_Image(i:i+DCT_Block_Size-1 , j:j+DCT_Block_Size-1);
        DCT_Image_Recieved(i:i+DCT_Block_Size-1,j:j+DCT_Block_Size-1) = CosineTransform(Block_Matrix);
    end
end
%performing dct on the steganographed image

Quantized_Image_Recieved = zeros(n1,n2);
for i = 1:DCT_Block_Size:n1
    for j = 1:DCT_Block_Size:n2
        for k = 1:DCT_Block_Size
            for l = 1:DCT_Block_Size
                Quantized_Image_Recieved(i+k-1,j+l-1) = (DCT_Image_Recieved(i+k-1,j+l-1)/Quantization_Table(k,l));
            end
        end
    end
end
%performing quantiation on the steganographed image 

%Zigzag converts the image into a row matrix 
ZigZag_Recieved = [];
for i = 1 : DCT_Block_Size : n1
    for j = 1 : DCT_Block_Size : n2
        Block_Matrix = Quantized_Image_Recieved(i:i+DCT_Block_Size-1,j:j+DCT_Block_Size-1);
        ZigZag_Recieved = [ZigZag_Recieved zigzag(Block_Matrix)];
    end
end
Lsbbit = [];
for i = 1:1:Embedding_Length
     Variable = round((mod(ZigZag_Recieved(i),1))*128);
     if Variable == 128
         Lsbbit = [Lsbbit 0];
     else
         Lsbbit = [Lsbbit Variable ];
     end
end

counter = 1;
Extracting_Length = Embedding_Length;
%Lsbbit = mod((ZigZag_Recieved(1:Embedding_Length)),1);
%This line extracts lsb bit of all the steganoraphed image
Huffman_Decoded = huffmandeco(Lsbbit,Huffman_Dictionary);
%Performing the huffman decoding
%reshaping the extracted image Again to remove noise
Reshaped_Decoded_Image = reshape(Huffman_Decoded,[256 256]);
Obtained_Image = (Reshaped_Decoded_Image)/255;
imwrite(Obtained_Image,"SecretImage.jpg");
%mat2gray converts matlab array into a greyscale image 
