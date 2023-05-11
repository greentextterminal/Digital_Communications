n =2;
m = 2^n;
N = 1000;


%Initialize q values with linspace
q = linspace(-10, 10,m);

%Initialize vectors with zeros to help with memory issues
b = zeros(1,m+1);
sum = zeros(1,m);
interval = zeros(1,m);

for count = 1:100
    % For loop to update boundary values 1
    for i = 1:m+1
        if i == 1
            b(i) = -10;
        elseif i == m+1
                b(i) = 10;
        else
            b(i) = (q(i-1) + q(i))/2;
        end
    end
    
    % Interval values
    for i = 1:m
        interval(i) = (b(i+1)-b(i))/1000;
    end
    
    % Update q values
    for i = 1:m
        sum = 0;
        for j = 1:1000
            sum = sum + (normpdf(b(i) + (interval(i) * (j-1))))* interval(i);
        end
        q(i) = sum;
    end
end

%x1 = -10 + (20).*rand(N,1);
x1 = linspace(-10,10,N);

mse_sum = 0;
for i = 1:m
    for j = 1:N
        if (b(i) <= x1(j)) && (x1(j) <= b(i+1))
            mse_sum= mse_sum + (x1(j) - q(i))^2;
        end
    end
end

final_MSE = mse_sum/N
