function images = HSVHue(images,sd)
    %Loop over images
    for n = 1:size(images,4)
        %Get image at index
        image = images(:,:,:,n);
        %Convert image to HSV
        imageHSV = rgb2hsv(image);
        %Extract hue layers
        hue = imageHSV(:,:,1);
        %Add gaussian noise to layer
        newHue = hue + normrnd(0,sd,224,224);
        %If value above 1 subtract 1
        newHue(newHue>1) = newHue(newHue>1)-1;
        %If value it below 0 add 1
        newHue(newHue<0) = newHue(newHue<0)+1;
        %Replace hue layer
        imageHSV(:,:,1) = newHue; 
        %Convert image back to RGB
        images(:,:,:,n) = im2uint8(hsv2rgb(imageHSV));
    end

    %Make sure 0-255
    images = uint8(images);
end

