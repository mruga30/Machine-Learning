D = csvread('x06Simple.csv',1,1);
%disp(D);
[row,col] = size(D);

%randomize the data
for seed=0:19
    
rng(seed);
ind = randperm(row);
RD = D(ind,:);

S = 3;
%divide into training and testing data 
s_ind= ceil((1*row)/S);
for i=1:(S-1)
    row_dist(1,i) = s_ind;
end    
row_dist(1,i+1)=row-(S-1)*s_ind;
fold = mat2cell(RD,row_dist);
% disp(fold{1});
% disp(fold{2});
% disp(fold{3});

SE =0;

for i=1:S
    a = 1:S;
    tr ={};
    
    %assign fold i to testing data
    ts = fold{i};
    [ts_ind,col_ts] = size(ts);
    
    %assign other folds to training data
    b = a(a~=i);
    
    for j = b
        tr = [tr;fold{j}];
    end   
    tr = cell2mat(tr);
    [tr_ind,col_tr] = size(tr);
    
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
        for j = 1:ts_ind
             ts1(j,k)= ts1(j,k)-M(1,k);
             ts1(j,k)= ts1(j,k)/S(1,k);
        end
    end

    %add the bias value
    ts2 = zeros(ts_ind,1);
    ts2(1:ts_ind,1) = 1;

    for k = 2:(col+1)
        for j = 1:ts_ind
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
    for k = 1:ts_ind
       MSE = MSE + (Y_exp(k,1)-Y_ts(k,1))^2;
    end
    
    SE = SE + MSE;
    S = 3;
end

%calculate RMSE
RMSE(seed+1,1) = sqrt(SE/S);   
end

M = mean(RMSE);
STD = std(RMSE);

disp("No. of folds");
disp(S);
% disp("RMSE");
% disp(RMSE);
disp("Mean");
disp(M);
disp("Standard Deviation");
disp(STD)