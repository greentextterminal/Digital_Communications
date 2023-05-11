clc
clear
% start from lec.24
% x codeword : (n, k)
% n: codeword (block) length, k: message length, d: hamming distance
% Generator matrix (G) is (k, n) which has k rows and n columns 
% codeword x for u is x=uG ; u is any input vector

%% Exercise 1 (Linear Codes)
% k=3 , so message bits is 3
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
%% Exercise 2
% uG=x , where x is codeword
P = [1 1 0; 0 1 1; 1 0 1]
I = eye(3) % Identity mat
G = [P I] % Generator mat
H = [I 1*transpose(P)]

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
C

% finding dmin 
dmin = sum(C(2, :)) ; % init to second row, since cannot be 0 row vector
for i=2:u_row_size % skip first 0 row, check all others
    dmin_check = sum(C(i, :)) ;
    if (dmin_check <= dmin)
        dmin = dmin_check ;
    end
end
dmin

%% Exercise 3 Syndrome Table Construction
% we have a (6, 3) code
t = (dmin - 1) / 2 ; % t : error correction capability pg.92
% create the standard array pg.98, 99 
% codewords = c1=all 0 vec, c2, ..., c2^k
% s=xH^T -> x(1x6), H^T(6x3), s(1x3)
% standard array (2^n-k, 2^k)->(8, 8) : six 1 bit error and two 2 bit errors

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

% creating error patterns matrix
errors_mat = zeros(HT_row, C_col_size) ;
% possible error positions based on 1 bit error
error_positions_arr = zeros(1, G_col_size) ;
for i=1:G_col_size
    error_positions_arr(i) = 1 ; % possible bit error
    errors_mat(i, :) = error_positions_arr ;
    error_positions_arr = zeros(1, G_col_size) ; % rezero
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

syndromes_mat 
standard_table

%% Exercise 4 Decode Recieved Vector
recieved_vector = [1, 0, 1, 1, 1, 1] 
% identify syndrome of recieved vector
% s = rH^t
vector_syndrome = mod(recieved_vector * H_tran, 2) 

% identify address (row idx) of syndrome in syndromes_mat
address = 0 ; % init to 0 to signal error if not found
for i=1:HT_row
    syndrome_row = syndromes_mat(i,:) ;
    if (syndrome_row == vector_syndrome)
        address = i ;
        break
    end
end

% scan across obtained address to find recieved vector col location
codeword_loc = 0 ; % init to 0 to signal error if not found
check_row = standard_table(address, :) ; % isolate row of interest 
idx1 = 1 ;
idx2 = 1 ;
for i=1:C_row_size
    idx2 = i * C_col_size ;
    extracted_recieved = check_row(idx1:idx2) ;
    if (extracted_recieved == recieved_vector)
        codeword_loc = i ;
        break
    end
    idx1 = idx2 + 1 ;
end

decoded_codeword = C(codeword_loc, :)

%% Exercise 5
% (6, 3) code, t = 1
% coding gain pg. 89, 90
% need bit error and block error prob
% the error rates are the probabilities of bit flipping
% theoretical bit error probabilities:
error_rate1 = 0.05
error_rate2 = 0.10
error_rate3 = 0.15

n = 6;
k = 3;

% theoretical block error probabilites for error rates 1, 2, 3
pblock1 = 0 ;
pblock2 = 0 ;
pblock3 = 0 ;
for i=(t+1):n 
    bincof = nchoosek(n, i) ;
    pb1_i = bincof * error_rate1^i * (1-error_rate1)^(n-i) ;
    pblock1 = pblock1 + pb1_i ;
    
    pb2_i = bincof * error_rate2^i * (1-error_rate2)^(n-i) ;
    pblock2 = pblock2 + pb2_i ;

    pb3_i = bincof * error_rate3^i * (1-error_rate3)^(n-i) ;
    pblock3 = pblock3 + pb3_i ;
end
pblock1
pblock2
pblock3

% simulating with introduced errors
% get 10^4 random code words
signal_rand_idx = randi([1 8], 1, 10^4) ;
signal = C(signal_rand_idx, :) ; % random signals (transmitted signals x)
% pass signals through a BSC channel to introduce error rate
signal_e1 = bsc(signal, error_rate1) ;
signal_e2 = bsc(signal, error_rate2) ;
signal_e3 = bsc(signal, error_rate3) ;

[bit_error1, block_error1] = error_probability_calc(u,P,I,G,H,signal_e1) ;
[bit_error2, block_error2] = error_probability_calc(u,P,I,G,H,signal_e2) ;
[bit_error3, block_error3] = error_probability_calc(u,P,I,G,H,signal_e3) ;
bit_error1 
bit_error2 
bit_error3
block_error1 
block_error2
block_error3

%% Exercise 6 Coding Gain over Uncoded BPSK pg.102
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

























% syndrome_key = [""] % obtained from H^T
% syndrome_value = [""] % the bit error 

% % the tranpose of H gives us the syndrome error code
% H_tran = transpose(H)
% for i=1:G_col_size
%     H_tran_bin_str = num2str(H_tran(i, :)) ;
%     syndrome_key(i) = H_tran_bin_str ;
% end

% % possible error positions based on 1 bit error
% error_positions_arr = zeros(1, G_col_size) ;
% for i=1:G_col_size
%     error_positions_arr(i) = 1 ; % possible bit error
%     syndrome_value(i) = num2str(error_positions_arr) ;
%     error_positions_arr = zeros(1, G_col_size) ; % rezero
% end

