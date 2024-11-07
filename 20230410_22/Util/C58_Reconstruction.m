clear;  close all;  clc;
addpath(genpath('E:\00_Matlab_Code'))
addpath(genpath('E:\A_Fiji.app\Fiji.app\scripts'))
addpath(genpath('E:\02_ACsN'))
addpath(genpath('E:\02_MIRO'))

%% General Parameter Set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    for idxsg = 1	                                                       % Save path name   set                 
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
        File_46_FLFImg_ExpPro = [File_00_path,File_40_FLFImg,'_6',File_0b_exp,File_06_pro];
        
        File_50_FLFVid        = '5FLFVid'; 
        File_51_FLFVid_SimSav = [File_00_path,File_50_FLFVid,'_1',File_0a_sim,File_01_sav];mkdir(File_51_FLFVid_SimSav);
        File_52_FLFVid_ExpRaw = [File_00_path,File_50_FLFVid,'_2',File_0b_exp,File_02_raw];mkdir(File_52_FLFVid_ExpRaw);
        File_53_FLFVid_BkgRaw = [File_00_path,File_50_FLFVid,'_3',File_0c_bkg,File_02_raw];mkdir(File_53_FLFVid_BkgRaw);
        File_54_FLFVid_SimRec = [File_00_path,File_50_FLFVid,'_4',File_0a_sim,File_04_rec];
        File_55_FLFVid_ExpRec = [File_00_path,File_50_FLFVid,'_5',File_0b_exp,File_04_rec];
        File_56_FLFVid_ExpPro = [File_00_path,File_50_FLFVid,'_6',File_0b_exp,File_06_pro];
        
        File_90_RayTracingsav = [File_00_path,'\','90_Ray_Tracingsave'];mkdir(File_90_RayTracingsav);
    end
    for idxsg = 1                                                          % Image  parameter set                 
        Data_00_bit     = 16    ;                                          %get
        Data_00_maxval  = 2^Data_00_bit-1;
        Data_01_formIm  = '.tif';                                          %get
        Data_01_formVd  = '.avi';                                          %get
        Data_02_formDt  = '.mat';                                          %get
        Data_04_smoothn = 1;                                               %Get?Recons_00_NUMd
        Data_04_Oper_sm = fspecial('gaussian',[Data_04_smoothn Data_04_smoothn],0.6);
    end
%% System parameter set 16X_NEW_300 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for idxsg = 1                                                          % System and simulate parameter 16XWV2 
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
    for idxsg = 1                                                          % Object parameters    set             
        Object_31_ZuFOV  = + 150.000*10^-6;                                % Get
        Object_31_ZlFOV  = - 150.000*10^-6;                                % Get
        Object_32_Z_stp  =   000.400*10^-6;                                % Get
        
       [Object_31_ZmFOV,Object_33_ZuNum,Object_33_ZlNum,...
        Object_33_ZdNum,Object_34_Z_Ind,Object_35_ZCoor] = S01_Coord_create_ud(...
        Object_31_ZuFOV,Object_31_ZlFOV,Object_32_Z_stp);
    end
%% System Charaterization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    for idxsg = 1                                                          % Ray tracing figure set and draw      
        Para_Raytrace_step_xx = 0.05;
        Para_Raytrace_Ray_num = 35;
        Para_draw_axis        = 0;
        
        Ini_coorr = 0.0;
        Ini_coorz = 0.5;
        I91_ray_tracing_CPU_20191221(dis_01_oo ,Fl_01_obj,Dm_01_obj,...
                                     dis_02_ot ,Fl_02_tub,Dm_02_tub,...
                                     dis_03_te ,Fl_03_ent,Dm_03_ent,...
                                     dis_04_em ,Fl_04_MLA,Dm_04_mic,...
                                     dis_05_mc ,Pi_04_MLA,Dm_04_MLA,...
                                     Ma_01_obj,NA_01_obj,Pi_05_cam,...
                                     Para_Raytrace_step_xx,Para_Raytrace_Ray_num,Ini_coorr,...
                                     Flag_Lens_On_axis    ,Para_draw_axis       ,Ini_coorz,...
                                     File_90_RayTracingsav,Data_01_formIm)
    end
    for idxta = 1                                                          % Theoretical predicted Character      
        %FLFM system AND FLFM system-imaging
       [Ma_06_Mic,Ma_06_FLF,fn_06_FLF                  ,...
        fn_06_sub,Ma_07_img                            ,...
        Theory_21_BakRd,Theory_22_NatRd,Theory_23_FouRd,...
        Theory_31_RatEl,Theory_31_NumEl                ,...
        Theory_41_ResNL,Theory_41_ResNA                ,...
        Theory_51_FWHML,Theory_52_FWHMA                ,...
        Theory_61_ResR0,Theory_62_ResZ0,Theory_63_ResZE,...
        Theory_71_FOVR0                                ,...
        Theory_72_DOFZ0,Theory_73_FOVZu,Theory_74_FOVZl,...
        Theory_32_NumEl,Theory_73_FOV_R,Theory_74_DOF_Z,...
        Theory_66_Res_R,Theory_67_Res_Z,Theory_68_ResZR,...
        Path_s010_ObjLam,Path_s020_FouLFM,Path_s021_MLALFM,Path_s040_zrange] =  ...
        F03_FLFsys_Characters_Lable(Fl_01_obj,NA_01_obj,Ma_01_obj,...
                                  Fl_01_tub,Fl_02_tub          ,...
                                  Fl_03_ent,Fl_07_img          ,...
                                  Fl_04_MLA,Dm_04_mic,Pi_04_MLA,...
                                  fn_01_obj,fn_04_MLA,lambdaAir,...
                                  del_05_mc,del_03_te,del_04_em,...
                                  Object_34_Z_Ind,Object_32_Z_stp,...
                                  Object_31_ZuFOV,Object_31_ZlFOV);
    end
close all
%% CSF&PSF calculation and data storage %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for idxsg = 1                                                          % Sampling parameter set               
        NIP_SegSZ = 600;
        Data_05_Refine = 2;
        Data_05_DownRT = 1;                                                % Downsampling ratio
                                                                           % Mic & MLA & FLP characterization  
       [Data_06_CCD_DN   ,Data_06_CCD_RF     ,...
        P27_NIP_RefAr_Odd,P27_NIP_RefAr_Eve  ,...
        P27_WFM_RefAd_Odd,P27_WFM_RefAd_Eve  ,...
        P35_Len_NumPd_DN ,P37_Len_NumPd_RF ,P37_Len_NumAd_RF,...
        P47_Fou_NumAd_RF ,P47_MLA_NumAdSim ,P47_MLA_NumAd_RF,...
        Path_s011Lsample ,Path_s031Lsample]= F02_FLFsys_SampleL(                ...
        Ma_06_Mic, NA_01_obj, Pi_04_MLA, Dm_04_mic, Pi_05_cam, Num05_cam       ,...
        Data_05_DownRT   ,Data_05_Refine   ,Object_31_ZmFOV  ,Object_33_ZdNum  ,...
        Theory_22_NatRd  ,Theory_23_FouRd  ,Theory_31_NumEl  ,Theory_41_ResNL  ,...
        Flag_simPSFfine  ,Flag_WFMPSFOnly  ,Flag_Simulation  ,...
        P291_NIP_Size_Ext,P292_NIP_Size_Wav,P293_NIP_Size_Num,...
        Flag_MLA_size_Odd,P492_MLA_lens_Ext,P491_MLA_lens_Num);
    end
%% For image %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % For image
        FLFRec_06_Iters = 20;
        FLFRec_07_PSFpw = 1;
        FLFRec_53cMdNum = 351;
        Path_s090_IterPW = F04_FLFrec_para_Lable(FLFRec_06_Iters,FLFRec_07_PSFpw);
        
    for idxta = 1                                                          % Reconstruction parameter set               
        Path_L259Time = '210707_2015';
        Path_L359Time = '210702_2232';
        Path_L449Time = '210627_1355';
        Path_L459Time = '210823_0052';
        Path_L549Time = '210823_0052';
        Path_L559Time = '04_6DecompL4nor';
%         Path_L559Time = '04_6DecompS4nor';
        
        Recons_51_NumML_sim_x = 91;                                        %get
        Recons_51_NumML_sim_y = 91;                                        %get
        Recons_52_NumML_exp_x = 93;                                        %get
        Recons_52_NumML_exp_y = 93;                                        %get
        
        WFMImg_01_Flag = 25;                                               % 'Experiment  Img 25'
        
        
        FLFPSF_01_Flag = 33;                                               % 'Simulated   PSF 10'
                                                                           % 'SimulateCrp PSF 11'
                                                                           % 'Experiment  PSF 20'
                                                                           % 'Hybried     PSF 30'
                                                                           % 'HyRried_rez PSF 31'
                                                                           % 'HyRried_crp PSF 32'
%         FLFImg_01_Flag = 47;                                             % 'Simulated  PSF  34'
        FLFImg_01_Flag = 57;                                               % 'Simulated  PSF  34'
                                                                           % 'Experiment PSF  35'
                                                                           % 'Simulated  Img  44'
                                                                           % 'Simulated  crp  46'
                                                                           % 'Experiment Img  45'
                                                                           % 'Experiment crp  47'
                                                                           % 'Simulated  Vid  54'
                                                                           % 'Experiment Vid  55'
                                                                           % 'Simulated  Vids 56'
                                                                           % 'Experiment Vids 57'
                                                                           
        FLFRec_01_Flag = 3;                                                % 'Single frame      1'
                                                                           % 'Volumetric stacks 2' 
                                                                           % 'Temperal   frames 3' 
        Recons_03_dzstr = 1e-9;
        Recons_03_zcstr = 50000;
        
        FLFPSF_31_ZlFOV = -200.000*10^-6;                                  %GET
        FLFPSF_31_ZuFOV = +200.000*10^-6;                                  %GET
        FLFPSF_32_Z_Stp = Object_32_Z_stp;                                 
        
        FLFImg_31_ZlFOV = -000.000*10^-6;                                  %GET
        FLFImg_31_ZuFOV = +000.000*10^-6;                                  %GET
        FLFImg_32_Z_Stp = Object_32_Z_stp;                                 
                
        FLFImg_31_ZlSeg = -000.000*10^-6;                                  %GET
        FLFImg_31_ZuSeg = +000.000*10^-6;                                  %GET
        FLFImg_32_Z_Seg = 1;                                               %GET
        
        FLFRec_31_ZuFOV = +200.000*10^-6;                                  %GET
        FLFRec_31_ZlFOV = -200.000*10^-6;                                  %GET
        FLFRec_32_Z_Stp = Object_32_Z_stp;                                     
        FLFRec_32_Z_Seg = 2;
        
        FLFImg_41_TlVid =  000.010;                                        %GET
        FLFImg_41_TuVid =  006.150;                                        %GET
        FLFImg_42_T_Stp =  000.010;                                        %GET
        
        FLFImg_41_TlSeg =  000.010;                                        %GET
        FLFImg_41_TuSeg =  006.150;                                        %GET
        FLFImg_42_T_Seg =  1;                                              %GET

%         Recons_11_FOVXX = Theory_05_FOVX0;                               %SET
%         Recons_21_FOVYY = Theory_05_FOVY0;                               %SET
        WFMImg_31_ZuFOV = +048.000*10^-6;                                  %GET
        WFMImg_31_ZlFOV = -048.000*10^-6;                                  %GET
        WFMImg_32_Z_Stp =  000.400*10^-6;                                  
        
        WFMImg_31_ZlSeg = -040.000*10^-6;                                  %GET
        WFMImg_31_ZuSeg = +040.000*10^-6;                                  %GET
        WFMImg_32_Z_Seg = 1;                                               %GET
        
        FLFRec_53_MdLen = 3;
        FLFRec_53_MrRat = 1.51; 
        FLFRec_53_MrNum = floor(FLFRec_53_MrRat);
        FLFRec_53_MdNum = FLFRec_53_MrNum*2+1;                             %GET
    end
        
    for idxta = 1                                                          % Reconstruction coordinates and paths generate        
       [WFMImg_31_ZmFOV,WFMImg_33_ZuNum,WFMImg_33_ZlNum,WFMImg_33_ZdNum,WFMImg_34_Z_Ind,WFMImg_35_ZCoor,...
        WFMSeg_38_Frm_Z,                WFMSeg_33_ZcNum,WFMSeg_33_ZdNum,WFMSeg_34_Z_Ind,WFMSeg_35_ZCoor,...
        FLFPSF_31_ZmFOV,FLFPSF_33_ZuNum,FLFPSF_33_ZlNum,FLFPSF_33_ZdNum,FLFPSF_34_Z_Ind,FLFPSF_35_ZCoor,...
        FLFRec_38_Frm_Z,                FLFRec_33_ZcNum,FLFRec_33_ZdNum,FLFRec_34_Z_Ind,FLFRec_35_ZCoor,...
        FLFImg_31_ZmFOV,FLFImg_33_ZuNum,FLFImg_33_ZlNum,FLFImg_33_ZdNum,FLFImg_34_Ind_Z,FLFImg_35_ZCoor,...
        FLFSeg_38_Z_Frm,                FLFSeg_33_ZcNum,FLFSeg_33_ZdNum,FLFSeg_34_Z_Ind,FLFSeg_35_ZCoor,...
        FLFImg_41_TmFOV,FLFImg_43_TuNum,FLFImg_43_TlNum,FLFImg_43_TdNum,FLFImg_44_T_Ind,FLFImg_45_TCoor,...
        FLFSeg_48_T_Frm,                FLFSeg_43_TcNum,FLFSeg_43_TdNum,FLFSeg_44_T_Ind,FLFSeg_45_TCoor,...
        FLFRec_03_MRaxi,FLFRec_04_MRmax,FLFRec_04_MRmin,FLFRec_03_fnum ,...
        FLFRec_13_Xrnum,FLFRec_13_XrNum,Recons_13_NumXc,FLFRec_13_XdNum,FLFRec_14_X_Ind,FLFRec_10_XCoor,...
        FLFRec_23_Yrnum,FLFRec_23_YrNum,Recons_23_NumYc,FLFRec_23_YdNum,FLFRec_24_Y_Ind,FLFRec_20_YCoor,...
        FLFRec_54_M_Ind,Path_s050_zrange] = S07_Coord_All(...
        WFMImg_31_ZuFOV,WFMImg_31_ZlFOV,WFMImg_32_Z_Stp,...
        WFMImg_31_ZuSeg,WFMImg_31_ZlSeg,WFMImg_32_Z_Seg,...
        FLFPSF_31_ZuFOV,FLFPSF_31_ZlFOV,FLFPSF_32_Z_Stp,...
        FLFRec_31_ZuFOV,FLFRec_31_ZlFOV,FLFRec_32_Z_Seg,...
        FLFImg_31_ZuFOV,FLFImg_31_ZlFOV,FLFImg_32_Z_Stp,...
        FLFImg_31_ZuSeg,FLFImg_31_ZlSeg,FLFImg_32_Z_Seg,...
        FLFImg_41_TuVid,FLFImg_41_TlVid,FLFImg_42_T_Stp,...
        FLFImg_41_TuSeg,FLFImg_41_TlSeg,FLFImg_42_T_Seg,...
        FLFRec_53_MrNum,Pi_05_cam,Pi_04_MLA,Ma_06_FLF,fn_06_FLF);

       [Path_L310_PSF,Path_L311_PSF,Path_L312_PSF                     ,...
        Path_L31A_PSF,Path_L31B_PSF,Path_L31C_PSF                     ,...
        Path_L32A_PSF,Path_L32B_PSF,Path_L32C_PSF] = S08_Load_Name_PSF(...
        Path_s020_FouLFM,Path_s031Lsample,Path_s040_zrange,...
        FLFPSF_31_ZlFOV ,FLFPSF_31_ZuFOV ,FLFRec_53cMdNum ,...
        File_31_FLFPSF_SimSav,File_32_FLFPSF_ExpRaw);

       [Path_L572cEnd,...
        Path_L250_Uni,Path_L250_Img,...
        Path_L340_Uni,Path_L340_Img,Path_L360_Uni,Path_L360_Img,...
        Path_L350_Uni,Path_L350_Img,...
        Path_L440_Uni,Path_L440_Img,Path_L460_Uni,Path_L460_Img,...
        Path_L450_Uni,Path_L450_Img,Path_L470_Uni,Path_L470_Img,...
        Path_L540_Uni,Path_L540_Img,Path_L560_Uni,Path_L560_Img,...
        Path_L550_Uni,Path_L550_Img,Path_L570_Uni,Path_L570_Img,...
        Path_L570cUni,Path_L570cImg] = S08_Load_Name_Img(...
        Path_s020_FouLFM,Path_s031Lsample  ,...
        WFMImg_31_ZlFOV ,WFMImg_31_ZuFOV   ,...
        FLFPSF_31_ZlFOV ,FLFPSF_31_ZuFOV   ,FLFImg_31_ZlFOV ,FLFImg_31_ZuFOV   ,...
        FLFImg_41_TlVid ,FLFImg_41_TuVid   ,FLFImg_42_T_Stp ,FLFSeg_44_T_Ind   ,...
        File_26_WFMImg_ExpPro,Path_L259Time,File_36_FLFPSF_ExpPro,Path_L359Time,...
        File_41_FLFImg_SimSav,Path_L449Time,File_46_FLFImg_ExpPro,Path_L459Time,...
        File_51_FLFVid_SimSav,Path_L549Time,File_56_FLFVid_ExpPro,Path_L559Time,...
        FLFRec_53cMdNum ,Data_02_formDt);

       [Path_s200_update,Path_s204_unifor,Path_s201_unifor,...
        Path_s400_update,Path_s401_unifor,Path_s404_unifor,...
        Path_s41o_FLFCrp,Path_s41p_FLFRez,Path_s41q_WFMPSF,Path_s41rsWFMPSF,Path_s41s_Hybper,...
        Path_s270_WFMImg,Path_s275_WFMdec,Path_s276_WFMreg,Path_s277_WFMcmp,...
        Path_s278_WFMcmp,...
        Path_s470_Object,Path_s472_Objnor,Path_s472_Objb16,Path_s474_ObjCrp,Path_s477_Objrez,...
        Path_s460_FLFSub,Path_s485_FLFLsp,Path_s487_FLFRez,Path_s495_FLFHsp,...
        Path_s4a0_HybImg,Path_s4b0_HydImg,Path_s4c0_Hydae8,Path_s4d0_Hydpe4,...
        Path_s40y_Profil,Path_s40z_Analys,...
        Text_s401Rescale,Text_s402Cropped,...
        Text_s554MIP3Dmv,Text_s554MIP3DmL,Text_s557MIP3Dmp,...
        Text_s554_MIPCro,Path_s554lMIPCro,...
        Text_s556_PtsAll,Text_s556_BoxReg,Text_s557_DataSV,Text_s558_T_Disp,Text_s559_T_CaTr...
        ] = S20_DataSave_PathSet(         ...
        Path_s010_ObjLam,Path_s020_FouLFM,Path_s021_MLALFM,WFMImg_01_Flag,...
        Path_s011Lsample,Path_s031Lsample,Path_s090_IterPW,FLFImg_01_Flag,...
        File_14_WFMPSF_SimRec,File_15_WFMPSF_ExpRec,File_24_WFMImg_SimRec,File_25_WFMImg_ExpRec,...
        File_34_FLFPSF_SimRec,File_35_FLFPSF_ExpRec,File_44_FLFImg_SimRec,...
        File_45_FLFImg_ExpRec,File_54_FLFVid_SimRec,File_55_FLFVid_ExpRec);

%         load([File_56_FLFVid_ExpPro,Path_L559Time,'\FLF_ExpImgSystole_Pts',Data_02_formDt],'FLFimgCorrelation','Systole_Pts','diastolePts','Beat_Peroid')
        FLFRec_49_Fram0 = 0001;
        FLFRec_49_Fram1 = 0021;
        FLFRec_49_Fram2 = 0042;
    end
    
    for idxsg = 1                                                          % Image croping - croping pattern simulation 
%         Recons_51_Stoper = I25_MLA_Modulation_SQU_Aperture_Num(                 ...
%                              Fl_04_MLA       , k0             ,Data_06_CCD_RF  ,...
%                              P37_Len_NumPd_RF,P37_Len_NumPd_RF,P37_Len_NumAd_RF,...
%                              P47_MLA_NumAd_RF,P47_Fou_NumAd_RF,P490_MLA_Beam_Rat,...
%                              Flag_LensTraCir,Flag_LensletCen,1,Flag_LensAlluse);
%         Recons_51_Stpcro = I25_MLA_Modulation_SQU_Aperture_Num(                 ...
%                              Fl_04_MLA       , k0             ,Data_06_CCD_RF  ,...
%                              P37_Len_NumPd_RF,P37_Len_NumPd_RF,P37_Len_NumAd_RF,...
%                              P47_MLA_NumAd_RF,P47_Fou_NumAd_RF,1.51            ,...
%                              1,Flag_LensletCen,1,0);
%         Recons_51_StoAbs = imbinarize(O10_pixelBinning(Recons_51_Stoper,Data_05_Rifine));imshow(Recons_51_StoAbs)
%         Recons_51_StcAbs = imbinarize(O10_pixelBinning(Recons_51_Stpcro,Data_05_Rifine));imshow(Recons_51_StcAbs)
%         Recons_51_StpAbs = xor(Recons_51_StcAbs,Recons_51_StoAbs)                       ;imshow(Recons_51_StpAbs)

%         Recons_50_CoorM = (abs(Recons_54_Ind_M)+1)'*(abs(Recons_54_Ind_M)+1);
%         Recons_51_StrAbs= kron(Recons_50_CoorM,ones(160));                 U60_Imshow_B16(Recons_51_StrAbs)
        Recons_50_Mask_1 = xor(mod(repmat((1:3),[3,1]),2),mod(repmat((1:3)',[1,3]),2));
        Recons_50_Mask_2 = ~Recons_50_Mask_1;
        
        Recons_51_StpCro = kron(Recons_50_Mask_1,ones(FLFRec_53cMdNum,FLFRec_53cMdNum));
        Recons_51_StpPer = kron(Recons_50_Mask_2,ones(FLFRec_53cMdNum,FLFRec_53cMdNum));
                                                                           U60_Imshow_B16(Recons_51_StpCro);
                                                                           U60_Imshow_B16(Recons_51_StpPer);
    end
    close all;clc
%% Data imput: Using entire information%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    switch FLFPSF_01_Flag                                                  % FLF PSF load and space characterization    
        case 10                                                            % 'Simulated   PSF 10'
            load([Path_L310_PSF,'_','6_3DNDat_Down',Data_02_formDt]);      FLFPSF_64_NorCrp = P62_FLF_PSF3Dn_nor(:,:,FLFRec_38_Frm_Z);  
                                                                           U_Image_show_16(203,FLFPSF_64_NorCrp(:,:,FLFRec_33_ZcNum));     clear P62_FLF_PSF3Dn_nor;   
            FLFRec_13_RdNum  = P17_ParityMatch_Min(round(Pi_04_MLA*FLFRec_53_MdLen/Data_06_CCD_DN),size(RecRez_64_PSFunc,1));   % get
            if mod(FLFRec_13_RdNum,2)                                      
                load([Path_L310_PSF,'_','6_WFModd_Down',Data_02_formDt]);   WFMPSF_64_NorCrp = P62_WFM_PSFodd_nor(:,:,FLFRec_38_Frm_Z);	U_Image_show_16(201,WFMPSF_64_NorCrp(  :,:,FLFRec_33_ZcNum));   clear P62_WFM_PSFodd_nor;   
            else
                load([Path_L310_PSF,'_','6_WFMeve_Down',Data_02_formDt]);   WFMPSF_64_NorCrp = P62_WFM_PSFeve_nor(:,:,FLFRec_38_Frm_Z);  U_Image_show_16(202,WFMPSF_64_NorCrp(  :,:,FLFRec_33_ZcNum));   clear P62_WFM_PSFeve_nor;   
            end
            RezRec_13_RdNum  = size(RecRez_64_PSFunc,1);                   Recons_15_RcNum = ceil(RezRec_13_RdNum/2);        
            FLFPSF_74_NorCrp = P35_Imgcrop_centerS(FLFPSF_64_NorCrp,FLFRec_13_RdNum);	clear RecFLF_64_PSFunc;
            RezPSF_74_NorCrp = P35_Imgcrop_centerS(RecRez_64_PSFunc,RezRec_13_RdNum);    
                                                                           U_Image_show_16(206,RezPSF_74_NorCrp(:,:,FLFRec_33_ZcNum));     clear RecRez_64_PSFunc;
            FLFRec_33_ZdNum  = size(FLFImg_74_NorCrp,3);
        case 11                                                            % 'SimulateCrp PSF LS'
            load([Path_L31C_PSF,Data_02_formDt]);                      
            FLFPSF_74_NorCrp = FLF_SimPSF_bin_crp(:,:,:);              
            clear FLF_SimPSF_bin_crp;
        case 12                                                            % 'SimulateCrp PSF HS'
            load([Path_L31D_PSF,Data_02_formDt]);                      
            FLFPSF_74_NorCrp = V40_NorGPU_one(FLF_SimPSF_rez_crp(:,:,:));
%                 RecFLF_64_PSFcrp = V40_NorGPU_one(FLF_SimPSF_rez_crp(:,:,:).*Recons_51_StrAbs);
            clear FLF_SimPSF_bin_crp;
        case 30                                                            
            load([Path_L32A_PSF,Data_02_formDt]);                      
            FLFPSF_74_NorCrp = FLF_HybPSF_Nor(:,:,:);                  
            clear FLF_HybPSF_Nor;
        case 31                                                            
            load([Path_L32B_PSF,Data_02_formDt]);                      
            FLFPSF_74_NorCrp = rescale(FLF_HyRPSF_Nor(:,:,:).^FLFRec_07_PSFpw);
            U65_Imshow_B16_3DMaxP_Fire(FLF_HyRPSF_Nor);                
            clear FLF_HyRPSF_Nor;
        case 32                                                            
            load([Path_L32C_PSF,Data_02_formDt]);                          
            FLFPSF_74_NorCrp = rescale(FLF_HySPSF_Nor(:,:,FLFRec_34_Z_Ind-FLFPSF_34_Z_Ind(1)+1).^FLFRec_07_PSFpw);
            U65_Imshow_B16_MIP_3D_Fire(FLF_HySPSF_Nor);                    
            clear FLF_HySPSF_Nor;
            U65_Imshow_B16_MIP_3D_Fire(FLFPSF_74_NorCrp);
        case 33                                                            
            load([Path_L32B_PSF,Data_02_formDt]);                      
            FLF_ExpPSF_Zshift = +150;
%             FLF_SubPSF_crp_rad=  175;
            FLF_SubPSF_crp_rad=  floor(FLFRec_53cMdNum/2);
            Recons_43_NumEd   = 3;

            load([File_32_FLFPSF_ExpRaw,'\','FLFM_PSF_CenfitCoordinates_sub','.mat'],'FLF_ExpPSF_sub_Xfit','FLF_ExpPSF_sub_Yfit');

            FLF_HySPSF_Nor = S21_DataSave_FLF_HySPSF_Back( FLF_HyRPSF_Nor  ,FLF_SubPSF_crp_rad ,Recons_43_NumEd,...
                                                        FLF_ExpPSF_sub_Yfit,FLF_ExpPSF_sub_Xfit,FLF_ExpPSF_Zshift);
            FLFPSF_74_NorCrp = rescale(FLF_HySPSF_Nor(:,:,FLFRec_34_Z_Ind-FLFRec_34_Z_Ind(1)+1).^FLFRec_07_PSFpw);
            U65_Imshow_B16_MIP_3D_Fire(FLF_HySPSF_Nor);
            U65_Imshow_B16_MIP_3D_Fire(FLFPSF_74_NorCrp);
            clear FLF_HySPSF_Nor;
            clear FLF_HyRPSF_Nor;
        otherwise                                                          
            
    end
    
    switch FLFImg_01_Flag                                                  % FLF IMG load and Path choice               
        case 21
            for idxsg = 1                                                  % Reconstruction data load and crop - simulated  PSF  
                load([Path_L31C_PSF,Data_02_formDt]);                      
                FLFImg_74_Crpnor = FLF_SimPSF_bin_crp(:,:,:);              U65_Imshow_B16_3DMaxP_Fire(FLFImg_74_Crpnor);
                FLFImg_74_NorCrp = single(V41_NorGPU_one_1b1(FLFImg_74_Crpnor(:,:,FLFSeg_38_Z_Frm)));
                                                                           U65_Imshow_B16_3DMaxP_Fire(FLFImg_74_NorCrp);
                clear FLF_SimPSF_bin_crp;
            end
            for idxsg = 1                                                  % Reconstruction data load and crop - simulated  PSFHS
                load(Path_L31D_PSF);                      
                FLFImg_74_Crpnor = FLF_SimPSF_rez_crp(:,:,:);              U65_Imshow_B16_3DMaxP_Fire(FLFImg_74_Crpnor);
                FLFImg_74_NorCrp = single(V41_NorGPU_one_1b1((FLFImg_74_Crpnor(:,:,FLFSeg_38_Z_Frm))));
                                                                           U65_Imshow_B16_3DMaxP_Fire(FLFImg_74_NorCrp);
                clear FLF_SimPSF_bin_crp;
            end
        case 35
            for idxsg = 1                                                  % Reconstruction data load and crop - Experiment PSF  
                load(Path_L350_Img);                                   U60_Imshow_B16(FLF_DnsPSF_Nor(:,:,end));
                FLFImg_74_NorCrp = single(FLF_DnsPSF_Nor(:,:,FLFSeg_38_Z_Frm));
                clear FLF_DnsPSF_Nor;
            end
        case 44
            for idxsg = 1                                                  % Reconstruction data load and crop - simulated  Fix  
                load(Path_L440_Img);                                   U60_Imshow_B16(ObjFLF_72_Orgnor(:,:,end));
                FLFImg_74_NorCrp = single(ObjFLF_72_Orgnor(:,:,FLFSeg_38_Z_Frm));
            end
        case 45
            for idxsg = 1                                                  % Reconstruction data load and crop - Experiment Fix  
                load(Path_L450_Img);                                   U60_Imshow_B16(FLFimg_74_Crpnor(:,:,end));
                FLFImg_74_NorCrp = single(FLFimg_74_Crpnor(:,:,FLFSeg_38_Z_Frm));
                clear FLFimg_74_Crpnor;
            end
        case 46
            for idxsg = 1                                                  % Reconstruction data load and crop - simulated  Fix  
                load(Path_L460_Img);                                   U60_Imshow_B16(ObjFLF_72cOrgnor(:,:,end));
                FLFImg_74_NorCrp = single(ObjFLF_72cOrgnor(:,:,FLFSeg_38_Z_Frm));
                clear ObjFLF_82cOrgnor;
            end
        case 47
            for idxsg = 1                                                  % Reconstruction data load and crop - simulated  Fix  
                load(Path_L470_Img);                                   U60_Imshow_B16(FLFimg_74cCrpnor(:,:,end));
                FLFImg_74_NorCrp = single(FLFimg_74cCrpnor(:,:,FLFSeg_38_Z_Frm));
                clear FLFimg_74cCrpnor;
            end
        case 57                                                            % Reconstruction data load and crop - Experiment Fix  (19)_10_5000  
                load(Path_L570_Img);                                       U60_Imshow_B16(FLFimg_74cCrpnor(:,:,end));
                FLFImg_74_NorCrp = single(FLFimg_74cCrpnor);
                clear RecFLF_84cCrpnor;
        otherwise
    end
                                                                           U60_Imshow_B16(FLFImg_74_NorCrp(:,:,end));   
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for idxta = 1                                                          % Reconstruction FLF OTF processing          
        FLFPSF_74_NorCr1 = FLFPSF_74_NorCrp.*repmat(Recons_51_StpPer, [1,1,FLFRec_33_ZdNum]);
        U65_Imshow_B16_MIP_3D_Fire(FLFPSF_74_NorCr1);                      
%        [FLFPSF_75_OTFunc, FLFPSF_75tOTFunc] = N32_DeconvRL_3D_APU_OTF_FLFM_NnTn( single( FLFPSF_74_NorCrp ) );gpuDevice;
       [FLFPSF_75_OTFun1, FLFPSF_75tOTFun1] = N32_DeconvRL_3D_APU_OTF_FLFM_N1T1( single( FLFPSF_74_NorCr1 ) );gpuDevice;
                FLFPSF_70_VLsize = size(FLFPSF_74_NorCrp);
    end
    clear FLFPSF_74_NorCr1;
    for idxta = 1                                                          % Reconstruction FLF OTF processing          
        FLFPSF_74_NorCr2 = FLFPSF_74_NorCrp.*repmat(Recons_51_StpCro, [1,1,FLFRec_33_ZdNum]);
        U65_Imshow_B16_MIP_3D_Fire(FLFPSF_74_NorCr2);                       
%        [FLFPSF_75_OTFunc, FLFPSF_75tOTFunc] = N32_DeconvRL_3D_APU_OTF_FLFM_NnTn( single( FLFPSF_74_NorCrp ) );gpuDevice;
       [FLFPSF_75_OTFun2, FLFPSF_75tOTFun2] = N32_DeconvRL_3D_APU_OTF_FLFM_N1T1( single( FLFPSF_74_NorCr2 ) );gpuDevice;
                FLFPSF_70_VLsize = size(FLFPSF_74_NorCrp);
    end
    clear FLFPSF_74_NorCr2;
    clear FLFPSF_74_NorCrp;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Recons_06_PSFIM  = 1e0;                                                % FLForg and FLFrez Reconstruction and save  
    FLFRec_09_ColSat = 2;
    switch  FLFRec_01_Flag                                                 
    case 1                                                                 
        for idxz = 1                                                       % Reconstruction and save                    
            Path_L554_Index = 'Focal';
            
            figure,  histogram(FLFImg_74_NorCrp(FLFImg_74_NorCrp>0),200);
            FLFImg_74_CrpNos = 0.025;
            FLFImg_75_DnsNor = FLFImg_74_NorCrp - FLFImg_74_CrpNos;    FLFImg_75_DnsNor(FLFImg_75_DnsNor<0)=0;
            figure,  histogram(FLFImg_75_DnsNor(FLFImg_75_DnsNor>0));  
                                                                       U60_Imshow_B16(  FLFImg_75_DnsNor(:,:,end));
                                                                       
            FLFRec_37_ZcInd = 1:FLFRec_33_ZdNum;
            FLFRec_85_CrpNor = N36_DeconvRL_3D_APU_lite_FLFM(FLFPSF_75_OTFunc,FLFPSF_75tOTFunc,FLFImg_75_DnsNor,...
                                                             FLFRec_06_Iters ,FLFRec_53cMdNum ,FLFRec_37_ZcInd ,...
                                                             0.001^2         ,65535           , 0);    gpuDevice(1);
                                                                       U65_Imshow_B16_MIP_3D_Fire(FLFRec_85_CrpNor);
                                                                       
            FLFRec_18cX_Ind  = 029:175;                                disp(length(FLFRec_18cX_Ind));
            FLFRec_28cY_Ind  = 027:173;                                disp(length(FLFRec_28cY_Ind));
            FLFRec_38cZ_Ind  =(269:749)-208;                           disp(length(FLFRec_38cZ_Ind));
            FLFRec_38cZ_Ind  =(275:645)-208;                           disp(length(FLFRec_38cZ_Ind));
            
            FLFRec_86_FlpNor = flip(rot90(FLFRec_85_CrpNor(:,:,FLFRec_38cZ_Ind),3),2 );
                                                                       U64_Imshow_B16_MIP_2D_Fire(FLFRec_86_FlpNor);
                                                                       U65_Imshow_B16_MIP_3D_Fire(FLFRec_86_FlpNor);
                                                                       U69_Imshow_B16_DepthC_Col( FLFRec_86_FlpNor,294,FLFRec_09_ColSat,0);
                                                                       
            save(                      [Path_s408_FLFLsp,Path_L554_Index ,Data_02_formDt],'FLFRec_85_CrpNor','FLFRec_86_FlpNor','-v7.3');
            S60_Imsave_B16_Nor_Col(    [Path_s408_FLFLsp,Path_L554_Index],Data_01_formIm , FLFRec_86_FlpNor ,'fire',1);
            disp(['Layer' Path_L554_Index]);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FLFM Volume resize and saving
            FLFRec_96_FlpRez = rescale(imresize(FLFRec_86_FlpNor,Ma_01_obj/Ma_06_FLF));
                                                                       U65_Imshow_B16_MIP_3D_Fire(FLFRec_96_FlpRez);
                                                                       U69_Imshow_B16_DepthC_Col( FLFRec_96_FlpRez,211,FLFRec_09_ColSat,1);
            
            save(                     [Path_s408_FLFRez,Path_L554_Index ,Data_02_formDt],'FLFRec_96_FlpRez','-v7.3');
            S60_Imsave_B16_Nor_Col(   [Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_FlpRez ,'fire' ,1);
            S65_Imsave_B16_MIP_3D_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_FlpRez ,'green',1);
            S65_Imsave_B16_MIP_3D_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_FlpRez ,'fire' ,1);
            S69_Imsave_B16_DepthC_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_FlpRez ,241    ,1,FLFRec_09_ColSat,0);
            S69_Imsave_B16_DepthC_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_FlpRez ,221    ,1,FLFRec_09_ColSat,0);
            S69_Imsave_B16_DepthC_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_FlpRez ,211    ,1,FLFRec_09_ColSat,1);
            S69_Imsave_B16_DepthC_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_FlpRez ,294    ,1,FLFRec_09_ColSat,1);
            close all;clc;
        end
        for idxz = 1                                                       % Reconstruction and saveHS                  
%                 Path_s043_Index = 'Focal';
%                 min(RecFLF_84_CrpNor(:))
%                 RecRez_95_Crpnor = N32_DeconvRL_3D_APU_lite(RecFLF_64_OTFunc          , RecFLF_64tOTFunc ,...
%                                                             RecFLF_84_CrpNor(:,:,idxz), RecFLF_64_PSFsiz,...
%                                                             Recons_06_Iters, 0.001, 100000, 10000,...
%                                                             Recons_13_NumRd, 1:Recons_33_NumZd, 0);   gpuDevice;
%                 RecRez_95_Flpnor = flip(rot90(RecRez_95_Crpnor,3),2);      U65_Imshow_B16_3DMaxP_Fire(RecRez_95_Flpnor)
%                 U68_Imshow_B16_Coordc_Hot(RecRez_95_Flpnor,81,81,76) 
%                 
%                 save(                           [Path_s408_FLFRez,Path_s043_Index ,Data_02_formDt],'RecRez_95_Flpnor','RecRez_95_Crpnor','-v7.3');
%                 S61_Imsave_B16_Fire(            [Path_s408_FLFRez,Path_s043_Index],Data_01_formIm , RecRez_95_Flpnor);
%                 S65_Imsave_B16_3DMaxP_Fire_File([Path_s408_FLFRez,Path_s043_Index],Data_01_formIm , RecRez_95_Flpnor);
%                 disp(['Frame' Path_s043_Index]);
        end
        for idxz = 1                                                       % Reconstruction and save                    
            Path_L554_Inde1 = 'Focal1';
            Path_L554_Inde2 = 'Focal2';
            Path_L554_Index = 'Focal' ;

            FLFImg_74_NorCr1= FLFImg_74_NorCrp.*Recons_51_StpPer;
                                                                       U60_Imshow_B16(  FLFImg_74_NorCr1(:,:,end));
            FLFImg_74_NorCr2= FLFImg_74_NorCrp.*Recons_51_StpCro;
                                                                       U60_Imshow_B16(  FLFImg_74_NorCr2(:,:,end));


            figure,  histogram(FLFImg_74_NorCr1(FLFImg_74_NorCr1>0),200);
            FLFImg_74_CrpNo1 = 0.000;
            FLFImg_75_DnsNo1 = FLFImg_74_NorCr1 - FLFImg_74_CrpNo1;    FLFImg_75_DnsNo1(FLFImg_75_DnsNo1<0)=0;
            figure,  histogram(FLFImg_75_DnsNo1(FLFImg_75_DnsNo1>0));  
                                                                       U60_Imshow_B16(  FLFImg_75_DnsNo1(:,:,end));

            figure,  histogram(FLFImg_74_NorCr2(FLFImg_74_NorCr2>0),200);
            FLFImg_74_CrpNo2 = 0.000;
            FLFImg_75_DnsNo2 = FLFImg_74_NorCr2 - FLFImg_74_CrpNo2;    FLFImg_75_DnsNo2(FLFImg_75_DnsNo2<0)=0;
            figure,  histogram(FLFImg_75_DnsNo2(FLFImg_75_DnsNo2>0));  
                                                                       U60_Imshow_B16(  FLFImg_75_DnsNo2(:,:,end));
                                                                       
            FLFRec_37_ZcInd = 1:FLFRec_33_ZdNum;
            FLFRec_85_CrpNo1 = N36_DeconvRL_3D_GPU_lite_FLFM(FLFPSF_75_OTFun1,FLFPSF_75tOTFun1,FLFImg_74_NorCr1,...
                                                             FLFRec_06_Iters ,FLFRec_53cMdNum ,FLFRec_37_ZcInd ,...
                                                             0.001^2         ,65535           , 0);    gpuDevice(1);
                                                                       U65_Imshow_B16_MIP_3D_Fire(FLFRec_85_CrpNo1);

            FLFRec_38cZ_Ind  =(512:652)-132;                            disp(length(FLFRec_38cZ_Ind));

            FLFRec_86_FlpNo1 = rot90(flip(flip(P35_Imgcrop_centerS(FLFRec_85_CrpNo1(:,:,FLFRec_38cZ_Ind),80),2),1 ),3);
                                                                       U64_Imshow_B16_MIP_2D_Fire(FLFRec_86_FlpNo1);
                                                                       U65_Imshow_B16_MIP_3D_Fire(FLFRec_86_FlpNo1);


            FLFRec_85_CrpNo2 = N36_DeconvRL_3D_APU_lite_FLFM(FLFPSF_75_OTFun2,FLFPSF_75tOTFun2,FLFImg_74_NorCr2,...
                                                             FLFRec_06_Iters ,FLFRec_53cMdNum ,FLFRec_37_ZcInd ,...
                                                             0.001^2         ,65535           , 0);    gpuDevice(1);
                                                                       U65_Imshow_B16_MIP_3D_Fire(FLFRec_85_CrpNo2);
            FLFRec_86_FlpNo2 = rot90(flip(flip(P35_Imgcrop_centerS(FLFRec_85_CrpNo2(:,:,FLFRec_38cZ_Ind),80),2),1 ),3);
                                                                       U64_Imshow_B16_MIP_2D_Fire(FLFRec_86_FlpNo2);
                                                                       U65_Imshow_B16_MIP_3D_Fire(FLFRec_86_FlpNo2);                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_86_FlpNo2);
                                                                       
            save(                      [Path_s408_FLFLsp,Path_L554_Index ,Data_02_formDt],...
                                                                       'FLFRec_85_CrpNo1','FLFRec_85_CrpNo2',...
                                                                       'FLFRec_85_CrpNor','FLFRec_86_FlpNor','-v7.3');
            disp(['Layer' Path_L554_Index]);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FLFM Volume resize and saving
            FLFRec_88cFlpRe1 = rescale(imresize(FLFRec_86_FlpNo1,Ma_01_obj/Ma_06_FLF));
                                                                       U65_Imshow_B16_MIP_3D_Fire(FLFRec_88cFlpRe1);
            FLFRec_18cX_Ind  =(-100:100)+ceil((185+305)/2);                    disp(length(FLFRec_18cX_Ind));
            FLFRec_28cY_Ind  =(-100:100)+ceil((245+350)/2);                    disp(length(FLFRec_28cY_Ind));
            FLFRec_88cFlpRe1 = FLFRec_88cFlpRe1(FLFRec_28cY_Ind,FLFRec_18cX_Ind,:);
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_88cFlpRe1);

            FLFRec_88cFlpRe2 = rescale(imresize(FLFRec_86_FlpNo2,Ma_01_obj/Ma_06_FLF));
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_88cFlpRe2);

            FLFRec_88cFlpRe2 = FLFRec_88cFlpRe2(FLFRec_28cY_Ind,FLFRec_18cX_Ind,:);
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_88cFlpRe2);
            FLFRec_88cFlpco1 = U65_Imshow_B16_MIP_3D_Col(FLFRec_88cFlpRe1,022,2);
            FLFRec_88cFlpco2 = U65_Imshow_B16_MIP_3D_Col(FLFRec_88cFlpRe2,023,2);
            FLFRec_88cFlpcol = ceil((FLFRec_88cFlpco1 + FLFRec_88cFlpco2)/1.2);
            figure,imshow(FLFRec_88cFlpcol)
            save(      [Path_s408_FLFRez,Path_L554_Index ,Data_02_formDt],'FLFRec_88cFlpRe1','FLFRec_88cFlpRe2','-v7.3');
            S30_Imsave([Path_s408_FLFRez,Path_L554_Index,'g'],Data_01_formIm , FLFRec_88cFlpco1 ,1,0);
            S30_Imsave([Path_s408_FLFRez,Path_L554_Index,'r'],Data_01_formIm , FLFRec_88cFlpco2 ,1,0);
            S30_Imsave([Path_s408_FLFRez,Path_L554_Index,'A'],Data_01_formIm , FLFRec_88cFlpcol ,1,0);
            close all;clc;
        end
        close all;clc
    case 2                                                                 
        for idts = 1                                                                                                    
            figure,  histogram(FLFImg_74_NorCrp(FLFImg_74_NorCrp>0),200);
            FLFImg_74_CrpNos = 0.040;
            FLFImg_75_DnsNor = FLFImg_74_NorCrp - FLFImg_74_CrpNos;    FLFImg_75_DnsNor(FLFImg_75_DnsNor<0)=0;
            figure, histogram(FLFImg_75_DnsNor);                       U60_Imshow_B16(  FLFImg_75_DnsNor(:,:,end));
                                                                       U65_Imshow_B16_3DMaxP_Fire(FLFPSF_74_NorCrp);
            FLFRec_33_ZdNum  = FLFPSF_70_VLsize(3);
            
            FLFRec_85_CrpNor = N36_DeconvRL_3D_APU_lite_FLFM(FLFPSF_75_OTFunc,FLFPSF_75tOTFunc,FLFImg_74_NorCrp(:,:,1),...
                                                             FLFRec_06_Iters ,FLFRec_13_XdNum ,1:FLFRec_33_ZdNum,...
                                                             0.001^2         ,65535           , 0);    gpuDevice;
                                                                       U65_Imshow_B16_3DMaxP_Fire( FLFRec_85_CrpNor );
        end
        for idxz = 1:FLFSeg_33_ZdNum                                       % Reconstruction and save                    
            Path_L554_Index = [num2str(FLFSeg_34_Z_Ind(idxz),'%03d'),num2str(FLFSeg_35_ZCoor(idxz)*1e6,'%+.2f'),'um'];
            FLFRec_85_CrpNor = N32_DeconvRL_3D_APU_lite(FLFPSF_75_OTFunc                             , FLFPSF_75tOTFunc,...
                                                        FLFImg_74_NorCrp                             , FLFPSF_70_VLsize,...
                                                        FLFRec_06_Iters,   0.001^2, 10000            ,...
                                                        size(FLFImg_74_NorCrp,1)/3, 1:FLFRec_33_ZdNum, 0);    gpuDevice;
                                                                       U65_Imshow_B16_3DMaxP_Fire( FLFRec_85_CrpNor );
            
            Recons_13_NumRd = 171;
            Recons_09_frame = (380:720)-260;
            
            FLFRec_85_CrpNor = N32_DeconvRL_3D_APU_lite(FLFPSF_75_OTFunc          ,  FLFPSF_75tOTFunc     ,...
                                                        FLFImg_74_NorCrp(:,:,idxz),  FLFPSF_70_VLsize     ,...
                                                        FLFRec_06_Iters,   0.001^2,  Recons_06_PSFIM,10000,...
                                                        size(FLFImg_74_NorCrp,1)/3,1:FLFRec_33_ZdNum, 0);    gpuDevice;
                                                                       U65_Imshow_B16_3DMaxP_Fire(FLFRec_85_CrpNor);
            
            FLFRec_86_FlpNor = flip(rot90(FLFRec_85_CrpNor,3),2);      
           [FLFRec_16_Max_X, FLFRec_16_Max_Y, FLFRec_16_Max_Z] = Q55_Coord_WightCenter(FLFRec_86_FlpNor);
            FLFRec_86_FlpNor = flip(rot90(P38_Volcrop_coordc(...
                                          FLFRec_85_CrpNor,FLFRec_16_Max_X,FLFRec_16_Max_Y,FLFRec_16_Max_Z,...
                                          Recons_13_NumRd,round(Recons_13_NumRd)),3),2);  

            save(                           [Path_s408_FLFLsp,Path_L554_Index ,Data_02_formDt],'RecFLF_85_RecNor','RecFLF_85_FlpNor','-v7.3');
            S65_Imsave_B16_3DMaxP_Fire_File([Path_s408_FLFLsp,Path_L554_Index],Data_01_formIm , FLFRec_86_FlpNor);
            S69_Imsave_B16_3DColC_ColO(     [Path_s408_FLFLsp,Path_L554_Index],Data_01_formIm , FLFRec_86_FlpNor,241,1.5);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FLFM Volume resize and saving                      
            FLFRec_32rZ_Stp = 0.4e-06;
            FLFRec_35rZCoor = FLFRec_31_ZlFOV:FLFRec_32rZ_Stp:FLFRec_31_ZuFOV;
            FLFRec_33rZdNum = ceil( FLFRec_33_ZdNum *FLFPSF_32_Z_Stp/FLFRec_32rZ_Stp);
                                                                       U65_Imshow_B16_3DMaxP_Fire(FLFRec_86_FlpNor);
                                                                       
            FLFRec_96_FlpRez = rescale(imresize(FLFRec_86_FlpNor,Ma_01_obj/Ma_06_FLF));
                                                                       U65_Imshow_B16_3DMaxP_Fire(FLFRec_96_FlpRez);
            
            save(                           [Path_s408_FLFRez,Path_L554_Index ,Data_02_formDt],'RecFLF_89_FlpRez','-v7.3');
            S65_Imsave_B16_3DMaxP_Fire_File([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_FlpRez)
            S69aImsave_B16_3DColC_ColO_File([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_FlpRez,241,1.5);
            disp(['Layer' Path_L554_Index]);
        end
        close all;clc
    otherwise

        for idxsg = 1                                                      % Reconstruction crop range set (Test)       
            FLFimg_09_VidCol = 011;
            FLFImg_41_TlSeg =  000.010;                                        %GET
            FLFImg_41_TuSeg =  006.150;                                        %GET
            FLFImg_42_T_Seg =  1;                                              %GET
           [FLFSeg_48_T_Frm,FLFSeg_43_TdNum,~              ,FLFSeg_44_T_Ind,FLFSeg_45_TCoor] = S02_Coord_Used(...
            FLFImg_41_TlSeg,FLFImg_41_TuSeg,FLFImg_42_T_Seg,FLFImg_44_T_Ind,FLFImg_45_TCoor);
           
            FLFImg_74_NorCrp = single(FLFimg_74cCrpnor);
            FLFImg_74_NorCr1= FLFImg_74_NorCrp.*Recons_51_StpPer;
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Reconstruction parameter set
            Magnify_val = 65535;
            Max_BKG_rat = 0.001^2;
            Image_data  = single( Magnify_val * FLFImg_74_NorCr1);
            
            OTF_N_data  = single( Magnify_val.* FLFPSF_75_OTFun1);
                                                                           clear   FLFPSF_75_OTFun1
            OTF_T_data  = single( Magnify_val.* FLFPSF_75tOTFun1);
                                                                           clear   FLFPSF_75tOTFun1
            Image_size = [size(Image_data,1), size(Image_data,2)];
            PSF__depth =                      size(OTF_N_data,3) ;
            Recon_size = [size(OTF_N_data,1), size(OTF_N_data,2)];
          %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Reconstruction
            for idxt = FLFRec_49_Fram1                                     
                Path_L554_Index  = num2str(FLFSeg_48_T_Frm(idxt),'%05d');
                load([Path_L570_Uni,Path_L554_Index,Data_02_formDt]);
                                                                           U60_Imshow_B16(FLFimg_74cCrpnor(:,:,end));
                FLFImg_74_NorCr1 = single(FLFImg_74_NorCrp.*Recons_51_StpPer);
                                                                           clear RecFLF_84cCrpnor;
                figure,  histogram(FLFImg_74_NorCr1(FLFImg_74_NorCr1>0),200);
                FLFImg_74_CrpNo1 = 0.003;
                FLFImg_75_Denois = FLFImg_74_NorCr1 - FLFImg_74_CrpNo1;    FLFImg_75_Denois(FLFImg_75_Denois<0)=0;
                figure,  histogram(FLFImg_75_Denois(FLFImg_75_Denois>0));  
                                                                           U60_Imshow_B16(FLFImg_75_Denois(:,:,end));
                %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Start APU deconvolution
                        Image_data = gpuArray(single( Magnify_val.*(FLFImg_75_Denois+Max_BKG_rat)));

                disp(['FFT size is '   num2str(Recon_size(1)) 'X' num2str(Recon_size(2))]); 
                disp('Start iteration');

                        FFTPad_Tep = gpuArray.zeros( Recon_size             ,'single');
                        Recon_data = gpuArray.zeros([Image_size, PSF__depth],'single');  
                    for idxk = 1:PSF__depth                                
                        ImgFFT_Pad = FFTPad_Tep;  ImgFFT_Pad( 1:Image_size(1), 1:Image_size(2) ) = Image_data;

                        Recon_temp =         real( ifft2( fft2(ImgFFT_Pad).* OTF_T_data(:,:,idxk) ) ) ;
                        Recon_data( : , : ,idxk) = Recon_temp( 1:Image_size(1), 1:Image_size(2));
                    end
                for idxit = 1:FLFRec_06_Iters                              
                    tic;                                                               % ForwardProject
                        Recon_Proj = gpuArray.zeros( Image_size             ,'single');
                    for idxk = 1:PSF__depth                                           
                        PrjFFT_Pad = FFTPad_Tep;  PrjFFT_Pad( 1:Image_size(1), 1:Image_size(2) ) = Recon_data(:,:,idxk);

                        Prj_SLayer =        real( ifft2( fft2(PrjFFT_Pad).* OTF_N_data(:,:,idxk) ) ) ;
                        Recon_Proj = Recon_Proj + Prj_SLayer( 1:Image_size(1), 1:Image_size(2));
                    end
                                                                                       % BackwardProject
                    for idxk = 1:PSF__depth                                           
                        PrjErr_Pad = FFTPad_Tep;  PrjErr_Pad( 1:Image_size(1), 1:Image_size(2) ) = Image_data./Recon_Proj;

                        Err_SLayer =         real( ifft2( fft2(PrjErr_Pad).* OTF_T_data(:,:,idxk) ) ) ;
                        Recon_data( : , : ,idxk) = Err_SLayer( 1:Image_size(1), 1:Image_size(2)).* Recon_data( : , : ,idxk);
                    end
                        Recon_data(isnan(Recon_data)) = 0;
                    disp(idxit)
                end     
            end
                                                                           U65_Imshow_B16_MIP_3D_Fire(Recon_data);
            FLFRec_85_RecNor = P35_Imgcrop_centerS(gather(Recon_data),FLFRec_53cMdNum);
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_85_RecNor);
            FLFRec_18cX_Ind  = 31:345;                                     disp(length(FLFRec_18cX_Ind));
            FLFRec_28cY_Ind  = 06:320;                                     disp(length(FLFRec_28cY_Ind));
            FLFRec_38cZ_Ind  =(364:834)-363;                               disp(length(FLFRec_38cZ_Ind));
            FLFRec_86_FlpNor = rot90(flip(flip(FLFRec_85_RecNor(FLFRec_28cY_Ind,FLFRec_18cX_Ind,FLFRec_38cZ_Ind),2),1 ),3);
            U65_Imshow_B16_MIP_3D_Fire(   FLFRec_86_FlpNor);

            for idxt = FLFRec_49_Fram2                                     
                Path_L554_Index  = num2str(FLFSeg_48_T_Frm(idxt),'%05d');
                load([Path_L570_Uni,Path_L554_Index,Data_02_formDt]);
                                                                           U60_Imshow_B16(FLFimg_74cCrpnor(:,:,end));
                FLFImg_74_NorCr1 = single(FLFimg_74cCrpnor.*Recons_51_StpPer);
                                                                           clear RecFLF_84cCrpnor;
                figure,  histogram(FLFImg_74_NorCr1(FLFImg_74_NorCr1>0),200);
                FLFImg_74_CrpNo1 = 0.010;
                FLFImg_75_Denois = FLFImg_74_NorCr1 - FLFImg_74_CrpNo1;    FLFImg_75_Denois(FLFImg_75_Denois<0)=0;
                figure,  histogram(FLFImg_75_Denois(FLFImg_75_Denois>0));  
                                                                           U60_Imshow_B16(FLFImg_75_Denois(:,:,end));
                %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Start APU deconvolution
                        Image_data = gpuArray(single( Magnify_val.*(FLFImg_75_Denois+Max_BKG_rat)));

                disp(['FFT size is '   num2str(Recon_size(1)) 'X' num2str(Recon_size(2))]); 
                disp('Start iteration');

                        FFTPad_Tep = gpuArray.zeros( Recon_size             ,'single');
                        Recon_data = gpuArray.zeros([Image_size, PSF__depth],'single');  
                    for idxk = 1:PSF__depth                                
                        ImgFFT_Pad = FFTPad_Tep;  ImgFFT_Pad( 1:Image_size(1), 1:Image_size(2) ) = Image_data;

                        Recon_temp =         real( ifft2( fft2(ImgFFT_Pad).* OTF_T_data(:,:,idxk) ) ) ;
                        Recon_data( : , : ,idxk) = Recon_temp( 1:Image_size(1), 1:Image_size(2));
                    end
                for idxit = 1:FLFRec_06_Iters                              
                    tic;                                                               % ForwardProject
                        Recon_Proj = gpuArray.zeros( Image_size             ,'single');
                    for idxk = 1:PSF__depth                                           
                        PrjFFT_Pad = FFTPad_Tep;  PrjFFT_Pad( 1:Image_size(1), 1:Image_size(2) ) = Recon_data(:,:,idxk);

                        Prj_SLayer =        real( ifft2( fft2(PrjFFT_Pad).* OTF_N_data(:,:,idxk) ) ) ;
                        Recon_Proj = Recon_Proj + Prj_SLayer( 1:Image_size(1), 1:Image_size(2));
                    end
                                                                                       % BackwardProject
                    for idxk = 1:PSF__depth                                           
                        PrjErr_Pad = FFTPad_Tep;  PrjErr_Pad( 1:Image_size(1), 1:Image_size(2) ) = Image_data./Recon_Proj;

                        Err_SLayer =         real( ifft2( fft2(PrjErr_Pad).* OTF_T_data(:,:,idxk) ) ) ;
                        Recon_data( : , : ,idxk) = Err_SLayer( 1:Image_size(1), 1:Image_size(2)).* Recon_data( : , : ,idxk);
                    end
                        Recon_data(isnan(Recon_data)) = 0;
                    disp(idxit)
                end

            end
                                                                           U65_Imshow_B16_MIP_3D_Fire(Recon_data);
            FLFRec_85_RecNor = P35_Imgcrop_centerS(gather(Recon_data),FLFRec_53cMdNum);
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_85_RecNor);
            FLFRec_18cX_Ind  = 31:345;                                     disp(length(FLFRec_18cX_Ind));
            FLFRec_28cY_Ind  = 06:320;                                     disp(length(FLFRec_28cY_Ind));
            FLFRec_38cZ_Ind  =(364:834)-363;                               disp(length(FLFRec_38cZ_Ind));
            FLFRec_86_FlpNor = rot90(flip(flip(FLFRec_85_RecNor(FLFRec_28cY_Ind,FLFRec_18cX_Ind,FLFRec_38cZ_Ind),2),1 ),3);
            U65_Imshow_B16_MIP_3D_Fire(   FLFRec_86_FlpNor);
            close all
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            FLFRec_18cX_Ind  = 31:345;                                     disp(length(FLFRec_18cX_Ind));
            FLFRec_28cY_Ind  = 06:320;                                     disp(length(FLFRec_28cY_Ind));
            FLFPSF_38cZ_Ind  =(364:844)-363;                               disp(length(FLFPSF_38cZ_Ind));
            FLFRec_38cZ_Ind  = 10:(length(FLFPSF_38cZ_Ind)-10);            disp(length(FLFRec_38cZ_Ind));

            FLFPSF_75_OTFun1 = OTF_N_data;                                 
            OTF_N_data = single(FLFPSF_75_OTFun1(:,:,FLFPSF_38cZ_Ind));
            FLFPSF_75tOTFun1 = OTF_T_data;                                 
            OTF_T_data = single(FLFPSF_75tOTFun1(:,:,FLFPSF_38cZ_Ind));
            
            Image_size = [size(Image_data,1), size(Image_data,2)];
            PSF__depth =                      size(OTF_N_data,3) ;
            Recon_size = [size(OTF_N_data,1), size(OTF_N_data,2)];

            for idxt = FLFRec_49_Fram0                                     
                Path_L554_Index  = num2str(FLFSeg_44_T_Ind(idxt),'%05d');
                load([Path_L570_Uni,Path_L554_Index,Data_02_formDt]);
                                                                           U60_Imshow_B16(FLFimg_74cCrpnor(:,:,end));
                FLFImg_74_NorCr1 = single(FLFImg_74_NorCrp.*Recons_51_StpPer);
                                                                           clear RecFLF_84cCrpnor;
                figure,  histogram(FLFImg_74_NorCr1(FLFImg_74_NorCr1>0),200);
                FLFImg_74_CrpNo1 = 0.030;
                FLFImg_75_Denois = FLFImg_74_NorCr1 - FLFImg_74_CrpNo1;    FLFImg_75_Denois(FLFImg_75_Denois<0)=0;
                figure,  histogram(FLFImg_75_Denois(FLFImg_75_Denois>0));
                                                                           U60_Imshow_B16(FLFImg_75_Denois(:,:,end));
                %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Start APU deconvolution
                        Image_data = gpuArray(single( Magnify_val.*(FLFImg_75_Denois+Max_BKG_rat)));

                disp(['FFT size is '   num2str(Recon_size(1)) 'X' num2str(Recon_size(2))]); 
                disp('Start iteration');

                        FFTPad_Tep = gpuArray.zeros( Recon_size             ,'single');
                                                                                       % Inverse PSF
                        Recon_data = gpuArray.zeros([Image_size, PSF__depth],'single');  
                    for idxk = 1:PSF__depth                                           
                        ImgFFT_Pad = FFTPad_Tep;  ImgFFT_Pad( 1:Image_size(1), 1:Image_size(2) ) = Image_data;

                        Recon_temp = gather( real( ifft2( fft2(ImgFFT_Pad).* OTF_T_data(:,:,idxk) ) ) );
                        Recon_data( : , : ,idxk) = Recon_temp( 1:Image_size(1), 1:Image_size(2));
                    end
                for idxit = 1:FLFRec_06_Iters                                         
                    tic;                                                               % ForwardProject
                        Recon_Proj =          zeros( Image_size              ,'single');
                    for idxk = 1:PSF__depth                                           
                        PrjFFT_Pad = FFTPad_Tep;  PrjFFT_Pad( 1:Image_size(1), 1:Image_size(2) ) = Recon_data(:,:,idxk);

                        Prj_SLayer = gather( real( ifft2( fft2(PrjFFT_Pad).* OTF_N_data(:,:,idxk) ) ) );
                        Recon_Proj = Recon_Proj + Prj_SLayer( 1:Image_size(1), 1:Image_size(2));
                    end
                                                                                       % BackwardProject
                    for idxk = 1:PSF__depth                                           
                        PrjErr_Pad = FFTPad_Tep;  PrjErr_Pad( 1:Image_size(1), 1:Image_size(2) ) = Image_data./Recon_Proj;

                        Err_SLayer =       gather( real( ifft2( fft2(PrjErr_Pad).* OTF_T_data(:,:,idxk) ) ) );
                        Recon_data( : , : ,idxk) = Err_SLayer( 1:Image_size(1), 1:Image_size(2)).* Recon_data( : , : ,idxk);
                    end
                        Recon_data(isnan(Recon_data)) = 0;
                    disp(idxit)
                end
            end
                                                                           U65_Imshow_B16_MIP_3D_Fire(Recon_data);
            FLFRec_85_RecNo1 = P35_Imgcrop_centerS(gather(Recon_data),FLFRec_53cMdNum);
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_85_RecNo1);
            FLFRec_86_FlpNo1 = rot90(flip(flip(FLFRec_85_RecNo1(FLFRec_28cY_Ind,FLFRec_18cX_Ind,FLFRec_38cZ_Ind),2),1 ),3);
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_86_FlpNo1);
            FLFPSF_75_OTFun1 = OTF_N_data;
            FLFPSF_75tOTFun1 = OTF_T_data;
            save([Path_s485_FLFLsp,'OTF1',Data_02_formDt],'FLFPSF_75_OTFun1','FLFPSF_75tOTFun1','-v7.3','-nocompression');


            OTF_N_data = single( FLFPSF_75_OTFun2(:,:,FLFPSF_38cZ_Ind).*Magnify_val);
            OTF_T_data = single( FLFPSF_75tOTFun2(:,:,FLFPSF_38cZ_Ind).*Magnify_val);
            
            Image_size = [size(Image_data,1), size(Image_data,2)];
            PSF__depth =                      size(OTF_N_data,3) ;
            Recon_size = [size(OTF_N_data,1), size(OTF_N_data,2)];

            for idxt = FLFRec_49_Fram0                                     
                Path_L554_Index  = num2str(FLFSeg_44_T_Ind(idxt),'%05d');
                load([Path_L570_Uni,Path_L554_Index,Data_02_formDt]);
                                                                           U60_Imshow_B16(FLFimg_74cCrpnor(:,:,end));
                FLFImg_74_NorCr2 = single(FLFImg_74_NorCrp.*Recons_51_StpCro);
                                                                           clear RecFLF_84cCrpnor;
                                                                           U60_Imshow_B16(FLFImg_74_NorCr2(:,:,end));
                figure,  histogram(FLFImg_74_NorCr2(FLFImg_74_NorCr2>0),200);
                FLFImg_74_CrpNo1 = 0.004;
                FLFImg_75_Denois = FLFImg_74_NorCr2 - FLFImg_74_CrpNo1;    FLFImg_75_Denois(FLFImg_75_Denois<0)=0;
                figure,  histogram(FLFImg_75_Denois(FLFImg_75_Denois>0));
                                                                           U60_Imshow_B16(FLFImg_75_Denois(:,:,end));
                %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Start APU deconvolution
                        Image_data = gpuArray(single( Magnify_val.*(FLFImg_75_Denois+Max_BKG_rat)));

                disp(['FFT size is '   num2str(Recon_size(1)) 'X' num2str(Recon_size(2))]); 
                disp('Start iteration');

                        FFTPad_Tep = gpuArray.zeros( Recon_size              ,'single');
                                                                                       % Inverse PSF
                        Recon_data = gpuArray.zeros([Image_size, PSF__depth],'single');  
                    for idxk = 1:PSF__depth                                           
                        ImgFFT_Pad = FFTPad_Tep;  ImgFFT_Pad( 1:Image_size(1), 1:Image_size(2) ) = Image_data;

                        Recon_temp = gather( real( ifft2( fft2(ImgFFT_Pad).* OTF_T_data(:,:,idxk) ) ) );
                        Recon_data( : , : ,idxk) = Recon_temp( 1:Image_size(1), 1:Image_size(2));
                    end
                for idxit = 1:FLFRec_06_Iters                                              
                    tic;                                                               % ForwardProject
                        Recon_Proj =          zeros( Image_size              ,'single');
                    for idxk = 1:PSF__depth                                           
                        PrjFFT_Pad = FFTPad_Tep;  PrjFFT_Pad( 1:Image_size(1), 1:Image_size(2) ) = Recon_data(:,:,idxk);

                        Prj_SLayer = gather( real( ifft2( fft2(PrjFFT_Pad).* OTF_N_data(:,:,idxk) ) ) );
                        Recon_Proj = Recon_Proj + Prj_SLayer( 1:Image_size(1), 1:Image_size(2));
                    end
                                                                                       % BackwardProject
                    for idxk = 1:PSF__depth                                           
                        PrjErr_Pad = FFTPad_Tep;  PrjErr_Pad( 1:Image_size(1), 1:Image_size(2) ) = Image_data./Recon_Proj;

                        Err_SLayer =       gather( real( ifft2( fft2(PrjErr_Pad).* OTF_T_data(:,:,idxk) ) ) );
                        Recon_data( : , : ,idxk) = Err_SLayer( 1:Image_size(1), 1:Image_size(2)).* Recon_data( : , : ,idxk);
                    end
                        Recon_data(isnan(Recon_data)) = 0;
                    disp(idxit)
                end

            end
                                                                           U65_Imshow_B16_MIP_3D_Fire(Recon_data);
            FLFRec_85_RecNo2 = P35_Imgcrop_centerS(gather(Recon_data),FLFRec_53cMdNum);
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_85_RecNo2);
            FLFRec_86_FlpNo2 = rot90(flip(flip(FLFRec_85_RecNo2(FLFRec_28cY_Ind,FLFRec_18cX_Ind,FLFRec_38cZ_Ind),2),1 ),3);
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_86_FlpNo2);

            Path_L554_Index = num2str(FLFSeg_44_T_Ind(FLFRec_49_Fram0),'%05d');
            save([Path_s485_FLFLsp,Path_L554_Index ,Data_02_formDt],'FLFRec_86_FlpNo1','FLFRec_86_FlpNo2','-v7.3');

            FLFRec_96_FlpRe1 = rescale(imresize(FLFRec_86_FlpNo1,Ma_01_obj/Ma_06_FLF));
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_96_FlpRe1);
            FLFRec_96_FlpRe2 = rescale(imresize(FLFRec_86_FlpNo2,Ma_01_obj/Ma_06_FLF));
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_96_FlpRe2);
            FLFRec_96cFlpco1 = U65_Imshow_B16_MIP_3D_Col(FLFRec_96_FlpRe1,022,1.5);
            FLFRec_96cFlpco2 = U65_Imshow_B16_MIP_3D_Col(FLFRec_96_FlpRe2,023,2);
            FLFRec_96cFlpcol = ceil((FLFRec_96cFlpco1 + FLFRec_96cFlpco2)/1.2);
            figure,imshow(FLFRec_96cFlpcol)
            imwrite(FLFRec_96cFlpcol,'test.tif')

            FLFPSF_75_OTFun2 = OTF_N_data;      clear OTF_N_data
            FLFPSF_75tOTFun2 = OTF_T_data;      clear OTF_T_data
            save([Path_s485_FLFLsp,'OTF2',Data_02_formDt],'FLFPSF_75_OTFun2','FLFPSF_75tOTFun2','-v7.3');
        end

        for idxsg = 1                                                      % Reconstruction frame by frame (All)        
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Reconstruction parameter set
            FLFRec_18cX_Ind  = 31:345;                                     disp(length(FLFRec_18cX_Ind));
            FLFRec_28cY_Ind  = 06:320;                                     disp(length(FLFRec_28cY_Ind));
            FLFPSF_38cZ_Ind  =(364:844)-363;                               disp(length(FLFPSF_38cZ_Ind));
            FLFRec_38cZ_Ind  = 10:(length(FLFPSF_38cZ_Ind)-10);            disp(length(FLFRec_38cZ_Ind));
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            FLFImg_41_TlSeg =  000.010;                                        %GET
            FLFImg_41_TuSeg =  006.150;                                        %GET
            FLFImg_42_T_Seg =  1;                                              %GET
           [FLFSeg_48_T_Frm,FLFSeg_43_TdNum,~              ,FLFSeg_44_T_Ind,FLFSeg_45_TCoor] = S02_Coord_Used(...
            FLFImg_41_TlSeg,FLFImg_41_TuSeg,FLFImg_42_T_Seg,FLFImg_44_T_Ind,FLFImg_45_TCoor);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            for idxta = 1                                                  
                Path_L554_Index  = num2str(FLFSeg_44_T_Ind(0001),'%05d');
                load([Path_L570_Uni,Path_L554_Index,Data_02_formDt]);
                                                                           U60_Imshow_B16(FLFimg_74cCrpnor(:,:,end));
                FLFImg_74_NorCrp = single(FLFimg_74cCrpnor);               clear FLFimg_74cCrpnor;
                FLFImg_74_NorCr1 = single(FLFImg_74_NorCrp.*Recons_51_StpPer);
                FLFImg_74_NorCr2 = single(FLFImg_74_NorCrp.*Recons_51_StpCro);
                                                                           clear FLFimg_74cCrpnor;
                                                                           U60_Imshow_B16(FLFImg_74_NorCr1(:,:,end));
                figure,  histogram(FLFImg_74_NorCr1(FLFImg_74_NorCr1>0),200);
                FLFImg_74_CrpNo1 = 0.01;
                FLFImg_75_Denois = FLFImg_74_NorCr1 - FLFImg_74_CrpNo1;    FLFImg_75_Denois(FLFImg_75_Denois<0)=0;
                                                                           U60_Imshow_B16(FLFImg_75_Denois(:,:,end));
                figure,  histogram(FLFImg_75_Denois(FLFImg_75_Denois>0));

                                                                           U60_Imshow_B16(FLFImg_74_NorCr2(:,:,end));
                figure,  histogram(FLFImg_74_NorCr2(FLFImg_74_NorCr2>0),200);
                FLFImg_74_CrpNo2 = 0.004;
                FLFImg_75_Denois = FLFImg_74_NorCr2 - FLFImg_74_CrpNo2;    FLFImg_75_Denois(FLFImg_75_Denois<0)=0;
                                                                           U60_Imshow_B16(FLFImg_75_Denois(:,:,end));
                figure,  histogram(FLFImg_75_Denois(FLFImg_75_Denois>0));

                Magnify_val     = 65535;
                Max_BKG_rat     = 0.001^2;
            end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Reconstruction frame by frame (All) 
            if ~(exist('FLFPSF_75_OTFun1','var')&&exist('FLFPSF_75tOTFun1','var')) 
                load([Path_s485_FLFLsp,'OTF1',Data_02_formDt],'FLFPSF_75_OTFun1','FLFPSF_75tOTFun1');
            end

                Image_data = gpuArray(FLFImg_75_Denois);
                OTF_N_data = gpuArray(FLFPSF_75_OTFun1);
