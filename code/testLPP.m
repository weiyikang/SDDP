%% 清除环境变量
clear
clc

%% 加载数据集
dataset = 'Yale';
path = ['./数据集/',dataset,'_32x32.mat'];
load(path);

% 划分训练集与测试集
ratio = 5;
times = 1;

X_train = [];
y_train = [];
X_test = [];
y_test = [];

splitPath = ['./数据集/',dataset,'/',num2str(ratio),'Train/',num2str(times)];
load(splitPath);
for i=1:size(trainIdx,1)
    X_train = [X_train;fea(trainIdx(i),:)];
    y_train = [y_train;gnd(trainIdx(i))];
end

for i=1:size(testIdx,1)
    X_test = [X_test;fea(testIdx(i),:)];
    y_test = [y_test;gnd(testIdx(i))];
end

% 进行特征提取
maxDim = 15;
options = [];
options.PCARatio = 1;
options.ReducedDim = maxDim;
[eigvector, eigvalue] = lppnew(options, X_train);
X_train_LPP = X_train*eigvector;
X_test_LPP = X_test*eigvector;
accuracy = KNN(X_train_LPP,y_train,X_test_LPP,y_test,1)


path = ['Yale',num2str(ratio),'lpp'];
% path = ['ORL_L',num2str(ratio),'_acc_1to45_lpp'];
% save(path,'acc','std_acc');
% plot(1:maxDim,acc);

% [maxAcc,idx] = max(acc)
