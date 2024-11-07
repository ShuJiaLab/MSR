function Rec_02_norm = N36_DeconvRL_3D_GPU_lite_FLFM( OTF_0N_data, OTF_0T_data, Img_00_data,...
                                                      Rec_maxIter, Crop_R_size, Crop_ZIndex,...
                                                      Max_BKG_rat, Magnify_val, flagtest)
                                                                 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     From N35_DeconvRL_3D_GPU_lite to N36_DeconvRL_3D_GPU_lite_FLFM
    %     1, Delete input variables PSF_03_size;
    %     2, Let PSF_03_size to be equal to Img_03_size, 
    %        which may only be adaptable to FLFM
    %     3, Let Rec_04_size to be equal to size(OTF_0N_data,1:2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     Two sub functions are used: 
    %     Iteration_show
    %     Volcrop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     PSF_0N_data = single(RecFLF_64_PSFcrp);
    %     PSF_0T_data = single(RecFLF_64TPSFcrp);
    %     Img_00_data = single(RecFLF_84_crpnor(:,:,idxt))*65535;
    %     maxIter     = 10;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    OTF_0N_data = gpuArray( single( Magnify_val * OTF_0N_data)             );
    OTF_0T_data = gpuArray( single( Magnify_val * OTF_0T_data)             );
    Img_00_data = gpuArray( single( Magnify_val *(Img_00_data+Max_BKG_rat)));
    
    Img_03_size = [size(Img_00_data,1), size(Img_00_data,2)];
    PSF_03depth =                       size(OTF_0N_data,3) ;
    Rec_03_size = [size(OTF_0N_data,1), size(OTF_0N_data,2)];
    
    disp(['FFT size is '     num2str(Rec_03_size(1)) 'X' num2str(Rec_03_size(2))]); 
            
    disp('Start iteration');
    
        time_sum    = 0;
        
            Pad_00_Temp   = gpuArray.zeros( Rec_03_size              ,'single');
            
            Rec_00_data   = gpuArray.zeros([Img_03_size, PSF_03depth],'single');  % Inverse PSF
        for idxk = 1:PSF_03depth                                      
            Img_00_Pad0 = Pad_00_Temp;  Img_00_Pad0( 1:Img_03_size(1), 1:Img_03_size(2) ) = Img_00_data;
            
            Rec_00_temp               = real( ifft2( fft2(Img_00_Pad0).* OTF_0T_data(:,:,idxk) ) );
            Rec_00_data( : , : ,idxk) = Rec_00_temp( 1:Img_03_size(1), 1:Img_03_size(2));
        end
            
	for idxit = 1:Rec_maxIter                                              
    	tic;
            Rec_01_Proj   = gpuArray.zeros( Img_03_size              ,'single');   % ForwardProject
        for idxk = 1:PSF_03depth                                           
            Prj_00_Pad0 = Pad_00_Temp;  Prj_00_Pad0( 1:Img_03_size(1), 1:Img_03_size(2) ) = Rec_00_data(:,:,idxk);
            
            Prj_00_temp               = real( ifft2( fft2(Prj_00_Pad0).* OTF_0N_data(:,:,idxk)));
            Rec_01_Proj = Rec_01_Proj + Prj_00_temp( 1:Img_03_size(1), 1:Img_03_size(2));
        end
                    
            Prj_Er_Pad0 = Pad_00_Temp;  Prj_Er_Pad0( 1:Img_03_size(1), 1:Img_03_size(2) ) = Img_00_data./Rec_01_Proj;
            
        for idxk = 1:PSF_03depth                                                   % BackwardProject
            Err_00_temp               = real( ifft2( fft2(Prj_Er_Pad0).* OTF_0T_data(:,:,idxk)));
            Rec_00_data( : , : ,idxk) = Err_00_temp( 1:Img_03_size(1), 1:Img_03_size(2)).* Rec_00_data( : , : ,idxk);
        end
            Rec_00_data(isnan(Rec_00_data)) = 0;
        
        ttime       = toc;
        time_sum    = ttime + time_sum;
        Iteration_show(idxit,Rec_maxIter,ttime,time_sum,Img_00_data./Rec_01_Proj,flagtest);
    end
    
	Rec_02_norm = rescale( Volcrop(gather(Rec_00_data), Crop_R_size, Crop_ZIndex) );
    
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function [] = Iteration_show(Iter,MaxIter,Iter_time,Tims_sum,cal_error,Flagtest)
        if(Flagtest==1)
            disp(['  iter ' num2str(Iter) ' | ' num2str(MaxIter) ', took ' num2str(Iter_time) ' secs']);
            disp(['RL1.0 Have taken '                                      num2str(Tims_sum)  ' secs']);

            Error = log10(sum(abs(cal_error(:)))/length(cal_error(:)));
            figure(9999);plot(Iter ,Error ,'r*');
            hold on;
        else
            disp(['  iter ' num2str(Iter) ' | ' num2str(MaxIter) ', is completed. ']);
        end
    end
        
    function Image = Volcrop(Input,Side_Long,index_dep)                    
    %  Embedded the input into a black background.
    %  The size of the imput is larger than. 
    %  the size of the background.
    %  This is the test
    % 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  for a = 6:7
    %      for b = 2:3
    %          tst0 = 1:a;
    %          Imput = repmat(tst0'*tst0,[1,1,3]);          disp(Imput)
    %          Image = P36_Volcrop_center(Imput,b,b,1:2);   disp(Image)
    %      end
    %  end
    %  Input = Imput;
    %  Hight_new = b
    %  Width_new = b
    %  index_dep = 1:2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Size_old = [size( Input,1  ), size( Input,2  ), size( Input,3  )];
        Size_new = [round(Side_Long), round(Side_Long),length(index_dep)];
        if( Size_old(1) < Size_new(1) || Size_old(2) < Size_new(2) || Size_old(3) < Size_new(3) )
            error('Wrong use of the function!!!!!!!');
        end

        disp(['A Volume of size: ', num2str(Size_new(1),'%.0f'), ' X ', num2str(Size_new(2),'%.0f'), ' X ', num2str(Size_new(3),'%.0f'),...
              ' is cropped from '  ,...
              'a Volume of size: ', num2str(Size_old(1),'%.0f'), ' X ', num2str(Size_old(2),'%.0f'), ' X ', num2str(Size_old(3),'%.0f')])

        IndexIni = ceil(Size_old(1:2)/2) - floor((Size_new(1:2)-1)/2) - 1;

        Image = Input(  IndexIni(1) + ( 1 :  Size_new(1) ) , ...
                        IndexIni(2) + ( 1 :  Size_new(2) ) , index_dep);
    end
end