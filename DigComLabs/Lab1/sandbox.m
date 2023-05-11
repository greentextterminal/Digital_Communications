
y = [1 2 1 2 1 2 1 2 1 2]
fs = 


idx1 = 1;
count = 1;
while count <= fs
    if (mod(idx1,2)==0)
        element = transposed_y(idx1) ; 
        downsampled_result(count) = element ;
        count = count + 1;
    end
    idx1 = idx1 + 1;
end