function [bit_error, block_error] = golay_error_prob_calc(u, Q, I, G, H, received_signal)
    % error prob 
    bit_error = 0 ;
    block_error = 0 ;

        
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
    C ;
    
    % finding dmin 
    dmin = sum(C(2, :)) ; % init to second row, since cannot be 0 row vector
    for i=2:u_row_size % skip first 0 row, check all others
        dmin_check = sum(C(i, :)) ;
        if (dmin_check <= dmin)
            dmin = dmin_check ;
        end
    end
    dmin ;
    
    %% Exercise 3 Syndrome Table Construction
    % we have a (6, 3) code
    t = (dmin - 1) / 2 ; 
    
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
    errors_mat = zeros(HT_row * dmin, C_col_size) ; % adjust for up to 7 bits
    % row dim of errors wont be HT_row * dmin, but decrease as error grows,
    % HT_row * dmin is max estimate
    error_positions_arr = zeros(1, G_col_size) ;
    row_idx = 1;
    inner_limit = HT_row ;
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
    %% START MAIN LOOP HERE 
    for i=1:10^4
        current_signal_vector = received_signal(i, :) ;
        %% Exercise 4 Decode Recieved Vector
        address = 0 ; % init to 0 to signal error if not found or codeword is valid
        flag_var = 0 ; % flag is codeword found in codewords list
        decoded_codeword = zeros(1, C_col_size) ; % initialize
        % find recieved vector in C first then through syndrome
        for i=1:C_row_size
            c_row_check = C(i, :) ;
            if (c_row_check == current_signal_vector)
                address = i;
                flag_var = 1 ;
                decoded_codeword = C(address, :) ;
            end
        end
    
        %if (address == 0)
        if (flag == 0)
            % identify syndrome of recieved vector
            vector_syndrome = mod(current_signal_vector * H_tran, 2) ;
            % identify address (row idx) of syndrome in syndromes_mat
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
                if (extracted_recieved == current_signal_vector)
                    codeword_loc = i ;
                    break
                end
                idx1 = idx2 + 1 ;
            end
            decoded_codeword = C(codeword_loc, :);
        end
        
        %% Probability Processing 1
        % block 
        if decoded_codeword == current_signal_vector
            block_error = block_error + 0 ;
        else
            block_error = block_error + 1;
        end

        % bits
        mismatch_bits = 0;
        for i=1:C_col_size
            if (decoded_codeword(i) ~= current_signal_vector(i))
                mismatch_bits = mismatch_bits + 1 ;
            end
        end
        bit_error = bit_error + mismatch_bits ;
    end 
    %% Prob Processing 2
    total_blocks = 10^4 ;
    total_bits = 10^4 * C_col_size ;

    block_error = block_error / total_blocks ;
    bit_error = bit_error / total_bits ;

end