% �����������
clear
clc

% ����Yale���ݼ�
load('./���ݼ�/Yale_64x64.mat');
% load('./���ݼ�/Yale_32x32.mat');
classNum = 15;

% % ����ORL���ݼ�
% load('./���ݼ�/ORL_32x32.mat');
% classNum = 40;

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
%         X_train = X_train./norm(X_train,2);
%         X_test = X_test./norm(X_test,2);
        options = [];
        options.k = ratio-1;
        options.PCARatio = 40;
        options.beta = 0.01;
        options.t = 1.326;
        options.ReducedDim = dim;
        if dim > classNum-1
            options.ReducedDim = classNum-1;
        end
        [eigvector] = LGSDP(X_train,y_train,options);
        X_train_LSDA = X_train*eigvector;
        X_test_LSDA = X_test*eigvector;
        
        accuracy(i) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);
    end
    acc(dim) = mean(accuracy);
    std_acc(dim) = std(accuracy);
end

% acc = mean(accuracy);
% std = std(accuracy);
path = ['Yale_L',num2str(ratio),'_acc_1to45_LGSDP'];
% path = ['ORL_L',num2str(ratio),'_acc_1to45_LGSDP'];
save(path,'acc','std_acc');
plot(1:maxDim,acc);

[maxAcc, idx] = max(acc)

