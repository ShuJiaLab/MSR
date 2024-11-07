function S27_DataSave_MOV_1FOVV2_Test(  File_32_FLFPSF_ExpRaw, File_52_FLFVid_ExpRaw , ...
                                        FLF_Load_ImshowMag,Data_02_formDt,Recons_43_NumEd, ...
                                        FLF_Test_Index_Ini,FLF_Test_Index_End,FLF_Load_Index_Stp,...
                                        FLF_ExpImg_range_x,FLF_ExpImg_range_y,FLF_SubPSF_crp_dia,...
                                        FLF_PSFSub_crp_sfx,FLF_PSFSub_crp_sfy,FLF_PSFSub_crp_sfz,...
                                        GroupName,Framesize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GroupName = char(FLF_ExpBKG_GrpName(idxfl))
% FileSuffix = File_0h_sbk
% FLF_ExpSub_crp_rad = 250

% File_52_FLFVid_ExpRaw = '..';
% GroupName = '';

    for idxsg = 1                                                          % FLFimg read and save name set    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load file name set
        FLF_Load_Folder = [File_52_FLFVid_ExpRaw,GroupName,'\'];
        FLF_Load_IndexTStr = ls(FLF_Load_Folder);        
        FLF_Load_IndexAStr = FLF_Load_IndexTStr(3:end,:);
        FLF_Load_Index_Str = char(FLF_Load_IndexAStr-FLF_Load_IndexAStr);
        FLF_Load_Index_Num = 0;
        for idxfr = 1:size(FLF_Load_Index_Str,1)
            [~,~,File_ext] = fileparts(FLF_Load_IndexAStr(idxfr,:));
            if( strcmp(strtrim(File_ext),'.tif') )
                FLF_Load_Index_Num=+1;
                FLF_Load_Index_Str(FLF_Load_Index_Num,:) = FLF_Load_IndexAStr(idxfr,:);
            end
        end
        FLF_Load_Index_Str = FLF_Load_Index_Str(1:FLF_Load_Index_Num,:);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load and save Index set
        FLF_Test_Index_All = FLF_Test_Index_Ini:FLF_Load_Index_Stp:FLF_Test_Index_End;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FOV crop parameter set
        FLF_ExpImg_sub_rad = floor(FLF_SubPSF_crp_dia/2);
        FLF_ExpImg_sub_dia =  FLF_ExpImg_sub_rad*2+1 ;
        FLF_ExpImg_sub_Ind = -FLF_ExpImg_sub_rad:FLF_ExpImg_sub_rad;
        
        load([File_32_FLFPSF_ExpRaw,'\','FLFM_PSF_CenfitCoordinates_sub',Data_02_formDt],'FLF_ExpPSF_sub_Yfit','FLF_ExpPSF_sub_Xfit')
        FLF_ExpImg_subYcen = FLF_ExpPSF_sub_Yfit(:,:,ceil(size(FLF_ExpPSF_sub_Yfit,3)/2)+FLF_PSFSub_crp_sfz) + FLF_PSFSub_crp_sfy + FLF_ExpImg_range_y(1) - 1;
        FLF_ExpImg_subXcen = FLF_ExpPSF_sub_Xfit(:,:,ceil(size(FLF_ExpPSF_sub_Xfit,3)/2)+FLF_PSFSub_crp_sfz) + FLF_PSFSub_crp_sfx + FLF_ExpImg_range_x(1) - 1;

        FLFimg_74_tepFOV = zeros(FLF_ExpImg_sub_dia*Recons_43_NumEd,FLF_ExpImg_sub_dia*Recons_43_NumEd,'uint16');
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for idxfr = FLF_Test_Index_All                                                 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Image read 
            FLFimg_70_Origin = imread([FLF_Load_Folder,strtrim(FLF_Load_Index_Str(idxfr,:))]);
%                                                                          U61_Imshow_B16_Fire(FLFimg_70_Origin)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Crop the original image to fix the FOV
        for idxxi = 1:Recons_43_NumEd                                      % FLFimg FOV limited one crop range set
        for idxet = 1:Recons_43_NumEd                                      % FLFimg generated eleimg by eleimg    
            FLFimg_74_tepFOV((1:FLF_ExpImg_sub_dia) + (idxet-1)*FLF_ExpImg_sub_dia ,   ...
                             (1:FLF_ExpImg_sub_dia) + (idxxi-1)*FLF_ExpImg_sub_dia ) = ...
            FLFimg_74_tepFOV((1:FLF_ExpImg_sub_dia) + (idxet-1)*FLF_ExpImg_sub_dia ,   ...
                             (1:FLF_ExpImg_sub_dia) + (idxxi-1)*FLF_ExpImg_sub_dia ) + ...
            FLFimg_70_Origin(   FLF_ExpImg_sub_Ind  + FLF_ExpImg_subYcen(idxet,idxxi),...
                                FLF_ExpImg_sub_Ind  + FLF_ExpImg_subXcen(idxet,idxxi),:);
        end
        end
        disp(idxfr);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        FLFimg_SubTem0 = zeros(size(FLFimg_70_Origin),'uint16');
        FLFimg_SubTem1 = ones(FLF_ExpImg_sub_dia)*65535;
        FLFimg_SubTem1(Framesize+1:(end-Framesize), ...
                       Framesize+1:(end-Framesize)) = 0;
        for idxxi = 1:Recons_43_NumEd                                      % FLFimg FOV limited one crop range set
        for idxet = 1:Recons_43_NumEd                                      % HybPSF generated eleimg by eleimg   
            FLFimg_SubTem0(   FLF_ExpImg_sub_Ind  + FLF_ExpImg_subYcen(idxet,idxxi),...
                              FLF_ExpImg_sub_Ind  + FLF_ExpImg_subXcen(idxet,idxxi)) = FLFimg_SubTem1;
        end
        end
        FLFimg_Subshow = FLFimg_70_Origin + FLFimg_SubTem0/max(max(FLFimg_70_Origin))/2;
%         figure,imshow(FLFimg_70_Origin,[])
%         figure,imshow(FLFimg_Subshow,[])

%     figure,imshow(ind2rgb( uint16( single(FLFimg_Subshow-90).^FLF_Load_ImshowMag ),parula(65535)))
      U40_Imshow_Sat((FLFimg_Subshow-90).^4,1)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
end





















