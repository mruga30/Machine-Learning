D = csvread('CTG.csv',2,0);
[row,col] = size(D);
D(:,(col-1))=[];
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

c1 = 0;
c2 = 0;
c3 = 0;
for j = 1:tr_ind
    if tr(j,col) == 1
        c1 = c1+1;
        class1(c1,:) = tr(j,:); 
    elseif tr(j,col) == 2 
        c2 = c2+1;
        class2(c2,:) = tr(j,:);
    else
        c3 = c3+1;
        class3(c3,:) = tr(j,:);
    end
end


%divide into classes
% noc = 3; %number of classes specified
% class = 1:noc;
% class_count(class) = {1}; 
% class_c = cell2mat(class_count);
% ones = class_c;
% for j = 1:tr_ind
%     for k = 1:noc
%         if tr(j,col) == k
%             class_ind(k,class_c(k))=j;
%             class_c(k) = class_c(k)+1;
%         end
%     end
% end
% class_c = class_c-ones;
% 
% tr_cell=num2cell(tr(:,:));
% class_div = {0};
% 
% for k =1:noc
%     for j = 1:length(class_ind(k,:))
%         if class_ind(k,j) == 0
%             break;
%         else
%             class_div{k}(j,:) = tr_cell(class_ind(k,j),:);
%         end
%     end
% end
% for k = 1:noc
%     M(k,:)= mean(tr(class_ind(k,:),:));
%     S(k,:)= std(tr(class_ind(k,:),:));
% end

%Naive Bayes
M1 = mean(class1(:,1:(col-1)));
S1 = std(class1(:,1:(col-1)));
M2 = mean(class2(:,1:(col-1)));
S2 = std(class2(:,1:(col-1)));
M3 = mean(class3(:,1:(col-1)));
S3 = std(class3(:,1:(col-1)));

P1 = c1/(c1+c2+c3);
P2 = c2/(c1+c2+c3);
P3 = c3/(c1+c2+c3);

ts1 = ts;

for k = 1:(row-tr_ind)
    p1 = P1;
    p2 = P2;
    p3 = P3;
    for j = 1:(col-1)
        a1 = (1/(S1(1,j)*sqrt(2*3.14)))*(exp(-1*((ts1(k,j)-M1(1,j))^2)/(2*(S1(1,j)^2))));
        a2 = (1/(S2(1,j)*sqrt(2*3.14)))*(exp(-1*((ts1(k,j)-M2(1,j))^2)/(2*(S2(1,j)^2))));     
        a3 = (1/(S3(1,j)*sqrt(2*3.14)))*(exp(-1*((ts1(k,j)-M3(1,j))^2)/(2*(S3(1,j)^2)))); 
        p1 = p1*a1;
        p2 = p2*a2;
        p3 = p3*a3;
    end
    i = [p1,p2,p3];
    if max(i) == p1
        ts1(k,col+1)=1;
    elseif max(i) == p2
        ts1(k,col+1)=2;
    else
        ts1(k,col+1)=3;
    end
end

TP1 = 0; TN1 = 0; FP1 = 0; FN1 = 0;
TP2 = 0; TN2 = 0; FP2 = 0; FN2 = 0;
TP3 = 0; TN3 = 0; FP3 = 0; FN3 = 0;

for k = 1:(row-tr_ind)
    if ts1(k,col) == 1
        if ts1(k,col+1) == 1
            TP1 = TP1+1;
            TN2 =TN2+1;
            TN3 =TN3+1;
        elseif ts1(k,col+1) == 2
            FN1 = FN1+1;
            FP2 = FP2+1;
            TN3 = TN3+1;
        else
            FN1 = FN1+1;
            TN2 = TN2+1;
            FP3 = FP3+1;
        end    
    elseif ts1(k,col) == 2
        if ts1(k,col+1) == 1
            FP1 = FP1+1;
            FN2 = FN2+1;
            TN3 = TN3+1;
        elseif ts1(k,col+1) == 2
            TN1 = TN1+1;
            TP2 = TP2+1;
            TN3 = TN3+1;
        else
            TN1 = TN1+1;
            FN2 = FN2+1;
            FP3 = FP3+1;
        end  
    else
        if ts1(k,col+1) == 1
            FP1 = FP1+1;
            TN2 = TN2+1;
            FN3 = FN3+1;
        elseif ts1(k,col+1) == 2
            TN1 = TN1+1;
            FP2 = FP2+1;
            FN3 = FN3+1;
        else
            TN1 = TN1+1;
            TN2 = TN2+1;
            TP3 = TP3+1;
        end  
    end
end

disp('Naive Bayes');
accuracy = (TP1+TN1)/(TP1+TN1+FP1+FN1);
disp('Class 1 accuracy:');
disp(accuracy);
accuracy = (TP2+TN2)/(TP2+TN2+FP2+FN2);
disp('Class 2 accuracy:');
disp(accuracy);
accuracy = (TP3+TN3)/(TP3+TN3+FP3+FN3);
disp('Class 3 accuracy:');
disp(accuracy);

%Decision Tree
% accuracy = (TP+TN)/(TP+TN+FP+FN);