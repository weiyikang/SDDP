% 清除环境
clear all;
clc;

% 样本个数
ratio = 4;

path = 'ORL';
% path = 'Yale';

% 绘制曲线图
path_pca = [path, num2str(ratio), '_acc_1to40_pca'];
pca = load(path_pca,'acc_avg');
path_lsda = [path,num2str(ratio),'_acc_1to40_lsda'];
lsda = load(path_lsda,'acc_avg2');
% path_mfa = [path,num2str(ratio),'_acc_1to45_mfa'];
% mfa = load(path_mfa,'acc');
path_mmc = [path,num2str(ratio),'_acc_1to40_mmc'];
mmc = load(path_mmc,'acc_avg');

path_lda = [path,num2str(ratio),'_acc_1to40_lda'];
lda = load(path_lda,'acc_avg');

path_lpp = [path,num2str(ratio),'_acc_1to40_baseline'];
baseline = load(path_lpp,'acc_avg');
% 
path_lpp = [path,num2str(ratio),'_acc_1to40_lpp'];
lpp = load(path_lpp,'acc_avg');
% 
% path_wlda = [path,num2str(ratio),'_acc_1to45_wlda'];
% wlda = load(path_wlda,'acc');

ldp = [path,num2str(ratio),'_acc_1to40_ldp'];
ldp = load(ldp,'acc_avg3');

lgsdp = [path,num2str(ratio),'_acc_1to40_LGSDP'];
lgsdp = load(lgsdp,'acc_avg1');

% slsda = [path,num2str(ratio),'_acc_1to45_slsda'];
% slsda = load(slsda,'acc');

% 取结构体中的值
pca = getfield(pca,'acc_avg');
lsda = getfield(lsda,'acc_avg2');
% mfa = getfield(mfa,'acc');
mmc = getfield(mmc,'acc_avg');
lda = getfield(lda,'acc_avg');
baseline = getfield(baseline,'acc_avg');
lpp = getfield(lpp,'acc_avg');
% wlda = getfield(wlda,'acc');
ldp = getfield(ldp,'acc_avg3');
lgsdp = getfield(lgsdp,'acc_avg1');
% slsda = getfield(slsda,'acc');

x = 1:40;
% plot(x,Yale_pca,':^',x,Yale_mmc,':V',x,Yale_mfa,':*',x,Yale_mdp,':>',x,Yale_lpp,':o');
% plot(x,baseline,x,pca,x,lda,x,lsda,x,ldp,x,lgsdp);
plot(x,baseline,x,pca,':o',x,mmc,':*',x,lsda,':^',x,ldp,':V',x,lgsdp,':>');
xlabel('维数');
ylabel('准确率');
% legend('Baseline','PCA','LDA','LSDA','LDP','LGSDP','Location','Best');
legend('Baseline','PCA','MMC','LSDA','LDP','LSDP','Location','Best');

[Y_pca,I_pca] = max(pca)
[Y_mmc,I_mmc] = max(mmc)
[Y_lsda,I_lsda] = max(lsda)
% [Y_mfa,I_mfa] = max(mfa)
[Y_lda,I_lda] = max(lda)
[Y_lpp,I_lpp] = max(lpp)

[Y_ldp,I_ldp] = max(ldp)
[Y_lgsdp,I_lgsdp] = max(lgsdp)
% [Y_slsda,I_slsda] = max(slsda)

[Y_baseline,I_baseline] = max(baseline)

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

