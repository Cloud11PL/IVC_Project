function img = gray2rgb(img)
    if size(img,3) ~= 3
        img = img(:,:,[1,1,1]);
    end
end 