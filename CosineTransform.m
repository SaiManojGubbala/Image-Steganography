function DCT = CosineTransform(Image)
    
    [m, n] = size(Image);
    
    DCT = zeros(m, n);
    
    for i = 0:m-1
        for j = 0:n-1
            sum = 0;
            for k = 0:m-1
                for l = 0:n-1
                    sum = sum + Image(k+1,l+1) * cos(pi*(2*k+1)*i/(2*m)) * cos(pi*(2*l+1)*j/(2*n));
                end
            end
            if i == 0
                ci = sqrt(1/m);
            else
                ci = sqrt(2/m);
            end
            if j == 0
                cj = sqrt(1/n);
            else
                cj = sqrt(2/n);
            end
            DCT(i+1,j+1) = ci * cj * sum;
        end
    end
end

