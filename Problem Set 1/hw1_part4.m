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
M = mean(C);
D = double(C);
S = std(D);

%Standardise the data
for k = 1:1600
   for j = 1:154
        D(j,k)= D(j,k)-M(1,k);
        D(j,k)= D(j,k)/S(1,k);
   end
end

nocl = 2;
myKMeans(D,nocl);
%myKMeans function with input dataset X and no. of clusters nocl
function a = myKMeans(D,nocl)

%m=number of observations, n = no.of features
[m,n]= size(D);

  if n > 3
    %pca reduction
    E = cov(D);
    [vec,val] = eig(E);
    
    [d,ind] = sort(diag(val));
    val_sorted = val(ind,ind);
    vec_sorted = vec(:,ind);
    
    %find the 3 principal components
    vec_proj = vec(:,1598:1600);

    Z = D*vec_proj;
  end
  
  %generate random indices
  rng(0);
  ind = randi([1,m],1,nocl);
  
  %reference vectors
  ref = Z(ind,:);
  %[r,c]= size(Z);
  
  
  %Eucledian Distance
  for k = 1:nocl
      for i = 1:m
          sub = Z(i,:)-ref(k,:);
          dist(k,i) = norm(sub); 
      end
  end
    
  %divide into clusters
  [min_val,index] = min(dist);
  CZ1 =[];
  CZ2 =[];
  for i = 1:m
      if index(1,i) == 1
          CZ1 = [CZ1;Z(i,:)];
      else 
          CZ2 = [CZ2;Z(i,:)];
      end  
  end
  
%   fid = figure;
  f=1;
  plot3(CZ1(:,1),CZ1(:,2),CZ1(:,3), 'x', 'Color', 'red');
  Frame(f)=getframe(gcf);
  hold on
  f=f+1;
  plot3(CZ2(:,1),CZ2(:,2),CZ2(:,3), 'x', 'Color', 'blue');
  Frame(f)=getframe(gcf);
  f=f+1;
  plot3(ref(1,1),ref(1,2),ref(1,3), 'o', 'MarkerFaceColor', 'red');
  Frame(f)=getframe(gcf);
  f=f+1;
  plot3(ref(2,1),ref(2,2),ref(2,3), 'o', 'MarkerFaceColor', 'blue');
  Frame(f)=getframe(gcf);
  f=f+1;
  writerObj = VideoWriter('K_2.avi'); 
  writerObj.FrameRate = 1;
  open(writerObj);

  
  MCZ1 = mean(CZ1);
  MCZ2 = mean(CZ2);
  refn = [MCZ1;MCZ2];

  man_dist = sum(abs(refn-ref).');
  man_dist = man_dist.';
  
  e_dist = sum(man_dist);
  e = 2^(-23);
  
  ref = refn;
  
  noi = 0;
  
  while (e_dist>e)
      for k = 1:nocl
          for i = 1:m
          sub = Z(i,:)-ref(k,:);
          dist(k,i) = norm(sub); 
          end
      end
      
      [min_val,index] = min(dist);
      CZ1 =[];
      CZ2 =[];
      for i = 1:m
          if index(1,i) == 1
              CZ1 = [CZ1;Z(i,:)];
          else
              CZ2 = [CZ2;Z(i,:)];
          end
      end
      
      refn = [];
      MCZ1 = mean(CZ1);
      MCZ2 = mean(CZ2);
      refn = [MCZ1;MCZ2];
      
      man_dist = sum(abs(refn-ref).');
      man_dist = man_dist.';
      e_dist = sum(man_dist);
      ref = refn;
      Z = [CZ1;CZ2];
      noi = noi+1;
      
      plot3(CZ1(:,1),CZ1(:,2),CZ1(:,3), 'x', 'Color', 'red');
      hold on;
      Frame(f)=getframe(gcf);
      f=f+1;
      plot3(CZ2(:,1),CZ2(:,2),CZ2(:,3), 'x', 'Color', 'blue');
      Frame(f)=getframe(gcf);
      f=f+1;
      plot3(MCZ1(:,1),MCZ1(:,2),MCZ1(:,3), 'o', 'MarkerFaceColor', 'red');
      Frame(f)=getframe(gcf);
      f=f+1;
      plot3(MCZ2(:,1),MCZ2(:,2),MCZ2(:,3), 'o', 'MarkerFaceColor', 'blue');
      Frame(f)=getframe(gcf);
      f=f+1;
      
  end
  hold off
  writeVideo(writerObj, Frame);
  close(writerObj);
end