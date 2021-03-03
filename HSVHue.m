function images = HSVHue(images,sd)

    for n = 1:size(images,4)
        image = images(:,:,:,n);
        imageHSV = rgb2hsv(image);
        hue = imageHSV(:,:,1);
        mat = normrnd(0,sd,224,224);
        newHue = hue + mat;
        newHue(newHue>1) = newHue(newHue>1)-1;
        imageHSV(:,:,1) = newHue; 
        images(:,:,:,n) = im2unit8(hsv2rgb(imageHSV));
    end

    images = uint8(images);
end
