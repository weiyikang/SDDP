% �����������
clear
clc

% ����Yale���ݼ�
load('./���ݼ�/Yale_64x64.mat');
classNum = 15;

% % ����ORL���ݼ�
% load('./���ݼ�/ORL_32x32.mat');
% classNum = 40;

% % ����YaleB���ݼ�
% load('./���ݼ�/YaleB_32x32.mat');
% classNum = 38;
ratio = 5;

% ����myLPP�㷨 
maxDim = 45;
for i = 1:10
        % ����ѵ���������Լ�
        [X_train, y_train, X_test, y_test] = Mysplit_train_test(fea, gnd, classNum, ratio);
        accuracy(i) = KNN(X_train,y_train,X_test,y_test,1);
end
acc_baseline = mean(accuracy);
for dim=1:maxDim
    acc(dim) = acc_baseline;
end

path = ['Yale',num2str(ratio),'_acc_1to40_baseline'];
% path = ['ORL_L',num2str(ratio),'_acc_1to45_baseline'];
save(path,'acc');
plot(1:maxDim,acc);




