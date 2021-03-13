function images = imdsToImages(imds)

    %Transform the imds using a gray to rgb function
    tImds = transform(imds, ...
        @(x) gray2rgb(x));
    
    %Initialize image array
    images = zeros(224,224,3,numel(imds.Files));
    
    %Initialize image index
    idx = 1;
    
    %Loop over images in transformed datastore
    while hasdata(tImds)
        %get an image in the imds
        mat = read(tImds);
        %Add image to the image array
        images(:,:,:,idx) = mat;
        %Increase image index
        idx = idx + 1;
    end
    
    %Make sure images are values 0-255
    images = uint8(images);
end

