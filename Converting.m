Counter = 1;
for i = 1: n1*n2
    if(Counter <= Embedding_Length)
        Least_Significant_Bit = mod(Quantized_Image_Final(:,i),2);
%The mod function produces a result that is either zero or has the same sign as the divisor. 
        Encoded_Message(i) = Quantized_Image_Final(i) + double(xor(Least_Significant_Bit,Binary_Information(Counter)));
        Counter = Counter + 1;
    end
end

% number_of_iterations for 1024 columns each iteration gives 8 columns 
Iterations = n1/DCT_Block_Size;
EightRow = [];
IZigZag_Encoded_Image = [];
% Number of Matrcies to embed n1/8 and then embed in rows in this case 1024/8 = 128
for i = 1:DCT_Block_Size.^2:length(Encoded_Message)
        Temp = Encoded_Message(i:i+DCT_Block_Size^2-1);
        Temp1 = izigzag(Temp,8,8);
        EightRow = [EightRow Temp1];
end
iterator = n1*n2/DCT_Block_Size;
for i = 1:n2:iterator
    Temp = EightRow(:,i:i+n2-1);
    IZigZag_Encoded_Image = [IZigZag_Encoded_Image ; Temp];
end
%Now Performing Inverse Quantisation and Inverse DCT 
Steganographed_Image = zeros(n1,n2);
for i = 1 : DCT_Block_Size : n1
    for j = 1 : DCT_Block_Size : n2
        for k = 1:1:DCT_Block_Size
            for l = 1:1:DCT_Block_Size
                Steganographed_Image(i+k-1,j+l-1) = IZigZag_Encoded_Image(i+k-1,j+l-1)*Quantization_Table(k,l);
            end
        end

    end
end

for i = 1 : DCT_Block_Size : n1
    for j = 1 : DCT_Block_Size : n2
        Block_Matrix = Steganographed_Image(i:i+DCT_Block_Size-1,j:j+DCT_Block_Size-1);
        IDCT = InverseCosineTransform(Block_Matrix);
        Steganographed_Image1(i:i+DCT_Block_Size-1,j:j+DCT_Block_Size-1) = IDCT;
    end
end
imshow(Steganographed_Image1/255);
%The Final Red Part of Steganographed Image
Final_Steganographed_Image = cat(3,Steganographed_Image1,Green_Part,Blue_Part);
imwrite(Final_Steganographed_Image,"Steganogrphed_Image.jpg");

imshow(Final_Steganographed_Image);
title("Steganographed Image");



