function images = HSVSaturation(images,sd)
    %Loop over images
    for n = 1:size(images,4)
        %Extract image at index
        image = images(:,:,:,n);
        %Convert image to HSV
        imageHSV = rgb2hsv(image);
        %Extract stauration layer
        saturation = imageHSV(:,:,2);
        %Add gaussian noise to saturation
        newSat = saturation + normrnd(0,sd,224,224);
        %Set values greater than 1 to 1
        newSat(newSat>1) = 1;
        %Set values less than 0 to 0
        newSat(newSat<0) = 0;
        %Replace with new noisy saturation
        imageHSV(:,:,2) = newSat; 
        %Convert image back to RGB and back into image array
        images(:,:,:,n) = im2uint8(hsv2rgb(imageHSV));
    end
    %Make sure 0-255 values
    images = uint8(images);
end