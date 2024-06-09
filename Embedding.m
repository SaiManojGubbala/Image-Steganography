Cover_Image = imread("coverimage.jpg");
size(Cover_Image)
Cover_Image_Dimensions = [1024 1024]
Cover_Image = imresize(Cover_Image,[Cover_Image_Dimensions(1) Cover_Image_Dimensions(2)]);
imwrite(Cover_Image,"Finalised_Cover_Image.jpg");

%This Has 3 Components RGB We are Embedding in the R Component
Red_Part = Cover_Image(:,:,1);
Green_Part = Cover_Image(:,:,2);
Blue_Part = Cover_Image(:,:,3);
Image = cat(3,Red_Part,Green_Part,Blue_Part);

Grey_Image = Red_Part;
Grey_Image = im2double(Grey_Image);
%Converts Image to Double Precision divides every value in matrix by 255
Grey_Image = Grey_Image*255;
%Integer Array Converted to Double

%To Perform Discrete Cosine Trandform For Block _ Matrix
DCT_Block_Size = 8;
n1 = (floor(Cover_Image_Dimensions(1)/DCT_Block_Size))*DCT_Block_Size;
n2 = (floor(Cover_Image_Dimensions(2)/DCT_Block_Size))*DCT_Block_Size;
Grey_Image  = resize(Grey_Image,[n1 n2]);
Blue_Part  = resize(Blue_Part,[n1 n2]);
Green_Part  = resize(Green_Part,[n1 n2]);
DCT_Image = zeros(n1,n2);
Quantized_Image = zeros(n1,n2);
Quantization_Table = [16 11 10 16 24 40 51 61;
                      12 12 14 19 26 58 60 55;
                      14 13 16 24 40 57 69 56;
                      14 17 22 29 51 87 80 62;
                      18 22 37 56 68 109 103 77;
                      24 35 55 64 81 104 113 92;
                      49 64 78 87 103 121 120 101;
                      72 92 95 98 112 100 103 99];
%Updating Performing DCT and Quantization Simultaneously

for i = 1 : DCT_Block_Size : n1
    for j = 1 : DCT_Block_Size : n2
        Block_Matrix = Grey_Image(i:i+DCT_Block_Size-1,j:j+DCT_Block_Size-1);
        DCT = CosineTransform(Block_Matrix);
        DCT_Image(i:i+DCT_Block_Size-1,j:j+DCT_Block_Size-1) = DCT;
    end
end

for i = 1 : DCT_Block_Size : n1
    for j = 1 : DCT_Block_Size : n2
        for k = 1:1:DCT_Block_Size
            for l = 1:1:DCT_Block_Size
                Temporary = DCT_Image(i+k-1,j+l-1);
                Quantized_Image(i+k-1,j+l-1) = Temporary/Quantization_Table(k,l);
            end
        end

    end
end



Quantized_Image_Final = round(Quantized_Image);
Encoded_Message1 = [];
for i = 1 : DCT_Block_Size : n1
    for j = 1 : DCT_Block_Size : n2
        Block_Matrix = Quantized_Image_Final(i:i+DCT_Block_Size-1,j:j+DCT_Block_Size-1);
        Encoded_Message1 = [Encoded_Message1 zigzag(Block_Matrix)];
    end
end


Quantized_Image_Final = Encoded_Message1;


Encoded_Message =(Quantized_Image_Final);





