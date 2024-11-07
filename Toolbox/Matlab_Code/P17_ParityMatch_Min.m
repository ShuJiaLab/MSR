
function  size_new = P17_ParityMatch_Min(size_old,size_cmp)
%  To match the parity of number 1 and number 2
% This is the test

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tst1 = [3,4,4,3];                   disp(tst1)
% tst2 = [3,3,4,4];                   disp(tst2)
% tst3 = P20_ParityMatch(tst1,tst2);  disp(tst3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    size_new = size_old - xor(mod(size_old,2),mod(size_cmp,2));
end





