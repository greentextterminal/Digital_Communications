clear
clc
%% Average Length of Huffman Code (using given prob array)
% sort needs to be descending (non-increasing)
source = ["x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8", "x9"] ;
prob = [0.2, 0.15, 0.13, 0.12, 0.1, 0.09, 0.08, 0.07, 0.06] ;

HuffmanLength(prob) ;

%% Discrete Random Vars 
xy_probs = [0.15, 0.1, 0.15, 0.2, 0.3, 0.1] ;
% horizontal row is x, vertical row is y
x_source = ["1", "2", "3"] ;
xp1 = 0.15 + 0.2 ;
xp2 = 0.1 + 0.3 ;
xp3 = 0.1 + 0.15 ;
%xptotal = xp1 + xp2 + xp3
x_prob = [xp1, xp2, xp3] ;

y_source = ["1", "2"] ;
yp1 = 0.15 + 0.1 + 0.15 ;
yp2 = 0.2 + 0.3 + 0.1 ;
%yptotal = yp1 + yp2
y_prob = [yp1, yp2] ;

% average huffman code length for x
x_huff_len = HuffmanLength(x_prob) ;

% average huffman code length for y
y_huff_len = HuffmanLength(y_prob) ;

% joint XY Huffman length
xy_huff_len = HuffmanLength(xy_probs) ;
%% Constitution Parsing
fileID = fopen('constitution.txt', 'r') ;
formatSpec = '%s' ;
txt_data = fscanf(fileID, formatSpec) ; % too long for following prints
% returns unique elements found in txt data
unique_data = unique(txt_data) ;
% unique data length
udata_len = length(unique_data) ;
% create an array to store frequencies of an element
udata_elem_freq_array = zeros(1, udata_len) ;

% find elements (For W there is 33 instances)
% elem = unique_data(41) % idx of W
% elem_idx_positions = strfind(txt_data, elem) 
% elem_frequency = length(elem_idx_positions)

count = 1;
for uelem=unique_data % pull out element from unique elements array
    elem_idx_positions = strfind(txt_data, uelem); % get idx of uelem in txt
    elem_frequency = length(elem_idx_positions); % count frequency
    udata_elem_freq_array(count) = elem_frequency; % write freq at correponding idx
    count = count + 1 ;
end

fclose(fileID);
%% Normalizing data and getting probability array for character frequencies
freq_total = sum(udata_elem_freq_array); % get character frequency total
norm_freq_array = udata_elem_freq_array ./ freq_total ; % normalize freq to get prob
sanity_check = sum(norm_freq_array) ; % check that prob total equals 1
%% Huffman Length For 'constitution.txt'
constitution_huff_len = HuffmanLength(norm_freq_array) ;

%% Exercise 2
[L, c] = huffcode(norm_freq_array);
%[L, c] = huffcode(prob);
c
L
%% Length of Each Codeword
c_lengths = zeros(1, length(c)) ;
for i=1:length(c)
    c_lengths(i) = strlength(c(i)) ;
end

c_and_len_table = table(transpose(c), transpose(c_lengths));

%% Symbols Encoder
% symbols = [""] % create an empty string array
% for i=1:length(unique_data)
%     %unique_data(i)
%     symbols(i) = unique_data(i);
% end
% codewords = c;
% 
% dict = dictionary(symbols, codewords);
% 
% encoded_data = [""];
% 
% data_len = strlength(txt_data);
% count = 1;
% for char=txt_data
%     encoded_data(count) = dict(char);
%     count = count + 1;
% end

encoded_data = symbols_encoder(unique_data, c, txt_data) ;

%% Length
enc_len = length(encoded_data);
codeword_len_sum = 0;
for code=encoded_data
    codeword_len_sum = codeword_len_sum + strlength(code);
end
codeword_len = codeword_len_sum / enc_len;

%% Codeword Decoder
decoded_data = decoder(unique_data, c, encoded_data)

% symbols2 = [""] % create an empty string array
% for i=1:length(unique_data)
%     %unique_data(i)
%     symbols2(i) = unique_data(i);
% end
% codewords = c;
% 
% dict2 = dictionary(codewords, symbols2);
% decoded_data = [""]
% 
% data_len = strlength(txt_data);
% count = 1;
% for codeword=encoded_data
%     decoded_data(count) = dict2(codeword);
%     count = count + 1;
% end
























% using p as prob array
% p = prob ;
% m = length(p) ;
% q = zeros(1, 2*m-1) ;
% k = linspace(1, m-1, m-1) ;
% 
% % writing probs into q vector
% q(1:m) = p ;
% 
% % sorting q probs
% q = sort(q, 'ascend') ;
% 
% 
% for kval=k
%     idx_shifter = 2 * kval + 1 ; % shifts across q vector as probs are used
%     % finding lowest probs from available selection
%     q_selection = q(idx_shifter:end) % available q selection
%     q_nonzero = q_selection(q_selection~=0)
%     q_sort = sort(q_nonzero, 'ascend')
%     
%     kval
%     sub_idx1 = 2*kval+1
%     sub_idx2 = 2*kval+m-kval-1
%     subvector_idx_pos = linspace(sub_idx1, sub_idx2, sub_idx2-sub_idx1)
% 
%     if kval == k(end)
%         smallest_vals = q_sort(1) ; 
%         val1 = smallest_vals(1)
%         
%     else
%         smallest_vals = q_sort(1:2) ;
%         val1 = smallest_vals(1)
%         val2 = smallest_vals(2)
%         q(2*kval-1) = val1
%         q(2*kval) = val2
%         s = q(2*kval-1) + q(2*kval)
% 
%     end
%     
%     % s = q(2*kval-1) + q(2*kval);
%     
% end

% function [L,c] = huffcode(p)
%     L = HuffmanLength(p)
%     % non decreasing = increasing
%     
% 
% end

