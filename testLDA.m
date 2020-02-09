% �����������
clear
clc

% ����Yale���ݼ�
% load('./���ݼ�/Yale_64x64.mat');
classNum = 15;

% % ����ORL���ݼ�
load('./���ݼ�/ORL_32x32.mat');
% classNum = 40;

% % ����YaleB���ݼ�
% load('./���ݼ�/YaleB_32x32.mat');
% classNum = 38;
ratio = 5;

% ����LDA�㷨 
maxDim = 45;
for dim=1:maxDim
    for i = 1:10
        % ����ѵ���������Լ�
        [X_train, y_train, X_test, y_test] = Mysplit_train_test(fea, gnd, classNum, ratio);
        options = [];
        options.Fisherface = 1;
        [eigvector, eigvalue] = LDA(y_train, options, X_train);
        reduceDim = dim;
        if(dim>classNum-1)
            reduceDim  = classNum-1;
        end
        X_train_lda = X_train*eigvector(:,1:reduceDim);
        X_test_lda = X_test*eigvector(:,1:reduceDim); 
        accuracy(i) = KNN(X_train,y_train,X_test,y_test,1);
    end
    acc(dim) = mean(accuracy);
    std_acc(dim) = std(accuracy);
end

% path = ['Yale_L',num2str(ratio),'_acc_1to45_lda'];
path = ['ORL_L',num2str(ratio),'_acc_1to45_lda'];
save(path,'acc','std_acc');
plot(1:maxDim,acc);

