function images = imageContrast(images, val)
    
    for n = 1:size(images,4)
        image = images(:,:,:,n);
        images(:,:,:,n) = image * val;
    end

    images = uint8(images);

end

