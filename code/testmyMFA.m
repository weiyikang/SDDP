% �����������
clear
clc

% ��������
load('./���ݼ�/Yale_32x32.mat');
classNum = 15;
% ����ѵ���������Լ�
[X_train, y_train, X_test, y_test] = Mysplit_train_test(fea, gnd, classNum, 0.3);

% �Ƚ���PCAԤ�������������������
% options=[];
% options.ReducedDim=70;
% [eigvector,eigvalue] = PCA(X_train,options);
% X_train = X_train*eigvector;
% X_test = X_test*eigvector;

% ����MFA
k = 16;
k1 = 2;
k2 = 1;
[W] = myMFA(y_train, k, X_train, k1, k2);
X_train_mfa = X_train*W;
X_test_mfa = X_test*W;

% ʹ��knnԤ����




