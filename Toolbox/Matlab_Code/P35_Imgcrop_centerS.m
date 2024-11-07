function  Image = P35_Imgcrop_centerS(Input,Side_Long)
%  Embedded the input into a black background.
%  The size of the imput is larger than. 
%  the size of the background.
% This is the test
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for a = 6:7
%     for b = 2:3
%         tst0 = 1:a;
%         Imput = tst0'*tst0;              disp(Imput)
%         Image = P35_Imgcrop_center(Imput,b,b);  disp(Image)
%         Image = P35_Imgcrop_centerN(Imput,b,b);  disp(Image)
%         Image = P35_Imgcrop_centerP(Imput,b,b);  disp(Image)
%         Image = P35_Imgcrop_centerS(Imput,b  );  disp(Image)
%     end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    Size_old = [size( Input,1  ), size( Input,2  )];
    Size_new = [round(Side_Long), round(Side_Long)];
    if( Size_old(1)<Size_new(1)||Size_old(2)<Size_new(2))
        error('Wrong use of the function!!!!!!!');
    end
    
    disp(['An image of size: ', num2str(Size_new(1),'%.0f'), ' X ', num2str(Size_new(2),'%.0f'),...
          ' is cropped from '  ,...
          'an image of size: ', num2str(Size_old(1),'%.0f'), ' X ', num2str(Size_old(2),'%.0f')])
    
    IndexIni = ceil(Size_old/2) - floor((Size_new-1)/2) - 1;
    
    Image = Input(  IndexIni(1) + ( 1 :  Size_new(1) ) , ...
                    IndexIni(2) + ( 1 :  Size_new(2) ) , :);
end