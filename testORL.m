% 清除环境变量
clear
clc

dataset = 'ORL';

maxDim = 45;

% 加载Yale数据集
% path = ['./数据集/',dataset,'_64x64.mat'];
path = ['./数据集/',dataset,'_32x32.mat'];

% % 加载ORL数据集
% load('./数据集/ORL_32x32.mat');
% classNum = 40;

% % 加载YaleB数据集
% load('./数据集/YaleB_32x32.mat');
% classNum = 38;

% 划分训练集与测试集
% [X_train, y_train, X_test, y_test] = Mysplit_train_test(fea, gnd, classNum, ratio);

for ratio=6:6
    acc = [];
    max_idx = [];
    orl_repts_4 = [1,2,47,9,9,2,2,8,9,9];
    orl_repts_5 = [1,2,1,1,1,6,7,8,9,1];
    orl_repts_6 = [16,17,18,25,20,21,23,23,23,25];
    for rept=1:10
%         times = repts_4(rept);
%         times = repts_5(rept);
%         times = repts_6(rept);
%         times = rept;
        times = orl_repts_4(rept);
        X_train = [];
        y_train = [];
        X_test = [];
        y_test = [];
        splitPath = ['./数据集/',dataset,'/',num2str(ratio),'Train/',num2str(times)];
        load(path);
        load(splitPath);
        for i=1:size(trainIdx,1)
            X_train = [X_train;fea(trainIdx(i),:)];
            y_train = [y_train;gnd(trainIdx(i))];
        end
        
        for i=1:size(testIdx,1)
            X_test = [X_test;fea(testIdx(i),:)];
            y_test = [y_test;gnd(testIdx(i))];
        end
        accuracy = [];
        for dim=1:maxDim
            
%             测试MFA
             options = [];
             options.ell = dim;
             options.K1 = 2; 
             options.K2 = 10;
             options.t = 3;
             options.cutoff = 0.80;
             eigvector = myMFA(X_train, y_train, options);
             X_train_mfa = X_train*eigvector;
             X_test_mfa = X_test*eigvector;
             accuracy(dim) = KNN(X_train_mfa,y_train,X_test_mfa,y_test,1);
             
% %             测试LGSDP
%             options = [];
%             options.k = ratio;
%             options.PCARatio = 0.95;
%             options.beta = 0.01;
%             options.t = 1;
%             options.ReducedDim = dim;
%             [eigvector] = LGSDP(X_train,y_train,options);
%             X_train_LSDA = X_train*eigvector;
%             X_test_LSDA = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);

% %             测试baseline
%             if dim==1
%                 accuracy(dim) = KNN(X_train,y_train,X_test,y_test,1);  
%             else
%                 accuracy(dim) = accuracy(1);
%             end      

% %             测试PCA
%             options = [];
%             options.ReducedDim = dim;
%             [eigvector, eigvalue] = PCA(X_train, options);
%             X_train_PCA = X_train*eigvector;
%             X_test_PCA = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_PCA,y_train,X_test_PCA,y_test,1);

% %             测试LDA
%               options = [];
%               options.PCARatio = 0.90;
%               options.ReducedDim = dim;
%               [eigvector, eigvalue] = myLDA(y_train,options,X_train);
%               X_train_lda = X_train*eigvector;
%               X_test_lda = X_test*eigvector; 
%               accuracy(dim) = KNN(X_train_lda,y_train,X_test_lda,y_test,1);

% %               测试MMC
%             ReducedDim = dim;
% %             PCA预处理
%             options = [];
%             options.PCARatio = 0.95;
%             options.ReducedDim = dim;
%             [eigvector,~] = MMC(y_train, options, X_train);
%             X_train_MMC = X_train*eigvector;
%             X_test_MMC = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_MMC,y_train,X_test_MMC,y_test,1);

%             % 测试LPP
%             options = [];
%             options.k = ratio-1;
%             options.ReducedDim = dim;
%             options.t = 1.6;
%             options.PCARatio = 0.98;
%             [eigvector, eigvalue] = myLPP(options, X_train);
%             X_train_lpp = X_train*eigvector;
%             X_test_lpp = X_test*eigvector; 
%             accuracy(dim) = KNN(X_train_lpp,y_train,X_test_lpp,y_test,1);

% %             测试LPNDP
%             options = [];
%             options.k = 20;
%             options.PCARatio = 0.86;
%             options.beta = 0.0006;
%             options.t = 0.6;
%             options.ReducedDim = dim;
%             [eigvector] = LPNDP(X_train,y_train,options);
%             X_train_LPNDP = X_train*eigvector;
%             X_test_LPNDP = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_LPNDP,y_train,X_test_LPNDP,y_test,1);

%             % 测试LDP
%             options = [];
%             options.k = (ratio-1)*2;
%             options.PCARatio = 0.95;
%             options.t = 15;
%             options.ReducedDim=dim;
%             [eigvector] = LDP(X_train,y_train,options);
%             X_train_LDP = X_train*eigvector;
%             X_test_LDP = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_LDP,y_train,X_test_LDP,y_test,1);

%             % LSDA
%             options = [];
%             options.k = 3;
%             options.PCARatio = 0.83;
%             options.beta = 0.06;
%             options.ReducedDim = dim;
%             [eigvector, ~] = LSDA(y_train, options, X_train);
%             X_train_LSDA = X_train*eigvector;
%             X_test_LSDA = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);

% %             测试SLSDA
%             options = [];
%             options.k = ratio;
%             options.PCARatio = 0.95;
%             options.beta = 0.1;
%             options.t = 1;
%             options.ReducedDim = dim;
%             [eigvector] = SLSDA(X_train,y_train,options);
%             X_train_LSDA = X_train*eigvector;
%             X_test_LSDA = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);

        end
        acc = [acc;accuracy];
        [maxAcc_50, idx] = max(accuracy)
        rept
    end
    acc_avg = mean(acc,1);
    std_acc = std(acc,1);
    path = [dataset,num2str(ratio),'mfa'];
    save(path,'acc_avg','std_acc');
    plot(1:maxDim,acc_avg);
    
    [maxAcc, idx] = max(acc_avg)
    
end
