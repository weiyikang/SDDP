% 清除环境
clear all;
clc;

% 样本个数
ratio = 6;

path = 'ORL';
% path = 'Yale';

% 绘制曲线图

path_lsda = [path,num2str(ratio),'_acc_1to50_32lsdp01'];
lsdp01 = load(path_lsda,'acc_avg');
path_mmc = [path,num2str(ratio),'_acc_1to50_32lsdp005'];
lsdp005 = load(path_mmc,'acc_avg');
path_lda = [path,num2str(ratio),'_acc_1to50_32lsdp001'];
lsdp001 = load(path_lda,'acc_avg');
path_pca = [path, num2str(ratio), '_acc_1to50_32lsdp0001'];
lsdp0001 = load(path_pca,'acc_avg');

% 取结构体中的值

lsdp01 = getfield(lsdp01,'acc_avg');
lsdp005 = getfield(lsdp005,'acc_avg');
lsdp001 = getfield(lsdp001,'acc_avg');
lsdp0001 = getfield(lsdp0001,'acc_avg');

% 转化为%制
lsdp01 = lsdp01*100;
lsdp005 = lsdp005*100;
lsdp001 = lsdp001*100;
lsdp0001 = lsdp0001*100;

x = 10:50;
plot(x,lsdp01(10:50),':*',x,lsdp005(10:50),':^',x,lsdp001(10:50),':V',x,lsdp0001(10:50),':o');
xlabel('Reduced dimensions');
ylabel('Accuracy rates(%)');
% legend('Baseline','PCA','LDA','LSDA','LDP','LGSDP','Location','Best');
legend('\alpha=0.1','\alpha=0.05','\alpha=0.01','\alpha=0.001','Location','Best');


% % 显示图片
% load('./数据集/Yale_32x32.mat');
% faceW = 32; 
% faceH = 32; 
% numPerLine = 11; 
% ShowLine = 7; 
% 
% Y = zeros(faceH*ShowLine,faceW*numPerLine); 
% for i=0:ShowLine-1 
%   	for j=0:numPerLine-1 
%     	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(fea(i*numPerLine+j+1,:),[faceH,faceW]); 
%   	end 
% end 
% 
% imagesc(Y);colormap(gray);

