# Image Steganography 
---
## This is a project on Image Steganography which is performed using <span style="color:Cyan">Block-DCT and Huffman Coding </span>
---
## Description :
                  Image steganography is the art of hiding information into a cover 
    image. This project presents a technique for Image steganography based 
    on Block-DCT, where DCT is used to transform original image (cover image) 
    blocks from spatial domain to frequency domain. Firstly a grey scale image of 
    size M× N is divided into no joint 8 × 8 blocks and a two dimensional Discrete 
    Cosine Transform(2-d DCT) is performed on each of the P = MN / 64 blocks. 
    Then Huffman encoding is also performed on the secret messages/images 
    before embedding and each bit of Huffman code of secret message/image is 
    embedded in the frequency domain by altering the least significant bit of each 
    of the DCT coefficients of cover image blocks.
## Methodology :
    This Method of Image Steganography uses Huffman Coding to embed the bits into the cover image
    Since Huffman Coding decreases the number of bits required to embed
    The Image Quality of The Cover Image is not reduced Heavily as compared to normal lsb embedding 
    Normal method uses 8 bits to represent every pixel value (range 0 -255) for grey scale

    Block-DCT is performed on The Cover Image to convert the Image into frequency domain from spatial domain
    This is done to find the high frequency elements in the image
    Because, Human eyes can't really see the high frequency parts in the image 

    This technique is widely used in many image compression Techniques such as JPEG

    After converting it to frequency domain we perform Quantization to reduce amount of high frequency elements in the image
    As these elements gets reduced to value zero The amount of storage required to store the image or transmit the image is also reduced
    By keeping the Image Quality closer to the RAW Image 
    - Better Image Compression  

    Then Zig-Zag Scaning is also Done to the image matrix in frequency domain Could also be considered as improved security because the order of embedding changes
    Because , The matrix obtained may have intra block correlation to remove this zig zag  
    scanning is done which results in 1d array which is arranged in acceding order.    

    Note That All of These operations are performed on individual Block Matrix i.e(8*8 Matrices) of Image Matrix
