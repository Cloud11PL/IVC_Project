function images = HSVSaturation(images,sd)

    for n = 1:size(images,4)
        image = images(:,:,:,n);
        imageHSV = rgb2hsv(image);
        saturation = imageHSV(:,:,2);
        newSat = imnoise(saturation,'gaussian',0,sd);
        imageHSV(:,:,2) = newSat; 
        images(:,:,:,n) = im2uint8(hsv2rgb(imageHSV));
    end

    images = uint8(images);
end