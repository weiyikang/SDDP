% 清除环境变量
clear
clc

dataset = 'Yale';
% dataset = 'ORL';
% dataset = 'FERET';
classNum = 15;
persons = 11;
% ratio = 2;
maxDim = 40;

% 加载数据集
path = ['./数据集/',dataset,'_64x64.mat'];
% path = ['./数据集/',dataset,'_32x32.mat'];


for ratio=7:7
    acc1 = [];
    acc2 = [];
    acc3 = [];
    acc4 = [];
    for times=1:10
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
        for dim=1:maxDim
%             LGSDP
            options = [];
            options.k = ratio-1;
            options.PCARatio = 40;
            options.beta = 0.01;
            options.t = 1.3;
            options.ReducedDim = dim;
            [eigvector] = LGSDP(X_train,y_train,options);
            X_train_LGSDP = X_train*eigvector;
            X_test_LGSDP = X_test*eigvector;
            
%             LSDA
            options = [];
            options.k = ratio-1;
            options.PCARatio = 40;
            options.beta = 0.01;
            options.ReducedDim = dim;
            [eigvector, ~] = LSDA(y_train, options, X_train);
            X_train_LSDA = X_train*eigvector;
            X_test_LSDA = X_test*eigvector;
%             LDP
            options = [];
            options.k = ratio-1;
            options.PCARatio = 40;
            options.t = 1;
            options.ReducedDim=dim;
            [eigvector] = LDP(X_train,y_train,options);
            X_train_LDP = X_train*eigvector;
            X_test_LDP = X_test*eigvector;
            
            % 测试MMC
            ReducedDim = dim;
%             PCA预处理
            options = [];
            options.PCARatio = 40;
            [eigvector, eigvalue] = PCA(X_train, options);
            X_train = X_train*eigvector;
            X_test = X_test*eigvector;
            [eigvector] = MMC(y_train, ReducedDim, X_train);
            X_train_MMC = X_train*eigvector;
            X_test_MMC = X_test*eigvector;
            
            accuracy1(dim) = KNN(X_train_LGSDP,y_train,X_test_LGSDP,y_test,1);
            accuracy2(dim) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);
            accuracy3(dim) = KNN(X_train_LDP,y_train,X_test_LDP,y_test,1);
            accuracy4(dim) = KNN(X_train_MMC,y_train,X_test_MMC,y_test,1);
        end
        acc1 = [acc1;accuracy1];
        acc2 = [acc2;accuracy2];
        acc3 = [acc3;accuracy3];
        acc4 = [acc4;accuracy4];
    end
    acc_avg1 = mean(acc1,1);
    std_acc1 = std(acc1,1);
    acc_avg2 = mean(acc2,1);
    std_acc2 = std(acc2,1);
    acc_avg3 = mean(acc3,1);
    std_acc3 = std(acc3,1);
    acc_avg4 = mean(acc4,1);
    std_acc4 = std(acc4,1);
%     path1 = [dataset,num2str(ratio),'_acc_1to40_lgsdp'];
%     save(path1,'acc_avg1','std_acc1');
%     path2 = [dataset,num2str(ratio),'_acc_1to40_lsda'];
%     save(path2,'acc_avg2','std_acc2');
%     path3 = [dataset,num2str(ratio),'_acc_1to40_ldp'];
%     save(path3,'acc_avg3','std_acc3');
    plot(1:maxDim,acc_avg1,1:maxDim,acc_avg2,1:maxDim,acc_avg3,1:maxDim,acc_avg4);
    legend('LGSDP','LSDA','LDP','MMC','Location','Best');
%     
    [maxAcc1, idx1] = max(acc_avg1)
    [maxAcc2, idx2] = max(acc_avg2)
    [maxAcc3, idx3] = max(acc_avg3)
    [maxAcc4, idx4] = max(acc_avg4)
end
