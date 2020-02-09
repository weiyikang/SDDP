% 清楚环境
clear all
clc

% 加载数据
path='./数据集/FERET_80x80_col';
load(path);

s_fea = FERET_80_80_col';
fea = [];
for i=1:1400
    I = s_fea(i,:);
    I = reshape(I,80,80);
    J = imresize(I,[64,64]);
    J = reshape(J,1,64*64);
    fea = [fea;J];
end

% fea = double(fea);
path='./数据集/FERET/fea';
% save(path);

% 显示缩放后的两个人各7张图像
Is = fea(1:22,:);
faceW = 64; 
faceH = 64; 
numPerLine = 7; 
ShowLine = 2; 

Y = zeros(faceH*ShowLine,faceW*numPerLine); 
for i=0:ShowLine-1 
  	for j=0:numPerLine-1 
    	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(Is(i*numPerLine+j+1,:),[faceH,faceW]); 
  	end 
end 

imagesc(Y);
colormap(gray);


