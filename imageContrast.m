function images = imageContrast(images, val)
    %Loop over images
    for n = 1:size(images,4)
        %Get image at index
        image = images(:,:,:,n);
        %Multiple all channels by constant value
        images(:,:,:,n) = image * val;
    end
    %Make sure image is 0-255 values
    images = uint8(images);
end

