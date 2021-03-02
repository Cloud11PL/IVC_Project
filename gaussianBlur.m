function images = gaussianBlur(images,times)

    H = [1 2 1; 2 4 2; 1 2 1]/16;
    J = 1;
    
    for i = 1:times
        J = conv2(J,H);
    end
    
    for n = 1:size(images,4)
            image = images(:,:,:,n);
            images(:,:,:,n) = imfilter(image,J,'conv');
    end
    
    images = uint8(images);
end

