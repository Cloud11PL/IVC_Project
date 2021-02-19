function images = gaussianBlur(images)

    H = [1 2 1; 2 4 2; 1 2 1]/16;
    
    for n = 1:size(images,4)
            image = images(:,:,:,n);
            images(:,:,:,n) = imfilter(image,H,'conv');
    end
    
    images = uint8(images);
end

