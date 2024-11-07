function [] = I91_ray_tracing_CPU_20191221(                ...
                             ds_01_oo ,Fl_01_obj,Dm_01_obj,...
                             ds_02_ot ,Fl_02_tub,Dm_02_tub,...
                             ds_03_te ,Fl_03_ent,Dm_03_ent,...
                             ds_04_em ,Fl_04_mla,Dm_04_mic,...
                             ds_05_mc ,Pi_04_MLA,Dm_04_MLA,...
                             Ma_01_obj,NA_01_obj,Dm_05_ccd,...
                             step_xx  ,Ray_num  ,Ini_coorx,...
                             flag_cent,Para_axis,Ini_coorz,...
                             Path_Tracingsave,Data_01_formIm)
% flag_cent = point_cenlenslet
% flag_axis = 0
    for idxsg = 1	% Path name set                                        
        File_01_time = datetime;
        File_01_tstr = [num2str(yyyymmdd(datetime))      ,...
                    '_',num2str(File_01_time.Hour,'%02d'),...
                    '_',num2str(File_01_time.Minute)];
        File_02_path = [Path_Tracingsave,'\',File_01_tstr];mkdir(File_02_path);
    end
    for idxta = 1                                                          
        G_ds_01_oo = ds_01_oo*1000+Ini_coorz ; G_Fl_01_obj = Fl_01_obj*1000; G_Dm_01_obj = Dm_01_obj*1000;
        G_ds_02_ot = ds_02_ot*1000           ; G_Fl_02_tub = Fl_02_tub*1000; G_Dm_02_tub = Dm_02_tub*1000;
        G_ds_03_te = ds_03_te*1000           ; G_Fl_03_ent = Fl_03_ent*1000; G_Dm_03_ent = Dm_03_ent*1000;
        G_ds_04_em = ds_04_em*1000           ; G_Fl_04_mla = Fl_04_mla*1000; G_Dm_04_mic = Dm_04_mic*1000;
        G_ds_05_mc = ds_05_mc*1000           ; G_Pi_04_MLA = Pi_04_MLA*1000; G_Dm_04_MLA = Dm_04_MLA*1000;
    end
    for idxta = 1                                                          
        Node_rh = [                                                        ...
                  0                                                       ,...
                  G_ds_01_oo                                              ,...
                  G_ds_01_oo                                              ,...
                  G_ds_01_oo+G_ds_02_ot                                   ,...
                  G_ds_01_oo+G_ds_02_ot                                   ,...
                  G_ds_01_oo+G_ds_02_ot+G_ds_03_te                        ,...
                  G_ds_01_oo+G_ds_02_ot+G_ds_03_te                        ,...
                  G_ds_01_oo+G_ds_02_ot+G_ds_03_te+G_ds_04_em             ,...
                  G_ds_01_oo+G_ds_02_ot+G_ds_03_te+G_ds_04_em             ,...
                  G_ds_01_oo+G_ds_02_ot+G_ds_03_te+G_ds_04_em+G_ds_05_mc  ,...
                  G_ds_01_oo+G_ds_02_ot+G_ds_03_te+G_ds_04_em+G_ds_05_mc  ,...
                 ]                          ;
        Nod_num_rh = length(Node_rh);
    end
    for idxta = 1   % figure                                               
        figure('Name'       ,'Measured Data' ,...
               'color'      ,[0.78,0.96,1.00],...
               'NumberTitle','off'           ,...
               'Position'   ,[500,200,1200,600]);
        hold on;
        ap_max  = max(G_Dm_01_obj,G_Dm_02_tub);
        axis_yc = Dm_05_ccd*2048*1000;
        axis_ym = 0.75;
        axis_xm = 3;
        axis_dl = G_ds_01_oo;
        axis_xl =-axis_dl*axis_xm;
        axis_xr =+axis_dl*axis_xm*2+Node_rh(end);
        axis_yl =-ap_max*axis_ym;
        axis_yr =+ap_max*axis_ym;
        xlim([axis_xl,axis_xr])
        ylim([axis_yl,axis_yr])
        xlabel(   'z(mm)','FontSize',20,'FontWeight','bold','Color','k')
        ylabel('\rho(mm)','FontSize',20,'FontWeight','bold','Color','k')
        ax = gca; % current axes
        ax.FontSize = 20;
    end
    for idxta = 1                                                          
        % Plot the optical axis
        axis_xx = axis_xl:step_xx:axis_xr;
        axis_yy = zeros(1,length(axis_xx));
            plot(axis_xx, axis_yy,'k:');
        % Plot the object plane
        I00_Plane_Figure1(ap_max*axis_ym  ,step_xx,Node_rh(1)  ,'NOP');
        % Plot the Camera plane
        I00_Plane_Figure1(       axis_yc  ,step_xx,Node_rh(end),'CP');

        % Plot the objective lens 
        I10_Lens_Figure_1( G_Fl_01_obj,G_Dm_01_obj,Node_rh(2),0,'obj');
        %Plot the tube      lens 
        I10_Lens_Figure_1( G_Fl_02_tub,G_Dm_02_tub,Node_rh(4),0,'TL');
        % Plot the entrance  lens 
        I10_Lens_Figure_1( G_Fl_03_ent,G_Dm_03_ent,Node_rh(6),0,'EL');

        % Plot the MLA       lens 
        I20_MLA_Figure_1( G_Fl_04_mla,G_Dm_04_MLA,Node_rh(8),...
                          G_Pi_04_MLA,G_Dm_04_mic,flag_cent,...
                          axis_xl    ,axis_xr    ,Para_axis);
    end
    for idxsg = 1                                                          
        Rho_upp = Ini_coorx;
        Rho_dow = Rho_upp;
        Ang_upp = (+G_Dm_01_obj/2-Rho_upp-0.001)/G_ds_01_oo;
        Ang_dow = (-G_Dm_01_obj/2-Rho_dow+0.001)/G_ds_01_oo;
%         Ang_upp = +0.05;
%         Ang_dow = -0.05;
        Ray_rh_ini = linspace(  Rho_dow, Rho_upp,Ray_num);
        Ray_th_ini = linspace(  Ang_dow, Ang_upp,Ray_num);
    end
    for idxsg = 1                                                          
        I90_optical_system_FLFM( ...
                                 G_ds_01_oo,G_Fl_01_obj,G_Dm_01_obj,...
                                 G_ds_02_ot,G_Fl_02_tub,G_Dm_02_tub,...
                                 G_ds_03_te,G_Fl_03_ent,G_Dm_03_ent,...
                                 G_ds_04_em,G_Fl_04_mla,G_Dm_04_mic,...
                                 G_ds_05_mc,G_Pi_04_MLA,G_Dm_04_MLA,...
                                 Node_rh   ,step_xx                ,...
                                 Nod_num_rh,Ray_num                ,...
                                 Ray_rh_ini,Ray_th_ini             ,...
                                 [1.00,0.00,0.00],flag_cent);
    end
    for idxsg = 1                                                          
        saveas(gcf,[File_02_path,'\'                                   ,...
                            'MA',num2str(  Ma_01_obj, '%03d')   'X_'   ,...
                            'NA',num2str(  NA_01_obj, '%.2f')    '_'   ,...
                            'ft',num2str(G_Fl_02_tub *1e0   )  'mm_'   ,...
                            'Dt',num2str(G_Dm_02_tub *1e0   )  'mm_'   ,...
                            'fe',num2str(G_Fl_03_ent *1e0   )  'mm_'   ,...
                            'De',num2str(G_Dm_03_ent *1e0   )  'mm_'   ,...
                            'MS',num2str(G_Dm_04_mic *1e0   )    '-'   ,...
                            'MP',num2str(  Pi_04_MLA *1e0   )    '_'   ,...
                            'fm',num2str(G_Fl_04_mla *1e0   )    '_'   ,...
                            'x0',num2str(Ini_coorx   *1e3   )  'um_'   ,...
                            Data_01_formIm]);
    end
 
    
    
function [Ray_coords] = I90_optical_system_FLFM( ...
                             F_ds_01_oo,F_Fl_01_obj,F_Dm_01_obj,...
                             F_ds_02_ot,F_Fl_02_tub,F_Dm_02_tub,...
                             F_ds_03_te,F_Fl_03_ent,F_Dm_03_ent,...
                             F_ds_04_em,F_Fl_04_mla,F_Dm_04_mic,...
                             F_ds_05_mc,F_Pi_04_MLA,F_Dm_04_MLA,...
                             Node   ,step   ,...
                             Nod_num,Ray_num,...
                             Rho_ini,Ang_ini,...
                             Line_color,flag_center)
% 
% F_ds_01_oo = G_ds_01_oo ; F_Fl_01_obj = G_Fl_01_obj ; F_Dm_01_obj = G_Dm_01_obj ;
% F_ds_02_ot = G_ds_02_ot ; F_Fl_02_tub = G_Fl_02_tub ; F_Dm_02_tub = G_Dm_02_tub ;
% F_ds_03_te = G_ds_03_te ; F_Fl_03_ent = G_Fl_03_ent ; F_Dm_03_ent = G_Dm_03_ent ;
% F_ds_04_em = G_ds_04_em ; F_Fl_04_mla = G_Fl_04_mla ; F_Dm_04_mic = G_Dm_04_mic ;
% F_ds_05_mc = G_ds_05_mc ; F_Pi_04_MLA = G_Pi_04_MLA ; F_Dm_04_MLA = G_Dm_04_MLA ;
% Node = Node_rh;
% step = step_rh;
% Nod_num = Nod_num_rh;
% Ray_num = Ray_num;
% Rho_ini = Ray_rh_ini;
% Ang_ini = Ray_th_ini;
% Line_color = [1.00,0.00,0.00];
% flag_center = point_cenlenslet

% Bunch of rays tracing
% initialization
    Oddoreven = 0.5*(1-flag_center);
    for idxtt = 1                                                          
        Ray_coords = zeros(Ray_num*2,Nod_num);
        Ray_coords(1:2:end,1) = Rho_ini;
        Ray_coords(2:2:end,1) = Ang_ini;
        RatiaMLA =         F_Dm_04_mic/F_Pi_04_MLA;
    end
    for idxrn = 1:Ray_num                                                  
        idxrh = 2*idxrn-1;
        idxth = 2*idxrn  ;
        
        % Free space before fo
            Ray_coords(idxrh:idxth,2) = P1_freespace(Ray_coords(idxrh:idxth,1), F_ds_01_oo);
        % Lens fo
        if( abs(Ray_coords(  idxrh,2))< F_Dm_01_obj/2)
            Ray_coords(idxrh:idxth,3) = P2_lens(     Ray_coords(idxrh:idxth,2), F_Fl_01_obj);
        else        
            Ray_coords(idxrh:idxth,3) = P1_freespace(Ray_coords(idxrh:idxth,2), 0);
        end
        
        % Free space before ft
            Ray_coords(idxrh:idxth,4) = P1_freespace(Ray_coords(idxrh:idxth,3), F_ds_02_ot);
        % Lens ft
        if( abs(Ray_coords(  idxrh,4))< F_Dm_02_tub/2)
            Ray_coords(idxrh:idxth,5) = P2_lens(     Ray_coords(idxrh:idxth,4), F_Fl_02_tub);
        else        
            Ray_coords(idxrh:idxth,5) = P1_freespace(Ray_coords(idxrh:idxth,4), 0);
        end
        
        % Free space before fe
            Ray_coords(idxrh:idxth,6) = P1_freespace(Ray_coords(idxrh:idxth,5), F_ds_03_te);
        % Lens fe
        if( abs(Ray_coords(  idxrh,6))< F_Dm_03_ent/2)
            Ray_coords(idxrh:idxth,7) = P2_lens(     Ray_coords(idxrh:idxth,6), F_Fl_03_ent);
        else        
            Ray_coords(idxrh:idxth,7) = P1_freespace(Ray_coords(idxrh:idxth,6), 0);
        end
        
        % Free space before MLA
            Ray_coords(idxrh:idxth,8) = P1_freespace(Ray_coords(idxrh:idxth,7), F_ds_04_em);
        % Microlens array and Free space after fm
            Lens_rat = Ray_coords(idxrh,8)/F_Pi_04_MLA;
            Lens_num = Lens_rat + sign(Lens_rat)*Oddoreven;
            Lens_ind = round(Lens_num);
            Lens_cen = Lens_ind - sign(Lens_num)*Oddoreven;
            Lens_edg = abs(  Lens_num - Lens_ind);
        if((abs(Ray_coords(  idxrh,8))> F_Dm_04_MLA) || Lens_edg > RatiaMLA/2)
            Ray_coords(idxrh:idxth,9) = P1_freespace(Ray_coords(idxrh:idxth,8), 0);
            Ray_coords(idxrh:idxth,10)=              Ray_coords(idxrh:idxth,9)    ;
        else        
            ray_temp_rh               = Ray_coords(idxrh,8) - Lens_cen*F_Pi_04_MLA;
            Ray_coords(idxrh:idxth,9) = P2_lens([ray_temp_rh,Ray_coords(idxth,8)]',F_Fl_04_mla);
            Ray_coords(idxrh      ,9) = Ray_coords(idxrh,9) + Lens_cen*F_Pi_04_MLA ;
            Ray_coords(idxrh:idxth,10)= P1_freespace(Ray_coords(idxrh:idxth,9), F_ds_05_mc);
        end
        for idxnd = 1:Nod_num-4                                           
            stp_num = length(   Node(idxnd) : step : Node(  idxnd+1)        );
            xx      = linspace( Node(idxnd) ,        Node(  idxnd+1),stp_num);
            yy      = (xx                    -Node(         idxnd))...
                   .*(Ray_coords(idxrh,idxnd+1)-Ray_coords(idxrh,idxnd))...
                   ./(Node(            idxnd+1)-Node(            idxnd))...
                    + Ray_coords(idxrh,idxnd);
            plot( xx, yy, 'Color',Line_color);
        end
        
            flagcente = Lens_edg||flag_center;
        if((abs(Ray_coords(  idxrh,8))> F_Dm_04_MLA) || Lens_edg > RatiaMLA/2 || flagcente == 0)
        else
            for idxnd = Nod_num-4:Nod_num-1
                stp_num = length(   Node(idxnd) : step : Node(  idxnd+1)        );
                xx      = linspace( Node(idxnd) ,        Node(  idxnd+1),stp_num);
                yy      = (xx                    -Node(         idxnd))...
                       .*(Ray_coords(idxrh,idxnd+1)-Ray_coords(idxrh,idxnd))...
                       ./(Node(            idxnd+1)-Node(            idxnd))...
                        + Ray_coords(idxrh,idxnd);
                plot( xx, yy, 'Color',Line_color);
            end
        end
    end
%         Rho_end = Ray_coords(1:2:end,:);
%         Ang_end = Ray_coords(2:2:end,:);
end



































    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
end