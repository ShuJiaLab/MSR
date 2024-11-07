function S27_DataSave_MOV_6DCP( File_56_FLFVid_ExpPro                       , ...
                                Data_01_formIm,Data_02_formDt,FLFsub_num_dia, ...
                                Load_Index_Ini,Load_Index_End,Load_Index_Seg, ...
                                Save_PeroidIni,Save_PeroidEnd,Save_PeroidSeg, ...
                                FLF_Load_FrameRate           ,FLFSub_rad,PCA_Sparsity, ...
                                LoadSuffi0,LoadSuffix,SaveSuffix,SaveSuffi1,SaveSuffi2,GroupName)
% Difference from 
% LoadSuffi0 = File_0i_Crp;
% LoadSuffix = File_0k_Dns;
% SaveSuffix = File_0o_DCP;
% GroupName  = FLF_ExpVid_GrpName(idxfl==EXP_group,:);
% FLFsub_num_dia = Recons_43_NumEd;
% FLFSub_rad = FLF_ExpSub_crp_rad(idxfl);
% Load_Index_Ini = FLF_Load_SparseIni;
% Load_Index_End = FLF_Load_SparseEnd;
% Load_Index_Seg = FLF_Load_SparseSeg;
% Save_PeroidIni = FLF_Save_SparseIni;
% Save_PeroidEnd = FLF_Save_SparseEnd;
% Save_PeroidSeg = FLF_Save_SparseSeg;
% PCA_Sparsity   = 3; 
% SaveSuffi1 = File_0p_DCP;
% SaveSuffi2 = File_0q_DCP;
    tic
    for idxsg = 1                                                          % FLFimg read and save name set    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load and save path name set        
        if(isempty(SaveSuffix))
            SaveSuffix = char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'));
        end
        PCA_num = num2str(PCA_Sparsity);
        Loadpath_Uni0 = [File_56_FLFVid_ExpPro,GroupName,LoadSuffi0,        '\','FLF_ExpImg'];
        Loadpath_UniN = [File_56_FLFVid_ExpPro,GroupName,LoadSuffix,        '\','FLF_ExpImg'];
        Savepath_UniN = [File_56_FLFVid_ExpPro,GroupName,SaveSuffix,PCA_num,'\','FLF_ExpImg'];
        Savepath_UniL = [File_56_FLFVid_ExpPro,GroupName,SaveSuffi1,PCA_num,'\','FLF_ExpImg'];
        Savepath_UniS = [File_56_FLFVid_ExpPro,GroupName,SaveSuffi2,PCA_num,'\','FLF_ExpImg'];
                  mkdir([File_56_FLFVid_ExpPro,GroupName,SaveSuffix,PCA_num])
                  mkdir([File_56_FLFVid_ExpPro,GroupName,SaveSuffi1,PCA_num])
                  mkdir([File_56_FLFVid_ExpPro,GroupName,SaveSuffi2,PCA_num])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load and save Index set
        load([Loadpath_Uni0,'Systole_Pts.mat'],'Systole_Pts','diastolePts');
%         Peroids_PtsTep =sort([Systole_Pts;diastolePts]);
        Peroids_PtsTep = Systole_Pts;
        Peroids_PtsUse = Peroids_PtsTep((Save_PeroidIni<Systole_Pts)&(Systole_Pts<Save_PeroidEnd));
        
        Save_Index_Ini = Peroids_PtsUse(1);
        Save_Index_End = Peroids_PtsUse(end)-1;
        Save_Index_Seg = Save_PeroidSeg;

        LoadnameDepth =[num2str(Load_Index_Ini*FLF_Load_FrameRate),'-',...
                        num2str(Load_Index_End*FLF_Load_FrameRate),'-',...
                        num2str(Load_Index_Seg*FLF_Load_FrameRate),'s'];
        SavenameDepth =[num2str(Save_Index_Ini*FLF_Load_FrameRate),'-',...
                        num2str(Save_Index_End*FLF_Load_FrameRate),'-',...
                        num2str(Save_Index_Seg*FLF_Load_FrameRate),'s'];
        Save_FrameNum = length( Save_Index_Ini:Save_Index_Seg:Save_Index_End);  

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Decompose parameter set
        FLFsub_num = FLFsub_num_dia^2;
        FLFSub_dia = FLFSub_rad*2+1;
        FLFSub_len = FLFSub_dia^2;

        % index of nine elements
        Ay_i = reshape(kron((1:FLFsub_num_dia) ,ones(FLFsub_num_dia,1)),[1 FLFsub_num]);
        Ax_i = reshape(kron((1:FLFsub_num_dia)',ones(1,FLFsub_num_dia)),[1 FLFsub_num]);
%          ind  = reshape([1:FLFsub_num],[FLFsub_num_dia FLFsub_num_dia])';
        
        Coord_xl = (Ax_i-1)*FLFSub_dia + 1;
        Coord_xu = (Ax_i-1)*FLFSub_dia + FLFSub_dia;
        Coord_yl = (Ay_i-1)*FLFSub_dia + 1;
        Coord_yu = (Ay_i-1)*FLFSub_dia + FLFSub_dia;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Index of Subimage show
        SubCen = [2,2];
        SubCro = [1,2];
        FLFSub_Center = zeros(FLFSub_dia,FLFSub_dia,Save_FrameNum,'uint16');
        FLFSub__Cross = zeros(FLFSub_dia,FLFSub_dia,Save_FrameNum,'uint16');
    end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Decomposition peroid by peroid
    for idxPd = 1:(size(Peroids_PtsUse,1)-1)
%         idxPd = (size(Systole_Pts,1)-1)
%         idxPd = 2
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Decomposition parameter initialization
        Frame_ini = Peroids_PtsUse(idxPd);
        Frame_end = Peroids_PtsUse(idxPd+1)-1;
        Frame_Ind = Frame_ini:Frame_end;
        Frame_Len = length(Frame_Ind);
        
        FLFvid_Period        = gpuArray.zeros(FLFSub_dia*FLFsub_num_dia,FLFSub_dia*FLFsub_num_dia,Frame_Len,'uint16');
        FLFsub_reshaplowrank = gpuArray.zeros(Frame_Len,FLFSub_len,FLFsub_num,'uint16');
        FLFsub_reshap_sparse = gpuArray.zeros(Frame_Len,FLFSub_len,FLFsub_num,'uint16');
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Image in peroid read frame by frame   
        for idxfr = 1:Frame_Len   
            Frame = ['Frm',num2str(Frame_Ind(idxfr),'%05.0f')];
            FLFvid_Period(:,:,idxfr)= imread([Loadpath_UniN,'_','7',LoadSuffix(2:end),'_',LoadnameDepth,'_', Frame ,Data_01_formIm]);
        end

        for idxsb = 1:FLFsub_num
            FLFsub_reshap = reshape(permute(squeeze(FLFvid_Period(Coord_yl(idxsb):Coord_yu(idxsb),Coord_xl(idxsb):Coord_xu(idxsb),:)),[3,1,2]),Frame_Len,FLFSub_len);

            PCA_Lambda = 1/sqrt(max( [Frame_Len,FLFSub_len] )) /PCA_Sparsity;
            PCA_Mu     = PCA_Lambda*10;
            [FLFsub_reshaplowrank(:,:,idxsb),FLFsub_reshap_sparse(:,:,idxsb)] = ...
            RobustPCA( single(FLFsub_reshap), PCA_Lambda, PCA_Mu,1e-5, 5000);
            disp(idxsb);
        end
        save([Savepath_UniN,'_',num2str(Frame_ini),'-',num2str(Frame_end),'-',num2str(Save_PeroidSeg),Data_02_formDt],'FLFsub_reshaplowrank','FLFsub_reshap_sparse');

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% put together nine elementary images and save
        FLFsubLowrank = reshape(permute(reshape(FLFsub_reshaplowrank,Frame_Len,FLFSub_len,FLFsub_num,1), ...
                                                         [2,4,3,1]),FLFSub_dia,FLFSub_dia,FLFsub_num,Frame_Len);
        FLFsub_Sparse = reshape(permute(reshape(FLFsub_reshap_sparse,Frame_Len,FLFSub_len,FLFsub_num,1), ...
                                                         [2,4,3,1]),FLFSub_dia,FLFSub_dia,FLFsub_num,Frame_Len);

        FLFsubLowrank(FLFsubLowrank < 0) = 0;
        FLFsub_Sparse(FLFsub_Sparse < 0) = 0;

        FLFvidLowrank = gpuArray.zeros(FLFSub_dia*FLFsub_num_dia,FLFSub_dia*FLFsub_num_dia,Frame_Len,'uint16');
        FLFvid_Sparse = gpuArray.zeros(FLFSub_dia*FLFsub_num_dia,FLFSub_dia*FLFsub_num_dia,Frame_Len,'uint16');

        for idxsb = 1:FLFsub_num
            FLFvidLowrank(Coord_yl(idxsb):Coord_yu(idxsb),Coord_xl(idxsb):Coord_xu(idxsb),:) = uint16(FLFsubLowrank(:,:,idxsb,:));
            FLFvid_Sparse(Coord_yl(idxsb):Coord_yu(idxsb),Coord_xl(idxsb):Coord_xu(idxsb),:) = uint16(FLFsub_Sparse(:,:,idxsb,:));
        end
        for idxfr = 1:Frame_Len
            Frame = ['Frm',num2str(Frame_Ind(idxfr),'%05.0f')];
            imwrite(FLFvidLowrank(:,:,idxfr),[Savepath_UniL,'_','7',SaveSuffi1(2:end),PCA_num,'_',SavenameDepth,'_', Frame ,Data_01_formIm]);
            imwrite(FLFvid_Sparse(:,:,idxfr),[Savepath_UniS,'_','7',SaveSuffi2(2:end),PCA_num,'_',SavenameDepth,'_', Frame ,Data_01_formIm]);

            disp([Frame,'|',num2str(Save_FrameNum)])
        end
            FLFSub_Center(:,:,Frame_Ind-Peroids_PtsUse(1)+1) = FLFvid_Sparse(FLFSub_dia*SubCen(2)+(1:FLFSub_dia),FLFSub_dia*SubCen(1)+(1:FLFSub_dia),:);
            FLFSub__Cross(:,:,Frame_Ind-Peroids_PtsUse(1)+1) = FLFvid_Sparse(FLFSub_dia*SubCro(2)+(1:FLFSub_dia),FLFSub_dia*SubCro(1)+(1:FLFSub_dia),:);
    end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Save central elemental images
        for idxfr = 1:Frame_Len
            imwrite(FLFSub_Center(:,:,idxfr),[Savepath_UniN,'_','6',SaveSuffix(2:end),PCA_num,'_',SavenameDepth,'_','Subim',num2str(SubCen')',Data_01_formIm],'WriteMode','append');
            imwrite(FLFSub__Cross(:,:,idxfr),[Savepath_UniN,'_','6',SaveSuffix(2:end),PCA_num,'_',SavenameDepth,'_','Subim',num2str(SubCro')',Data_01_formIm],'WriteMode','append');
        end

            toc
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [L, S] = RobustPCA(X, lambda, mu, tol, max_iter)                  
    % - X is a data matrix (of the size N x M) to be decomposed
    %   X can also contain NaN's for unobserved values
    % - lambda   - regularization parameter,           default = 1/sqrt(max(N,M))
    % - mu       - the augmented lagrangian parameter, default = 10*lambda
    % - tol      - reconstruction error tolerance,     default = 1e-6
    % - max_iter - maximum number of iterations,       default = 1000

    [M, N] = size(X);
    unobserved = isnan(X);
    X(unobserved) = 0;
    normX = norm(X, 'fro');

    % default arguments
    if nargin < 2
        lambda = 1 / sqrt(max(M,N));
    end
    if nargin < 3
        mu = 10*lambda;
    end
    if nargin < 4
        tol = 1e-6;
    end
    if nargin < 5
        max_iter = 1000;
    end
%     if nargin < 6
%         L0 = zeros(M, N);
%     end
    
    % initial solution
    L = zeros(M, N);
    S = zeros(M, N);
    Y = zeros(M, N);
    
    for iter = (1:max_iter)
        % ADMM step: update L and S
        L = Do(1/mu, X - S + (1/mu)*Y);
        S = So(lambda/mu, X - L + (1/mu)*Y);
        % and augmented lagrangian multiplier
        Z = X - L - S;
        Z(unobserved) = 0; % skip missing values
        Y = Y + mu*Z;
        
        err = norm(Z, 'fro') / normX;
%         Err(iter) = err;

        if (iter == 1) || (mod(iter, 10) == 0) %|| (err < tol)
            fprintf(1, 'iter: %04d\terr: %f\trank(L): %d\tcard(S): %d\n', ...
                    iter, err, rank(L), nnz(S(~unobserved)));
        end

        if (err <= tol && iter >= 500 && rank(L) <= 3) 
            break; 
        end
%         if iter > 1
%             if (err >= Err(iter-1))
%                 fprintf(1, 'iter: %04d\terr: %f\trank(L): %d\tcard(S): %d\n', ...
%                     iter, err, rank(L), nnz(S(~unobserved)));
%                 break; end
%         end
    end
end

function r = So(tau, X)                                                    
    % shrinkage operator
    r = sign(X) .* max(abs(X) - tau, 0);
end

function r = Do(tau, X)                                                    
    % shrinkage operator for singular values
    [U, S, V] = svd(X, 'econ');
    r = U*So(tau, S)*V';
end










