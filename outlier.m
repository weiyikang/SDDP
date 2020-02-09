% �������
clear all
clc

% % ����FERET���ݼ���p=3ʱ��21���һ�������Ľ�������
% path_data = './���ݼ�/FERET/fea';
% path_label = './���ݼ�/FERET/gnd';
% path_trainIdx = './���ݼ�/FERET/trainIdx';

% % ����ORL���ݼ���p=4ʱ��1���һ�������Ľ�������
% path_data = './���ݼ�/ORL_32x32';
% % path_label = './���ݼ�/FERET/gnd';
% path_trainIdx = './���ݼ�/ORL/4Train/1';

% ����Yale���ݼ���p=4ʱ��1���һ�������Ľ�������
path_data = './���ݼ�/Yale_32x32';
% path_label = './���ݼ�/FERET/gnd';
path_trainIdx = './���ݼ�/Yale/4Train/1';

load(path_data);
% load(path_label);
load(path_trainIdx);

% ����ѵ����
X_train = [];
y_train = [];
for i=1:size(trainIdx,1)
    X_train = [X_train;fea(trainIdx(i),:)];
    y_train = [y_train;gnd(trainIdx(i))];
end

% % ��ʾԭʼ�ռ��е�ǰ6������
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

% % ��PCA��ԭʼ���ݽ���150ά
% options = [];
% options.ReducedDim = 150;
% [eigvector, eigvalue] = PCA(X_train, options);
% X_train = X_train*eigvector;

% ����FERETѵ�����е�21��������ͬ�������������
sample = 1*4;
y_sample = y_train(sample);
I = X_train(sample,:);
res = X_train - repmat(I,15*4,1);
res = sum(abs(res).^2,2);

[~,idx] = sort(res,'ascend');
for i=1:40
    y_train(idx(i))
end

% ��ʾԭʼ�ռ��еĽ�������
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



