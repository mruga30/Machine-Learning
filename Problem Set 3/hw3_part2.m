filename = 'spambase.data';
D = importdata(filename,',',0);
[row,col] = size(D);

%randomize the data
rng(0);
ind = randperm(row);
RD = D(ind,:);

%divide into training and testing data 
tr_ind = ceil((2*row)/3);
tr = RD(1:tr_ind,:);
ts = RD((tr_ind+1):row,:);

%mean and standard deviation of training set
M = mean(tr(:,1:(col-1)));
S = std(tr(:,1:(col-1)));
D1 = RD;

% Standardise all data
for k = 1:(col-1)
    for j = 1:row
         D1(j,k)= D1(j,k)-M(1,k);
         D1(j,k)= D1(j,k)/S(1,k);
    end
end

tr = D1(1:tr_ind,:);
ts = D1((tr_ind+1):row,:);

%divide into spam and not spam
spr = 1;
nspr = 1;
for j = 1:tr_ind
    if tr(j,col) == 1
        SP(spr,:) = tr(j,:);
        spr = spr+1;
    else 
        NSP(nspr,:) = tr(j,:);
        nspr = nspr+1;
    end
end
spr = spr-1;
nspr = nspr-1;

%mean and std of spam(1) and not-spam(0)(Model/parameters) 
MSP = mean(SP(:,1:(col-1)));
SSP = std(SP(:,1:(col-1)));
MNSP = mean(NSP(:,1:(col-1)));
SNSP = std(NSP(:,1:(col-1)));

%calculate priors
P1 = spr/(nspr+spr);
P0 = nspr/(nspr+spr);

ts1 = ts;

%compare the probabilities and classify
for k = 1:(row-tr_ind)
    p0 = P0;
    p1 = P1;
    for j = 1:(col-1)
        a0 = (1/(SNSP(1,j)*sqrt(2*3.14)))*(exp(-1*((ts1(k,j)-MNSP(1,j))^2)/(2*(SNSP(1,j)^2))));
        a1 = (1/(SSP(1,j)*sqrt(2*3.14)))*(exp(-1*((ts1(k,j)-MSP(1,j))^2)/(2*(SSP(1,j)^2))));     
        p0 = p0*a0;
        p1 = p1*a1;
    end
    if p0 > p1
        ts1(k,col+1)=0;
    else 
        ts1(k,col+1)=1;
    end
end

TP0 = 0; TN0 = 0;
FP0 = 0; FN0 = 0;
TP1 = 0; TN1 = 0;
FP1 = 0; FN1 = 0;
%calculate the error types
for k = 1:(row-tr_ind)
    if ts1(k,col) == 0
        if ts1(k,col+1) == 0
            TP0 = TP0+1;
            TN1 = TN1+1;
        else
            FN0 = FN0+1;
            FP1 = FP1+1;
        end    
    else
        if ts1(k,col+1) == 0
            FP0 = FP0+1;
            FN1 = FN1+1;
        else
            TN0 = TN0+1;
            TP1 = TP1+1;
        end   
    end
end

precision = TP0/(TP0+FP0);
recall = TP0/(TP0+FN0);
f_measure = (2*precision*recall)/(precision+recall);
accuracy = (TP0+TN0)/(TP0+TN0+FP0+FN0);

disp(' ');
disp('CLASS 0:');
pre = ['precision: ',num2str(precision)];
disp(pre);
re = ['recall: ',num2str(recall)];
disp(re);
fm = ['f_measure: ',num2str(f_measure)];
disp(fm);
ac = ['accuracy: ',num2str(accuracy)];
disp(ac);

precision = TP1/(TP1+FP1);
recall = TP1/(TP1+FN1);
f_measure = (2*precision*recall)/(precision+recall);
accuracy = (TP1+TN1)/(TP1+TN1+FP1+FN1);

disp(' ');
disp('CLASS 1:');
pre = ['precision: ',num2str(precision)];
disp(pre);
re = ['recall: ',num2str(recall)];
disp(re);
fm = ['f_measure: ',num2str(f_measure)];
disp(fm);
ac = ['accuracy: ',num2str(accuracy)];
disp(ac);