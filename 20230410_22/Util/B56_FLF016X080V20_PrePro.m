clear;  close all;  clc;
addpath(genpath('E:\00_Matlab_Code'))
addpath(genpath('E:\02_MIRO'))
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for idxsg = 1                                                              % System parameter set                   
    Recons_43_NumEd    = 3;
    FLFRec_13_RdNum    = 501;
    FLFRec_13_RrNum    = floor(FLFRec_13_RdNum/2);

    WFM_EXPImg_Offset = 0; 
    FLF_EXPImg_Offset = 0;
    FLF_EXPVid_Offset = 0;

    Flag_multicolor    = 1;
    Flag_Normalization = 0;
    FLF_Save_Flag__Crp = 1;

    Index_Col0         = 011;
    Index_Col1         = 022;
    Index_Col2         = 023;
end
for idxsg = 1                                                              % Image parameter and Save path name set 
    Data_00_bit     = 16    ;                                              %get
    Data_00_maxval  = 2^Data_00_bit-1;
    Data_01_formIm  = '.tif';                                              %get
    Data_01_formVd  = '.avi';                                              %get
    Data_02_formDt  = '.mat';                                              %get
    Data_04_smoothn = 1;                                                   %Get?Recons_00_NUMd
    Data_04_Oper_sm = fspecial('gaussian',[Data_04_smoothn Data_04_smoothn],0.6);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    File_00_path = '..\';                                
    File_00_Dash = '\'; 
    File_00_Line = '_'; 
    File_01_sav = 'sav'; 
    File_02_raw = 'raw'; 
    File_04_rec = 'rec'; 
    File_06_pro = 'pro';
    
    File_0a_sim = 'sim'; 
    File_0b_exp = 'exp'; 
    File_0c_bkg = 'bkg'; 

    File_10_WFMPSF        = '1WFMPSF'; 
    File_11_WFMPSF_SimSav = [File_00_path,File_10_WFMPSF,'_1',File_0a_sim,File_01_sav];mkdir(File_11_WFMPSF_SimSav);
    File_12_WFMPSF_ExpRaw = [File_00_path,File_10_WFMPSF,'_2',File_0b_exp,File_02_raw];mkdir(File_12_WFMPSF_ExpRaw);
    File_13_WFMPSF_BkgRaw = [File_00_path,File_10_WFMPSF,'_3',File_0c_bkg,File_02_raw];mkdir(File_13_WFMPSF_BkgRaw);
    File_14_WFMPSF_SimRec = [File_00_path,File_10_WFMPSF,'_4',File_0a_sim,File_04_rec];mkdir(File_14_WFMPSF_SimRec);
    File_15_WFMPSF_ExpRec = [File_00_path,File_10_WFMPSF,'_5',File_0b_exp,File_04_rec];mkdir(File_15_WFMPSF_ExpRec);
    File_16_WFMPSF_ExpPro = [File_00_path,File_10_WFMPSF,'_6',File_0b_exp,File_06_pro];

    File_20_WFMImg        = '2WFMImg'; 
    File_21_WFMImg_SimSav = [File_00_path,File_20_WFMImg,'_1',File_0a_sim,File_01_sav];mkdir(File_21_WFMImg_SimSav);
    File_22_WFMImg_ExpRaw = [File_00_path,File_20_WFMImg,'_2',File_0b_exp,File_02_raw];mkdir(File_22_WFMImg_ExpRaw);
    File_23_WFMImg_BkgRaw = [File_00_path,File_20_WFMImg,'_3',File_0c_bkg,File_02_raw];mkdir(File_23_WFMImg_BkgRaw);
    File_24_WFMImg_SimRec = [File_00_path,File_20_WFMImg,'_4',File_0a_sim,File_04_rec];mkdir(File_24_WFMImg_SimRec);
    File_25_WFMImg_ExpRec = [File_00_path,File_20_WFMImg,'_5',File_0b_exp,File_04_rec];mkdir(File_25_WFMImg_ExpRec);
    File_26_WFMImg_ExpPro = [File_00_path,File_20_WFMImg,'_6',File_0b_exp,File_06_pro];

    File_30_FLFPSF        = '3FLFPSF'; 
    File_31_FLFPSF_SimSav = [File_00_path,File_30_FLFPSF,'_1',File_0a_sim,File_01_sav];mkdir(File_31_FLFPSF_SimSav);
    File_32_FLFPSF_ExpRaw = [File_00_path,File_30_FLFPSF,'_2',File_0b_exp,File_02_raw];mkdir(File_32_FLFPSF_ExpRaw);
    File_33_FLFPSF_BkgRaw = [File_00_path,File_30_FLFPSF,'_3',File_0c_bkg,File_02_raw];mkdir(File_33_FLFPSF_BkgRaw);
    File_34_FLFPSF_SimRec = [File_00_path,File_30_FLFPSF,'_4',File_0a_sim,File_04_rec];
    File_35_FLFPSF_ExpRec = [File_00_path,File_30_FLFPSF,'_5',File_0b_exp,File_04_rec];
    File_36_FLFPSF_ExpPro = [File_00_path,File_30_FLFPSF,'_6',File_0b_exp,File_06_pro];

    File_40_FLFImg        = '4FLFImg'; 
    File_41_FLFImg_SimSav = [File_00_path,File_40_FLFImg,'_1',File_0a_sim,File_01_sav];mkdir(File_41_FLFImg_SimSav);
    File_42_FLFImg_ExpRaw = [File_00_path,File_40_FLFImg,'_2',File_0b_exp,File_02_raw];mkdir(File_42_FLFImg_ExpRaw);
    File_43_FLFImg_BkgRaw = [File_00_path,File_40_FLFImg,'_3',File_0c_bkg,File_02_raw];mkdir(File_43_FLFImg_BkgRaw);
    File_44_FLFImg_SimRec = [File_00_path,File_40_FLFImg,'_4',File_0a_sim,File_04_rec];
    File_45_FLFImg_ExpRec = [File_00_path,File_40_FLFImg,'_5',File_0b_exp,File_04_rec];
    File_46_FLFPSF_ExpPro = [File_00_path,File_40_FLFImg,'_6',File_0b_exp,File_06_pro];

    File_50_FLFVid        = '5FLFVid'; 
    File_51_FLFVid_SimSav = [File_00_path,File_50_FLFVid,'_1',File_0a_sim,File_01_sav];mkdir(File_51_FLFVid_SimSav);
    File_52_FLFVid_ExpRaw = [File_00_path,File_50_FLFVid,'_2',File_0b_exp,File_02_raw];
    File_53_FLFVid_BkgRaw = [File_00_path,File_50_FLFVid,'_3',File_0c_bkg,File_02_raw];
    File_54_FLFVid_SimRec = [File_00_path,File_50_FLFVid,'_4',File_0a_sim,File_04_rec];
    File_55_FLFVid_ExpRec = [File_00_path,File_50_FLFVid,'_5',File_0b_exp,File_04_rec];
    File_56_FLFVid_ExpPro = [File_00_path,File_50_FLFVid,'_6',File_0b_exp,File_06_pro];

    File_90_RayTracingsav = [File_00_path,'\','90_Ray_Tracingsave'];mkdir(File_90_RayTracingsav);
end
for idxsg = 1                                                              % System and simulate parameter 16XWV2   
                                                                           % System parameters                    
   [Fl_01_obj,Dm_01_obj,fn_01_obj          ,...
    Fl_01_tub,Ma_01_obj,NA_01_obj,Ind01_obj,...
    Fl_02_tub,Dm_02_tub,fn_02_tub          ,...
    Fl_03_ent,Dm_03_ent,fn_03_ent          ,...
    Fl_04_MLA,Dm_04_MLA,fn_04_MLA,det_08MLA,...
    Fl_04bMLA,Dm_04_mic,Pi_04_MLA,Ind04_MLA,...
    Num05_cam,Dm_05_cam,Pi_05_cam          ,...
    Fl_07_img,Dm_07_img,fn_07_img          ,...
    lambdaAir,lambdaLen,k0       ,kn       ,...
    del_01_oo,del_02_ot,del_03_te,del_04_em,...
    del_05_mc,dell05_mc,del_06_ti,del_07_ec,...
    dis_01_oo,dis_02_ot,dis_03_te,dis_04_em,...
    dis_05_mc,dis_06_ti,dis_07_ec] = F16_FLF016XWV20_sys_para_525nm();
    lambda1 = .525;
    lambda2 = .610;
                                                                       % Simulation parameters                
   [Step_NIP_Finetune,Step_Propergation,...
    Flag_WFMPSFOnly  ,Flag_Simulation  ,...
    Flag_simPSFfine  ,Flag_Profilesim  ,...
    P291_NIP_Size_Ext,P292_NIP_Size_Wav,P293_NIP_Size_Num,...
    P490_MLA_Beam_Rat,P491_MLA_lens_Num,...
    P492_MLA_lens_Ext,Flag_MLA_size_Odd,...
    Flag_MLA_grid_Hex,Flag_MLA_grid_Inv,...
    Flag_Lens_On_axis,Flag_Lens_All_Use,...          
    Flag_Lens_Tra_Cir,Flag_Lens_Apt_Cir,...
    Flag_Aperture      ] = F16_FLF016XWV20_Sim_Para();
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for idxsg = 1                                                              % FLFimg and Sub Crop range set    

    FLF_Location = imread([File_00_path,'\','FLF_Location.tif']);          
    figure,imshow(FLF_Location,[])

    FLF_ExpImg_range_y = 270+(1:1503);  disp(length(FLF_ExpImg_range_y))
    FLF_ExpImg_range_x = 282+(1:1503);  disp(length(FLF_ExpImg_range_x))
                                                                           figure,imshow((FLF_Location(FLF_ExpImg_range_y,FLF_ExpImg_range_x)-10).^2)
    FLF_ExpSub_range_y = 278+(1:0501)+0501;  disp(length(FLF_ExpSub_range_y))
    FLF_ExpSub_range_x = 282+(1:0501)+0501;  disp(length(FLF_ExpSub_range_x))       
    Sub_Location_org   =           FLF_Location(FLF_ExpSub_range_y,FLF_ExpSub_range_x)      ;
                                                                           figure,imshow((Sub_Location_org-100)*2)
    Sub_Location_ort   =flip(rot90(FLF_Location(FLF_ExpSub_range_y,FLF_ExpSub_range_x),3),2);
                                                                           figure,imshow((Sub_Location_ort-100)*20000)
    FLF_PSFSub_crp_sfx = +11;
    FLF_PSFSub_crp_sfy = -01;
    FLF_PSFSub_crp_sfz = -18;
    FLF_Load_ImshowMag = 1.5;

    FLF_Test_Index_Ini = 1;
    FLF_Test_Index_End = 1;
    FLF_Test_Index_Stp = 1;
    

    S27_DataSave_MOV_1FOVV2_Test(  File_32_FLFPSF_ExpRaw, '..' , ...
                                   FLF_Load_ImshowMag,Data_02_formDt,Recons_43_NumEd, ...
                                   FLF_Test_Index_Ini,FLF_Test_Index_End,FLF_Test_Index_Stp,...
                                   FLF_ExpImg_range_x,FLF_ExpImg_range_y,485   ,...
                                   FLF_PSFSub_crp_sfx,FLF_PSFSub_crp_sfy,FLF_PSFSub_crp_sfz,'',4)
end
close all;clc

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FLFVID parameter set                              
for idxsg = 1                                                              
    EXP_group = [1:5];
    BKG_group = [1];
    File_0h_Sbk = '_2SubBKG'; 
    File_0i_Crp = '_3Croped'; 
    File_0k_Dns = '_4Denois'; 
    File_0m_DCR = '_5DftCor'; 
    File_0o_DCP = '_6Decomp'; 
    File_0p_DCP = '_6DecompL'; 
    File_0q_DCP = '_6DecompS'; 
    FLF_PSFSub_crp_sfz = -75;
    FLF_BkgRationMVVOL = 1;
    FLF_ExpSub_crp_Apt = 1

    FLF_ExpBKG_GrpName = num2str(BKG_group','%02d');           BKG_gpnum = size(FLF_ExpBKG_GrpName,1);
    FLF_ExpVid_GrpName = num2str(EXP_group','%02d');           EXP_gpnum = size(FLF_ExpVid_GrpName,1);
    
    FLF_ExpVid_SBKName = [FLF_ExpVid_GrpName,repmat(File_0h_Sbk,EXP_gpnum,1)];
    FLF_ExpVid_CrpName = [FLF_ExpVid_GrpName,repmat(File_0i_Crp,EXP_gpnum,1)];
    FLF_ExpVid_DNSName = [FLF_ExpVid_GrpName,repmat(File_0k_Dns,EXP_gpnum,1)];
    FLF_ExpVid_DCRName = [FLF_ExpVid_GrpName,repmat(File_0m_DCR,EXP_gpnum,1)];
    FLF_ExpVid_DCPName = [FLF_ExpVid_GrpName,repmat(File_0o_DCP,EXP_gpnum,1)];
    FLF_ExpVid_DCPNamL = [FLF_ExpVid_GrpName,repmat(File_0p_DCP,EXP_gpnum,1)];
    FLF_ExpVid_DCPNamS = [FLF_ExpVid_GrpName,repmat(File_0q_DCP,EXP_gpnum,1)];
    
    for idxfl = 1:BKG_gpnum                                                
        mkdir([File_53_FLFVid_BkgRaw,FLF_ExpBKG_GrpName(idxfl,:)])
    end
    for idxfl = 1:EXP_gpnum                                                
        mkdir([File_52_FLFVid_ExpRaw,FLF_ExpVid_GrpName(idxfl,:)])
        mkdir([File_56_FLFVid_ExpPro,FLF_ExpVid_SBKName(idxfl,:)])
        mkdir([File_56_FLFVid_ExpPro,FLF_ExpVid_CrpName(idxfl,:)])
        mkdir([File_56_FLFVid_ExpPro,FLF_ExpVid_DNSName(idxfl,:)])
        mkdir([File_56_FLFVid_ExpPro,FLF_ExpVid_DCRName(idxfl,:)])
        mkdir([File_56_FLFVid_ExpPro,FLF_ExpVid_DCPName(idxfl,:)])
        mkdir([File_56_FLFVid_ExpPro,FLF_ExpVid_DCPNamL(idxfl,:)])
        mkdir([File_56_FLFVid_ExpPro,FLF_ExpVid_DCPNamS(idxfl,:)])
    end

end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Video FOV crop                        
for idxsg = 1                                                              % FLFimg read and save name set    
    FLF_Load_Index_Ini = 00001;
    FLF_Load_Index_End = 01000;
    FLF_Load_Index_Stp = 1;
    FLF_Load_FrameRate = 0.01;
    FLF_Save_Index_Ini = 00001;
    FLF_Save_Index_End = 01000;
    FLF_Save_Index_Seg = 1;
    
    FLF_PSFSub_crp_sfz = 0;

    BKGGrp_Index = ones(1,5);
    for idxfl = [2,4]                                                          
        S28_DataSave_MOV_3FOVSBKoCRPV2(File_32_FLFPSF_ExpRaw,  File_53_FLFVid_BkgRaw, FLF_ExpBKG_GrpName(BKGGrp_Index(idxfl),:),...
                                       File_52_FLFVid_ExpRaw,  File_56_FLFVid_ExpPro, FLF_ExpVid_GrpName(idxfl,:),...
                                       Data_01_formIm,Data_02_formDt,Recons_43_NumEd, ...
                                       FLF_Load_Index_Ini,FLF_Load_Index_End,FLF_Load_Index_Stp,...
                                       FLF_Save_Index_Ini,FLF_Save_Index_End,FLF_Save_Index_Seg,...
                                       FLF_ExpImg_range_x,FLF_ExpImg_range_y,FLFRec_13_RdNum   ,...
                                       FLF_PSFSub_crp_sfx,FLF_PSFSub_crp_sfy,FLF_PSFSub_crp_sfz,...
                                       0,0,0,...
                                       FLF_Load_FrameRate,File_0h_Sbk       ,FLFRec_13_RrNum   ,...
                                       FLF_EXPImg_Offset ,FLF_BkgRationMVVOL,FLF_ExpSub_crp_Apt)
    end
end
close all;clc
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Video crop                        
    FLF_ExpSub_crp_sfx = zeros(EXP_gpnum,1);
    FLF_ExpSub_crp_sfy = zeros(EXP_gpnum,1);
    FLF_ExpSub_crp_sfz = zeros(EXP_gpnum,1);
    FLF_ExpSub_crp_rad = zeros(EXP_gpnum,1);

for idxfl = 1                                                              % FLFimg crop 1                   
    FLF_Test_PeroidIni = 00001;
    FLF_Test_PeroidEnd = 00050;
    FLF_Test_Index_Seg = 00001;
    FLF_Load_ImshowMag = 2;

    FLF_ExpSub_crp_sfx(idxfl) = +15;
    FLF_ExpSub_crp_sfy(idxfl) = +00;
    FLF_ExpSub_crp_sfz(idxfl) =-150;
    FLF_ExpSub_crp_rad(idxfl) = 160;

    S27_DataSave_MOV_3CrpV2Test(File_56_FLFVid_ExpPro,File_32_FLFPSF_ExpRaw,FLF_ExpVid_SBKName(idxfl,:),...
                                FLF_Test_PeroidIni,FLF_Test_PeroidEnd,FLF_Test_Index_Seg,...
                                Recons_43_NumEd   ,FLFRec_13_RdNum   ,FLF_Load_ImshowMag,...
                                FLF_ExpSub_crp_sfx(idxfl),FLF_ExpSub_crp_sfy(idxfl), ...
                                FLF_ExpSub_crp_sfz(idxfl),FLF_ExpSub_crp_rad(idxfl),1,1)

    -(1053-71-970)/2
    -(1053-90-1013)/2
    FLF_Test_PeroidIni = 00001;
    FLF_Test_PeroidEnd = 00001;
    FLF_Test_Index_Seg = 00001;
    FLF_Load_ImshowMag = 2;

    FLF_ExpSub_crp_sfx(idxfl) = +05;
    FLF_ExpSub_crp_sfy(idxfl) = +00;
    FLF_ExpSub_crp_sfz(idxfl) = 0;
    FLF_ExpSub_crp_rad(idxfl) = 175;

    S27_DataSave_MOV_3CrpV2Test(File_56_FLFVid_ExpPro,File_32_FLFPSF_ExpRaw,FLF_ExpVid_SBKName(idxfl,:),...
                                FLF_Test_PeroidIni,FLF_Test_PeroidEnd,FLF_Test_Index_Seg,...
                                Recons_43_NumEd   ,FLFRec_13_RdNum   ,FLF_Load_ImshowMag,...
                                FLF_ExpSub_crp_sfx(idxfl),FLF_ExpSub_crp_sfy(idxfl), ...
                                FLF_ExpSub_crp_sfz(idxfl),FLF_ExpSub_crp_rad(idxfl),1,1)


end

for idxfl = 2                                                              % FLFimg crop 2:4                 
    FLF_Test_PeroidIni = 00001;
    FLF_Test_PeroidEnd = 00050;
    FLF_Test_Index_Seg = 00001;
    FLF_Load_ImshowMag = 2;

    FLF_ExpSub_crp_sfx(idxfl) = -00;
    FLF_ExpSub_crp_sfy(idxfl) = -00;
    FLF_ExpSub_crp_sfz(idxfl) = -00;
    FLF_ExpSub_crp_rad(idxfl) = 160;

    S27_DataSave_MOV_3CrpV2Test(File_56_FLFVid_ExpPro,File_32_FLFPSF_ExpRaw,FLF_ExpVid_SBKName(idxfl,:),...
                                FLF_Test_PeroidIni,FLF_Test_PeroidEnd,FLF_Test_Index_Seg,...
                                Recons_43_NumEd   ,FLFRec_13_RdNum   ,FLF_Load_ImshowMag,...
                                FLF_ExpSub_crp_sfx(idxfl),FLF_ExpSub_crp_sfy(idxfl), ...
                                FLF_ExpSub_crp_sfz(idxfl),FLF_ExpSub_crp_rad(idxfl),1,1)

    -(1053-71-970)/2
    -(1053-90-1013)/2
end

for idxfl = 3                                                              % FLFimg crop 2:4                 
    FLF_Test_PeroidIni = 00001;
    FLF_Test_PeroidEnd = 00050;
    FLF_Test_Index_Seg = 00001;
    FLF_Load_ImshowMag = 2;

    FLF_ExpSub_crp_sfx(idxfl) = +15;
    FLF_ExpSub_crp_sfy(idxfl) = +10;
    FLF_ExpSub_crp_sfz(idxfl) = -150;
    FLF_ExpSub_crp_rad(idxfl) = 160;

    S27_DataSave_MOV_3CrpV2Test(File_56_FLFVid_ExpPro,File_32_FLFPSF_ExpRaw,FLF_ExpVid_SBKName(idxfl,:),...
                                FLF_Test_PeroidIni,FLF_Test_PeroidEnd,FLF_Test_Index_Seg,...
                                Recons_43_NumEd   ,FLFRec_13_RdNum   ,FLF_Load_ImshowMag,...
                                FLF_ExpSub_crp_sfx(idxfl),FLF_ExpSub_crp_sfy(idxfl), ...
                                FLF_ExpSub_crp_sfz(idxfl),FLF_ExpSub_crp_rad(idxfl),1,1)

    -(1053-71-970)/2
    -(1053-90-1013)/2
end

for idxfl = 4                                                              % FLFimg crop 2:4                 
    FLF_Test_PeroidIni = 00001;
    FLF_Test_PeroidEnd = 00051;
    FLF_Test_Index_Seg = 00001;
    FLF_Load_ImshowMag = 2;

    FLF_ExpSub_crp_sfx(idxfl) = -10;
    FLF_ExpSub_crp_sfy(idxfl) = +15;
    FLF_ExpSub_crp_sfz(idxfl) = -00;
    FLF_ExpSub_crp_rad(idxfl) = 175;

    S27_DataSave_MOV_3CrpV2Test(File_56_FLFVid_ExpPro,File_32_FLFPSF_ExpRaw,FLF_ExpVid_SBKName(idxfl,:),...
                                FLF_Test_PeroidIni,FLF_Test_PeroidEnd,FLF_Test_Index_Seg,...
                                Recons_43_NumEd   ,FLFRec_13_RdNum   ,FLF_Load_ImshowMag,...
                                FLF_ExpSub_crp_sfx(idxfl),FLF_ExpSub_crp_sfy(idxfl), ...
                                FLF_ExpSub_crp_sfz(idxfl),FLF_ExpSub_crp_rad(idxfl),1,1)
    close all
    -(1053-71-970)/2
    -(1053-90-1013)/2
end

for idxfl = 5                                                              % FLFimg crop 2:4                 
    FLF_Test_PeroidIni = 00001;
    FLF_Test_PeroidEnd = 00050;
    FLF_Test_Index_Seg = 00001;
    FLF_Load_ImshowMag = 2;

    FLF_ExpSub_crp_sfx(idxfl) = -30;
    FLF_ExpSub_crp_sfy(idxfl) = +05;
    FLF_ExpSub_crp_sfz(idxfl) = -150;
    FLF_ExpSub_crp_rad(idxfl) = 160;

    S27_DataSave_MOV_3CrpV2Test(File_56_FLFVid_ExpPro,File_32_FLFPSF_ExpRaw,FLF_ExpVid_SBKName(idxfl,:),...
                                FLF_Test_PeroidIni,FLF_Test_PeroidEnd,FLF_Test_Index_Seg,...
                                Recons_43_NumEd   ,FLFRec_13_RdNum   ,FLF_Load_ImshowMag,...
                                FLF_ExpSub_crp_sfx(idxfl),FLF_ExpSub_crp_sfy(idxfl), ...
                                FLF_ExpSub_crp_sfz(idxfl),FLF_ExpSub_crp_rad(idxfl),1,1)

    -(1053-71-970)/2
    -(1053-90-1013)/2
end

    FLF_Save_Index_Ini = 00001;
    FLF_Save_Index_End = 01000;
    FLF_Save_Index_Seg = 1;

    FLF_save_Video_Ini = 00001;
    FLF_save_Video_End = 00700;
    FLF_save_Video_Seg = FLF_Save_Index_Seg;

    FLF_Load_FrameRate = 0.01;
    FLF_ExpVid_Frameps = 100;
    Flag_Decomposition = 0;

for idxfl = [2,4]                                                          
    S27_DataSave_MOV_3CrpV2(File_32_FLFPSF_ExpRaw            ,File_56_FLFVid_ExpPro , ...
                            Data_01_formIm    ,Data_02_formDt,Recons_43_NumEd       , ...
                            FLF_Save_Index_Ini,FLF_Save_Index_End,FLF_Save_Index_Seg, ...
                            FLF_save_Video_Ini,FLF_save_Video_End,FLF_save_Video_Seg, ...
                            FLF_ExpSub_crp_sfx(idxfl),FLF_ExpSub_crp_sfy(idxfl)  ,FLF_ExpSub_crp_sfz(idxfl), ...
                            FLF_Load_FrameRate       ,FLFRec_13_RdNum            ,FLF_ExpSub_crp_rad(idxfl), ...
                            File_0h_Sbk, File_0i_Crp ,FLF_ExpVid_GrpName(idxfl,:),FLF_ExpSub_crp_Apt)

%     S27_DataSave_MOV_4NorV1(File_56_FLFVid_ExpPro                                   ,...
%                             Data_01_formIm    ,Data_02_formDt    ,Data_01_formVd    ,...
%                             Index_Col0,Index_Col1,Index_Col2     ,FLF_ExpVid_Frameps,...
%                             FLF_load_DecompIni,FLF_load_DecompEnd,FLF_load_DecompSeg,...
%                             FLF_save_DecompIni,FLF_save_DecompEnd,FLF_save_DecompSeg,...
%                             FLF_Load_FrameRate,FLF_ExpSub_crp_rad,...
%                             Flag_multicolor   ,Flag_Normalization,File_0i_Crp,...
%                             FLF_ExpVid_GrpName(idxfl==EXP_group,:));
end

for idxfl = 4
    FLF_ExpVid_Frameps = 100;

    Flag_Decomposition = 0;
    FLF_save_CrMIROIni = 00001;
    FLF_save_CrMIROEnd = 00700;
    FLF_save_CrMIROSeg = 1;
    FLF_save_mvMIROIni = 00001;
    FLF_save_mvMIROEnd = 00700;
    FLF_save_mvMIROSeg = 1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    GroupName  = FLF_ExpVid_GrpName(idxfl==EXP_group,:);
    SubImSize  = FLF_ExpSub_crp_rad(idxfl)*2+1;
    LoadSuffix = File_0i_Crp;

    % Load ideal image
    loadpath = [File_56_FLFVid_ExpPro,GroupName,LoadSuffix,'\','FLF_ExpImg'];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load and save Index set    
    load([loadpath,'Systole_Pts.mat'],'Systole_Pts','diastolePts');
    Peroids_PtsTep =sort([Systole_Pts;diastolePts]);
    Peroids_PtsUse = Peroids_PtsTep((FLF_save_mvMIROIni<Peroids_PtsTep)&(Peroids_PtsTep<FLF_save_mvMIROEnd));
    
    Save_Index_Ini = Peroids_PtsUse(1);
    Save_Index_End = Peroids_PtsUse(end)-1;
    Save_Index_Seg = FLF_save_mvMIROSeg; 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    S27_DataSave_MOV_4NorV1( File_56_FLFVid_ExpPro,...
                             Data_01_formIm ,Data_02_formDt,Data_01_formVd,...
                             Index_Col0,Index_Col1,Index_Col2     ,FLF_ExpVid_Frameps,...
                             FLF_save_CrMIROIni,FLF_save_CrMIROEnd,FLF_save_CrMIROSeg,...
                             Save_Index_Ini    ,Save_Index_End    ,Save_Index_Seg,...
                             FLF_Load_FrameRate,FLF_ExpSub_crp_rad(idxfl), ...
                             Flag_multicolor   ,Flag_Normalization,File_0i_Crp,FLF_ExpVid_GrpName(idxfl,:));
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Correlation                        
FLFimg_PeroidStd = [00,35,00,32,00];

for idxfl = [2,4]                                                          % Correlation                      
    for idxta = 1                                                          % FLFimg read and save name set    
        FLF_Load_FrameRate = 0.01;
    
        FLF_Load_DenoisIni = 00001;
        FLF_Load_DenoisEnd = 00700;
        FLF_Load_DecompSeg = 1;
    
        FLF_save_Video_Ini = FLF_Load_DenoisIni;
        FLF_save_Video_End = FLF_Load_DenoisEnd;
        FLF_save_Video_Seg = FLF_Load_DecompSeg;
    end

    for idxta = 1                                                          % FLFimg read and save name set    
        FLF_ExpVid_saveUniN = [File_56_FLFVid_ExpPro,FLF_ExpVid_CrpName(idxfl,:),'\','FLF_ExpImg'];
        FLF_ExpVid_LoadUniN = [File_56_FLFVid_ExpPro,FLF_ExpVid_CrpName(idxfl,:),'\','FLF_ExpImg'];

        FLF_ExpVid_LoadDep =[num2str(FLF_Load_DenoisIni*FLF_Load_FrameRate),'-',...
                             num2str(FLF_Load_DenoisEnd*FLF_Load_FrameRate),'-',...
                             num2str(FLF_Load_DecompSeg*FLF_Load_FrameRate),'s'];
        FLF_save_PeroidInd = FLF_Load_DenoisIni:FLF_Load_DecompSeg:FLF_Load_DenoisEnd;
        FLF_save_PeroidLen = length( FLF_save_PeroidInd );

        SaveNameUniN = [FLF_ExpVid_LoadUniN,'_7',File_0i_Crp(2:end),'_',FLF_ExpVid_LoadDep];

        FLFimgCorrelation = zeros(FLF_save_PeroidLen,1);        
        FLFimg_PeroidIni = imread([SaveNameUniN,'_','Frm',num2str(FLFimg_PeroidStd(idxfl),'%05.0f'),Data_01_formIm]);
    end
    
    for idxfr = 1:FLF_save_PeroidLen                                       
        FLFimg_74cCrpnor = imread([SaveNameUniN,'_','Frm',num2str(FLF_save_PeroidInd(idxfr),'%05.0f'),Data_01_formIm]);
        FLFimgCorrelation(idxfr) = corr2(FLFimg_PeroidIni, FLFimg_74cCrpnor );
        disp(idxfr)
    end

    for idxta = 1                                                          % FLFimg read and save name set    
        figure,plot(+FLFimgCorrelation)
        figure,plot(-FLFimgCorrelation)
        [~,Systole_Pts] = findpeaks(+FLFimgCorrelation,'MinPeakDistance',30,'MinPeakHeight',+mean(FLFimgCorrelation));
        [~,diastolePts] = findpeaks(-FLFimgCorrelation,'MinPeakDistance',30,'MinPeakHeight',-mean(FLFimgCorrelation));
        figure,plot(1:FLF_save_PeroidLen, FLFimgCorrelation,Systole_Pts, ...
                    FLFimgCorrelation(Systole_Pts),'o',diastolePts, FLFimgCorrelation(diastolePts),"diamond")
        
%         FLFimgCorrelation = FLFimgCorrelation(1:700);
%         Systole_Pts = Systole_Pts(1:700);
%         diastolePts = diastolePts(1:700);
    
    %     Systole_Pts = [Systole_Temp(1)-round(mean(diff(Systole_Temp))),Systole_Temp']+FLF_save_PeroidIni-1;
        Beat_Peroid = round(60/(mean(diff(Systole_Pts))*FLF_Load_FrameRate));
    
        save([FLF_ExpVid_LoadUniN,'Systole_Pts',Data_02_formDt],'FLFimgCorrelation','Systole_Pts','diastolePts','Beat_Peroid')
    end
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Correlation                         
% for idxta = 1                                                              % FLFimg read and save name set     
%     FLF_Load_FrameRate = 0.01;
%     
%     FLF_Save_CropedIni = 00001;
%     FLF_Save_CropedEnd = 00700;
%     FLF_Save_DenoisSeg = 1;
% 
%     Beating_Peroid_Est = 75;
%     Beating_Peroid_Sht = 20;
% 
%     SubCen = [1,1];
% 
%     FLF_ExpVid_LoadDep =[num2str(FLF_Save_CropedIni*FLF_Load_FrameRate),'-',...
%                          num2str(FLF_Save_CropedEnd*FLF_Load_FrameRate),'-',...
%                          num2str(FLF_Save_DenoisSeg*FLF_Load_FrameRate),'s'];
%     FLF_save_PeroidInd = FLF_Save_CropedIni:FLF_Save_DenoisSeg:FLF_Save_CropedEnd;
%     FLF_save_PeroidLen = length( FLF_save_PeroidInd );        
% 
%     FLFsub_CenVal      = zeros(EXP_gpnum,Beating_Peroid_Est);
%     FLFimg_PeroidStd   = zeros(EXP_gpnum,1);
% 
% end
% 
% for idxfl = 7:EXP_gpnum                                                    % Correlation made and save         
%     FLF_ExpVid_saveUniN= [File_56_FLFVid_ExpPro,FLF_ExpVid_CrpName(idxfl,:),'\','FLF_ExpImg'];
%     LoadNameUniN  = [FLF_ExpVid_saveUniN,'_','6',File_0i_Crp(2:end),'_',FLF_ExpVid_LoadDep,'_','Subim',num2str(SubCen')'];
%     SaveNameUniN  = [FLF_ExpVid_saveUniN,'_','7',File_0i_Crp(2:end),'_',FLF_ExpVid_LoadDep];
%     FLFcrp_subtst =            imread([LoadNameUniN,Data_01_formIm]);
%     FLFcrp_sub_BW     = zeros([size(FLFcrp_subtst),50]);
%     FLFimgCorrelation = zeros(FLF_save_PeroidLen,1);        
%     
%     for idxfr = 1:Beating_Peroid_Est                                       
%         FLFcrp_subtst = rescale(imread([LoadNameUniN,Data_01_formIm],idxfr));
%         FLFcrp_sub_BW(:,:,idxfr) = imbinarize(FLFcrp_subtst,graythresh(FLFcrp_subtst));
%         imwrite(FLFcrp_sub_BW(:,:,idxfr),strtrim([LoadNameUniN,'BW',Data_01_formIm]),'WriteMode','append');
%     end
%     FLFsub_CenVal(idxfl,:) = squeeze(sum(FLFcrp_sub_BW,[1 2]));
%    [~,FLFimg_PeroidStd(idxfl)] = max(FLFsub_CenVal(idxfl,:));
% 
%     
%         FLFimg_PeroidIni = imread([SaveNameUniN,'_','Frm',num2str(FLFimg_PeroidStd(idxfl),'%05.0f'),Data_01_formIm]);
%     for idxfr = 1:FLF_save_PeroidLen                                       
%         FLFimg_74cCrpnor = imread([SaveNameUniN,'_','Frm',num2str(FLF_save_PeroidInd(idxfr),'%05.0f'),Data_01_formIm]);
%         FLFimgCorrelation(idxfr) = corr2(FLFimg_PeroidIni, FLFimg_74cCrpnor );
%         disp(idxfr)
%     end
% 
%     for idxta = 1                                                          % FLFimg read and save name set     
%         [~,diastolePts] = findpeaks(+FLFimgCorrelation,'MinPeakDistance',Beating_Peroid_Est-Beating_Peroid_Sht,'MinPeakHeight',+mean(FLFimgCorrelation));
%         [~,Systole_Pts] = findpeaks(-FLFimgCorrelation,'MinPeakDistance',Beating_Peroid_Est-Beating_Peroid_Sht,'MinPeakHeight',-mean(FLFimgCorrelation));
% %         FLFimgCorrelation = FLFimgCorrelation(1:700);
% %         Systole_Pts = Systole_Pts(1:700);
% %         diastolePts = diastolePts(1:700);
%     
%     %     Systole_Pts = [Systole_Temp(1)-round(mean(diff(Systole_Temp))),Systole_Temp']+FLF_save_PeroidIni-1;
%         Beat_Peroid = round(60/(mean(diff(Systole_Pts))*FLF_Load_FrameRate));
%         save([FLF_ExpVid_saveUniN,'Systole_Pts',Data_02_formDt],'FLFimgCorrelation','Systole_Pts','diastolePts','Beat_Peroid')
%     end
%     disp(idxfl)
% end
% 
% for idxta = 1                                                              % Recording figure made and save    
%     f=figure(1000);
%     g= repmat(f,EXP_gpnum,1);
%     for idxfl = 7:EXP_gpnum
%         FLF_ExpVid_saveUniN= [File_56_FLFVid_ExpPro,FLF_ExpVid_CrpName(idxfl,:),'\','FLF_ExpImg'];
%         load([FLF_ExpVid_saveUniN,'Systole_Pts',Data_02_formDt],'FLFimgCorrelation','Systole_Pts','diastolePts','Beat_Peroid')
%         g(idxfl)=figure(idxfl);
%         g(idxfl).Position = [100,100,1200,1200];
%         subplot(2,2,1),hold on,...
%         plot(FLFsub_CenVal(idxfl,:))
%         plot(FLFimg_PeroidStd(idxfl),FLFsub_CenVal(idxfl,FLFimg_PeroidStd(idxfl)),'o')
%         hold off
%         subplot(2,2,2),plot(1:FLF_save_PeroidLen, FLFimgCorrelation,Systole_Pts, FLFimgCorrelation(Systole_Pts),'o',diastolePts, FLFimgCorrelation(diastolePts),"diamond")
%         subplot(2,2,3),plot(+FLFimgCorrelation)
%         subplot(2,2,4),plot(-FLFimgCorrelation)
%         saveas(g(idxfl),[FLF_ExpVid_saveUniN,'Systole_Pts',Data_01_formIm])
%         disp(idxfl)
%     end
% 
%     close all;
%         figure('position',[100,100,1800,1200]),
%     for idxfl = 7:EXP_gpnum
%         subplot(4,ceil(EXP_gpnum/5),idxfl),hold on,...
%         plot(FLFsub_CenVal(idxfl,:))
%         plot(FLFimg_PeroidStd(idxfl),FLFsub_CenVal(idxfl,FLFimg_PeroidStd(idxfl)),'o')
%         title(FLF_ExpVid_CrpName(idxfl,1:(find(FLF_ExpVid_CrpName(idxfl,:)=='_'))-1))
%     end
%         saveas(gcf,'DiastolePts.tif')
%     
%         figure('position',[100,100,1800,1200]),
%     for idxfl = 7:EXP_gpnum
%         FLF_ExpVid_saveUniN= [File_56_FLFVid_ExpPro,FLF_ExpVid_CrpName(idxfl,:),'\','FLF_ExpImg'];
%         load([FLF_ExpVid_saveUniN,'Systole_Pts',Data_02_formDt],'FLFimgCorrelation','Systole_Pts','diastolePts','Beat_Peroid')
%     
%         subplot(4,ceil(EXP_gpnum/5),idxfl),hold on,...
%         plot(1:FLF_save_PeroidLen, FLFimgCorrelation,Systole_Pts, FLFimgCorrelation(Systole_Pts),'o',diastolePts, FLFimgCorrelation(diastolePts),"diamond")
%         
%         title(FLF_ExpVid_CrpName(idxfl,1:(find(FLF_ExpVid_CrpName(idxfl,:)=='_'))-1))
%         disp(idxfl)
%     end
%         saveas(gcf,'BeatingPeroids.tif')
% end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Denois                            
for idxfl = [2,4]                                                          % MIRO denoise 1                   
    % close all
    FLF_ExpVid_Frameps = 100;

    Flag_Decomposition = 0;
    FLF_save_CrMIROIni = 00001;
    FLF_save_CrMIROEnd = 00700;
    FLF_save_CrMIROSeg = 1;
    FLF_save_mvMIROIni = 00001;
    FLF_save_mvMIROEnd = 00700;
    FLF_save_mvMIROSeg = 1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    GroupName  = FLF_ExpVid_GrpName(idxfl==EXP_group,:);
    SubImSize  = FLF_ExpSub_crp_rad(idxfl)*2+1;
    LoadSuffix = File_0i_Crp;
    SaveSuffix = File_0k_Dns;

    Load_Index_Ini = FLF_save_CrMIROIni;
    Load_Index_End = FLF_save_CrMIROEnd;
    Load_Index_Seg = FLF_save_CrMIROSeg;

    % Load ideal image
    loadpath = [File_56_FLFVid_ExpPro,GroupName,LoadSuffix,'\','FLF_ExpImg'];
    savepath = [File_56_FLFVid_ExpPro,GroupName,SaveSuffix,'\','FLF_ExpImg'];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load and save Index set    
    load([loadpath,'Systole_Pts.mat'],'Systole_Pts','diastolePts');
    Peroids_PtsTep =sort([Systole_Pts;diastolePts]);
    Peroids_PtsUse = Peroids_PtsTep((FLF_save_mvMIROIni<Peroids_PtsTep)&(Peroids_PtsTep<FLF_save_mvMIROEnd));
    
    Save_Index_Ini = Peroids_PtsUse(1);
    Save_Index_End = Peroids_PtsUse(end)-1;
    Save_Index_Seg = FLF_save_mvMIROSeg;    

    LoadnameDepth =[num2str(Load_Index_Ini*FLF_Load_FrameRate),'-',...
                    num2str(Load_Index_End*FLF_Load_FrameRate),'-',...
                    num2str(Load_Index_Seg*FLF_Load_FrameRate),'s'];
    SavenameDepth =[num2str(Save_Index_Ini*FLF_Load_FrameRate),'-',...
                    num2str(Save_Index_End*FLF_Load_FrameRate),'-',...
                    num2str(Save_Index_Seg*FLF_Load_FrameRate),'s'];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MIRO parameter set
    idxfr  = 1
    Frame  = ['Frm',num2str(idxfr,'%05.0f')];
    imgtep = imread([loadpath,'_','7',LoadSuffix(2:end),'_',LoadnameDepth,'_', Frame,Data_01_formIm]);
    imgsiz = size(imgtep);


    for idxPd = 1:(size(Peroids_PtsUse,1)-1)                               
        disp(idxPd)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MIRO parameter initialization

        Frame_ini = Peroids_PtsUse(idxPd);
        Frame_end = Peroids_PtsUse(idxPd+1)-1;
        Frame_Ind = Frame_ini:Frame_end;
        Frame_Len = length(Frame_Ind);
    
        FLFvidOrg = zeros([imgsiz,Frame_Len]);
        FLFvidDns = zeros([imgsiz,Frame_Len]);
    
        for idxt = 1:Frame_Len                                             
            FLFvidOrg(:,:,idxt) = imread([loadpath,'_','7',LoadSuffix(2:end),'_',LoadnameDepth,'_', ...
                                       'Frm',num2str(Frame_Ind(idxt),'%05d'),Data_01_formIm]);
            disp(idxt)
        end
        
        for idxxi = 1:Recons_43_NumEd                                      
        for idxet = 1:Recons_43_NumEd
            FLFvidsub = FLFvidOrg((idxxi-1)*SubImSize+(1:SubImSize), ...
                                  (idxet-1)*SubImSize+(1:SubImSize),:);
            if xor(mod(idxxi,2),mod(idxet,2))
                LambdaM = lambda1;
            else
                LambdaM = lambda2;
            end
            
            if ~exist('SLsys','var')                                           
                SLsys =  getSLsys(FLFvidOrg, 3);
            end

            [VidDNS] = MIRO(FLFvidsub,...
                        'Offset'                , 1,...
                        'Gain'                  , 2.1,...
                        'Lambda'                , LambdaM,...
                        'NA'                    , 0.078,...
                        'Magnification'         , 3.6, ... 
                        'Mode'                  , 'y',...
                        'OptionalFilter'        , 3,...
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
            FLFvidDns((idxxi-1)*SubImSize+(1:SubImSize), ...
                      (idxet-1)*SubImSize+(1:SubImSize),:) = VidDNS;
            disp(idxxi);disp(idxet);
        end
        end

        for idxt = 1:Frame_Len                                             
            imwrite(uint16(FLFvidDns(:,:,idxt)),[savepath,'_','7',SaveSuffix(2:end),'_',SavenameDepth,'_', ...
                                                 'Frm',num2str(Frame_Ind(idxt),'%05d'),Data_01_formIm]);            
            disp(idxt)
        end
        close all
    end
    
    S27_DataSave_MOV_4NorV1( File_56_FLFVid_ExpPro,...
                             Data_01_formIm ,Data_02_formDt,Data_01_formVd,...
                             Index_Col0,Index_Col1,Index_Col2     ,FLF_ExpVid_Frameps,...
                             Save_Index_Ini    ,Save_Index_End    ,Save_Index_Seg,...
                             Save_Index_Ini    ,Save_Index_End    ,Save_Index_Seg,...
                             FLF_Load_FrameRate,FLF_ExpSub_crp_rad(idxfl), ...
                             Flag_multicolor   ,Flag_Normalization,File_0k_Dns,FLF_ExpVid_GrpName(idxfl,:));
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Decompose                        
for idxsg = 1                                                              
    FLF_load_DecompIni = [000,016,000,005,000];
    FLF_load_DecompEnd = [000,690,000,673,000];
    FLF_Load_DecompSeg = 1;
    FLF_ExpVid_Frameps = 100;
    FLF_Load_FrameRate = 0.01;
end

for idxfl = 2                                                              % Decomposition                    
    PCA_Sparsity = 5;

    S27_DataSave_MOV_6DCP(  File_56_FLFVid_ExpPro                        , ...
                            Data_01_formIm,Data_02_formDt,Recons_43_NumEd, ...
                            FLF_load_DecompIni(idxfl),FLF_load_DecompEnd(idxfl),FLF_Load_DecompSeg, ...
                            FLF_load_DecompIni(idxfl),FLF_load_DecompEnd(idxfl),FLF_Load_DecompSeg, ...
                            FLF_Load_FrameRate,FLF_ExpSub_crp_rad(idxfl),PCA_Sparsity  , ...
                            File_0i_Crp,File_0k_Dns,File_0o_DCP,File_0p_DCP,File_0q_DCP, ...
                            FLF_ExpVid_GrpName(idxfl==EXP_group,:) )
end

for idxfl = 4                                                              % Decomposition                    
    PCA_Sparsity = 4;

    S27_DataSave_MOV_6DCP(  File_56_FLFVid_ExpPro                        , ...
                            Data_01_formIm,Data_02_formDt,Recons_43_NumEd, ...
                            FLF_load_DecompIni(idxfl),FLF_load_DecompEnd(idxfl),FLF_Load_DecompSeg, ...
                            FLF_load_DecompIni(idxfl),FLF_load_DecompEnd(idxfl),FLF_Load_DecompSeg, ...
                            FLF_Load_FrameRate,FLF_ExpSub_crp_rad(idxfl),PCA_Sparsity  , ...
                            File_0i_Crp,File_0k_Dns,File_0o_DCP,File_0p_DCP,File_0q_DCP, ...
                            FLF_ExpVid_GrpName(idxfl==EXP_group,:) )

end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rename                        

for idxfl = 1:EXP_gpnum                                                                                       

    LoadPath  = 'E:\20230410_2204\5FLFVid_6exppro04_6Decomp' ;
    SavePathL = [LoadPath,'L'];
    SavePathS = [LoadPath,'S'];

    name_new1  = 'FLF_ExpImg_76DecompL4_';
    name_new2  = 'FLF_ExpImg_76DecompS4_';

    FLF_save_DecVidIni = 01;
    FLF_save_DecVidEnd = 615;
    FLF_save_DecVidSeg = 01;

    FLF_ExpVid_LoadDep =[num2str(FLF_save_DecVidIni*FLF_Load_FrameRate),'-',...
                         num2str(FLF_save_DecVidEnd*FLF_Load_FrameRate),'-',...
                         num2str(FLF_save_DecVidSeg*FLF_Load_FrameRate),'s'];
    for idxt = FLF_save_DecVidIni:FLF_save_DecVidEnd                                        
        load([LoadPath,'\',num2str(idxt),'.mat'],'bkg_','recon_')

        imwrite(uint16(rescale(bkg_  )*65535),[SavePathL,'\',name_new1,FLF_ExpVid_LoadDep,'_Frm',num2str(idxt,'%05d'),'.tif'])
        imwrite(uint16(rescale(recon_)*65535),[SavePathS,'\',name_new2,FLF_ExpVid_LoadDep,'_Frm',num2str(idxt,'%05d'),'.tif'])

        disp(idxt)
    end

    S27_DataSave_MOV_4NorV1( File_56_FLFVid_ExpPro,...
                             Data_01_formIm ,Data_02_formDt,Data_01_formVd,...
                             Index_Col0,Index_Col1,Index_Col2     ,FLF_ExpVid_Frameps,...
                             FLF_save_DecVidIni,FLF_save_DecVidEnd,FLF_save_DecVidSeg, ...
                             FLF_save_DecVidIni,FLF_save_DecVidEnd,FLF_save_DecVidSeg, ...
                             FLF_Load_FrameRate,FLF_ExpSub_crp_rad(idxfl), ...
                             Flag_multicolor   ,Flag_Normalization,[File_0p_DCP,'4'],FLF_ExpVid_GrpName(idxfl,:));
    
    Index_Col0 = 011;
    Index_Col1 = 023;
    Index_Col2 = 023;
    S27_DataSave_MOV_4NorV1( File_56_FLFVid_ExpPro,...
                             Data_01_formIm ,Data_02_formDt,Data_01_formVd,...
                             Index_Col0,Index_Col1,Index_Col2     ,FLF_ExpVid_Frameps,...
                             FLF_save_DecVidIni,FLF_save_DecVidEnd,FLF_save_DecVidSeg, ...
                             FLF_save_DecVidIni,FLF_save_DecVidEnd,FLF_save_DecVidSeg, ...
                             FLF_Load_FrameRate,FLF_ExpSub_crp_rad(idxfl), ...
                             Flag_multicolor   ,Flag_Normalization,[File_0q_DCP,'4'],FLF_ExpVid_GrpName(idxfl,:));

end


















































