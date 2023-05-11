function decoded_data=decoder(unique_data, codewords, encoded_data)
    symbols2 = [""] % create an empty string array
    for i=1:length(unique_data)
        %unique_data(i)
        symbols2(i) = unique_data(i);
    end
    
    dict2 = dictionary(codewords, symbols2);
    decoded_data = [""]
    
    data_len = strlength(encoded_data);
    count = 1;
    for codeword=encoded_data
        decoded_data(count) = dict2(codeword);
        count = count + 1;
    end
end