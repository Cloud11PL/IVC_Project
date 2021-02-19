function images = occlusion(images,length)
    
    occ = zeros(length,length,3);
   
    for n = 1:size(images,4)
        
        image = images(:,:,:,1);

        x = randi([1 224-length]);
        y = randi([1 224-length]);

        image(x:x+length-1,y:y+length-1,:) = occ;

        images(:,:,:,n) = image;
    end
    
    images = uint8(images);
    
end

