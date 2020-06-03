D = csvread('x06Simple.csv',1,1);
[row,col] = size(D);

%randomize the data
rng(0);
ind = randperm(row);
RD = D(ind,:);

%divide into training and testing data 
tr_ind = ceil((2*row)/3);
tr = RD(1:tr_ind,:);
ts = RD((tr_ind+1):row,:);

M = mean(tr(:,1:(col-1)));
S = std(tr(:,1:(col-1)));
tr1=tr;

% Standardise the training data
for k = 1:(col-1)
    for j = 1:tr_ind
         tr1(j,k)= tr1(j,k)-M(1,k);
         tr1(j,k)= tr1(j,k)/S(1,k);
    end
end

%add the bias value
tr2 = zeros(tr_ind,1);
tr2(1:tr_ind,1) = 1;

for k = 2:(col+1)
    for j = 1:tr_ind
        tr2(j,k)=tr1(j,(k-1));
    end
end

%divide training data into X and Y
X = tr2(:,1:col);
Y = tr2(:,col+1);

%calculate the theta
th = (inv((X.')*X))*(X.')*Y;

ts1=ts;
% Standardise the testing data
for k = 1:(col-1)
    for j = 1:(row-tr_ind)
         ts1(j,k)= ts1(j,k)-M(1,k);
         ts1(j,k)= ts1(j,k)/S(1,k);
    end
end

%add the bias value
ts2 = zeros(row-tr_ind,1);
ts2(1:row-tr_ind,1) = 1;

for k = 2:(col+1)
    for j = 1:(row-tr_ind)
        ts2(j,k)=ts1(j,(k-1));
    end
end

%divide testing data into X_ts and Y_ts
X_ts = ts2(:,1:col);
Y_ts = ts2(:,col+1);

%calculate the expected value
Y_exp = X_ts*th;

MSE = 0;
%calculate the MSE
for k = 1:(row-tr_ind)
   MSE = MSE + (Y_exp(k,1)-Y_ts(k,1))^2;
end

%calculate RMSE
RMSE = sqrt(MSE/(row-tr_ind));
    
