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
ratio = 6;

% ����myLPP�㷨 
maxDim = 45;
for dim=1:maxDim
    for i = 1:10
        % ����ѵ���������Լ�
        [X_train, y_train, X_test, y_test] = Mysplit_train_test(fea, gnd, classNum, ratio);
        
        options = [];
        options.k = 5;
        options.r = dim;
        options.t = 2.60;
        options.PCARatio = 40;
        [eigvector] = myLPP(options, X_train);
        X_train_lpp = X_train*eigvector;
        X_test_lpp = X_test*eigvector; 
        accuracy(i) = KNN(X_train_lpp,y_train,X_test_lpp,y_test,1);
    end
    acc(dim) = mean(accuracy);
    std_acc(dim) = std(accuracy);
end

path = ['Yale_L',num2str(ratio),'_acc_1to45_lpp'];
% path = ['ORL_L',num2str(ratio),'_acc_1to45_lpp'];
% save(path,'acc','std_acc');
plot(1:maxDim,acc);

[maxAcc,idx] = max(acc)


