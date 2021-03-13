function images = imageBrightness(images,val)
    %Loop over images
    for n = 1:size(images,4)
        %Get image at index 
        image = images(:,:,:,n);
        %Add constant value over whole image
        images(:,:,:,n) = image + val;
    end
    %Make sure values between 0-255
    images = uint8(images);
end

