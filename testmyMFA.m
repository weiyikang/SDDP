% 清除环境变量
clear
clc

% 加载数据
load('./数据集/Yale_32x32.mat');
classNum = 15;
% 划分训练集，测试集
[X_train, y_train, X_test, y_test] = Mysplit_train_test(fea, gnd, classNum, 0.3);

% 先进行PCA预处理，避免矩阵奇异问题
% options=[];
% options.ReducedDim=70;
% [eigvector,eigvalue] = PCA(X_train,options);
% X_train = X_train*eigvector;
% X_test = X_test*eigvector;

% 测试MFA
k = 16;
k1 = 2;
k2 = 1;
[W] = myMFA(y_train, k, X_train, k1, k2);
X_train_mfa = X_train*W;
X_test_mfa = X_test*W;

% 使用knn预测结果




