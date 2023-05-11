clc
clear

% setup
%p = [0.5, 0.2, 0.2, 0.1] ;
% p_sort = sort(p, "descend");
% m = length(p) ; 
% loops = m - 1 ;

% % arrays to track
% idx_pos_arr = [] ;
% idx_bit_arr = [] ;
% 
% % dict to tie idx_pos_arr to idx_bit_arr
% dict = dictionary(idx_pos_arr, idx_bit_arr) ;
% 
% % init empty str arr
% idx_str_arr = strings(1, m) ; 
% 
% sub_array = p_sort(1:m) 
% for i=1:loops
%     i
%     % temp_p_arr = zeros(1, m - i)
%     [Val, Idx] = mink(sub_array, 2)
%     %val_length = length(Val)
%     for idx=Idx
%         idx
%     end
% end



p =  [0.2, 0.15, 0.13, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06] ;
[L, c] = huffcode(p);
disp(c)
disp(L)

c(1);