%                 OTF_T_data = gpuArray(FLFPSF_75tOTFun1);
                OTF_T_data = FLFPSF_75tOTFun1;
                
                Image_size = [size(Image_data,1), size(Image_data,2)];
                PSF__depth =                      size(OTF_N_data,3) ;
                Recon_size = [size(OTF_N_data,1), size(OTF_N_data,2)];
                disp(['FFT size is ' num2str(Recon_size(1)) 'X' num2str(Recon_size(2))]); 

            for idxt = 0001:FLFSeg_43_TdNum                                
                Path_L554_Index = num2str(FLFSeg_44_T_Ind(idxt),'%05d');
                load([Path_L570_Uni,Path_L554_Index,Data_02_formDt]);
%                                                                            U60_Imshow_B16(FLFimg_74cCrpnor(:,:,end));
                FLFImg_74_NorCrp = single(FLFimg_74cCrpnor);               clear FLFimg_74cCrpnor;
                FLFImg_74_NorCr1 = single(FLFImg_74_NorCrp.*Recons_51_StpPer);
                                                                           clear FLFimg_74cCrpnor;
                FLFImg_75_Denois = FLFImg_74_NorCr1 - FLFImg_74_CrpNo1;    FLFImg_75_Denois(FLFImg_75_Denois<0)=0;
             %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Start APU deconvolution
