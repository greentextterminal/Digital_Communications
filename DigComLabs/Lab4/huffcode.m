function [L, c] = huffcode(p)
%L = HuffmanLength(p);
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
        % switch case to choose between lower or higher prob
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
% get avg huffman length
length_sum = 0;
for code=c
    %code
    %strlength(code)
    length_sum = length_sum + strlength(code);
end
avg_huff_len = length_sum / m;
L = avg_huff_len
end
