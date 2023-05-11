function avg_code_length = HuffmanLength(prob_arr)
    % prob_arr
    sorted_array = sort(prob_arr, 'descend') ;

    m = length(sorted_array) ;
    j_max = m - 2 ;
    j_vals = linspace(0, j_max, j_max + 1) ;
    
    length_sum = 0 ;

    for j=j_vals % for loop j_vals amount of times
        % get prob sum from last two probability elements of array
        %p1 = sorted_array(end-1)
        %p2 = sorted_array(end)
        prob_sum = sorted_array(end-1) + sorted_array(end) ;
        % sum the last two prob elements to total sum
        length_sum = length_sum + prob_sum ;
        % delete last element from array
        sorted_array(end) = [] ;
        % overwrite last element with summed prob of prob_sum
        sorted_array(end) = prob_sum ;
        % resort the array
        sorted_array = sort(sorted_array, 'descend') ;
    end
    
    avg_code_length = length_sum ;
end


