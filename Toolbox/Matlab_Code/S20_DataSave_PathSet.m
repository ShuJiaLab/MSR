function[Path_s200_update,Path_s204_unifor,Path_s201_unifor,...
         Path_s400_update,Path_s401_unifor,Path_s404_unifor,...
         Path_s41o_FLFCrp,Path_s41p_FLFRez,Path_s41q_WFMPSF,Path_s41rsWFMPSF,Path_s41s_Hybper,...
         Path_s270_WFMImg,Path_s275_WFMdec,Path_s276_WFMreg,Path_s277_WFMcmp,...
         Path_s278_WFMcmp,...
         Path_s470_Object,Path_s472_Objnor,Path_s472_Objb16,Path_s474_ObjCrp,Path_s477_Objrez,...
         Path_s460_FLFSub,Path_s485_FLFLsp,Path_s486_FLFNor,Path_s487_FLFRez,...
         Path_s495_FLFHsp,...
         Path_s4a0_HybImg,Path_s4b0_HydImg,Path_s4c0_Hydae8,Path_s4d0_Hydpe4,...
         Path_s40y_Profil,Path_s40z_Analys,...
         Text_s401Rescale,Text_s402Cropped,...
         Text_s554MIP3Dmv,Text_s554MIP3DmL,Text_s557MIP3Dmp,...
         Text_s554_MIPCro,Path_s554lMIPCro,...
         Text_s556_PtsAll,Text_s556_BoxReg,Text_s557_DataSV,Text_s558_T_Disp,Text_s559_T_CaTr...
         ] = S20_DataSave_PathSet(         ...
         Path_s010_ObjLam,Path_s020_FouLFM,Path_s021_MLALFM,WFMImg_01_Flag,...
         Path_s011Lsample,Path_s033Lsample,Path_s090_IterPW,FLFImg_01_Flag,...
         File_14_WFMPSF_SimRec,File_15_WFMPSF_ExpRec,File_24_WFMImg_SimRec,File_25_WFMImg_ExpRec,...
         File_34_FLFPSF_SimRec,File_35_FLFPSF_ExpRec,File_44_FLFImg_SimRec,...
         File_45_FLFImg_ExpRec,File_54_FLFVid_SimRec,File_55_FLFVid_ExpRec)

        switch WFMImg_01_Flag
            case 14
                    path_s002_FileSV = File_14_WFMPSF_SimRec;
            case 15
                    path_s002_FileSV = File_15_WFMPSF_ExpRec;
            case 24
                    path_s002_FileSV = File_24_WFMImg_SimRec;
            case 25
                    path_s002_FileSV = File_25_WFMImg_ExpRec;
            otherwise
        end
        switch FLFImg_01_Flag
            case 21                                                        
                    path_s004_FileSV = File_34_FLFPSF_SimRec;
            case 35                                                        
                    path_s004_FileSV = File_35_FLFPSF_ExpRec;
            case 44                                                        
                    path_s004_FileSV = File_44_FLFImg_SimRec;
            case 46                                                        
                    path_s004_FileSV = File_44_FLFImg_SimRec;
            case 45                                                        
                    path_s004_FileSV = File_45_FLFImg_ExpRec;
            case 47                                                        
                    path_s004_FileSV = File_45_FLFImg_ExpRec;
            case 54                                                        
                    path_s004_FileSV = File_54_FLFVid_SimRec;
            case 56                                                        
                    path_s004_FileSV = File_54_FLFVid_SimRec;
            case 55                                                        
                    path_s004_FileSV = File_55_FLFVid_ExpRec;
            case 57                                                        
                    path_s004_FileSV = File_55_FLFVid_ExpRec;
            otherwise
        end


        Path_s000neotime = char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'));
        Path_s200_update = [path_s002_FileSV,Path_s000neotime,'\']; mkdir(Path_s200_update);
        Path_s400_update = [path_s004_FileSV,Path_s000neotime,'\']; mkdir(Path_s400_update);
        Path_s201_unifor = ['WFM',...
                            Path_s010_ObjLam,                 '_',Path_s011Lsample];
        Path_s401_unifor = [Path_s020_FouLFM,Path_s021_MLALFM,'_',Path_s033Lsample];
        Path_s204_unifor = [Path_s010_ObjLam,                 '_',Path_s011Lsample,Path_s090_IterPW];
        Path_s404_unifor = [Path_s020_FouLFM,Path_s021_MLALFM,'_',Path_s033Lsample,Path_s090_IterPW];
        
        Path_s41o_FLFCrp = [Path_s400_update,Path_s201_unifor,'_','o_FLFCrp'];
        Path_s41p_FLFRez = [Path_s400_update,Path_s201_unifor,'_','p_FLFRez'];
        Path_s41q_WFMPSF = [Path_s400_update,Path_s201_unifor,'_','q_WFMPSF'];
        Path_s41rsWFMPSF = [Path_s400_update,Path_s201_unifor,'_','rsWFMPSF'];
        Path_s41s_Hybper = [Path_s400_update,Path_s201_unifor,'_','s_Hybper'];
        
        Path_s270_WFMImg = [Path_s200_update,Path_s201_unifor,'_','7_WFMImg'];
        Path_s275_WFMdec = [Path_s200_update,Path_s204_unifor,'_','7_WFMdec'];
        Path_s276_WFMreg = [Path_s200_update,Path_s201_unifor,'_','7_WFMreg'];
        Path_s277_WFMcmp = [Path_s200_update,Path_s201_unifor,'_','7_WFMcmp'];
        Path_s278_WFMcmp = [Path_s200_update,Path_s204_unifor,'_','7dWFMcmp'];
        
        Path_s470_Object = [Path_s400_update,Path_s401_unifor,'_','7_Ground'];
        Path_s472_Objnor = [Path_s400_update,Path_s401_unifor,'_','7_Objnor'];
        Path_s472_Objb16 = [Path_s400_update,Path_s401_unifor,'_','7_Objb16'];
        Path_s474_ObjCrp = [Path_s400_update,Path_s401_unifor,'_','7_ObjCrp'];
        Path_s477_Objrez = [Path_s400_update,Path_s401_unifor,'_','7_Objrez'];

        Path_s460_FLFSub = [Path_s400_update,Path_s401_unifor,'_','6_FLFSub'];
        Path_s485_FLFLsp = [Path_s400_update,Path_s404_unifor,'_','8_FLFLsp'];
        Path_s486_FLFNor = [Path_s400_update,Path_s404_unifor,'_','8_FLFNor'];
        Path_s487_FLFRez = [Path_s400_update,Path_s404_unifor,'_','8_FLFRez'];
        Path_s495_FLFHsp = [Path_s400_update,Path_s404_unifor,'_','9_FLFHsp'];
        Path_s4a0_HybImg = [Path_s400_update,Path_s404_unifor,'_','a_HybImg'];
        Path_s4b0_HydImg = [Path_s400_update,Path_s404_unifor,'_','b_HydImg'];
        Path_s4c0_Hydae8 = [Path_s400_update,Path_s404_unifor,'_','c_Hydae8'];
        Path_s4d0_Hydpe4 = [Path_s400_update,Path_s404_unifor,'_','d_Hydpe4'];
        
        Path_s40y_Profil = [Path_s400_update,Path_s020_FouLFM,'_','y_Profil'];
        Path_s40z_Analys = [Path_s400_update,Path_s020_FouLFM,'_','z_Analys'];
        
        Text_s401Rescale = '_Res';
        Text_s402Cropped = '_crp';
        Text_s554MIP3Dmv = 'MIP3Dmv';
        Text_s554MIP3DmL = 'MIP3DmvL';
        Text_s557MIP3Dmp = 'MIP3DmvP';
        Text_s554_MIPCro = 'MIPCrmv';
        Path_s554lMIPCro = 'MIPCrmvL';

        Text_s556_PtsAll = 'All';
        Text_s556_BoxReg = 'Box';
        Text_s557_DataSV = 'Data';
        Text_s558_T_Disp = 'DisT';
        Text_s559_T_CaTr = 'IntT';
end





























