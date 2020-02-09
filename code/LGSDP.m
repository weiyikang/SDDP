function [eigvector] = LGSDP(X_train,y_train,options)
% LGSDP
% options.k: knn参数
% options.t: heatKernel参数
% options.beta: 平衡类内类间laplace矩阵
% options.ReducedDim: 降维维数

% 样本数目
[n,d] = size(X_train);
% k近邻参数
k = 3;
if isfield(options,'k')
   k = options.k; 
end

beta = 0.06;
if isfield(options,'beta')
   beta = options.beta; 
end

% 样本之间的距离D
D = EuDist2(X_train,X_train,0);

% 默认热核函数t值
t = mean(mean(D));
if isfield(options,'t')
   t = options.t*t; 
end

% 根据knn排序选取有效的距离
Ww = zeros(n,n);
Wb = zeros(n,n);

[dump,idx] = sort(D,2);
% idx = idx(:,1:k+1);
% dump = dump(:,1:k+1);

% 权重计算
for i=1:n
    for j=2:k+1
        temp = exp(-dump(i,j)/(t));
        if y_train(i)==y_train(idx(i,j))
            Ww(i,idx(i,j))= temp*(1+temp);
        else
            Wb(i,idx(i,j))= 1-temp;
        end
    end
end

for i=1:n
    for j=k+2:n
        temp = exp(-dump(i,j)/(t));
        if y_train(i)==y_train(idx(i,j))
            Ww(i,idx(i,j)) = temp*(1-temp);
        else
            Wb(i,idx(i,j)) = 0;
        end
    end
end


% 矩阵分解
Db = full(sum(Wb,2));
Dw = diag(sum(Ww,2));
Wb = -Wb;
for i=1:size(Wb,1)
    Wb(i,i) = Wb(i,i) + Db(i);
end
W = sparse((beta/(1-beta))*Wb+Ww);

% ============================ %
% 进行特征分解
[eigvector, eigvalue] = LGE(W, Dw, options, X_train);
eigIdx = find(eigvalue < 1e-10);
eigvalue (eigIdx) = [];
eigvector(:,eigIdx) = [];


