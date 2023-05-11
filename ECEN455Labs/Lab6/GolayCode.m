clc
clear
load('golay.mat')
% start from lec.24
% x codeword : (n, k)
% n: codeword (block) length, k: message length, d: hamming distance
% Generator matrix (G) is (k, n) which has k rows and n columns 
% codeword x for u is x=uG ; u is any input vector
%(23, 12) 
%% Exercise 1 (Linear Codes)
n=23 ;
k=12 ; % num message bits
codewords_num = 2^k ; % message bits

% Creating u message vector
u = zeros(codewords_num,k) ;
num = 0 ;
for i=1:codewords_num
    bin_str = dec2bin(num, k) ;
    u_row = u(i,:) ;
    for j=1:k
        char_extraction = extract(bin_str, j) ;
        integer = str2double(char_extraction) ;
        u_row(j) = integer ;
    end
    u(i,:) = u_row ;
    num = num + 1 ;
end

u ;
%% Exercise 2
% uG=x , where x is codeword
I = eye(k) ; % Identity mat
G = [Q I] ; % Generator mat
H = [eye(11) 1*transpose(Q)] ;

% uG matrix -> x matrix -> codeword (C) matrix
[u_row_size, u_col_size] = size(u) ;
[G_row_size, G_col_size] = size(G) ;
% C (u_row_size x G_col_size)
C = zeros(u_row_size, G_col_size);

% row extraction, uG=x, and generating C
for i=1:u_row_size
    u_row = u(i, :) ;
    uG_row = mod( (u_row * G), 2) ; % x , modded
    C(i, :) = uG_row ;
end
%C

% finding dmin 
dmin = sum(C(2, :)) ; % init to second row, since cannot be 0 row vector
for i=2:u_row_size % skip first 0 row, check all others
    dmin_check = sum(C(i, :)) ;
    if (dmin_check <= dmin)
        dmin = dmin_check ;
    end
end
dmin ;

%% Exercise 3 Syndrome Table Construction SHOW POSSIBLE SYNDROMES
t = (dmin - 1) / 2 ; % t : error correction capability pg.92
% 7 bit error correction

% creating codeword matrix
[C_row_size, C_col_size] = size(C) ;
codewords = zeros(1, (C_row_size * C_col_size)) ;
% populating codeword mat with C rows from C
idx1 = 0 ;
idx2 = 1 ;
for i=1:C_row_size
    C_row = C(i, :) ;
    %codewords(:, i * C_col_size) = C_row
    idx2 = i * C_col_size ;
    codewords(idx1 + 1:idx2) = C_row ;
    idx1 = idx2 ;
end

% the tranpose of H gives us the syndrome error code
H_tran = transpose(H) ;
[HT_row, HT_col] = size(H_tran) ;
syndromes_mat = H_tran ;
syndromes_mat

% creating error patterns matrix
errors_mat = zeros(HT_row * dmin, C_col_size) ; % adjust for up to 7 bits
% row dim of errors wont be HT_row * dmin, but decrease as error grows,
% HT_row * dmin is max estimate
error_positions_arr = zeros(1, G_col_size) ;
row_idx = 1;
inner_limit = HT_row
for i=1:dmin
    error_size = ones(1, i) ;
    for j=1:inner_limit
        errors_mat(row_idx, j:j+i-1) = error_size ;
        row_idx = row_idx + 1 ; % incremenet row idx
    end
    inner_limit = inner_limit - 1 ; % decrement to account for growing error
end

% creating standard table
standard_table = zeros(HT_row, length(codewords)) ;
idx1 = 1 ;
idx2 = 1 ;
for i=1:C_row_size
    idx2 = i * C_col_size ;
    codeword_for_processing = codewords(idx1:idx2) ;
    for j=1:C_col_size
        % codeword_for_processing
        error = errors_mat(j,:) ;
        recieved = codeword_for_processing + error ;
        standard_table(j, idx1:idx2) = mod(recieved, 2) ;
    end
    idx1 = idx2 + 1 ; % move idx cursor
end

%% Exercise 5
% coding gain pg. 89, 90
% theoretical bit error probabilities:
error_rate1 = 0.05
error_rate2 = 0.10
error_rate3 = 0.15

% theoretical block error probabilites for error rates 1, 2, 3
g_pblock1 = 0 ;
g_pblock2 = 0 ;
g_pblock3 = 0 ;
for i=(t+1):n 
    bincof = nchoosek(n, i) ;
    pb1_i = bincof * error_rate1^i * (1-error_rate1)^(n-i) ;
    g_pblock1 = g_pblock1 + pb1_i ;
    
    pb2_i = bincof * error_rate2^i * (1-error_rate2)^(n-i) ;
    g_pblock2 = g_pblock2 + pb2_i ;

    pb3_i = bincof * error_rate3^i * (1-error_rate3)^(n-i) ;
    g_pblock3 = g_pblock3 + pb3_i ;
end
g_pblock1
g_pblock2
g_pblock3

% simulating with introduced errors
% get 10^4 random code words
signal_rand_idx = randi([1 C_row_size], 1, 10^4) ;
signal = C(signal_rand_idx, :) ; % random signals (transmitted signals x)
% pass signals through a BSC channel to introduce error rate
signal_e1 = bsc(signal, error_rate1) ;
signal_e2 = bsc(signal, error_rate2) ;
signal_e3 = bsc(signal, error_rate3) ;

[g_bit_error1, g_block_error1] = golay_error_prob_calc(u,Q,I,G,H,signal_e1) ;
[g_bit_error2, g_block_error2] = golay_error_prob_calc(u,Q,I,G,H,signal_e2) ;
[g_bit_error3, g_block_error3] = golay_error_prob_calc(u,Q,I,G,H,signal_e3) ;
g_bit_error1 
g_bit_error2 
g_bit_error3
g_block_error1 
g_block_error2
g_block_error3

%% Exercise 6 Coding Gain over Uncoded BPSK
% assume error rate to be p=10^-5
p = 10^-5 ;
R = k / n ;
% coded BPSK
SNRc = (1 / (2*R)) * (qfuncinv(p)) ^ 2 ;
SNRc_dB = 10 * log10(SNRc) ;
% uncoded BPSK
% in uncoded transmission code is not used so codeword len = message len,
% R=1
SNRu = (1 / 2) * (qfuncinv(p)) ^ 2 ;
SNRu_dB = 10 * log10(SNRu) ;
% coding gain
gain = SNRc_dB - SNRu_dB 

