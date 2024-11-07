function SaveSuffix = S28_DataSave_MOV_3FOVSBKoCRPV2(   File_32_FLFPSF_ExpRaw,  File_53_FLFVid_BkgRaw, BKG_Group,...
                                                        File_52_FLFVid_ExpRaw,  File_56_FLFVid_ExpPro, Vid_Group,...
                                                        Data_01_formIm,Data_02_formDt,Recons_43_NumEd, ...
                                                        FLF_Load_Index_Ini,FLF_Load_Index_End,FLF_Load_Index_Stp,...
                                                        FLF_Save_Index_Ini,FLF_Save_Index_End,FLF_Save_Index_Seg,...
                                                        FLF_ExpImg_range_x,FLF_ExpImg_range_y,FLFRec_13_RdNum   ,...
                                                        FLF_PSFSub_crp_sfx,FLF_PSFSub_crp_sfy,FLF_PSFSub_crp_sfz,...
                                                        FLF_ExpSub_crp_sfx,FLF_ExpSub_crp_sfy,FLF_ExpSub_crp_sfz,...
                                                        FLF_Load_FrameRate,SaveSuffix        ,FLF_ExpImg_crp_rad,...
                                                        FLF_EXPImg_Offset ,FLF_BkgRationMVVOL,FLF_ExpSub_crp_Apt)
    %a
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BKG_Group = FLF_ExpBKG_GrpName(2)
% Vid_Group = FLF_ExpVid_GrpName(idxfl,:)
% SaveSuffix = File_0h_Sbk
% FLF_ExpSub_crp_rad = 250
    for idxsg = 1                                                          % FLFimg read and save name set    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load and save file name set
        if(isempty(SaveSuffix))
            SaveSuffix = char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'));
        end

        FLF_EXPVid_LoadFile = [File_52_FLFVid_ExpRaw,Vid_Group,'\'];
        FLF_EXPVid_SaveFile = [File_56_FLFVid_ExpPro,Vid_Group,SaveSuffix,'\']; mkdir(FLF_EXPVid_SaveFile)
        FLF_ExpVid_SaveUniN = [FLF_EXPVid_SaveFile  ,'FLF_ExpImg'];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load and save Index set
        FLF_Save_Index_All = FLF_Save_Index_Ini:FLF_Save_Index_Seg:FLF_Save_Index_End;
        FLF_ExpVid_LoadDep =  [num2str(FLF_Load_FrameRate*FLF_Load_Index_Ini),'-',...
                               num2str(FLF_Load_FrameRate*FLF_Load_Index_End),'-',...
                               num2str(FLF_Load_FrameRate*FLF_Load_Index_Stp),'s'];
        FLF_ExpVid_SaveDep =  [num2str(FLF_Load_FrameRate*FLF_Save_Index_Ini),'-',...
                               num2str(FLF_Load_FrameRate*FLF_Save_Index_End),'-',...
                               num2str(FLF_Load_FrameRate*FLF_Save_Index_Seg),'s'];

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Exp Image name set
        FLF_Load_IndexTStr = char(natsortfiles({dir(FLF_EXPVid_LoadFile).name}));
        FLF_Load_IndexAStr = FLF_Load_IndexTStr(3:end,:);
        FLF_Load_Depth_Ind = zeros(size(FLF_Load_IndexAStr,1),1);
        for idxfr = 1:size(FLF_Load_IndexAStr,1)
            [~,~,File_ext] = fileparts(FLF_Load_IndexAStr(idxfr,:));
            if( strcmp(strtrim(File_ext),'.tif') )
                FLF_Load_Depth_Ind(idxfr) = 1;
            end
        end
        FLF_Load_Index_Str = FLF_Load_IndexAStr(imbinarize(FLF_Load_Depth_Ind),:);
        
            FLF_Load_Dash__Num = find(FLF_Load_Index_Str(1,:)=='_');
        if isempty(FLF_Load_Dash__Num)
            FLF_Load_Dash__Num = 0;
        end
        FileName_Tep = [FLF_ExpVid_LoadDep,repmat( '0', 1,(size(FLF_Load_Index_Str,2)-FLF_Load_Dash__Num(end))+1  )];

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Background substraction parameter set
        FLF_ExpImg_sub_cen = ceil( FLFRec_13_RdNum/2);
        FLF_ExpImg_sub_rad = floor(FLFRec_13_RdNum/2);
        FLF_ExpImg_sub_dia =  FLF_ExpImg_sub_rad*2+1 ;
        FLF_ExpImg_sub_Ind = -FLF_ExpImg_sub_rad:FLF_ExpImg_sub_rad;
        
        if  FLF_EXPImg_Offset                                             
            FLFBKG_72_AveFOV = ones(FLF_ExpImg_sub_dia*Recons_43_NumEd,FLF_ExpImg_sub_dia*Recons_43_NumEd)*double(FLF_EXPImg_Offset);
        else
            load([File_53_FLFVid_BkgRaw,BKG_Group,'\','FLFBKGFOV',Data_02_formDt],'FLFBKG_72_AveFOV');
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FOV crop parameter set
      
        load([File_32_FLFPSF_ExpRaw,'\','FLFM_PSF_CenfitCoordinates_sub',Data_02_formDt],'FLF_ExpPSF_sub_Yfit','FLF_ExpPSF_sub_Xfit')
        
        FLF_ExpImg_subYcen = FLF_ExpPSF_sub_Yfit(:,:,ceil(size(FLF_ExpPSF_sub_Yfit,3)/2)+FLF_PSFSub_crp_sfz) + FLF_PSFSub_crp_sfy + FLF_ExpImg_range_y(1) - 1;
        FLF_ExpImg_subXcen = FLF_ExpPSF_sub_Xfit(:,:,ceil(size(FLF_ExpPSF_sub_Xfit,3)/2)+FLF_PSFSub_crp_sfz) + FLF_PSFSub_crp_sfx + FLF_ExpImg_range_x(1) - 1;

        FLF_ExpSub_crpYcen = FLF_ExpPSF_sub_Yfit(:,:,ceil(size(FLF_ExpPSF_sub_Yfit,3)/2)+FLF_ExpSub_crp_sfz) ...
                           - FLF_ExpPSF_sub_Yfit(:,:,ceil(size(FLF_ExpPSF_sub_Yfit,3)/2)+0)                  + FLF_ExpSub_crp_sfy + FLF_ExpImg_sub_cen;
        FLF_ExpSub_crpXcen = FLF_ExpPSF_sub_Xfit(:,:,ceil(size(FLF_ExpPSF_sub_Xfit,3)/2)+FLF_ExpSub_crp_sfz) ...
                           - FLF_ExpPSF_sub_Xfit(:,:,ceil(size(FLF_ExpPSF_sub_Xfit,3)/2)+0)                  + FLF_ExpSub_crp_sfx + FLF_ExpImg_sub_cen;

        FLFimg_71_TepFOV = zeros(FLF_ExpImg_sub_dia*Recons_43_NumEd,FLF_ExpImg_sub_dia*Recons_43_NumEd,'uint16');
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CrpImage parameter set
        if(length(FLF_ExpImg_crp_rad)==1)
            FLF_ExpImg_crp_rad = ones(2,1)*FLF_ExpImg_crp_rad;
        end
        FLF_ExpImg_Crp_szy = FLF_ExpImg_crp_rad(2)*2+1;
        FLF_ExpImg_Crp_szx = FLF_ExpImg_crp_rad(1)*2+1;
        FLF_ExpImg_CrpYInt =-FLF_ExpImg_crp_rad(2):FLF_ExpImg_crp_rad(2);
        FLF_ExpImg_CrpXInt =-FLF_ExpImg_crp_rad(1):FLF_ExpImg_crp_rad(1);

        FLFimg_74_TepCrp = zeros(FLF_ExpImg_Crp_szy*Recons_43_NumEd,FLF_ExpImg_Crp_szx*Recons_43_NumEd,'uint16');

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FOV image Aperture added or not
        if(FLF_ExpSub_crp_Apt)
            Stopper = single(repmat( ...
                      Stop_Modulation( FLF_ExpImg_sub_dia-FLF_ExpSub_crp_Apt,FLF_ExpImg_sub_dia ),Recons_43_NumEd));
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Index of Subimage show
        SubCen = [1,1];
        SubCro = [0,1];

    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for idxfr = FLF_Save_Index_All                                         
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rename the files                    
            Frame = ['Frm',num2str(idxfr,'%05.0f')];
            FileName_New = FileName_Tep;
            FileName_Old = strtrim(FLF_Load_Index_Str(idxfr,FLF_Load_Dash__Num(end):end));
            FileName_New((end-length(FileName_Old)+1):end) = FileName_Old;

                              S09_Rename( FLF_EXPVid_LoadFile,[strtrim(FLF_Load_Index_Str(idxfr,:))],FileName_New);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Image read 
                FLFimg_70_Origin = imread([FLF_EXPVid_LoadFile,FileName_New]);
%                                                                          U61_Imshow_B16_Fire(FLFimg_70_Orgdat)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Crop the original image to fix the FOV
                FLFimg_71_OrgFOV = FLFimg_71_TepFOV;
            for idxxi = 1:Recons_43_NumEd                                      % FLFimg FOV limited one crop range set
            for idxet = 1:Recons_43_NumEd                                      % FLFimg generated eleimg by eleimg    
                FLFimg_71_OrgFOV((1:FLF_ExpImg_sub_dia) + (idxet-1)*FLF_ExpImg_sub_dia ,   ...
                                 (1:FLF_ExpImg_sub_dia) + (idxxi-1)*FLF_ExpImg_sub_dia ) = ...
                FLFimg_70_Origin(   FLF_ExpImg_sub_Ind  + FLF_ExpImg_subYcen(idxet,idxxi),...
                                    FLF_ExpImg_sub_Ind  + FLF_ExpImg_subXcen(idxet,idxxi),:);
            end
            end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Offset substraction    
                FLFimg_72_SubBKG = single(FLFimg_71_OrgFOV) - single(FLFBKG_72_AveFOV*FLF_BkgRationMVVOL);
            if(FLF_ExpSub_crp_Apt)
                FLFimg_72_SubBKG = FLFimg_72_SubBKG.*Stopper;
            end                
%                                                                          U61_Imshow_B16_Fire(FLFimg_74_CrpDNS)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Crop the image in FOV to segment out the sample 
        if(FLF_ExpImg_Crp_szy(1)==FLFRec_13_RdNum)
                FLFimg_62_CenSBK = uint16(FLFimg_72_SubBKG(FLF_ExpImg_sub_dia*SubCen(1) + (1:FLF_ExpImg_sub_dia),...
                                                           FLF_ExpImg_sub_dia*SubCen(2) + (1:FLF_ExpImg_sub_dia)) );
                FLFimg_62_CroSBK = uint16(FLFimg_72_SubBKG(FLF_ExpImg_sub_dia*SubCro(1) + (1:FLF_ExpImg_sub_dia),   ...
                                                           FLF_ExpImg_sub_dia*SubCro(2) + (1:FLF_ExpImg_sub_dia)) );
            save(                     [FLF_ExpVid_SaveUniN,'_','7',SaveSuffix(2:end),'_',FLF_ExpVid_SaveDep,'_', Frame ,Data_02_formDt],'FLFimg_72_SubBKG');
            imwrite(FLFimg_62_CenSBK, [FLF_ExpVid_SaveUniN,'_','6',SaveSuffix(2:end),'_',FLF_ExpVid_SaveDep,'_','Subim',num2str(SubCen')', ...
                                                                                                                    Data_01_formIm],'WriteMode','append');
            imwrite(FLFimg_62_CroSBK, [FLF_ExpVid_SaveUniN,'_','6',SaveSuffix(2:end),'_',FLF_ExpVid_SaveDep,'_','Subim',num2str(SubCro')', ...
                                                                                                                    Data_01_formIm],'WriteMode','append');
        else
                FLFimg_73_Croped = FLFimg_74_TepCrp;
            for idxxi = 1:Recons_43_NumEd                                      % FLFimg FOV limited one crop range set
            for idxet = 1:Recons_43_NumEd                                      % HybPSF generated eleimg by eleimg    
                FLFimg_73_Croped((1:FLF_ExpImg_Crp_szy) + (idxet-1)*FLF_ExpImg_Crp_szy ,   ...
                                 (1:FLF_ExpImg_Crp_szx) + (idxxi-1)*FLF_ExpImg_Crp_szx ) = ...
                FLFimg_72_SubBKG(   FLF_ExpImg_CrpYInt  + (idxet-1)*FLF_ExpImg_sub_dia + FLF_ExpSub_crpYcen(idxet,idxxi),...
                                    FLF_ExpImg_CrpXInt  + (idxxi-1)*FLF_ExpImg_sub_dia + FLF_ExpSub_crpXcen(idxet,idxxi));
            end
            end
                FLFimg_63_CenCrp = uint16(FLFimg_73_Croped(FLF_ExpImg_Crp_szy*SubCen(1) + (1:FLF_ExpImg_Crp_szy),...
                                                           FLF_ExpImg_Crp_szx*SubCen(2) + (1:FLF_ExpImg_Crp_szx)) );
                FLFimg_63_CroCrp = uint16(FLFimg_73_Croped(FLF_ExpImg_Crp_szy*SubCro(1) + (1:FLF_ExpImg_Crp_szy),   ...
                                                           FLF_ExpImg_Crp_szx*SubCro(2) + (1:FLF_ExpImg_Crp_szx)) );
    
            imwrite(FLFimg_73_Croped,[FLF_ExpVid_SaveUniN,'_','7',SaveSuffix(2:end),'_',FLF_ExpVid_SaveDep,'_', Frame ,Data_01_formIm]);
            imwrite(FLFimg_63_CenCrp,[FLF_ExpVid_SaveUniN,'_','6',SaveSuffix(2:end),'_',FLF_ExpVid_SaveDep,'_','Subim',num2str(SubCen')', ...
                                                                                                                       Data_01_formIm],'WriteMode','append');
            imwrite(FLFimg_63_CroCrp,[FLF_ExpVid_SaveUniN,'_','6',SaveSuffix(2:end),'_',FLF_ExpVid_SaveDep,'_','Subim',num2str(SubCro')', ...
                                                                                                                       Data_01_formIm],'WriteMode','append');
        end
        disp(idxfr)
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
end

function Stopper = Stop_Modulation( Diameter_Inner,Diameter_Outer )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Diameter_Inner = FLF_ExpImg_crp_dia-6
% Diameter_Outer = FLF_ExpImg_crp_dia

        Radius_outer        = (Diameter_Outer-1)/2;
        Radius_Inner        = (Diameter_Inner-1)/2;
        idxxi               = -Radius_outer:+Radius_outer;
        idxet               = -Radius_outer:+Radius_outer;
        [idxxi, idxet]      = meshgrid(idxxi,idxet);                  
        Stopper      = ones(Diameter_Outer);
        Stopper(sqrt(idxxi.^2+idxet.^2)>Radius_Inner) = 0;

% figure(9030); imshow(uint16(I30_Stop_TFunc/max(I30_Stop_TFunc(:))*65535));
end




















