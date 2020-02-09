% 清除环境
clear all
clc

% 显示图片

% ORL数据集，40个人，每人10张灰度图像
% load('./数据集/ORL_32x32.mat');

% Yale数据集，15个人，每人10张灰度图像
load('./数据集/Yale_32x32.mat');

% PIE数据集，68个人，每人170张灰度图像（数据集太大）
% load('./数据集/PIE_32x32.mat');

% % AR数据集，120个人，每人14张灰度图像
% load('./数据集/AR_32x32.mat');

% % FERET数据集，200个人，每人7张灰度图像
% load('./数据集/FERET_32x32.mat');

faceW = 32; 
faceH = 32; 
numPerLine = 11; 
ShowLine = 1; 

Y = zeros(faceH*ShowLine,faceW*numPerLine); 
for i=0:ShowLine-1 
  	for j=0:numPerLine-1 
    	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(fea(i*numPerLine+j+1,:),[faceH,faceW]); 
  	end 
end 

imagesc(Y);
colormap(gray);


