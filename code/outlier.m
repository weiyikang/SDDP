% 清除环境
clear all
clc

% % 计算FERET数据集中p=3时第21类的一个样本的近邻样本
% path_data = './数据集/FERET/fea';
% path_label = './数据集/FERET/gnd';
% path_trainIdx = './数据集/FERET/trainIdx';

% % 计算ORL数据集中p=4时第1类的一个样本的近邻样本
% path_data = './数据集/ORL_32x32';
% % path_label = './数据集/FERET/gnd';
% path_trainIdx = './数据集/ORL/4Train/1';

% 计算Yale数据集中p=4时第1类的一个样本的近邻样本
path_data = './数据集/Yale_32x32';
% path_label = './数据集/FERET/gnd';
path_trainIdx = './数据集/Yale/4Train/1';

load(path_data);
% load(path_label);
load(path_trainIdx);

% 加载训练集
X_train = [];
y_train = [];
for i=1:size(trainIdx,1)
    X_train = [X_train;fea(trainIdx(i),:)];
    y_train = [y_train;gnd(trainIdx(i))];
end

% % 显示原始空间中的前6个样本
% Is = X_train(1:200,:);
% faceW = 64; 
% faceH = 64; 
% numPerLine = 3; 
% ShowLine = 10; 
% 
% Y = zeros(faceH*ShowLine,faceW*numPerLine); 
% for i=0:ShowLine-1 
%   	for j=0:numPerLine-1 
%     	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(Is(i*numPerLine+j+1,:),[faceH,faceW]); 
%   	end 
% end 
% 
% imagesc(Y);
% colormap(gray);

% % 用PCA将原始数据降至150维
% options = [];
% options.ReducedDim = 150;
% [eigvector, eigvalue] = PCA(X_train, options);
% X_train = X_train*eigvector;

% 计算FERET训练集中第21个样本的同类近邻样本集合
sample = 1*4;
y_sample = y_train(sample);
I = X_train(sample,:);
res = X_train - repmat(I,15*4,1);
res = sum(abs(res).^2,2);

[~,idx] = sort(res,'ascend');
for i=1:40
    y_train(idx(i))
end

% 显示原始空间中的近邻样本
Is = [];
for i=1:40
    Is = [Is;X_train(idx(i),:)];
end
faceW = 32; 
faceH = 32; 
numPerLine = 10; 
ShowLine = 4; 

Y = zeros(faceH*ShowLine,faceW*numPerLine); 
for i=0:ShowLine-1 
  	for j=0:numPerLine-1 
    	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(Is(i*numPerLine+j+1,:),[faceH,faceW]); 
  	end 
end 

imagesc(Y);
colormap(gray);



