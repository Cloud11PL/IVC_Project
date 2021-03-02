function images = HSVSaturation(images,sd)

    for n = 1:size(images,4)
        image = images(:,:,:,n);
        imageHSV = rgb2hsv(image);
        saturation = imageHSV(:,:,2);
        mat = normrnd(0,sd,224,224);
        newSat = saturation + mat;
        newSat(newSat<0)=0;
        newSat(newSat>1)=1;
        imageHSV(:,:,2) = newSat; 
        images(:,:,:,n) = hsv2rgb(imageHSV);
    end

    images = uint8(images);
end