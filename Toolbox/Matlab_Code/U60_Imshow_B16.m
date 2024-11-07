function [] = U60_Imshow_B16(Image_Data) 
%Show normalized image   
    Image_maxval = 65535;
    figure,imshow(uint16(Image_Data./max(Image_Data,[],'all')*Image_maxval));
end
                 
