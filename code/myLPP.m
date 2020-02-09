function [eigvector, eigvalue] = myLPP(options, data)
% data：每一行为一个样本点，data形状为 n*m
% option：
%   options.k:构造近邻图时k-nn中k的取值
%   options.t:根据近邻图计算权重时若用到HotKernel,需要的参数t
%   options.ReducedDim:降维的维数 r
% Output:eigvector,所要求的投影矩阵，shape为 m*d

% 先用pca预处理
Lpca = pca(data, options.PCARatio);
data = data*Lpca;

% 样本，特征数目，降维上界
[N,nFea] = size(data);
K = options.k;
if options.ReducedDim > nFea
    options.ReducedDim = nFea;
end

% 计算样本之间的权重
S = repmat(inf, N, N);
for i = 1 : N
    for j = i : N            
        S(i, j) = sum((data(i,:) - data(j,:)).^2);
    end
end

S = min(S,S');
[dummy, ind] = sort(S);
for i = 1 : N
    S(i, ind((2+K):end,i)) = inf;
end
S = min(S,S');

sig = median(S((S(:)~=inf & S(:)~=0)))*options.t;
% sig = std2(data)*(2^((options.t-10)/2.5));

% 近邻样本之间的相似性矩阵
S = exp(-S/sig);

% 计算 XLX', XDX'进行特征分解
D = zeros(N, N);
for i = 1 : N
    D(i,i) = sum(S(:,i));
end

L = D-S;

% eig(data*L*data',data*D*data',options.ReducedDim)特征分解
[eigvector, eigvalue] = eig_large_g(data'*S*data, data'*D*data, options.ReducedDim);
eigvector = Lpca*eigvector;

%%%%%%%%%%%%%%%%%%%%%%%%%%
function [V, D] = eig_large(M, ell)
    [V, D] = eig(M);
    [dummy, D_idx] = sort(-real(diag(D)));
    V = V(:, D_idx(1:ell));
    D = diag(D);
    D = D(D_idx(1:ell));
    return
    
    function [V, D] = eig_large_g(A, B, ell)
    [V, D] = eig(A, B);
    [dummy, D_idx] = sort(-real(diag(D)));
    V = V(:, D_idx(1:ell));
    D = diag(D);
    D = D(D_idx(1:ell,1));
    return
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    function L = pca(X_train, ell)
    
    [N,R] = size(X_train);
    
    Mt = zeros(R, 1);
    for m = 1 : N
        Mt = Mt + X_train(m,:)';
    end
    Mt = Mt/N;
    X = zeros(R, N);
    for m = 1 : N
        X(:, m) = X_train(m,:)' - Mt;
    end
    
    [L, S, V] = svd(X);
    
    if ell >= 1
        L = L(:, 1:ell);
    else
        S = sum(S, 1).^2;
        S_sum = cumsum(S);
        thres = S_sum(end)*ell;
        for i = 2 : length(S)
            if S_sum(i) > thres
                break;
            end
        end
        L = L(:, 1:i-1);
    end
    return


