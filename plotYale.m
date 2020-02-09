% �������
clear all;
clc;

% ��������
ratio = 5;

path = 'Yale';

% ��������ͼ
path_baseline = [path, num2str(ratio), 'baseline'];
baseline = load(path_baseline,'acc_avg');

path_pca = [path, num2str(ratio), 'pca'];
pca = load(path_pca,'acc_avg');

lda = [path,num2str(ratio),'lda'];
lda = load(lda,'acc_avg');
% 
mmc = [path,num2str(ratio),'mmc'];
mmc = load(mmc,'acc_avg');
% 
% ��δ���������Ž⣬�漰��k��tֵѡ���㷨���ֽϲ�
lpp = [path,num2str(ratio),'lpp'];
lpp = load(lpp,'acc_avg');

lsda = [path,num2str(ratio),'lsda'];
lsda = load(lsda,'acc_avg');


% path_ldp = [path,num2str(ratio),'ldp'];
% ldp = load(path_ldp,'acc_avg');

% MFAĿǰ�����������
path_mfa = [path,num2str(ratio),'mfa'];
mfa = load(path_mfa,'acc_avg');

% �Ľ��㷨����������������б�ͶӰ��SDDP��LPNDP
path_lpndp = [path,num2str(ratio),'lpndp'];
lpndp = load(path_lpndp,'acc_avg');


% ȡ�ṹ���е�ֵ
baseline = getfield(baseline,'acc_avg');

pca = getfield(pca,'acc_avg');

lda = getfield(lda,'acc_avg');
% 
mmc = getfield(mmc,'acc_avg');
% 
lpp = getfield(lpp,'acc_avg');

lsda = getfield(lsda,'acc_avg');
% 
% ldp = getfield(ldp,'acc_avg');
% 
mfa = getfield(mfa,'acc_avg');

lpndp = getfield(lpndp,'acc_avg');

pca = pca*100;
mmc = mmc*100;
mfa = mfa*100;
lsda = lsda*100;
lpndp = lpndp*100;
x = 1:30;

% plot(x,pca,'-+',x,mmc,'-V',x,mfa,'-^',x,lsda,'-square',x,lpndp,'-o','MarkerSize',4);
plot(x,pca,':+',x,mmc,':.',x,mfa,':*',x,lsda,':^',x,lpndp,':>');
xlabel('ά��');
ylabel('׼ȷ��(%)');
legend('PCA','MMC','MFA','LSDA','SDDP','Location','Best');


% set(gcf,'Position',[100 100 260 220]);
% set(gca,'Position',[.13 .17 .80 .74]);
% figure_FontSize=8;
% set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
% set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
% set(findobj('FontSize',10),'FontSize',figure_FontSize);
% set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);

[Y_baseline,I_baseline] = max(baseline)
[Y_pca,I_pca] = max(pca)
[Y_lda,I_lda] = max(lda)
[Y_mmc,I_mmc] = max(mmc)
[Y_lpp,I_lpp] = max(lpp)
[Y_lsda,I_lsda] = max(lsda)
[Y_mfa,I_mfa] = max(mfa)
[Y_lpndp,I_lpndp] = max(lpndp)


