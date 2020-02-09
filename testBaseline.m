% 清除环境变量
clear
clc

% 加载Yale数据集
load('./数据集/Yale_64x64.mat');
classNum = 15;

% % 加载ORL数据集
% load('./数据集/ORL_32x32.mat');
% classNum = 40;

% % 加载YaleB数据集
% load('./数据集/YaleB_32x32.mat');
% classNum = 38;
ratio = 5;

% 测试myLPP算法 
maxDim = 45;
for i = 1:10
        % 划分训练集，测试集
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




