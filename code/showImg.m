% �������
clear all
clc

% ��ʾͼƬ

% ORL���ݼ���40���ˣ�ÿ��10�ŻҶ�ͼ��
% load('./���ݼ�/ORL_32x32.mat');

% Yale���ݼ���15���ˣ�ÿ��10�ŻҶ�ͼ��
load('./���ݼ�/Yale_32x32.mat');

% PIE���ݼ���68���ˣ�ÿ��170�ŻҶ�ͼ�����ݼ�̫��
% load('./���ݼ�/PIE_32x32.mat');

% % AR���ݼ���120���ˣ�ÿ��14�ŻҶ�ͼ��
% load('./���ݼ�/AR_32x32.mat');

% % FERET���ݼ���200���ˣ�ÿ��7�ŻҶ�ͼ��
% load('./���ݼ�/FERET_32x32.mat');

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


