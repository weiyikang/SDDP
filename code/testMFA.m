% �����������
clear
clc

% ��������
% ����Yale���ݼ�
% load('./���ݼ�/Yale_32x32.mat');
% classNum = 15;

% ����ORL���ݼ�
load('./���ݼ�/ORL_32x32.mat');
classNum = 40;

% ����YaleB���ݼ�
% load('./���ݼ�/YaleB_32x32.mat');
% classNum = 38;
ratio = 5;

for dim=1:45
    for i=1:10
        % ����ѵ���������Լ�
        [X_train, y_train, X_test, y_test] = Mysplit_train_test(fea, gnd, classNum, ratio);
        
        % ����MFA
        k = dim;
        options = [];
        options.intraK = 2;
        options.interK = 25;
        options.Regu = 1;
        [~,~,W,eigvalue,~] = MFA(y_train, options, X_train);
        if k > 29
            k = 29;
        end
        X_train_mfa = X_train*W;
        X_test_mfa = X_test*W;
        accuracy(i) = KNN(X_train_mfa,y_train,X_test_mfa,y_test,1);
    end
    acc(dim) = mean(accuracy);
    std_acc(dim) = std(accuracy);
end

% acc = mean(accuracy);
% std = std(accuracy);

path = ['Yale_L',num2str(ratio),'_acc_1to45_mfa'];
path_orl = ['ORL_L',num2str(ratio),'_acc_1to45_mfa'];
save(path_orl,'acc','std_acc');
plot(1:45,acc);

