function [OTF_0N_data,OTF_0T_data] = N32_DeconvRL_3D_APU_OTF_FLFM_N1T1( PSF_0N_data )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     From N30_DeconvRL_3D_GPU_OTF to N32_DeconvRL_3D_GPU_OTF_FLFM
    %     1, Let Img_04_size to be equal to PSF_04_size, 
    %        which may only be adaptable to LFM and delete Img_04_size
    %     2, Let PSF_0T_data to be equal to flip(flip(PSF_0N_data,1),2);
    %        which may only be adaptable to LFM and delete PSF_0T_data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     Three sub functions are used: 
    %     exindex
    %     getinputs
    %     extend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     PSF_0N_data = single(RecFLF_64_PSFcrp);
    %     PSF_0T_data = single(RecFLF_64TPSFcrp);
    %     Img_00_data = single(RecFLF_84_crpnor(:,:,idxt))*65535;
    %     maxIter     = 10;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    PSF_0T_data = flip(flip(PSF_0N_data,1),2);
    PSF_03_size = [size(PSF_0N_data,1), size(PSF_0N_data,2)];              PSF_03depth = size(PSF_0N_data,3);
    PSF_03_Half = floor(PSF_03_size(1:2)/2);                               Img_03_size = PSF_03_size;
    
    Rec_03_size = [ min( 2^ceil(log2( (PSF_03_Half(1)+Img_03_size(1)) )),  128*ceil( (PSF_03_Half(1)+Img_03_size(1))/128) ),...
                    min( 2^ceil(log2( (PSF_03_Half(2)+Img_03_size(2)) )),  128*ceil( (PSF_03_Half(2)+Img_03_size(2))/128) )  ];
    
    disp(['FFT size is ', num2str(Rec_03_size(1)),'X',num2str(Rec_03_size(2))]); 
    
    Pad_00_Temp = gpuArray.zeros( Rec_03_size             , 'single' );
        
    OTF_0N_data =          zeros([Rec_03_size,PSF_03depth], 'single' );
    OTF_0T_data =          zeros([Rec_03_size,PSF_03depth], 'single' );
    for idxk        = 1:PSF_03depth                                      
        PSF_0N_temp = Pad_00_Temp;           PSF_0N_temp( 1:PSF_03_size(1), 1:PSF_03_size(2) ) = PSF_0N_data(:,:,idxk);
        PSF_0T_temp = Pad_00_Temp;           PSF_0T_temp( 1:PSF_03_size(1), 1:PSF_03_size(2) ) = PSF_0T_data(:,:,idxk);
        
        OTF_0N_Temp = gather( fft2( exindex( PSF_0N_temp, ( PSF_03_Half(1) + ( 1: Rec_03_size(1) ) ),...
                                                          ( PSF_03_Half(2) + ( 1: Rec_03_size(2) ) ), 'circular') ) );
        OTF_0T_Temp = gather( fft2( exindex( PSF_0T_temp, ( PSF_03_Half(1) + ( 1: Rec_03_size(1) ) ),...
                                                          ( PSF_03_Half(2) + ( 1: Rec_03_size(2) ) ), 'circular') ) );
                                                                 
        OTF_0N_data(:,:,idxk) = gather(OTF_0N_Temp./max(abs(OTF_0N_Temp),[],'all') );
        OTF_0T_data(:,:,idxk) = gather(OTF_0T_Temp./max(abs(OTF_0T_Temp),[],'all') );
        disp(  [num2str(idxk),'|',num2str(PSF_03depth)])
    end
    
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function arr                        = exindex(  arr, varargin)         
        % Sort out arguments
        [exindices, rules, nd, sz] = getinputs(arr, varargin{:});
        consts    = cellfun(@iscell, rules);  % Check for constants, as can be
        constused = any(consts);              % more efficient if there are none

        % Setup for constant padding
        if constused
            tofill = cell(1, nd);
        end

        % Main loop over subscript arguments, transforming them into valid subscripts into arr using the rule for each dimension
        if constused
            for i = 1:nd
                [exindices{i}, tofill{i}] = extend(exindices{i}, rules{i}, sz(i));
            end
        else % no need for information for doing constants
            for i = 1:nd
                exindices{i} = extend(exindices{i}, rules{i}, sz(i));
            end
        end

        % Create the new array by indexing into arr. 
        % If there are no constants, this does the whole job
        arr = arr(exindices{:});

        % Fill areas that need constants
        if constused
            % Get full range of output array indices
            ranges = arrayfun(@(x) {1:x}, size(arr));
            for i = nd:-1:1    % order matters
                if consts(i)
                    ranges{i} = tofill{i};      % don't overwrite original
                    c = rules{i};               % get constant and fill ...
                    arr(ranges{:}) = c{1};      % we've checked c is scalar
                    ranges{i} = ~tofill{i};     % don't overwrite
                end
            end
        end

    end

    function [exindices, rules, nd, sz] = getinputs(arr, varargin)         
    nd = length(varargin);
        if     nd == 0
            error('exindex:missingargs', 'Not enough arguments');
        elseif nd == 1
            exindices = varargin;
            rules = {{0}};
        elseif ~(isnumeric(varargin{2}) || strcmp(varargin{2}, ':'))           % have alternating indices and rule
            nd = nd/2;
            if round(nd) ~= nd
                error('exindex:badnumargs', ...
                    'Odd number of arguments after initial index/rule pair');
            end
            exindices = varargin(1:2:end);
            rules = varargin(2:2:end);
        elseif nd > 2 && ~(isnumeric(varargin{end}) || strcmp(varargin{end}, ':')) % have a general rule at end
            nd = nd - 1;
            exindices = varargin(1:nd);
            [rules{1:nd}] = deal(varargin{end});
        else                                                                   % no rule is specified
            exindices = varargin;
            [rules{1:nd}] = deal({0});
        end

        % Sort out mismatch of apparent array size and number of dimensions indexed
        sz = size(arr);
        ndarr = ndims(arr);
        if nd < ndarr
            if nd == 1 && ndarr == 2
                if sz(1) == 1 && sz(2) > 1                                     % have a row vector
                    exindices = [{1} exindices {1}];
                    rules = [rules rules];                                     % 1st rule doesn't matter
                elseif sz(2) == 1 && sz(1) > 1                                 % have a column vector
                    exindices = [exindices {1}];
                    rules = [rules rules];                                     % 2nd rule doesn't matter
                else
                    error('exindex:wantvector', ...
                        'Only one index but array is not a vector');
                end
            else
                error('exindex:toofewindices', ...
                    'Array has more dimensions than there are index arguments');
            end
            nd = 2;
        elseif nd > ndarr
            % Effective array size
            sz = [sz ones(1, nd-ndarr)];
        end

        colons = strcmp(exindices, ':');
        if any(colons)  % saves a little time
            exindices(colons) = arrayfun(@(x) {1:x}, sz(colons));
        end

        % Check the indices (rules are checked as required in extend)
        checkindex = @(ind) validateattributes(ind, {'numeric'}, {'integer'}, 'exindex', 'index');
        cellfun(checkindex, exindices);
    end

    function [ind, tofill]              = extend(   ind, rule, s )         
        % The core function: maps extended array subscripts into valid input array subscripts.

        if ischar(rule)    % pad with rule
            tofill = [];   % never used
            switch rule
                case 'replicate'
                    ind = min( max(1,ind),  s);
                case 'circular'
                    ind = mod(     ind-1,   s) + 1;
                case 'symmetric'
                    ind = mod(     ind-1, 2*s) + 1;
                    ott = ind > s;
                    ind(ott) = 2*s + 1 - ind(ott);
                otherwise
                    error('exindex:badopt', 'Unknown option');
            end

        elseif iscell(rule) && isscalar(rule)     % pad with constant

            tofill = ind < 1 | ind > s;
            ind(tofill) = 1;

        else
            error('exindex:badconst', 'Expecting string or scalar cell');
        end
    end
end