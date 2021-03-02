function images = imdsToImages(imds)

    tImds = transform(imds, ...
        @(x) gray2rgb(x));
    
    images = zeros(224,224,3,numel(imds.Files));
    
    idx = 1;
    
    while hasdata(tImds)
        mat = read(tImds);
        images(:,:,:,idx) = mat;
        idx = idx + 1;
    end
    
    images = uint8(images);
end