%                                                                            U60_Imshow_B16(FLFImg_75_Denois(:,:,end));
                disp(['FFT size is '   num2str(Recon_size(1)) 'X' num2str(Recon_size(2))]); 
                disp('Start iteration');
                
                        Image_data = gpuArray(single( Magnify_val.*(FLFImg_75_Denois+Max_BKG_rat)));
                        FFTPad_Tep = gpuArray.zeros( Recon_size             ,'single');
                        Recon_data = gpuArray.zeros([Image_size, PSF__depth],'single'); 
                    for idxk = 1:PSF__depth                                % Inverse PSF
                        ImgFFT_Pad = FFTPad_Tep;  ImgFFT_Pad( 1:Image_size(1), 1:Image_size(2) ) = Image_data;

                        Recon_temp =         real( ifft2( fft2(ImgFFT_Pad).* OTF_T_data(:,:,idxk) ) ) ;
                        Recon_data( : , : ,idxk) = Recon_temp( 1:Image_size(1), 1:Image_size(2));
                    end
                for idxit = 1:FLFRec_06_Iters                                           
                    tic;                                                   % ForwardProject
                        Recon_Proj = gpuArray.zeros( Image_size             ,'single');
                    for idxk = 1:PSF__depth                                           
                        PrjFFT_Pad = FFTPad_Tep;  PrjFFT_Pad( 1:Image_size(1), 1:Image_size(2) ) = Recon_data(:,:,idxk);

                        Prj_SLayer =        real( ifft2( fft2(PrjFFT_Pad).* OTF_N_data(:,:,idxk) ) ) ;
                        Recon_Proj = Recon_Proj + Prj_SLayer( 1:Image_size(1), 1:Image_size(2));
                    end
                                                                           % BackwardProject
                    for idxk = 1:PSF__depth                                           
                        PrjErr_Pad = FFTPad_Tep;  PrjErr_Pad( 1:Image_size(1), 1:Image_size(2) ) = Image_data./Recon_Proj;

                        Err_SLayer =         real( ifft2( fft2(PrjErr_Pad).* OTF_T_data(:,:,idxk) ) ) ;
                        Recon_data( : , : ,idxk) = Err_SLayer( 1:Image_size(1), 1:Image_size(2)).* Recon_data( : , : ,idxk);
                    end
                        Recon_data(isnan(Recon_data)) = 0;
                    disp(idxit)
                end
                FLFRec_86_FlpNo1 = rot90(flip(flip(Recon_data( FLFRec_28cY_Ind+FLFRec_53cMdNum,...
                                                               FLFRec_18cX_Ind+FLFRec_53cMdNum,FLFRec_38cZ_Ind),2),1),3);
