D = csvread('Complete_dataset_classes_relax.csv',2,0);
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

if spr>nspr
    Default = 1;
else
    Default = 0;
end

%mean and std Model/parameters 
MSP = mean(SP(:,1:(col-1)));
SSP = std(SP(:,1:(col-1)));
MNSP = mean(NSP(:,1:(col-1)));
SNSP = std(NSP(:,1:(col-1)));

tr1 = tr;
Attributes = 1:(col-1);
Trainset = tr(:,:);

tree = DTL(Trainset, Attributes, Default);

for k = 1:(row-tr_ind)
    Testset = ts(k,:);
    class_name = classify(Testset,tree);
    ts(k,col+1) = class_name;
end

%calculate accuracy
ts1 = ts;
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

function[tree]=DTL(examples, attributes, default)
tree = struct('index','null','left','null','right','null','decision','null');
if (isempty(examples))
    tree.decision = default;
    return
end

[rw,cl] = size(examples);
lastcol = sum(examples(:,cl));

if lastcol == 0
    tree.decision = 0;
    return
end

if lastcol == rw
    tree.decision = 1;
    return
end

if (isempty(attributes))
    tree.decision = mode(examples(:,cl));
    return
end

count = 1;
%calculate the information gain of all features in examples
for k = 1:length(attributes)
    sp_count_n = 0;
    nsp_count_n = 0;
    sp_count_p = 0;
    nsp_count_p = 0;
    neg_count = 0;
    pos_count= 0;
    for j = 1:rw
        if examples(j,k)<0 
            neg_count = neg_count+1;
            if examples(j,cl) == 0  
                nsp_count_n = nsp_count_n+1;
            else
                sp_count_n = sp_count_n+1;
            end
        else    
            pos_count = pos_count+1;
            if examples(j,cl) == 0  
                nsp_count_p = nsp_count_p+1;
            else
                sp_count_p = sp_count_p+1;
            end
        end    
    end
    E_neg = -(sp_count_n/neg_count)*log2(sp_count_n/neg_count)-(nsp_count_n/neg_count)*log2(nsp_count_n/neg_count);
    E_pos = -(sp_count_p/pos_count)*log2(sp_count_p/pos_count)-(nsp_count_p/pos_count)*log2(nsp_count_p/pos_count);
    E(1,count) = (neg_count/rw)*E_neg+(pos_count/rw)*E_pos;
    count = count+1;
end
count = count-1;
[val,indx]=min(E); %minimum entropy has maximum information gain

tree.index = attributes(1,indx);
attributes(:,indx) = [];

examples_0 = []; examples_0_count = 0;
examples_1 = []; examples_1_count = 0;
for k=1:rw
    if examples(k,indx)<0
        examples_0_count = examples_0_count+1;
        for j=1:length(attributes)
        examples_0(examples_0_count,j) = examples(k,j);
        end
    else
        examples_1_count = examples_1_count+1;
        for j=1:length(attributes)
        examples_1(examples_1_count,j) = examples(k,j);
        end
    end
end    

if (isempty(examples_0))
    if(mode(examples(:,cl))==0)
        tree.decision=0;
    else
        tree.decision = 1;
    end
else
    default = mode(examples_0(:,length(attributes)));
    tree.left = DTL(examples_0, attributes, default);
end

if (isempty(examples_1))
    if(mode(examples(:,cl))==0)
        tree.decision=0;
    else
        tree.decision = 1;
    end
else
    default = mode(examples_1(:,length(attributes)));
    tree.right = DTL(examples_1, attributes, default);
end

return
end

function[class_name] = classify(Testset,tree)
for k = 1:(length(Testset))
    if Testset(1,k) < 0
            if k == tree.index
                 class_name = 0;
                 return
            else
                classify(Testset,tree.left);
            end
        
    else
            if k == tree.index
                 class_name = 1;
                 return
            else
                classify(Testset,tree.right);
            end
        
    end
end

return
end