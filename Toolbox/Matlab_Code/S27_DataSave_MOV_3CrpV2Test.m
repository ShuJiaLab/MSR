function [] = S27_DataSave_MOV_3CrpV2Test(File_56_FLFVid_ExpPro,File_32_FLFPSF_ExpRaw,LoadSuffix,...
                                          FLF_Test_PeroidIni,FLF_Test_PeroidEnd,FLF_Test_Index_Seg,...
                                          Recons_43_NumEd   ,FLFRec_13_RdNum   ,FLF_Load_ImshowMag,...
                                          FLF_ExpSub_crp_sfx,FLF_ExpSub_crp_sfy,FLF_ExpSub_crp_sfz,...
                                          FLF_ExpSub_crp_rad,FLF_ExpSub_crp_Apt,Flag_video)
% FLF_Load_Index_Stp = 100
% FLF_Load_Index_Ini = 1;
% FLF_Load_Index_End = 4000;
% Flag_video = 1
% LoadSuffix = [FLF_ExpVid_GrpName(idxfl==EXP_group),File_0h_Sbk];

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load file name set
        FLF_Load_Folder = [File_56_FLFVid_ExpPro,LoadSuffix,'\'];
        FLF_Load_IndexTStr = ls(FLF_Load_Folder);        
        FLF_Load_IndexAStr = FLF_Load_IndexTStr(5:end,:);
        FLF_Load_Index_Str = char(FLF_Load_IndexAStr-FLF_Load_IndexAStr);
        FLF_Load_Index_Num = 0;

        for idxfr = 1:size(FLF_Load_Index_Str,1)
%             idxfr = 2
            [~,~,File_ext] = fileparts(FLF_Load_IndexAStr(idxfr,:));
            if( strcmp(strtrim(File_ext),'.mat') )
                FLF_Load_Index_Num=FLF_Load_Index_Num+1;
                FLF_Load_Index_Str(FLF_Load_Index_Num,:) = FLF_Load_IndexAStr(idxfr,:);
            end
        end
        FLF_Load_Index_Str = FLF_Load_Index_Str(1:FLF_Load_Index_Num,:);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load and save Index set
        FLF_Test_PeroidInd = FLF_Test_PeroidIni:FLF_Test_Index_Seg:FLF_Test_PeroidEnd;
        FLF_Test_Peroidlen = length(FLF_Test_PeroidInd);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Crop parameter set
        FLF_ExpImg_crp_cen = round(FLFRec_13_RdNum/2);
        FLF_ExpImg_crp_dia =       FLFRec_13_RdNum; 
        
        FLF_ExpSub_crp_dia = FLF_ExpSub_crp_rad*2+1;               
        FLF_ExpSub_crp_Int =-FLF_ExpSub_crp_rad:FLF_ExpSub_crp_rad;

        load([File_32_FLFPSF_ExpRaw,'\','FLFM_PSF_CenfitCoordinates_sub' ,'.mat'],'FLF_ExpPSF_sub_Yfit','FLF_ExpPSF_sub_Xfit')
        FLF_ExpSub_crp_ceny = FLF_ExpPSF_sub_Yfit(:,:,ceil(size(FLF_ExpPSF_sub_Yfit,3)/2)+FLF_ExpSub_crp_sfz) ...
                            - FLF_ExpPSF_sub_Yfit(:,:,ceil(size(FLF_ExpPSF_sub_Yfit,3)/2)+0) + FLF_ExpSub_crp_sfy + FLF_ExpImg_crp_cen;
        FLF_ExpSub_crp_cenx = FLF_ExpPSF_sub_Xfit(:,:,ceil(size(FLF_ExpPSF_sub_Xfit,3)/2)+FLF_ExpSub_crp_sfz) ...
                            - FLF_ExpPSF_sub_Xfit(:,:,ceil(size(FLF_ExpPSF_sub_Xfit,3)/2)+0) + FLF_ExpSub_crp_sfx + FLF_ExpImg_crp_cen;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if(FLF_ExpSub_crp_Apt)                                                 
        Stopper = single(repmat( ...
                  I30_Stop_Modulation( FLF_ExpImg_crp_dia-FLF_ExpSub_crp_Apt,FLF_ExpImg_crp_dia ),Recons_43_NumEd));
    end

    if(~Flag_video)                                                        
                FLFimg_73_Croped = zeros(FLF_ExpSub_crp_dia*Recons_43_NumEd,FLF_ExpSub_crp_dia*Recons_43_NumEd);
        for idxfr = FLF_Test_PeroidInd
                load([FLF_Load_Folder,'\',strtrim(FLF_Load_Index_Str(idxfr,:))],'FLFimg_72_SubBKG');
            if(FLF_ExpSub_crp_Apt)
                FLFimg_72_SubBKG = FLFimg_72_SubBKG.*Stopper;
            end
            for idxxi = 1:Recons_43_NumEd                                  % 
            for idxet = 1:Recons_43_NumEd                                  %  
                FLFimg_73_Croped((idxet-1)*FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),   ...
                                 (idxxi-1)*FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia)) = ...
                FLFimg_73_Croped((idxet-1)*FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),   ...
                                 (idxxi-1)*FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia)) + double(...
                FLFimg_72_SubBKG((idxet-1)*FLF_ExpImg_crp_dia +   FLF_ExpSub_crp_Int + FLF_ExpSub_crp_ceny(idxet,idxxi),...
                                 (idxxi-1)*FLF_ExpImg_crp_dia +   FLF_ExpSub_crp_Int + FLF_ExpSub_crp_cenx(idxet,idxxi)) );
            end
            end
            disp(['idxfr = ',num2str(idxfr)]);
        end
    else
                FLFimg_73_Croped = zeros(FLF_ExpSub_crp_dia*Recons_43_NumEd,FLF_ExpSub_crp_dia*Recons_43_NumEd,FLF_Test_Peroidlen);
        for idxfr = FLF_Test_PeroidInd                                     
                load([FLF_Load_Folder,'\',strtrim(FLF_Load_Index_Str(idxfr,:))],'FLFimg_72_SubBKG');
            if(FLF_ExpSub_crp_Apt)
                FLFimg_72_SubBKG = FLFimg_72_SubBKG.*Stopper;
            end


            for idxxi = 1:Recons_43_NumEd                                  % 
            for idxet = 1:Recons_43_NumEd                                  % 
                FLFimg_73_Croped((idxet-1)*FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),     ...
                                 (idxxi-1)*FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),idxfr) = ...
                FLFimg_72_SubBKG((idxet-1)*FLF_ExpImg_crp_dia +   FLF_ExpSub_crp_Int + FLF_ExpSub_crp_ceny(idxet,idxxi),...
                                 (idxxi-1)*FLF_ExpImg_crp_dia +   FLF_ExpSub_crp_Int + FLF_ExpSub_crp_cenx(idxet,idxxi))  ;
            end
            end
            disp(['idxfr = ',num2str(idxfr)]);
        end
    end
        FLFimg_73_CrpNor = uint8(rescale(FLFimg_73_Croped,0,255));         clear FLFimg_73_Croped
        for idxxi = 1:Recons_43_NumEd                                      % Line made to lable the boundary of elemental images
            FLFimg_73_CrpNor(idxxi*FLF_ExpSub_crp_dia,1:end,:) = 255;
            FLFimg_73_CrpNor(1:end,idxxi*FLF_ExpSub_crp_dia,:) = 255;
        end
        figure,imshow(ind2rgb(uint8(mean(FLFimg_73_CrpNor,3).*FLF_Load_ImshowMag),parula))
        T35_Vdsave_B08([FLF_Load_Folder,'\Test'],'.aiv',FLFimg_73_CrpNor.*FLF_Load_ImshowMag,100)
end



function [] = T35_Vdsave_B08(Video_Path,Video_form,Video_bt08,Frame_rate)
%     Video_Path = [Path_s487_FLFRez,Text_s555FileInd,'Vid3DL',Text_s554TimeInd]
%     Video_form = Data_01_formVd;
%     Video_data = FLFRec_98cMIP3DL;
%     Frame_rate = 100;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Video_Name =[Video_Path,'fps',num2str(Frame_rate)];
        Video_size = size(Video_bt08);
        Frame_time = 1/Frame_rate;
    if ndims(Video_bt08)==4
        Frame_Numb = Video_size(4);
        for idxfr = 1:Frame_Numb                                              
            [Img,cmap]= rgb2ind(Video_bt08(:,:,:,idxfr),256);
            if idxfr == 1
                imwrite(Img,cmap,[Video_Name,'.gif'],'gif','LoopCount',Inf     ,'DelayTime',Frame_time);
            else
                imwrite(Img,cmap,[Video_Name,'.gif'],'gif','WriteMode','append','DelayTime',Frame_time);
            end
            disp(['Frame' num2str(idxfr) '|' num2str(Frame_Numb)]);
        end
        
        Video_Made          = struct;
        Video_Made.cdata    = uint8(zeros([Video_size(1),Video_size(2),Frame_Numb]));
        Video_Made.colormap = [];
        for idxfr = 1:Frame_Numb                    
            Video_Made(idxfr) = im2frame(squeeze(Video_bt08(:,:,:,idxfr)));% 图片保存为动画的帧
            disp(idxfr)
        end
        writerObj= VideoWriter([Video_Name,Video_form]);                   % 生成一个avi动画
        writerObj.FrameRate=Frame_rate;                                    % 设置avi动画的参数，设置帧速率
        open(      writerObj);                                             % 打开avi动画
        writeVideo(writerObj,Video_Made);                                  % 将保存的动画写入到视频文件中
        close(     writerObj);                                             % 关闭动画
    elseif ndims(Video_bt08)==3
        Frame_Numb = Video_size(3);
        for idxfr = 1:Frame_Numb                                              
            Img = Video_bt08(:,:,idxfr);
            if idxfr == 1
                imwrite(Img,     [Video_Name,'.gif'],'gif','LoopCount',Inf     ,'DelayTime',Frame_time);
            else
                imwrite(Img,     [Video_Name,'.gif'],'gif','WriteMode','append','DelayTime',Frame_time);
            end
            disp(['Frame' num2str(idxfr) '|' num2str(Frame_Numb)]);
        end
        
%         Video_Made          = struct;
%         Video_Made.cdata    = uint8(zeros([Video_size(1),Video_size(2),Frame_Numb]));
%         Video_Made.colormap = [];
%         for idxfr = 1:Frame_Numb                    
%             Video_Made(idxfr) = im2frame(squeeze(Video_bt08(:,:,:,idxfr)));% 图片保存为动画的帧
%             disp(idxfr)
%         end
%         writerObj= VideoWriter([Video_Name,Video_form]);                   % 生成一个avi动画
%         writerObj.FrameRate=Frame_rate;                                    % 设置avi动画的参数，设置帧速率
%         open(      writerObj);                                             % 打开avi动画
%         writeVideo(writerObj,Video_Made);                                  % 将保存的动画写入到视频文件中
%         close(     writerObj);                                             % 关闭动画
    end
end

function I30_Stop_TFunc = I30_Stop_Modulation( Diameter_Inner,Diameter_Outer )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Diameter_Inner = FLF_ExpImg_crp_dia-6
% Diameter_Outer = FLF_ExpImg_crp_dia

        Radius_outer        = (Diameter_Outer-1)/2;
        Radius_Inner        = (Diameter_Inner-1)/2;
        idxxi               = -Radius_outer:+Radius_outer;
        idxet               = -Radius_outer:+Radius_outer;
        [idxxi, idxet]      = meshgrid(idxxi,idxet);                  
        I30_Stop_TFunc      = ones(Diameter_Outer);
        I30_Stop_TFunc(sqrt(idxxi.^2+idxet.^2)>Radius_Inner) = 0;

% figure(9030); imshow(uint16(I30_Stop_TFunc/max(I30_Stop_TFunc(:))*65535));
end































