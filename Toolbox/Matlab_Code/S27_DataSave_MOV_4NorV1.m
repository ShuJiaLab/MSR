function S27_DataSave_MOV_4NorV1(   File_56_FLFVid_ExpPro     ,...
                                    Data_01_formIm    ,Data_02_formDt    ,Data_01_formVd    ,...
                                    Index_Col0,Index_Col1,Index_Col2     ,FLF_ExpVid_Frameps,...
                                    FLF_save_PeroidIni,FLF_save_PeroidEnd,FLF_save_PeroidSeg,...
                                    FLF_save_Video_Ini,FLF_save_Video_End,FLF_save_Video_Seg,...
                                    FLF_Load_FrameRate,FLF_ExpSub_crp_rad,...
                                    Flag_multicolor   ,Flag_Normalization,LoadSuffix,GroupName)
    % GroupName
%     FLF_save_PeroidIni = FLF_load_DecompIni(idxfl);
%     FLF_save_PeroidEnd = FLF_load_DecompEnd(idxfl);
%     FLF_save_PeroidSeg = FLF_load_DecompSeg;
%     FLF_save_Video_Ini = FLF_save_DecompIni(idxfl);
%     FLF_save_Video_End = FLF_save_DecompEnd(idxfl);
%     FLF_save_Video_Seg = FLF_save_DecompSeg;
%     FLF_ExpSub_crp_rad = FLF_ExpSub_crp_rad(idxfl);
%     LoadSuffix = File_0q_DCP;
%     GroupName  = FLF_ExpVid_GrpName(idxfl==EXP_group,:);

    for idxsg = 1                                                          % FLFimg read and save name set    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load and save path name set        
        SaveSuffix = 'nor';
        FLF_ExpVid_LoadUniN = [File_56_FLFVid_ExpPro,GroupName,LoadSuffix           ,'\','FLF_ExpImg'];
        FLF_ExpVid_saveUniN = [File_56_FLFVid_ExpPro,GroupName,LoadSuffix,SaveSuffix,'\','FLF_ExpImg'];
                        mkdir([File_56_FLFVid_ExpPro,GroupName,LoadSuffix,SaveSuffix])

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load and save Index set
        FLF_ExpVid_LoadDep =[num2str(FLF_save_PeroidIni*FLF_Load_FrameRate),'-',...
                             num2str(FLF_save_PeroidEnd*FLF_Load_FrameRate),'-',...
                             num2str(FLF_save_PeroidSeg*FLF_Load_FrameRate),'s'];
        FLF_ExpVid_SaveDep =[num2str(FLF_save_Video_Ini*FLF_Load_FrameRate),'-',...
                             num2str(FLF_save_Video_End*FLF_Load_FrameRate),'-',...
                             num2str(FLF_save_Video_Seg*FLF_Load_FrameRate),'s'];
        FLF_Save_Depth_Ind =         FLF_save_Video_Ini:FLF_save_Video_Seg:FLF_save_Video_End;
        FLF_Save_Depth_len = length(FLF_Save_Depth_Ind);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Crop parameter set
        LoadNameUniN = [FLF_ExpVid_LoadUniN,'_','7'     ,LoadSuffix(2:end),'_',FLF_ExpVid_LoadDep];
        SaveNameUniN = [FLF_ExpVid_saveUniN,'_','74cCrp',SaveSuffix       ,'_',FLF_ExpVid_SaveDep];
        SaveNameUniC = [FLF_ExpVid_saveUniN,'_','64cCen',SaveSuffix       ,'_',FLF_ExpVid_SaveDep];
        SaveNameUniX = [FLF_ExpVid_saveUniN,'_','64cCro',SaveSuffix       ,'_',FLF_ExpVid_SaveDep]; 

        FLF_ExpSub_crp_dia = FLF_ExpSub_crp_rad*2+1;               

        FLF_ExpSub_lengthy = FLF_ExpSub_crp_rad*2+1;
        FLF_ExpSub_lengthx = FLF_ExpSub_crp_rad*2+1;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        SaveMaxInt       = 65535;
       [Colormap0bt16,~,Test_Col0] = U06_Color_B16(Index_Col0);
       [Colormap1bt16,~,Test_Col1] = U06_Color_B16(Index_Col1);
       [Colormap2bt16,~,Test_Col2] = U06_Color_B16(Index_Col2);

        FLFimg_64cCenC16 = zeros(FLF_ExpSub_crp_dia                ,FLF_ExpSub_crp_dia                ,3,FLF_Save_Depth_len,'uint16');
    end

    if     (~Flag_multicolor)                                              
        if (~Flag_Normalization)                                       
            for idxfr = FLF_save_Video_Ini:FLF_save_Video_Seg:FLF_save_Video_End        
                FrameIndex = ['Frm',num2str(idxfr,'%05.0f')];
                FLFimg_74cCrpDns = imread([LoadNameUniN,'_',FrameIndex,Data_01_formIm]);
    %                                                                            U61_Imshow_B16_Fire(FLFimg_74cCrpDns)
                FLFimg_74cCrpnor = rescale(FLFimg_74cCrpDns);
                FLFimg_74cCrpC16 = uint16(ind2rgb(uint16(adapthisteq(FLFimg_74cCrpnor).*SaveMaxInt),Colormap0bt16)*SaveMaxInt);
    %                                                                            figure,imshow(FLFimg_74cCrpC16,[])
                FLFimg_64cCenC16(:,:,:,idxfr-FLF_save_Video_Ini+1) = flip(rot90( ...
                FLFimg_74cCrpC16(FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),...
                                 FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),:),3),2);
                                    save([SaveNameUniN,'_',FrameIndex                      ,Data_02_formDt],'FLFimg_74cCrpnor','-v7.3');
                imwrite(FLFimg_74cCrpC16,[SaveNameUniN,'_',FrameIndex,Test_Col0,Data_01_formIm]);
        %         figure,imshow(FLFimg_64cCroC16)
                disp(idxfr)
            end 
        elseif  Flag_Normalization
                FLFimg_07_MaxVal = zeros(FLF_Save_Depth_len,1);
            for idxfr = FLF_save_Video_Ini:FLF_save_Video_Seg:FLF_save_Video_End             
                FrameIndex = ['Frm',num2str(idxfr,'%05.0f')];
                FLFimg_74cCrpDns = imread([LoadNameUniN,'_',FrameIndex,Data_01_formIm]);
                FLFimg_07_MaxVal(idxfr) = max(FLFimg_74cCrpDns,[],'all');
            end
                FLFimg_07_MaxMax = max(FLFimg_07_MaxVal);
                save([FLF_ExpVid_saveUniN,'_','07_MaxVal',Data_02_formDt], 'FLFimg_07_MaxVal','-v7.3');
    
            for idxfr = FLF_save_Video_Ini:FLF_save_Video_Seg:FLF_save_Video_End        
                FrameIndex = ['Frm',num2str(idxfr,'%05.0f')];
                FLFimg_74cCrpDns = imread([LoadNameUniN,'_',FrameIndex,Data_01_formIm]);
    %                                                                            U61_Imshow_B16_Fire(FLFimg_74cCrpb16)
                FLFimg_74cCrpnor = double(FLFimg_74cCrpDns)/FLFimg_07_MaxMax;
                FLFimg_74cCrpC16 = uint16(ind2rgb(uint16(            FLFimg_74cCrpnor.*SaveMaxInt),Colormap2bt16)*SaveMaxInt);
    %                                                                            figure,imshow(FLFimg_74cCrpC16,[])
                FLFimg_64cCenC16(:,:,:,idxfr-FLF_save_Video_Ini+1) = flip(rot90( ...
                FLFimg_74cCrpC16(FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),...
                                 FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),:),3),2);
                                    save([SaveNameUniN,'_',FrameIndex                      ,Data_02_formDt],'FLFimg_74cCrpnor','-v7.3');
                imwrite(FLFimg_74cCrpC16,[SaveNameUniN,'_',FrameIndex,Test_Col0,Data_01_formIm]);
        %         figure,imshow(FLFimg_64cCroC16)
                disp(idxfr)
            end
        end
    elseif ( Flag_multicolor)
        FLFimg_64cCroC16 = zeros(FLF_ExpSub_crp_dia                ,FLF_ExpSub_crp_dia                ,3,FLF_Save_Depth_len,'uint16');
        
        FLFimg_74_Mask_2 = xor(mod(repmat((1:3),[3,1]),2),mod(repmat((1:3)',[1,3]),2));
        FLFimg_74_Mask_1 = ~FLFimg_74_Mask_2;

        FLFimg_74_CrpMsk1 = uint16( kron(FLFimg_74_Mask_1,ones(FLF_ExpSub_lengthy,FLF_ExpSub_lengthx)) );
        FLFimg_74_CrpMsk2 = uint16( kron(FLFimg_74_Mask_2,ones(FLF_ExpSub_lengthy,FLF_ExpSub_lengthx)) );
                                                                           figure,imshow(FLFimg_74_CrpMsk2,[])
        if (~Flag_Normalization)                                           
            for idxfr = FLF_save_Video_Ini:FLF_save_Video_Seg:FLF_save_Video_End        
                FrameIndex = ['Frm',num2str(idxfr,'%05.0f')];
                FLFimg_74cCrpDns = imread([LoadNameUniN,'_',FrameIndex,Data_01_formIm]);
    %                                                                            U61_Imshow_B16_Fire(FLFimg_74cCrpb16)
                FLFimg_74cCrpCen = rescale(FLFimg_74cCrpDns.* FLFimg_74_CrpMsk1);
                FLFimg_74cCrpCro = rescale(FLFimg_74cCrpDns.* FLFimg_74_CrpMsk2);
                FLFimg_74cCrpnor =         FLFimg_74cCrpCen + FLFimg_74cCrpCro  ;
                FLFimg_74cCrpC16 = uint16(ind2rgb(uint16(adapthisteq( FLFimg_74cCrpCen).*SaveMaxInt),Colormap1bt16)*SaveMaxInt) + ...
                                   uint16(ind2rgb(uint16(adapthisteq( FLFimg_74cCrpCro).*SaveMaxInt),Colormap2bt16)*SaveMaxInt);
    %                                                                            figure,imshow(FLFimg_74cCrpC16,[])
                FLFimg_64cCenC16(:,:,:,idxfr-FLF_save_Video_Ini+1) = flip(rot90(...
                FLFimg_74cCrpC16(FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),...
                                 FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),:),3),2);
                FLFimg_64cCroC16(:,:,:,idxfr-FLF_save_Video_Ini+1) = flip(rot90(...
                FLFimg_74cCrpC16(                    (1:FLF_ExpSub_crp_dia),   ...
                                 FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),:),3),2);
    %                                                                          figure,imshow(FLFimg_64cCenC16(:,:,:,1))
    %                                                                          figure,imshow(FLFimg_64cCroC16(:,:,:,idxfr))
                                    save([SaveNameUniN,'_',FrameIndex                      ,Data_02_formDt],'FLFimg_74cCrpnor','-v7.3');
                imwrite(FLFimg_74cCrpC16,[SaveNameUniN,'_',FrameIndex,[Test_Col1,Test_Col2],Data_01_formIm]);
        %         figure,imshow(FLFimg_64cCroC16)
                disp(idxfr)
            end
        elseif  Flag_Normalization
                FLFimg_07_MaxVa1 = zeros(FLF_Save_Depth_len,1);
                FLFimg_07_MaxVa2 = zeros(FLF_Save_Depth_len,1);
            for idxfr = 1:FLF_Save_Depth_len        
                FrameIndex = ['Frm',num2str(FLF_Save_Depth_Ind(idxfr),'%05.0f')];
                FLFimg_74cCrpDns = imread([LoadNameUniN,'_',FrameIndex,Data_01_formIm]);
                FLFimg_07_MaxVa1(idxfr) = max(FLFimg_74cCrpDns.*FLFimg_74_CrpMsk1,[],'all');
                FLFimg_07_MaxVa2(idxfr) = max(FLFimg_74cCrpDns.*FLFimg_74_CrpMsk2,[],'all');
                disp(idxfr)
            end
                figure,plot(FLFimg_07_MaxVa1)
                figure,plot(FLFimg_07_MaxVa2)
                figure,plot(FLFimg_07_MaxVa2./FLFimg_07_MaxVa1)
                FLFimg_07_MaxMa1 = max(FLFimg_07_MaxVa1);
                FLFimg_07_MaxMa2 = max(FLFimg_07_MaxVa2);
                save([FLF_ExpVid_saveUniN,'_','07_MaxVa1',Data_02_formDt], 'FLFimg_07_MaxVa1','-v7.3');
                save([FLF_ExpVid_saveUniN,'_','07_MaxVa2',Data_02_formDt], 'FLFimg_07_MaxVa2','-v7.3');
    
            for idxfr = FLF_save_Video_Ini:FLF_save_Video_Seg:FLF_save_Video_End        
                FrameIndex = ['Frm',num2str(idxfr,'%05.0f')];
                FLFimg_74cCrpDns = imread([LoadNameUniN,'_',FrameIndex,Data_01_formIm]);
    %                                                                            U61_Imshow_B16_Fire(FLFimg_74cCrpb16)
                FLFimg_74cCrpCen = double( FLFimg_74cCrpDns.* FLFimg_74_CrpMsk1)./FLFimg_07_MaxMa1;
                FLFimg_74cCrpCro = double( FLFimg_74cCrpDns.* FLFimg_74_CrpMsk2)./FLFimg_07_MaxMa2;
                FLFimg_74cCrpnor =         FLFimg_74cCrpCen + FLFimg_74cCrpCro;
                FLFimg_74cCrpC16 = uint16(ind2rgb(uint16((FLFimg_74cCrpCen).*SaveMaxInt),Colormap1bt16)*SaveMaxInt) + ...
                                   uint16(ind2rgb(uint16((FLFimg_74cCrpCro).*SaveMaxInt),Colormap2bt16)*SaveMaxInt);
    %                                                                            figure,imshow(FLFimg_74cCrpC16,[])
    %                     figure,imshow(FLFimg_74cCrpCen,[])
    %                     figure,imshow(FLFimg_74cCrpCro,[])

                FLFimg_64cCenC16(:,:,:,idxfr-FLF_save_Video_Ini+1) = flip(rot90(...
                FLFimg_74cCrpC16(FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),...
                                 FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),:),3),2);
                FLFimg_64cCroC16(:,:,:,idxfr-FLF_save_Video_Ini+1) = flip(rot90(...
                FLFimg_74cCrpC16(                    (1:FLF_ExpSub_crp_dia),   ...
                                 FLF_ExpSub_crp_dia +(1:FLF_ExpSub_crp_dia),:),3),2);
    %                                                                          figure,imshow(FLFimg_64cCenC16(:,:,:,1))
    %                                                                          figure,imshow(FLFimg_64cCroC16(:,:,:,idxfr))
                                    save([SaveNameUniN,'_',FrameIndex                      ,Data_02_formDt],'FLFimg_74cCrpnor','-v7.3');
                imwrite(FLFimg_74cCrpC16,[SaveNameUniN,'_',FrameIndex,[Test_Col1,Test_Col2],Data_01_formIm]);
        %         figure,imshow(FLFimg_64cCroC16)
                disp(idxfr)
            end
        end
    end
                 save([SaveNameUniC,Data_02_formDt],      'FLFimg_64cCenC16','-v7.3');
        T35_Vdsave_B08(SaveNameUniC,Data_01_formVd ,uint8(double(FLFimg_64cCenC16)/65535*255),FLF_ExpVid_Frameps)
    if(Flag_multicolor)                                                    
                 save([SaveNameUniX,Data_02_formDt],      'FLFimg_64cCroC16','-v7.3');
        T35_Vdsave_B08(SaveNameUniX,Data_01_formVd ,uint8(double(FLFimg_64cCroC16)/65535*255),FLF_ExpVid_Frameps)
    end
    
end















