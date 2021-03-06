function images = imageContrast(images, val)
    
    for n = 1:size(images,4)
        image = images(:,:,:,n);
        images(:,:,:,n) = image * val;

        if images(:,:,:,n) > 255
            images(:,:,:,n) = 255;
        end
    end

    images = uint8(images);

end

