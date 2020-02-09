function [W] = LDP(X_train,y_train,options)
% LDP
% options.k: knn参数
% options.t: heatKernel参数
% options.ReducedDim: 降维维数

% 样本数目
[n,d] = size(X_train);
% k近邻参数
k = 5;
if isfield(options,'k')
   k = options.k; 
end

% 样本之间的距离D
D = EuDist2(X_train,X_train,0);

% 默认热核函数t值
t = mean(mean(D));
if isfield(options,'t')
   t = options.t*t; 
end

% 根据knn排序选取有效的距离
W = zeros(n,n);

[dump,idx] = sort(D,2);
idx = idx(:,1:k+1);
dump = dump(:,1:k+1);

for i=1:n;
    for j=1:k+1
        temp = exp(-dump(i,j)/(t));
        if y_train(i)==y_train(idx(i,j))
            W(i,idx(i,j))= temp*(1+temp);
        else
            W(i,idx(i,j))= temp*(1-temp);
        end
    end
end

W = max(W,W');
% ============================ %
% 进行特征分解
opt = [];
opt.PCARatio = options.PCARatio;
opt.ReducedDim = options.ReducedDim;
[W,~] = LPP(W,opt,X_train);


