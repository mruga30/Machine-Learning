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

%initialise theta
th = -1+(1+1)*rand(col,1);

eps = 2^(-23);
error=0.1;
lr = 0.01;
i=1;

%calculate the expected value
Y_tr_exp = X*th;
Y_ts_exp = X_ts*th;

MSE_tr = 0;
%calculate the MSE
for k = 1:tr_ind
   MSE_tr = MSE_tr + (Y_tr_exp(k,1)-Y(k,1))^2;
end

%calculate RMSE
RMSE_tr(i,1) = sqrt(MSE_tr/(tr_ind));

MSE_ts = 0;
%calculate the MSE
for k = 1:(row-tr_ind)
   MSE_ts = MSE_ts + (Y_ts_exp(k,1)-Y_ts(k,1))^2;
end

%calculate RMSE
RMSE_ts(i,1) = sqrt(MSE_ts/(row-tr_ind));

i=2;
% disp(th);
% disp(i);

while i<1000001
    if error<eps
        break;
    end
    th = th-(lr/tr_ind)*(X.')*(X*th-Y);
    
    Y_tr_exp = X*th;
    Y_ts_exp = X_ts*th;
    
    %training RMSE
    MSE_tr = 0;
    for k = 1:tr_ind
       MSE_tr = MSE_tr + (Y_tr_exp(k,1)-Y(k,1))^2;
    end
    RMSE_tr(i,1) = sqrt(MSE_tr/(tr_ind));

    %testing RMSE
    MSE_ts = 0;
    for k = 1:(row-tr_ind)
       MSE_ts = MSE_ts + (Y_ts_exp(k,1)-Y_ts(k,1))^2;
    end
    RMSE_ts(i,1) = sqrt(MSE_ts/(row-tr_ind));
    
    %error
    error = abs((RMSE_tr(i-1,1)-RMSE_tr(i,1))/RMSE_tr(i-1,1));
    i=i+1;
    %th=th1;
    if i<4
        error=0.1;
    end    
end

%disp(error);
disp(th);
% disp(i-1);
disp(RMSE_ts(i-1,1));

for k=1:(i-1)
    I(k,1)=k;
end    
plot(I,RMSE_tr);
hold on
plot(I,RMSE_ts,'Color','red');
hold off