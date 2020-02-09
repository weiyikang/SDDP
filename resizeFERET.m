% �������
clear all
clc

% ��������
path='./���ݼ�/FERET_80x80_col';
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
path='./���ݼ�/FERET/fea';
% save(path);

% ��ʾ���ź�������˸�7��ͼ��
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


