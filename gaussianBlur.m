function images = gaussianBlur(images,times)

    %Gaussian Kernel
    H = [1 2 1; 2 4 2; 1 2 1]/16;
    %Resulting kernel(Associativity)
    J = 1;
    
    %Loop over the amount of convolutions
    for i = 1:times
        %Convolve kernels with one another
        J = conv2(J,H);
    end
    
    %Loop over images
    for n = 1:size(images,4)
            %Get image at index
            image = images(:,:,:,n);
            %Convolve J kerenl over image
            images(:,:,:,n) = imfilter(image,J,'conv');
    end
    
    %Make sure values between 0 and 255
    images = uint8(images);
end

