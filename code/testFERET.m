% «Â≥˝ª∑æ≥±‰¡ø
clear
clc

dataset = 'FERET';
classNum = 200;
maxDim = 40;


for ratio=6:6
    acc = [];
    max_idx = [];
    for rept=1:1
        times = rept;
        path = ['./ ˝æ›ºØ/',dataset,'_32x32.mat'];
        load(path);
        [X_train, y_train, X_test, y_test] = Mysplit_train_test(fea, gnd, classNum, ratio);
        accuracy = [];
        for dim=1:maxDim
% %             ≤‚ ‘MFA
%              options = [];
%              options.ell = dim;
%              options.K1 = 2; 
%              options.K2 = 10;
%              options.t = 30;
%              options.cutoff = 0.95;
%              eigvector = myMFA(X_train, y_train, options);
%              X_train_mfa = X_train*eigvector;
%              X_test_mfa = X_test*eigvector;
%              accuracy(dim) = KNN(X_train_mfa,y_train,X_test_mfa,y_test,1);

% %             ≤‚ ‘LGSDP
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

% %             ≤‚ ‘baseline
%             if dim==1
%                 accuracy(dim) = KNN(X_train,y_train,X_test,y_test,1);  
%             else
%                 accuracy(dim) = accuracy(1);
%             end      

% %             ≤‚ ‘PCA
%             options = [];
%             options.ReducedDim = dim;
%             [eigvector, eigvalue] = PCA(X_train, options);
%             X_train_PCA = X_train*eigvector;
%             X_test_PCA = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_PCA,y_train,X_test_PCA,y_test,1);

% %             ≤‚ ‘LDA
%               options = [];
%               options.PCARatio = 40;
%               options.ReducedDim = dim;
%               [eigvector, eigvalue] = myLDA(y_train,options,X_train);
%               X_train_lda = X_train*eigvector;
%               X_test_lda = X_test*eigvector; 
%               accuracy(dim) = KNN(X_train_lda,y_train,X_test_lda,y_test,1);

% %               ≤‚ ‘MMC
%             ReducedDim = dim;
% %             PCA‘§¥¶¿Ì
%             options = [];
%             options.PCARatio = 40;
%             options.ReducedDim = dim;
%             [eigvector,~] = MMC(y_train, options, X_train);
%             X_train_MMC = X_train*eigvector;
%             X_test_MMC = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_MMC,y_train,X_test_MMC,y_test,1);

%             % ≤‚ ‘LPP
%             options = [];
%             options.k = ratio-1;
%             options.ReducedDim = dim;
%             options.t = 3e10;
%             options.PCARatio = 40;
%             [eigvector, eigvalue] = myLPP(options, X_train);
%             X_train_lpp = X_train*eigvector;
%             X_test_lpp = X_test*eigvector; 
%             accuracy(dim) = KNN(X_train_lpp,y_train,X_test_lpp,y_test,1);

% %             ≤‚ ‘LPNDP
%             options = [];
%             options.k = ratio;
%             options.PCARatio = 40;
%             options.beta = 0.03;
%             options.t = 1;
%             options.ReducedDim = dim;
%             [eigvector] = LPNDP(X_train,y_train,options);
%             X_train_LPNDP = X_train*eigvector;
%             X_test_LPNDP = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_LPNDP,y_train,X_test_LPNDP,y_test,1);

%             % ≤‚ ‘LDP
%             options = [];
%             options.k = (ratio-1)*2;
%             options.PCARatio = 0.95;
%             options.t = 15;
%             options.ReducedDim=dim;
%             [eigvector] = LDP(X_train,y_train,options);
%             X_train_LDP = X_train*eigvector;
%             X_test_LDP = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_LDP,y_train,X_test_LDP,y_test,1);

            % LSDA
            options = [];
            options.k = 50;
            options.PCARatio = 40;
            options.beta = 0.030;
            options.ReducedDim = dim;
            [eigvector, ~] = LSDA(y_train, options, X_train);
            X_train_LSDA = X_train*eigvector;
            X_test_LSDA = X_test*eigvector;
            accuracy(dim) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);
            
% %             ≤‚ ‘SLSDA
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
    path = [dataset,num2str(ratio),'lsda'];
    save(path,'acc_avg','std_acc');
    plot(1:maxDim,acc_avg);
    
    [maxAcc, idx] = max(acc_avg)
    
end
