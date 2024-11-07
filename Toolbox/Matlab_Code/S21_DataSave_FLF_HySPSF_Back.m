function FLF_HySPSF_Nor = S21_DataSave_FLF_HySPSF_Back( FLF_HyRPSF_Nor     ,FLF_SubPSF_crp_rad ,Recons_43_NumEd,...
                                                        FLF_ExpPSF_sub_Ypos,FLF_ExpPSF_sub_Xpos,FLF_ExpPSF_Zshift)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% V0->V1
% Focal plane can be adjusted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data_10_File  = File_42_FLF_Fixexp_Proc
% Data_11_strhd = FLFPSF_48_fix_strhd
% Data_11_strtl = FLFPSF_48_fix_strtl
% Data_13_FOVZu = +0*10^-6
% Data_13_FOVZl = -0*10^-6
% Data_14_STP_Z = 1.0*10^-6
% Data_12_dzstr = Recons_07_dzstr
% Data_12_zcstr = Recons_07_zcstr
% Data_19_form  = Data_01_formIm

for idxsg = 1                                                              % HyRPSF cropped for deeper field        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    FLF_SubPSF_crp_dia = FLF_SubPSF_crp_rad*2+1;                           % Crop HybPSF diameter
    FLF_SubPSF_crp_cen = FLF_SubPSF_crp_rad*1+1;                           % Crop HybPSF diameter

    FLF_HyRPSF_size = size(FLF_HyRPSF_Nor);                                % Original HybPSF size
    
    Imshow_B16_MIP_3D(     FLF_HyRPSF_Nor);                                % HybPSF imshow

                                                                           % Cropped HybPSF memory assignment
    FLF_HySPSF_Nor = zeros(FLF_SubPSF_crp_dia*Recons_43_NumEd,FLF_SubPSF_crp_dia*Recons_43_NumEd,FLF_HyRPSF_size(3));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    FLF_HySPSF_SubCentY = FLF_ExpPSF_sub_Ypos(:,:,ceil(size(FLF_ExpPSF_sub_Ypos,3)/2)+1+FLF_ExpPSF_Zshift);   % Cropped HybPSF subPSF centers coordinates y
    FLF_HySPSF_SubCentX = FLF_ExpPSF_sub_Xpos(:,:,ceil(size(FLF_ExpPSF_sub_Xpos,3)/2)+1+FLF_ExpPSF_Zshift);   % Cropped HybPSF subPSF centers coordinates x

    FLF_HySPSF_SubEdgeY = FLF_HySPSF_SubCentY;
    FLF_HySPSF_SubEdgeX = FLF_HySPSF_SubCentX;
    Recons_43_NumEr = ceil(Recons_43_NumEd/2);
    for idxxi = 1:Recons_43_NumEd                                          % Cropped HybPSF subPSF range generated eleimg by eleimg             
    for idxet = 1:Recons_43_NumEd
        FLF_HySPSF_SubEdgeY(idxet,idxxi) = FLF_HySPSF_SubCentY(idxet,idxxi)+(idxet-Recons_43_NumEr)*FLF_SubPSF_crp_rad;
        FLF_HySPSF_SubEdgeX(idxet,idxxi) = FLF_HySPSF_SubCentX(idxet,idxxi)+(idxxi-Recons_43_NumEr)*FLF_SubPSF_crp_rad;
    end
    end
                                                                           %    
    Dist_CrpHybPSFEdge = min([FLF_HyRPSF_size(1)-max(FLF_HySPSF_SubEdgeY(:)),...
                              FLF_HyRPSF_size(2)-max(FLF_HySPSF_SubEdgeX(:)),...
                                                 min(FLF_HySPSF_SubEdgeY(:))-1,...
                                                 min(FLF_HySPSF_SubEdgeY(:))-1 ]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                                           %Make the size of Cropped HybPSF subPSF index within the range of HybPSF
%     load([FLF_HyRPSF_saveUniN,'_','Nor' ,Data_02_formDt])
%     FLF_SubPSF_crp_rad_Use = FLF_SubPSF_crp_rad + min(Dist_CrpHybPSFEdge,0);
    FLF_SubPSF_crp_rad_Use = FLF_SubPSF_crp_rad + min(Dist_CrpHybPSFEdge,0) - 1;
    FLF_SubPSF_crp_Int =-FLF_SubPSF_crp_rad_Use : FLF_SubPSF_crp_rad_Use;  % Cropped HybPSF subPSF index 

    for idxxi = 1:Recons_43_NumEd                                          % HybPSF generated eleimg by eleimg             
    for idxet = 1:Recons_43_NumEd
        FLF_HySPSF_Nor((idxet-1)*FLF_SubPSF_crp_dia + FLF_SubPSF_crp_cen + FLF_SubPSF_crp_Int,...
                       (idxxi-1)*FLF_SubPSF_crp_dia + FLF_SubPSF_crp_cen + FLF_SubPSF_crp_Int,:) = ...
        FLF_HyRPSF_Nor(FLF_HySPSF_SubCentY(idxet,idxxi)                  + FLF_SubPSF_crp_Int,...
                       FLF_HySPSF_SubCentX(idxet,idxxi)                  + FLF_SubPSF_crp_Int,:);
            disp(['idxet = ',num2str(idxet),', ',...
                  'idxxi = ',num2str(idxxi),', ',]);
    end
    end
%     close all
end
end

        
function [] = Imshow_B16_MIP_3D(Image_Data)                                
%Show max projection of image in 3D direction
% Image_Data = FLF_HyRPSF_Nor;
    
    Image_norm   = rescale(double(Image_Data));
    
    Image_MaxP_x = squeeze(max(Image_norm,[],1))';
    Image_MaxP_y = squeeze(max(Image_norm,[],2));
    Image_MaxP_z = squeeze(max(Image_norm,[],3));
    
    Image_size = [size(Image_norm,1),size(Image_norm,2),size(Image_norm,3)];
    Seam__size = ceil(Image_size(1)/30);
%     Seam__size = 1;
    Maxpr_size = Image_size(3) + Seam__size + Image_size(1);
    Image_MaxP = ones(Maxpr_size,Maxpr_size);
    Image_MaxP( 1:Image_size(1)                              ,                              1:Image_size(2))   = Image_MaxP_z;
    Image_MaxP( 1:Image_size(1)                              ,Image_size(2) + Seam__size + (1:Image_size(3)) ) = Image_MaxP_y;
    Image_MaxP((1:Image_size(3)) + Image_size(1) + Seam__size,                              1:Image_size(2)  ) = Image_MaxP_x;
%                                                                            figure;imshow(Image_MaxP)
    Image_MaxP_hot = ind2rgb(uint16(Image_MaxP*65536),hot(65536));         figure;imshow(Image_MaxP_hot)
end

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

















































