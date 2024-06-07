function IDCT = InverseCosineTransform(DCT)
    % Get the size of the input matrix
    [m, n] = size(DCT);
    
    % Initialize the IDCT result matrix
    IDCT = zeros(m, n);
    
    % Compute the IDCT
    for i = 0:m-1
        for j = 0:n-1
            sum = 0;
            for k = 0:m-1
                for l = 0:n-1
                    if k == 0
                        ci = sqrt(1/m);
                    else
                        ci = sqrt(2/m);
                    end
                    if l == 0
                        cj = sqrt(1/n);
                    else
                        cj = sqrt(2/n);
                    end
                    sum = sum + ci * cj * DCT(k+1,l+1) * cos(pi*(2*i+1)*k/(2*m)) * cos(pi*(2*j+1)*l/(2*n));
                end
            end
            IDCT(i+1,j+1) = sum;
        end
    end
end


