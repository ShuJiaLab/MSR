clear;  close all;  clc;
addpath(genpath('E:\00_Matlab_Code'))
addpath(genpath('E:\02_MIRO'))

path = 'Y:\jia-lab\ZhiLing\TadpoleVol\20240905-cf\gata1gfp\TSeries-09052024-1049-030\';
file = dir(path);
file = file(6:end);

for idxfl = 1                                                              % WFMimg read and save              
    for idxt = 1:size(file,1)                                                            
        WFM_EXPmov(:,:,idxt) = imread([path,file(idxt).name]);
        disp(idxt)
    end                                                                         
%     figure,imshow(uint16(double(WFM_EXPmov(:,:,idxt)-90).^1),[])
end

WFMimg_74cCrpIni = WFM_EXPmov(:,:,1);
figure;histogram(WFMimg_74cCrpIni);

for idxfl = 1                                                              % WFMimg read and save              
    for idxfr = 1:size(file,1)      
        WFMimgCorrelation(idxfr) = corr2(WFMimg_74cCrpIni, WFM_EXPmov(:,:,idxfr));
        disp(idxfr)
    end
    figure,plot(WFMimgCorrelation)

    for idxta = 1                                                          % FLFimg read and save name set
        FLFimgCorrSort = sort(WFMimgCorrelation);
        [~,diastolePts] = findpeaks(+WFMimgCorrelation,'MinPeakDistance',20,'MinPeakHeight',+mean(FLFimgCorrSort(1:end-1)));
        [~,Systole_Pts] = findpeaks(-WFMimgCorrelation,'MinPeakDistance',20,'MinPeakHeight',-mean(FLFimgCorrSort(1:end-1))-0.001);
        Beat_Peroid = round(60/(mean(diff(diastolePts))*0.02)); % BPM

        figure,plot(1:length(WFMimgCorrelation), WFMimgCorrelation, ...
            Systole_Pts, WFMimgCorrelation(Systole_Pts),'o', ...
            diastolePts, WFMimgCorrelation(diastolePts),"*")
        disp(Beat_Peroid)
    end
    save('F:\TDP_cfm_1053-042\Systole_Pts.mat','WFMimgCorrelation','Systole_Pts','diastolePts','Beat_Peroid');
end

for idxfl = 1                                                              % MIRO denoise 1         
    Peroids_PtsUse = [172,0,471]; % sort([Systole_Pts,diastolePts]);
    for idxPd = 1                               
        Frame_ini = Peroids_PtsUse(idxPd);
        Frame_end = Peroids_PtsUse(idxPd+2)-1;
        Frame_Ind = Frame_ini:Frame_end;
        Frame_Len = length(Frame_Ind);
         
        WFMvidOrg = WFM_EXPmov(:,:,Frame_Ind);

        if ~exist('SLsys','var')                                           
            SLsys =  getSLsys(WFMvidOrg, 3);
        end

        [WFMvidDns] = MIRO(WFMvidOrg,...
                    'Offset'                , 14185,...
                    'Gain'                  , 800,...
                    'Lambda'                , 0.500,...
                    'NA'                    , 0.3,...
                    'CameraPixelSize'       , 10,...
                    'Magnification'         , 10, ... 
                    'Mode'                  , 'y',...
                    'OptionalFilter'        , 2,...
                    'LambdaVideo '          , 0.75, ...
                    'LambdaNLM '            , 0.5, ...
                    'max_scale_factor'      , 5,...
                    'HS'                    , 0,...
                    'DisplayImages'         , 1,...
                    'h'                     , 1,...
                    'ResolutionCheckAuto'   , 0,...
                    'ResolutionCheckNFrames', 1,...
                    'SpectralFilterOn'      , 1,...
                    'kmin'                  , 0.1,...
                    'k'                     , 0.25, ...
                    'shearletSystem'        , SLsys ...
                    );

        for idxt = 1:Frame_Len                                             
            imwrite(uint16(rescale(WFMvidDns(:,:,idxt))*65535),['Y:\jia-lab\ZhiLing\TadpoleVol\Processed\20240905-1049-030\MIRO2\',num2str(Frame_Ind(idxt),'%05d'),'.tif']);            
            disp(idxt)
        end
        close all

        WFMsub_reshap = reshape(permute(WFMvidDns,[3,1,2]),Frame_Len,512*512);
        
        clear WFMsub_reshaplowrank WFMsub_reshap_sparse
        PCA_Lambda = 1/sqrt(max( [Frame_Len,512*512] ));
        PCA_Mu     = PCA_Lambda*10;
        tic
        [WFMsub_reshaplowrank(:,:),WFMsub_reshap_sparse(:,:)] = ...
        RobustPCA( single(WFMsub_reshap), PCA_Lambda/3, PCA_Mu/3,1e-5, 5000);
        toc

        save(['Y:\jia-lab\ZhiLing\TadpoleVol\Processed\20240905-1049-030\Decomp2\',num2str(Frame_ini),'-',num2str(Frame_end),'.mat'], ...
            'WFMsub_reshaplowrank','WFMsub_reshap_sparse','-v7.3');
 
        WFMvidLowrank = reshape(permute(WFMsub_reshaplowrank,[2,3,1]),size(WFMvidDns,1),size(WFMvidDns,2),Frame_Len);
        WFMvid_Sparse = reshape(permute(WFMsub_reshap_sparse,[2,3,1]),size(WFMvidDns,1),size(WFMvidDns,2),Frame_Len);
        WFMvidLowrank(WFMvidLowrank < 0) = 0;
        WFMvid_Sparse(WFMvid_Sparse < 0) = 0;
 
        for idxfr = 1:Frame_Len 
            Frame = ['Frm',num2str(Frame_Ind(idxfr),'%05.0f')];
            imwrite(uint16(WFMvidLowrank(:,:,idxfr)/max(max(WFMvidLowrank(:,:,idxfr)))*65535),['Y:\jia-lab\ZhiLing\TadpoleVol\Processed\20240905-1049-030\L2\', Frame ,'.tif']);
            imwrite(uint16(rescale(WFMvid_Sparse(:,:,idxfr))*65535),['Y:\jia-lab\ZhiLing\TadpoleVol\Processed\20240905-1049-030\S2\', Frame ,'.tif']);

            disp([Frame,'|',num2str(Frame)])
        end
    end
end

for i = 9:994
    cell = imread(['F:\TDP_cfm_1053-042\S\Frm',num2str(i,'%05d'),'.tif']);
    imwrite(im2double(cell),['F:\TDP_cfm_1053-042\frameinterp\',num2str(i,'%05d'),'.bmp']);
    i
end
