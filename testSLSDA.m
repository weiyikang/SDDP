% �����������
clear
clc

% % ����Yale���ݼ�
% load('./���ݼ�/Yale_32x32.mat');
% classNum = 15;

% ����ORL���ݼ�
load('./���ݼ�/ORL_32x32.mat');
classNum = 40;

% % ����YaleB���ݼ�
% load('./���ݼ�/YaleB_32x32.mat');
% classNum = 38;
ratio = 5;
maxDim = 45;
for dim=1:maxDim
    for i = 1:10
        % ����ѵ���������Լ�
        [X_train, y_train, X_test, y_test] = Mysplit_train_test(fea, gnd, classNum, ratio);
        % ����LGSDP
        options = [];
        options.k = 2;
        options.PCARatio = 0.86;
        options.beta = 0.1;
        options.t = 14;
        options.ReducedDim = dim;
        if dim > classNum-1
            options.ReducedDim = classNum-1;
        end
        [eigvector] = SLSDA(X_train,y_train,options);
        X_train_LSDA = X_train*eigvector;
        X_test_LSDA = X_test*eigvector;
        
        accuracy(i) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);
    end
    acc(dim) = mean(accuracy);
    std_acc(dim) = std(accuracy);
end

% acc = mean(accuracy);
% std = std(accuracy);
% path = ['Yale_L',num2str(ratio),'_acc_1to45_slsda'];
path = ['ORL_L',num2str(ratio),'_acc_1to45_slsda'];
save(path,'acc','std_acc');
plot(1:maxDim,acc);

[maxAcc,idx] = max(acc)
