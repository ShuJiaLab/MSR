function [] = S60_Imsave_B16_Nor_Col(Image_Path,Image_form,Image_data,Index_Col,Flag_File)
% Data_10_File  = File_42_FLF_Fixexp_Proc
% Data_11_strhd = FLFPSF_48_fix_strhd
% Data_11_strtl = FLFPSF_48_fix_strtl
% Data_13_FOVZu = +0*10^-6
% Data_13_FOVZl = -0*10^-6
% Data_14_STP_Z = 1.0*10^-6
% Data_12_dzstr = Recons_07_dzstr
% Data_12_zcstr = Recons_07_zcstr
% Data_19_form  = Data_01_formIm

   [Color_bt16,Color_bar,ColorTest] = U06_Color_B16(Index_Col);
    Image_bt16 = uint16(rescale(Image_data,0,65535));
    
    Save_Path = [Image_Path,'_Nor',num2str(ColorTest)];
        
    if (Flag_File)
        mkdir(Save_Path);
        for idxk = 1 : size(Image_data,3)         
            imwrite(ind2rgb(Image_bt16(:,:,idxk),Color_bt16),[Save_Path ,'\','col',num2str(idxk,'%03d'),Image_form]);
            imwrite(        Image_bt16(:,:,idxk)            ,[Save_Path ,'\','Ind',num2str(idxk,'%03d'),Image_form]);
        end
            imwrite(        Color_bar                       ,[Save_Path ,'\','Map'                     ,Image_form]);
    else
        for idxk = 1 : size(Image_data,3)
            imwrite(ind2rgb(Image_bt16(:,:,idxk),Color_bt16),[Save_Path,'_','col'                      ,Image_form],'WriteMode','append');
            imwrite(        Image_bt16(:,:,idxk)            ,[Save_Path,'_','Ind'                      ,Image_form],'WriteMode','append');
            imwrite(        Color_bar                       ,[Save_Path,'_','Map'                      ,Image_form]);
        end
    end
end




























