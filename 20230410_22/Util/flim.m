addpath(genpath('E:\00_Matlab_Code'))
addpath(genpath('E:\A_Fiji.app\Fiji.app\scripts'))
addpath(genpath('E:\02_ACsN'))
addpath(genpath('E:\02_MIRO'))
addpath(genpath('E:\24_Largefield_flfm'))

for idxt = [2,4]
    if idxt == 0
        path = 'C:\Users\zling41\frame-interpolation\frame-interpolation\photos\';
        file = dir(path);
        file = file(3:end);
        file_name = natsortfiles({file.name});
        first_img = imread([path,'\',file(1).name]);
        first_img = rgb2gray(first_img);
        first_img_c = first_img(352:702,352:702);
        figure;imshow(first_img_c,[]);
        clear FLFimgCorrelation
        for i = 1:size(file,1)
            image = imread([path,'\',file_name{i}]);
            imageg = rgb2gray(image);
            imageg_c = imageg(352:702,352:702);
            FLFimgCorrelation(i) = corr2(imageg_c,first_img_c);
            i
        end
        figure;plot(FLFimgCorrelation);
    end

    if idxt == 1
        path1 = 'C:\Users\zling41\frame-interpolation\frame-interpolation\interpolated_frames_1TIME';
        file1 = dir(path1);
        file1 = file1(3:end);
        file1_name = natsortfiles({file1.name});
        first_img = imread([path1,'\',file1(1).name]);
        first_img = rgb2gray(first_img);
        first_img_c = first_img(352:702,352:702);
        figure;imshow(first_img_c,[]);
        clear FLFimgCorrelation0
        for i = 1:size(file1,1)
            image = imread([path1,'\',file1_name{i}]);
            imageg = rgb2gray(image);
            imageg_c = imageg(352:702,352:702);
            FLFimgCorrelation0(i) = corr2(imageg_c,first_img_c);
            i
        end
        figure;plot(FLFimgCorrelation0);
    end

    if idxt == 2
        path2 = 'C:\Users\zling41\frame-interpolation\frame-interpolation\interpolated_frames_2TIMES';
        file2 = dir(path2);
        file2 = file2(3:end);
        file2_name = natsortfiles({file2.name});
        first_img = imread([path2,'\',file2(1).name]);
        first_img = rgb2gray(first_img);
        first_img_c = first_img(352:702,352:702);
        figure;imshow(first_img_c,[]);
        clear FLFimgCorrelation1
        for i = 1:size(file2,1)
            image = imread([path2,'\',file2_name{i}]);
            imageg = rgb2gray(image);
            imageg_c = imageg(352:702,352:702);
            FLFimgCorrelation1(i) = corr2(imageg_c,first_img_c);
            i
        end
        figure;plot(FLFimgCorrelation1);
    end

    if idxt == 3
        path3 = 'C:\Users\zling41\frame-interpolation\frame-interpolation\interpolated_frames_3TIMES';
        file3 = dir(path3);
        file3 = file3(3:end);
        file3_name = natsortfiles({file3.name});
        first_img = imread([path3,'\',file3(1).name]);
        first_img = rgb2gray(first_img);
        first_img_c = first_img(352:702,352:702);
        figure;imshow(first_img_c,[]);
        clear FLFimgCorrelation2
        for i = 1:size(file3,1)
            image = imread([path3,'\',file3_name{i}]);
            imageg = rgb2gray(image);
            imageg_c = imageg(352:702,352:702);
            FLFimgCorrelation2(i) = corr2(imageg_c,first_img_c);
            i
        end
        figure;plot(FLFimgCorrelation2);
    end

    % hold on;
    % plot(fr(6,:),FLFimgCorrelation0(fr(6,:)),'r.');
    % xlabel('frame');
    % ylabel('Correlation');
    % set(gca,'FontSize',20);

    %% no interpolation
    if idxt == 0
        offset = 31;
        num_inter = 1;
        off_set = 0;
        fr = zeros(Systole_Pts(2)-Systole_Pts(1),size(Systole_Pts,1)-1);
        fr(:,1) = Systole_Pts(1)-offset:Systole_Pts(2)-offset-1;
        for i = 1:diastolePts(2)-Systole_Pts(1)+1
            for j = 2:size(Systole_Pts,1)-1
                [~, idk] = min(abs(FLFimgCorrelation ...
                    ((Systole_Pts(j)-offset)*num_inter-off_set:(diastolePts(j+1)-offset)*num_inter-off_set) ...
                    -FLFimgCorrelation((i+40)*num_inter-off_set)));
                fr(i,j) = (Systole_Pts(j)-offset)*num_inter-off_set+idk-1;
            end
        end
        for i = diastolePts(2)-offset+1:Systole_Pts(2)-offset-1
            for j = 2:size(Systole_Pts,1)-1
                [~, idk] = min(abs(FLFimgCorrelation ...
                    ((diastolePts(j+1)-offset+1)*num_inter-off_set:(Systole_Pts(j+1)-offset-1)*num_inter-off_set) ...
                    -FLFimgCorrelation((i+40)*num_inter-off_set)));
                fr(i,j) = (diastolePts(j+1)-offset)*num_inter-off_set+idk;
            end
        end
        figure;plot(FLFimgCorrelation);
        hold on;
        plot(fr(16,:),FLFimgCorrelation(fr(16,:)),'r.');
        xlabel('Frame');
        ylabel('Correlation');
        set(gca,'FontSize',20);
        xlim([16 616]);
        ylim([0.2 1]);
        save('inter0.mat','FLFimgCorrelation','fr');
        saveas(gcf,'inter0.jpg');
    end

    %% interpolate by num_inter times
    if idxt == 1
        offset = 31;
        num_inter = 2;
        off_set = 1;

        FLFimgCorrelation = FLFimgCorrelation0;
        fr = zeros(Systole_Pts(2)-Systole_Pts(1),size(Systole_Pts,1)-1);
        fr(:,1) = Systole_Pts(1)-offset:Systole_Pts(2)-offset-1;
        for i = 1:diastolePts(2)-Systole_Pts(1)+1
            for j = 2:size(Systole_Pts,1)-1
                [~, idk] = min(abs(FLFimgCorrelation ...
                    ((Systole_Pts(j)-offset)*num_inter-off_set:(diastolePts(j+1)-offset)*num_inter-off_set) ...
                    -FLFimgCorrelation((i+40)*num_inter-off_set)));
                fr(i,j) = (Systole_Pts(j)-offset)*num_inter-off_set+idk-1;
            end
        end
        for i = diastolePts(2)-offset+1:Systole_Pts(2)-offset-1
            for j = 2:size(Systole_Pts,1)-1
                [~, idk] = min(abs(FLFimgCorrelation ...
                    ((diastolePts(j+1)-offset+1)*num_inter-off_set:(Systole_Pts(j+1)-offset-1)*num_inter-off_set) ...
                    -FLFimgCorrelation((i+40)*num_inter-off_set)));
                fr(i,j) = (diastolePts(j+1)-offset)*num_inter-off_set+idk;
            end
        end
        figure;plot(FLFimgCorrelation0);
        hold on;
        plot(fr(16,:),FLFimgCorrelation0(fr(16,:)),'r.');
        xlabel('Frame');
        ylabel('Correlation');
        set(gca,'FontSize',20);
        xlim([37 1237]);
        ylim([0.2 1]);
        save('inter2.mat','FLFimgCorrelation0','fr');
        saveas(gcf,'inter2.jpg');
    end

    %% interpolate by num_inter times
    if idxt == 2
        num_inter = 4;
        off_set = 3;

        FLFimgCorrelation = FLFimgCorrelation1;
        fr = zeros(Systole_Pts(2)-Systole_Pts(1),size(Systole_Pts,1)-1);
        fr(:,1) = Systole_Pts(1)-offset:Systole_Pts(2)-offset-1;
        for i = 1:diastolePts(2)-Systole_Pts(1)+1
            for j = 2:size(Systole_Pts,1)-1
                [~, idk] = min(abs(FLFimgCorrelation ...
                    ((Systole_Pts(j)-offset)*num_inter-off_set:(diastolePts(j+1)-offset)*num_inter-off_set) ...
                    -FLFimgCorrelation((i+40)*num_inter-off_set)));
                fr(i,j) = (Systole_Pts(j)-offset)*num_inter-off_set+idk-1;
            end
        end
        for i = diastolePts(2)-offset+1:Systole_Pts(2)-offset-1
            for j = 2:size(Systole_Pts,1)-1
                [~, idk] = min(abs(FLFimgCorrelation ...
                    ((diastolePts(j+1)-offset+1)*num_inter-off_set:(Systole_Pts(j+1)-offset-1)*num_inter-off_set) ...
                    -FLFimgCorrelation((i+40)*num_inter-off_set)));
                fr(i,j) = (diastolePts(j+1)-offset)*num_inter-off_set+idk;
            end
        end
        figure;plot(FLFimgCorrelation1);
        hold on;
        plot(fr(16,:),FLFimgCorrelation1(fr(16,:)),'r.');
        xlabel('Frame');
        ylabel('Correlation');
        set(gca,'FontSize',20);
        xlim([60 2460]);
        ylim([0.2 1]);
        save('inter4.mat','FLFimgCorrelation1','fr');
        saveas(gcf,'inter4.jpg');
    end

    %% interpolate by num_inter times
    if idxt == 3
        num_inter = 8;
        off_set = 7;

        FLFimgCorrelation = FLFimgCorrelation2;
        fr = zeros(Systole_Pts(2)-Systole_Pts(1),size(Systole_Pts,1)-1);
        fr(:,1) = Systole_Pts(1)-offset:Systole_Pts(2)-offset-1;
        for i = 1:diastolePts(2)-Systole_Pts(1)+1
            for j = 2:size(Systole_Pts,1)-1
                [~, idk] = min(abs(FLFimgCorrelation ...
                    ((Systole_Pts(j)-offset)*num_inter-off_set:(diastolePts(j+1)-offset)*num_inter-off_set) ...
                    -FLFimgCorrelation((i+40)*num_inter-off_set)));
                fr(i,j) = (Systole_Pts(j)-offset)*num_inter-off_set+idk-1;
            end
        end
        for i = diastolePts(2)-offset+1:Systole_Pts(2)-offset-1
            for j = 2:size(Systole_Pts,1)-1
                [~, idk] = min(abs(FLFimgCorrelation ...
                    ((diastolePts(j+1)-offset+1)*num_inter-off_set:(Systole_Pts(j+1)-offset-1)*num_inter-off_set) ...
                    -FLFimgCorrelation((i+40)*num_inter-off_set)));
                fr(i,j) = (diastolePts(j+1)-offset)*num_inter-off_set+idk;
            end
        end
        figure;plot(FLFimgCorrelation2);
        hold on;
        plot(fr(16,:),FLFimgCorrelation2(fr(16,:)),'r.');
        xlabel('Frame');
        ylabel('Correlation');
        set(gca,'FontSize',20);
        xlim([150 4950]);
        ylim([0.2 1]);
        save('inter8.mat','FLFimgCorrelation2','fr');
        saveas(gcf,'inter8.jpg');
    end

    %%
    size_x = 351;
    size_y = 351;
    Ax = kron([1,2,3]',ones(1,3));
    Ay = Ax';
    Ax_i = reshape(Ay,[1 9]);
    Ay_i = reshape(Ax,[1 9]);
    ind = reshape([1:9],[3 3])';

    for i = 1:9
        Coord_xl(i) = 1+(Ay_i(i)-1)*size_x;
        Coord_xu(i) = size_x+(Ay_i(i)-1)*size_x;
        Coord_yl(i) = 1+(Ax_i(i)-1)*size_x;
        Coord_yu(i) = size_y+(Ax_i(i)-1)*size_y;
    end

    idxtt = [0,2,4,8];
    for t = 1:Systole_Pts(2)-Systole_Pts(1)
        t
        clear data_corr
        for n = 2:16
            switch idxt
                case 0
                    recon = rgb2gray(imread([path,'\',file_name{fr(t,n)}]));
                case 1
                    recon = rgb2gray(imread([path1,'\',file1_name{fr(t,n)}]));
                case 2
                    recon = rgb2gray(imread([path2,'\',file2_name{fr(t,n)}]));
                otherwise
                    recon = rgb2gray(imread([path3,'\',file3_name{fr(t,n)}]));
            end
            data_corr(:,:,n-1) = recon;
        end

        %     figure;
        %     for nn = 1:5
        %         for n = 1:16
        %             imshow(data_corr(:,:,n),[]);
        %             title(num2str(n));
        %             pause(0.01);
        %         end
        %     end

        clear X_
        data_acsn_ele_ = zeros(size_x,size_y,size(data_corr,3),9);
        data_acsn_roi_ = zeros(size_x,size_y,size(data_corr,3),9);
        for i = 1:size(data_corr,3)
            for j = 1:9
                data_acsn_ele_(:,:,i,j) = data_corr(Coord_xl(j):Coord_xu(j),Coord_yl(j):Coord_yu(j),i);
                X_(i,:,j) = reshape(data_acsn_ele_(:,:,i,j),[],1);
            end
        end

        L_ = zeros(size(data_corr,3),size_x*size_y,9);
        S_ = zeros(size(data_corr,3),size_x*size_y,9);
        for j = 5
            lambda = 1/sqrt(max(size(X_(:,:,j))));
            tic
            [L_(:,:,j),S_(:,:,j)] = RobustPCA(squeeze(X_(:,:,j)), lambda, 10*lambda, 0.5*1e-5, 5000);
            toc
            disp(j);
        end
        save(['Y:\jia-lab\ZhiLing\Decomposition\F_AllCode\MSR_code_1\20230410_22\Util\inter',num2str(idxtt(idxt/2+1)),'_LS\',num2str(t),'.mat'],'L_','S_');
    end
    close all;
end

figure;
for nn = 1:5
    for n = 1:16
        imshow(data_corr(:,:,n),[]);
        title(num2str(n));
        pause(0.01);
    end
end

L_r_ = zeros(size_x,size_y,16,9);
S_r_ = zeros(size_x,size_y,16,9);
for e = 1:9
    for i = 1:size(data_corr,3)
        L_r_(:,:,i,e) = reshape(L_(i,:,e),[size_x size_y]);
        cell_ = reshape(S_(i,:,e),[size_x size_y]);
        cell_(cell_<0) = 0;
        S_r_(:,:,i,e) = cell_;
    end
end

figure;
for nn = 1:5
    for n = 1:15
        imshow(S_r_(:,:,n,5),[]);
        title(num2str(n));
        pause(0.1);
    end
end

%%
for idxt = 1:4
    for t = 1:41
        load(['Y:\jia-lab\ZhiLing\Decomposition\F_AllCode\MSR_code_1\20230410_22\Util\inter', ...
            num2str(idxtt(idxt)),'_LS\',num2str(t),'.mat']);
        sparsity_S(idxt,t) = nnz(S_(:,:,5));
        sparsity_L(idxt,t) = nnz(L_(:,:,5));
        rank_L(idxt,t) = rank(L_(:,:,5));
    end
    idxt
end

figure;
for i = 1:4
    plot(sparsity_S(i,:));
    hold on;
end
legend({'1','2','3','4'})
sparsity_S_m = mean(sparsity_S,2);
sparsity_S_std = std(sparsity_S,0,2);

figure;
for i = 1:4
    plot(sparsity_L(i,:));
    hold on;
end
legend({'1','2','3','4'})
sparsity_L_m = mean(sparsity_L,2);
sparsity_L_std = std(sparsity_L,0,2);

figure;
for i = 1:4
    plot(rank_L(i,:));
    hold on;
end
legend({'1','2','3','4'})
rank_L_m = mean(rank_L,2);
rank_L_std = std(rank_L,0,2);

comp = [sparsity_S_m,sparsity_S_std,sparsity_L_m,sparsity_L_std,rank_L_m,rank_L_std];
writematrix(comp, 'S_L.xls');
save('comparison.mat','comp');

bkg_origin = zeros(size_x*3,size_y*3,fr_u-fr_b+1);
cell_joint = zeros(size_x*3,size_y*3,fr_u-fr_b+1);
for f = 1:fr_u-fr_b+1
    for e = 1:2:9
        bkg_origin(Coord_xl(e):Coord_xu(e),Coord_yl(e):Coord_yu(e),f) = L_r(:,:,f,e);
        cell_joint(Coord_xl(e):Coord_xu(e),Coord_yl(e):Coord_yu(e),f) = cell(:,:,f,e);
    end
    recon = cell_joint(:,:,f);
    bkg = bkg_origin(:,:,f);
    save([path4,'\',file(fr_b+f-1).name(1:end-3),'mat'],'recon');
end
