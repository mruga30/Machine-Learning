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
vec_proj = vec_sorted(:,1599:1600);

%Projection matrix using the principal component
Z = D*vec_proj;
Z_plot = plot(Z(:,1),Z(:,2),'o');