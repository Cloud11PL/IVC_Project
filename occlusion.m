function images = occlusion(images,length)
    
    %Define occlusion pathc of size length x length x 3
    occ = zeros(length,length,3);
   
    %Loop over images
    for n = 1:size(images,4)
        %Extract image
        image = images(:,:,:,n);
        %Select random x and y coordinates
        x = randi([1 224-length]);
        y = randi([1 224-length]);
        %Add occlusion over region of image
        image(x:x+length-1,y:y+length-1,:) = occ;
        %Replace with new image in images array
        images(:,:,:,n) = image;
    end
    
    %Make sure 0-255 values
    images = uint8(images);
    
end

