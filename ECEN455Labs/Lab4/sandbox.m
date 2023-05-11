clear
clc

% % arr = [3, 4, 3, 4, 2, 1, 2, 3, 4]
% % res = find(arr==3)
% % 
% % 
p = [0.9, 0.4, 0.1, 2, 0.1, 0.1]
[smallest_val1, smallest_val1_idx] = min(p)
% %[Val, Idx] = mink(p, 2)
% 
% % idx_pos = [3, 4, 5]
% % idx_bit_val = ["1", "00", "101"]
% % idx_bit_val(1) = strcat(idx_bit_val(1), "WORD")
% % idx_dict = dictionary(idx_pos, idx_bit_val)
% % 
% % idx_dict(3)
% 
% i = find(p > 0)


% function c = huffcode(p)
% m = length(p); 
% c = cell(1, m);
% 
% % from descending order to ascending order 
% p = sort(p, 'ascend'); 
% 
% % initializing code word for n = 1 case 
% if m == 1
%     c(1) = "1"; 
% end
% x = zeros(m, m); 
% x(:, 1) = (1:m)'; 
% 
% for i = 1:m-1
%     temp = p; 
%     [~, min1] = min(temp);  
%     temp(min1) = 1; 
%     [~, min2] = min(temp); 
%     p(min1) = p(min1) + p(min2); 
%     p(min2) = 1; 
%     x(:, i+1) = x(:, i); 
%     for j = 1:m
%         if x(j, i+1) == min1
%             c(j) = strcat('0', c(j)); 
%         elseif x(j, i+1) == min2
%             x(j, i+1) = min1; 
%             c(j) = strcat('1', c(j));
%         end
%     end
% end
% c = fliplr(c); 
% end



%% V2 Code
% function [L, c] = huffcode(p)
% % get avg huffman length
% L = HuffmanLength(p)
% m = length(p) ; % m : num of probs
% loops = m - 1;
% codes = strings(1, m) ;
% p = sort(p, 'ascend') % sort the prob
% prob_tree_mat = zeros(m, m) ;
% zero_char = '0';
% one_char = '1' ;
% 
% % init tree indices 
% for i = 1:m
%     prob_tree_mat(i, 1) = i ;
% end
% 
% for i = 1:loops
%     p_copy = p ; % copy to not overwrite orignal p
%     % use min to get val and idx
%     % retrieving val and idx of smallest val
%     [smallest_val1, smallest_val1_idx] = min(p_copy) ;
%     % smallest_val1
%     % smallest_val1_idx
%     % overwrite val1 idx with arbitrary >1 num to disregard it
%     p_copy(smallest_val1_idx) = 100 ;
%     [smallest_val2, smallest_val2_idx] = min(p_copy) ;
%     % smallest_val2
%     % smallest_val2_idx
%     % overwrite val1 idx position with the sum of the smallest probs
%     p(smallest_val1_idx) = p(smallest_val1_idx) + p(smallest_val2_idx) ;
%     % val2 idx is overwritten with arbitrary >1 num to disregard it
%     p(smallest_val2_idx) = 100 ;
%     % copying prev idx to next column to be adjusted
%     for y=1:m
%         prob_tree_mat(y, i + 1) = prob_tree_mat(y, i);
%     end
%     for k = 1:m
%         if prob_tree_mat(k, i + 1) == smallest_val1_idx
%             % smaller probs are concatenated with zeros
%             codes(k) = strcat(zero_char, codes(k)) ;
%         elseif prob_tree_mat(k, i + 1) == smallest_val2_idx
%             % larger probs are concatenated with ones
%             prob_tree_mat(k, i + 1) = smallest_val1_idx ;
%             codes(k) = strcat(one_char, codes(k)) ;
%         end
%     end
% end
% rev_codes = flip(codes) ; 
% c = rev_codes

%% V3 code
function [L, c] = huffcode(p)
% get avg huffman length
L = HuffmanLength(p);
m = length(p); % m : num of probs
loops = m - 1;
codes = strings(1, m);
p = sort(p, 'ascend'); % sort the prob
prob_tree_mat = zeros(m, m);
zero_char = '0';
one_char = '1';

% init tree indices
for i = 1:m
    prob_tree_mat(i, 1) = i;
end

for i = 1:loops
    p_copy = p; % copy to not overwrite orignal p
    % use min to get val and idx
    % retrieving val and idx of smallest val
    [smallest_val1, smallest_val1_idx] = min(p_copy);
    % smallest_val1
    % smallest_val1_idx
    % overwrite val1 idx with arbitrary >1 num to disregard it
    p_copy(smallest_val1_idx) = 100;
    [smallest_val2, smallest_val2_idx] = min(p_copy);
    % smallest_val2
    % smallest_val2_idx
    % overwrite val1 idx position with the sum of the smallest probs
    p(smallest_val1_idx) = p(smallest_val1_idx) + p(smallest_val2_idx);
    % val2 idx is overwritten with arbitrary >1 num to disregard it
    p(smallest_val2_idx) = 100;
    % copying prev idx to next column to be adjusted
    for y = 1:m
        prob_tree_mat(y, i + 1) = prob_tree_mat(y, i);
    end
    for k = 1:m
        switch prob_tree_mat(k, i + 1)
            case smallest_val1_idx
                % smaller probs are concatenated with zeros
                codes(k) = strcat(zero_char, codes(k));
            case smallest_val2_idx
                % larger probs are concatenated with ones
                prob_tree_mat(k, i + 1) = smallest_val1_idx;
                codes(k) = strcat(one_char, codes(k));
        end
    end
end
rev_codes = flip(codes);
c = rev_codes;
end

