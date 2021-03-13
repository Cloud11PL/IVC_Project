function img = gray2rgb(img)
    %If images layers not equal to 3
    if size(img,3) ~= 3
        %Replicate layer 1, 3 times and set images
        img = img(:,:,[1,1,1]);
    end
end 