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
maxDim = 45;
for dim=1:maxDim
    for i = 1:10
        % 划分训练集，测试集
        [X_train, y_train, X_test, y_test] = Mysplit_train_test(fea, gnd, classNum, ratio);
        % PCA预处理
        
        % 测试LDP
        options = [];
        options.k = ratio-1;
        options.PCARatio = 40;
        options.t = 1;
        options.ReducedDim=dim;
        if dim > classNum-1
            options.ReducedDim = classNum-1;
        end
        [eigvector] = LDP(X_train,y_train,options);
        X_train_LSDA = X_train*eigvector;
        X_test_LSDA = X_test*eigvector;
        
        accuracy(i) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);
    end
    acc(dim) = mean(accuracy);
    std_acc(dim) = std(accuracy);
end

% acc = mean(accuracy);
% std = std(accuracy);
path = ['Yale_L',num2str(ratio),'_acc_1to45_ldp'];
% path = ['ORL_L',num2str(ratio),'_acc_1to45_ldp'];
% path = ['YaleB_L',num2str(ratio),'_acc_1to45_ldp'];
save(path,'acc','std_acc');
plot(1:maxDim,acc);


[maxAcc,idx] = max(acc)


