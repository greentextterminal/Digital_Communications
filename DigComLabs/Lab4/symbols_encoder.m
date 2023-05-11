function encoded_data=symbols_encoder(unique_data, codewords, data)
    % symbols are the unique data
    % codewords are the codes we use to encode symbols
    % data is the txt we are processing
    symbols = [""] % create an empty string array
    for i=1:length(unique_data)
        %unique_data(i)
        symbols(i) = unique_data(i);
    end
    
    dict = dictionary(symbols, codewords);
    
    encoded_data = [""];
    
    data_len = strlength(data);
    count = 1;
    for char=data
        encoded_data(count) = dict(char);
        count = count + 1;
    end
    
end