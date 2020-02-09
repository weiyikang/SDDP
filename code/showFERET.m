
%% 加载数据
load('F:\论文阅读\2018-10月论文\实验\SubspaceLearning\数据集\FERET_32x32.mat');
Is = fea(1:22,:);

% for i=1:10
%     img = reshape(Is(:,i),[80,80]);
%     imagesc(img);
%     colormap(gray);
% end

faceW = 32; 
faceH = 32; 
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

