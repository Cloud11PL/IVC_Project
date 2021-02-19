function images = HSVSaturation(images,sd)

    for n = 1:size(images,4)
        image = images(:,:,:,n);
        imageHSV = rgb2hsv(image);
        saturation = imageHSV(:,:,2);
        mat = normrnd(0,sd,224,224);
        imageHSV(:,:,2) = saturation + mat; 
        images(:,:,:,n) = hsv2rgb(imageHSV);
    end

    images = uint8(images);
end