## References :
---
- #### Research Papers : 
   - [A novel technique for image steganography based on Block-DCT and Huffman Encoding](https://www.researchgate.net/publication/220487276_A_novel_technique_for_image_steganography_based_on_Block-DCT_and_Huffman_Encoding)
   - [Multiple Image Steganography using LSB – DCT Technique](https://www.ijert.org/research/multiple-image-steganography-using-lsb-dct-technique-IJERTCONV4IS22067.pdf)
- #### Video Tutorials :
   - [About DCT and ZigZag Scanning](https://youtu.be/0me3guauqOU?si=Uwck6uYCQQ8sc9b1)
   - [Huffman Encoding 1](https://youtu.be/co4_ahEDCho?si=ItALl7S2Jz5Ga-y8)
   - [Huffman Encoding 2](https://youtu.be/B3y0RsVCyrw?si=MVzfAFsSimP5GHrt)
   - [LSB Steganography](https://youtu.be/yNo58UiIMKU?si=n3YN3GeK4z_MePhU)
## Running this Code :
    The Codes should be Run in the following order
    - EncodingImage.m
    - Embedding.m
    - Converting.m
    - Decoding.m
    - Displaying.m
    But make sure that all the files are in the same folder including 
    - CosineTransform.m
    - InverseCosineTransform.m
    The above two files have functions to perform Discrete Cosine Transform and Inverse Discrete Cosine Transform 
    The inbuilt Matlab ZigZag function is used for zigzag scanning 
---
### Procedure to Perform : 
##### Encoding :
![Screenshot 2024-06-07 200958](https://github.com/SaiManojGubbala/Image-Steganography-/assets/171187843/bb721fba-ee60-4e58-80fa-f10fa49c6a87)
##### Decoding :
![Screenshot 2024-06-07 201019](https://github.com/SaiManojGubbala/Image-Steganography-/assets/171187843/916fd443-de18-4ab5-b05d-25eff7958b59)
##### DCT Formula :
![Screenshot 2024-06-07 201038](https://github.com/SaiManojGubbala/Image-Steganography-/assets/171187843/b99a6c44-0d4a-4e0a-b09b-c0459b80bc75)
---
### Steps Involved : 
---
* __EncodingImage__
 
    * Read The Image using <span style="color:Cyan">imread()</span> function
    * Convert The Image into a row matrix using <span style="color:Cyan">reshape()</span> function
    * Find The Unique Elements and their frequency and sort them by Highest frequency elements on the top
    using <span style="color:Cyan">Hashing Method and Sorting</span> in this Bubble Sort is used
    * Now Generate Huffman Dictionary using <span style="color:Cyan">huffmandict()</span>
    * Now Convert it to Binary using Huffman Encoding using the inbuilt <span style="color:Cyan">huffmanenco()</span>
    * Convert this matrix into a single bit binary column matrix using The matrix transform using <span style="color:Cyan">( : ) or  '</span> operator 
---
* __Embedding__
    * Read The Cover Image using the <span style="color:Cyan">imread()</span> function
    * Now Apply 2-D DCT ( 2-Dimensional Discrete Cosine Transform ) to each 8*8 block matrix to this function is written in the <span style="color:Cyan">CosineTransform</span> file and the syntax goes as follows <span style="color:Cyan">CosineTransform()</span> function
    * Now Perform Quantization using The Quantization table provided in <span style="color:Cyan">Research Paper - 2</span> : 
        1) [Multiple Image Steganography using LSB – DCT Technique](https://www.ijert.org/research/multiple-image-steganography-using-lsb-dct-technique-IJERTCONV4IS22067.pdf)
    * After this use the <span style="color:Cyan"> round() </span> function to convert the high frequency valued elements to value zero after they are quantized
    * Now perform zigzag scanning to each 8*8 Block Matrix and Create a new Row Matrix of the whole greyscale image
    * Note That all these are applied to the Red Part of the image for better image quality
---
*  __Converting__
    * Embedding actually occurs here add the bit stream into the lsb of each pixel generated in the RowMatrix as a resultant of zigzag scanning
    * Now This Matrix is converted into a 2-D Matrix using the <span style="color:Cyan">izigzag()</span> function for each 8*8 blocks.... 
    * Now Perform Inverse Quantization using the same Quantization Table as above
    * Now Perform Inverse 2-D DCT to the Matrix using the function written it's syntax is as folllows <span style="color:Cyan">InverseCosineTransform()</span> and Now The Matrix is again obtained in the spatial domain 
    * _The_ _Matrix_ _Obtained_ _here_ _is_ _nothing_ _but_ _the_ _Steganographed_ _Image_ _with_ _primary_ _image_ _hidden_ _in_ _it_
    * Save the Image using the using the function <span style="color:Cyan">imwrite()</span> in-built function
---
* __Decoding__
    * Now for the obtained Steganographed Image perform DCT and Quantization on Red part again and extract all the Least Significant Bits of each Individual pixel after applying the zigzag function again
    * Decode the  Matrix using the Huffman Decoding using the <span style="color:Cyan">huffmandeco()</span> function along with it's Dictionary Generated in the Encoding Image part
    * Convert the Matrix into a displayable image using the <span style="color:Cyan">mat2gray()</span> function or just divide every element of array with 255 because max value of a coordinate is 255 in a a image
    * Save the Obtained image once again using the <span style="color:Cyan">imwrite()</span> inbuilt function
---
* __Displaying__
    * This is just to diplay all the Images in the table format using <span style="color:Cyan">figure()</span>  and <span style="color:Cyan">nexttile()</span> 
---
* __Results__  
The Steganographed Image obtained by two different methods (i.e by using Converting.m and Converting_n.m )
The Input Image and the Recieved Decoded Image
    | Converting.m | Converting_n.m |
    | --- | --- |
    | ![Screenshot 2024-06-12 012827](https://github.com/SaiManojGubbala/Image-Steganography/assets/171187843/09d91c1a-ea1f-43bb-aaa6-7b0740044246) | ![Screenshot 2024-06-12 012704](https://github.com/SaiManojGubbala/Image-Steganography/assets/171187843/0c4abdb0-9cf8-4c27-9978-a3356cd6b98a) |  
    | Message Image | Decoded Image |
    | ![Finalised_Encoding_Image](https://github.com/SaiManojGubbala/Image-Steganography/assets/171187843/29ed57bc-a203-4e44-aea2-89472e0c0d43) | ![SecretImage](https://github.com/SaiManojGubbala/Image-Steganography/assets/171187843/af04660b-1998-46be-9b76-667c35ae5346) |