%                     U65_Imshow_B16_MIP_3D_Fire(   FLFRec_86_FlpNo1);
                save([Path_s485_FLFLsp,Path_L554_Index,'P',Data_02_formDt],'FLFRec_86_FlpNo1','-v7.3');
                disp(idxt)
                close all
            end
            clear OTF_N_data OTF_T_data
            
        end
    end
        
    for idxsg = 1                                                          % Video made for reconstruction              
        for idxt = FLFRec_49_Fram0                                         % Video legend set                
            FLFimg_09_VidCol = 'fire';
            FLFImg_41_TlSeg =  000.010;                                        %GET
            FLFImg_41_TuSeg =  006.150;                                        %GET
            FLFImg_42_T_Seg =  1;                                              %GET
           [FLFSeg_48_T_Frm,FLFSeg_43_TdNum,~              ,FLFSeg_44_T_Ind,FLFSeg_45_TCoor] = S02_Coord_Used(...
            FLFImg_41_TlSeg,FLFImg_41_TuSeg,FLFImg_42_T_Seg,FLFImg_44_T_Ind,FLFImg_45_TCoor);
            Text_s554TimeInd = [num2str(FLFImg_41_TlSeg),File_00_Line,...
                                num2str(FLFImg_41_TuSeg)];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            Path_L554_Index  = num2str(FLFSeg_44_T_Ind(FLFRec_49_Fram0),'%05d');
            load([Path_s485_FLFLsp,Path_L554_Index,'P',Data_02_formDt],'FLFRec_86_FlpNo1');

            FLFRec_88cFlpRe1 = imresize(gather(FLFRec_86_FlpNo1),Ma_01_obj/Ma_06_FLF/FLFRec_32_Z_Seg);

            FLFRec_88_MIPco1 = U55_Imshow_B08_MIP_3D_Col(FLFRec_88cFlpRe1,022,2,1);
            RecFLF_89_MIP3Dt = FLFRec_88_MIPco1;
            figure,imshow(RecFLF_89_MIP3Dt)
            tic
        end

        for idxt = 1                                                       % Video legend set                
            Fond_Size = 030;
            clear RecFLF_96_MIP3DmvL

            Fig_Txlft = 0021;           Fig_Frlft = 0575;
            Fig_Txtop = 0005;           Fig_Frtop = 0005;

            Fig_XYlft = 0580;           Fig_XYtop = 0630;
            Fig_Rshoz = 0575;           Fig_YZtop = 0630;

            Fig_YZlft = 1060;           Fig_RsVet = 0675;
            Fig_Zshoz = 1075;           Fig_ZsVet = 0675;

            Fig_SCwid = 010;
            Fig_XYlen = 100;
            Fig_YZlen = 050;
            Fig_XYpix = Pi_05_cam/Ma_01_obj*FLFRec_32_Z_Seg*1e6;
            Fig_YZpix =     FLFPSF_32_Z_Stp*FLFRec_32_Z_Seg*1e6;

            Fig_Title = '';
            Fig_XYscT = [num2str(Fig_XYlen) native2unicode([hex2dec('CE') hex2dec('BC')], 'UTF-8') 'm'];
            Fig_YZscT = [num2str(Fig_YZlen) native2unicode([hex2dec('CE') hex2dec('BC')], 'UTF-8') 'm'];

            Fig_TimeT = [num2str(FLFSeg_45_TCoor(FLFRec_49_Fram0),'%.2f'),'s'];

            RecFLF_96_MIP3DmvL = RecFLF_89_MIP3Dt;
            RecFLF_96_MIP3DmvL = insertText(RecFLF_96_MIP3DmvL,...
                [Fig_Txlft,Fig_Txtop],Fig_Title,'Font','Arial Bold','BoxOpacity',0,'FontSize',Fond_Size,'TextColor','white');
            RecFLF_96_MIP3DmvL = insertText(RecFLF_96_MIP3DmvL,...
                [Fig_Frlft,Fig_Frtop],Fig_TimeT,'Font','Arial Bold','BoxOpacity',0,'FontSize',Fond_Size,'TextColor','white');
            RecFLF_96_MIP3DmvL = insertText(RecFLF_96_MIP3DmvL,...
                [Fig_XYlft,Fig_XYtop],Fig_XYscT,'Font','Arial Bold','BoxOpacity',0,'FontSize',Fond_Size,'TextColor','white');
            RecFLF_96_MIP3DmvL = insertText(RecFLF_96_MIP3DmvL,...
                [Fig_YZlft,Fig_YZtop],Fig_YZscT,'Font','Arial Bold','BoxOpacity',0,'FontSize',Fond_Size,'TextColor','white');
            RecFLF_96_MIP3DmvL(Fig_RsVet+(1:Fig_SCwid),Fig_Rshoz+(1:round(Fig_XYlen/Fig_XYpix)),:,:) = 255;
            RecFLF_96_MIP3DmvL(Fig_ZsVet+(1:Fig_SCwid),Fig_Zshoz+(1:round(Fig_YZlen/Fig_YZpix)),:,:) = 255;
            figure,imshow(RecFLF_96_MIP3DmvL);
        end
            close all;


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3D MIP Video made (Entire and cropped)
            RecFLF_89_MIP3Dmv = zeros([size(RecFLF_89_MIP3Dt),FLFSeg_43_TdNum],'uint8');
        for idxt = 1:FLFSeg_43_TdNum                                       % 3DMIP    Video made             
            Path_L554_Index  = num2str(FLFSeg_44_T_Ind(idxt),'%05d');
            load([Path_s485_FLFLsp,Path_L554_Index,'P',Data_02_formDt],'FLFRec_86_FlpNo1');

            FLFRec_88cFlpRe1 = imresize(gather(FLFRec_86_FlpNo1),Ma_01_obj/Ma_06_FLF/FLFRec_32_Z_Seg);

            FLFRec_88_MIPco1 = U55_Imshow_B08_MIP_3D_Col(FLFRec_88cFlpRe1,022,3,0);
            RecFLF_89_MIP3Dmv(:,:,:,idxt) = FLFRec_88_MIPco1;

            disp(idxt);                                                close all;
        end
            save(          [Path_s487_FLFRez,Text_s554MIP3Dmv,    Text_s554TimeInd ,Data_02_formDt],'RecFLF_89_MIP3Dmv','-v7.3');
            T35_Vdsave_B08([Path_s487_FLFRez,Text_s554MIP3Dmv,    Text_s554TimeInd],Data_01_formVd,  RecFLF_89_MIP3Dmv ,100    );

            RecFLF_88_MIP3DmvL = RecFLF_89_MIP3Dmv;
            RecFLF_88_MIP3DmvL(Fig_RsVet+(1:Fig_SCwid),Fig_Rshoz+(1:round(Fig_XYlen/Fig_XYpix)),:,:) = 255;
            RecFLF_88_MIP3DmvL(Fig_ZsVet+(1:Fig_SCwid),Fig_Zshoz+(1:round(Fig_YZlen/Fig_YZpix)),:,:) = 255;
            figure,imshow(RecFLF_88_MIP3DmvL(:,:,:,0001));
            figure,imshow(RecFLF_88_MIP3DmvL(:,:,:,end ));
        for idxt = 1:FLFSeg_43_TdNum                                       % 3DMIP Video legend make       
            Fig_TimeT = [num2str(FLFSeg_45_TCoor(idxt),'%.2f'),'s'];
            RecFLF_88_MIP3DmvL(:,:,:,idxt) = insertText(RecFLF_88_MIP3DmvL(:,:,:,idxt),...
                [Fig_Txlft,Fig_Txtop],Fig_Title,'Font','Arial Bold','BoxOpacity',0,'FontSize',Fond_Size,'TextColor','white');
            RecFLF_88_MIP3DmvL(:,:,:,idxt) = insertText(RecFLF_88_MIP3DmvL(:,:,:,idxt),...
                [Fig_Frlft,Fig_Frtop],Fig_TimeT,'Font','Arial Bold','BoxOpacity',0,'FontSize',Fond_Size,'TextColor','white');
            RecFLF_88_MIP3DmvL(:,:,:,idxt) = insertText(RecFLF_88_MIP3DmvL(:,:,:,idxt),...
                [Fig_XYlft,Fig_XYtop],Fig_XYscT,'Font','Arial Bold','BoxOpacity',0,'FontSize',Fond_Size,'TextColor','white');
            RecFLF_88_MIP3DmvL(:,:,:,idxt) = insertText(RecFLF_88_MIP3DmvL(:,:,:,idxt),...
                [Fig_YZlft,Fig_YZtop],Fig_YZscT,'Font','Arial Bold','BoxOpacity',0,'FontSize',Fond_Size,'TextColor','white');
            disp(idxt)
        end
            figure,imshow(RecFLF_88_MIP3DmvL(:,:,:,end));
            
            clear RecFLF_89_MIP3Dmv;
            save(          [Path_s487_FLFRez,Text_s554MIP3DmL,Text_s554TimeInd ,Data_02_formDt],'RecFLF_88_MIP3DmvL','-v7.3');
            T35_Vdsave_B08([Path_s487_FLFRez,Text_s554MIP3DmL,Text_s554TimeInd],Data_01_formVd , RecFLF_88_MIP3DmvL ,100    );
    end    
    clear RecFLF_88_MIP3DmvL;



    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    