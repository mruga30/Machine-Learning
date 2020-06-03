%read all the images, parse them and add them to an array of 154*1600
A = imread('subject02.centerlight');
A = imresize(A,'OutputSize',[40 40]);
B = reshape(A,[1,1600]);
C = B;

myFolder = 'C:\Users\Owner\Documents\MATLAB';
filePattern = fullfile(myFolder, 'subject02.*');
jpegFiles = dir(filePattern);
for k = 2:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject03.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject04.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject05.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject06.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject07.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject08.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject09.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject10.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject11.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject12.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject13.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject14.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

filePattern = fullfile(myFolder, 'subject15.*');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  imageArray = imread(fullFileName);
  A = imresize(imageArray,'OutputSize',[40 40]);
  B = reshape(A,[1,1600]);
  C = [C;B];
end

%Calculate the mean and standard deviation of each row in matrix
D = double(C);
M = mean(D);
S = std(D);
 
%Standardise the data
for k = 1:1600
   for j = 1:154
        D(j,k)= D(j,k)-M(1,k);
        D(j,k)= D(j,k)/S(1,k);
   end
end

%calculate the eigenvalues and eigenvectors
E = cov(D);
[vec,val] = eig(E);

%sort the eigenvalues and eigenvectors
[d,ind] = sort(diag(val));
val_sorted = val(ind,ind);
vec_sorted = vec(:,ind);

%find the principal component
vec_proj = vec_sorted(:,1600);
Z = D(1,:)*vec_proj; %using principal component

%no. of principal components required
percent = 0;
val_sum = 0;
npc = -1;
sum = trace(val);
k =1600;
while (percent<=0.95)
    val_sum = val_sum + val(k,k);
    percent = val_sum/sum;
    npc = npc+1;
    k = k-1;
end

%visualise most important component as image
img1 = reshape(vec_proj,[40,40]);
imshow(img1,[min(vec_proj),max(vec_proj)]);

% Reconstruction using principal vector
X = Z*(vec_proj.');
img2 = reshape(X,[40,40]);
imshow(img2,[min(X),max(X)]);

%Reconstruction using npc principal components 
NPC = 1600-npc+1;
vec_proj_2 = vec_sorted(:,NPC:1600);
Z1 = D(1,:)*vec_proj_2;%using npc components
X1 = Z1*(vec_proj_2.');
img3 = reshape(X1,[40,40]);
imshow(img3,[min(X1),max(X1)]);
