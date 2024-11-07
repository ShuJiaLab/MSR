function Image_MaxP_16b = U65_Imshow_B16_MIP_3D_Fire(Image_Data) 
%Show max projection of image in 3D direction
% Image_Data = RecPE4_d5_Crpnor;
% Image_Data = RecFLF_80_Imgcrp;
% Image_Data = RecFLF_85_FlpNor(Recons_13cIndRy,Recons_13cIndRx,Recons_13cIndRz);
% Image_Data = FLF_HySPSF_Nor;
    
    MaxIntensity = 65535;
   [Colormap_bt16,~,~] = U06_Color_B16('fire');
   
    Image_norm   = rescale( single(Image_Data) ) ;
    
%     Image_MaxP_x = squeeze(Image_norm(:,277,:))';
%     Image_MaxP_y = squeeze(Image_norm(359,:,:));
%     Image_MaxP_z = squeeze(max(Image_norm,[],3)) ;
    Image_MaxP_x = squeeze(max(Image_norm,[],1))';   
    Image_MaxP_y = squeeze(max(Image_norm,[],2)) ;
    Image_MaxP_z = squeeze(max(Image_norm,[],3)) ;
    
    Image_size_y = size(Image_norm,1);
    Image_size_x = size(Image_norm,2);
    Image_size_z = size(Image_norm,3);
    Blank_size   = ceil(Image_size_y/30);
    
    Image_MaxP = ones(Image_size_z + Blank_size + Image_size_y,...
                      Image_size_z + Blank_size + Image_size_x);
    Image_MaxP( 1:Image_size_y                             ,                             1:Image_size_x)   = Image_MaxP_z;
    Image_MaxP( 1:Image_size_y                             ,Image_size_x + Blank_size + (1:Image_size_z) ) = Image_MaxP_y;
    Image_MaxP((1:Image_size_z) + Image_size_y + Blank_size,                             1:Image_size_x  ) = Image_MaxP_x;
    
    Image_MaxP_16b = ind2rgb( uint16(Image_MaxP*MaxIntensity), Colormap_bt16) *MaxIntensity;
    
    Image_MaxP_16b(Image_size_y+(1:Blank_size),  :              ,:) = MaxIntensity;
    Image_MaxP_16b(    :            ,Image_size_x+(1:Blank_size),:) = MaxIntensity;
    Image_MaxP_16b(end+1-(1:Image_size_z),end+1-(1:Image_size_z),:) = MaxIntensity;
    
    Image_MaxP_16b = uint16(Image_MaxP_16b);
    figure;imshow(Image_MaxP_16b)
%     hold on;plot([1,572],[359,359],'w--');
%     hold on;plot([277,277],[1,572],'w--');
%     figure;imshow(Image_MaxP_16b*2)
end


    