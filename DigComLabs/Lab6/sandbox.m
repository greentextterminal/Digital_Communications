clc
clear
% % start from lec.24
% % x codeword : (n, k)
% % Generator matrix (G) is (k, n) which has k rows and n columns 
% % codeword x for u is x=uG ; u is any input vector
% 
% %% Exercise 1 (Linear Codes)
% % k=3 , so message bits is 3
% n = 3
% k = 3
% codewords_num = 2^3
% P = [1 1 0; 0 1 1; 1 0 1]
% I = eye(3) % Identity mat
% G = [P I] % Generator mat
% H = [I 1*transpose(P)]
% 
% % Creating u message vector
% u = zeros(8,3) ;
% num = 0 ;
% for i=1:codewords_num
%     bin_str = dec2bin(num, 3)
%     u_row = u(i,:) ;
%     for j=1:3
%         char_extraction = extract(bin_str, j) ;
%         integer = str2double(char_extraction) ;
%         u_row(j) = integer ;
%     end
%     u(i,:) = u_row ;
%     num = num + 1 ;
% end
% 
% u



sig = 1
z1 = qfunc( 3 / sig)
z2 = qfunc(1 / sig)