clc
clear
% start from lec.24
% x codeword : (n, k)
% Generator matrix (G) is (k, n) which has k rows and n columns 
% codeword x for u is x=uG ; u is any input vector

%% Exercise 1 (Linear Codes)
% k=3 , so message bits is 3
n = 3
k = 3
codewords_num = 2^3

% Creating u message vector
u = zeros(8,3) ;
num = 0 ;
for i=1:codewords_num
    bin_str = dec2bin(num, 3) ;
    u_row = u(i,:) ;
    for j=1:3
        char_extraction = extract(bin_str, j) ;
        integer = str2double(char_extraction) ;
        u_row(j) = integer ;
    end
    u(i,:) = u_row ;
    num = num + 1 ;
end

u