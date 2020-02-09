function [eigvector,eigvalue] = caiLPP(options, data)
% data：每一行为一个样本点，data形状为 n*m
% option：
%   k:构造近邻图时k-nn中k的取值
%   t:根据近邻图计算权重时若用到HotKernel,需要的参数t
%   r:降维的维数 r
% Output:eigvector,所要求的投影矩阵，shape为 m*d
% 根据Cai Deng的论文实现的LPP(Locality Preserving Projection)算法


% 样本数目n,原始维数m
[nSmp,nFea] = size(data);

% 计算样本之间的欧氏距离来构建近邻图
W_dist = EuDist2(data);


% t = mean(mean(data));
% if isfield(options,'t')
%    t = options.t*t; 
% end
t = options.t;

% 计算权重矩阵
k = options.k;
W = zeros(nSmp,nSmp);
for i = 1:nSmp
    dist = W_dist(i,:);
    [~,idx] = sort(dist);
    for j = 1:k+1
        W(i,idx(j))= exp(-W_dist(i,idx(j))/t);
    end
end

W = max(W,W');
% 计算对角矩阵D与Laplacian矩阵L
D = diag(sum(W));
L = D - W;

% 分解矩阵inv（data'*D*data）(data'*L*data)求投影向量
if options.ReducedDim > nFea
    options.ReducedDim = nFea;
end
[eigvector,eigvalue] = eig_large_g(data'*L*data, data'*D*data, options.ReducedDim);

end

function [V, D] = eig_large_g(A, B, ell)
[V, D] = eig(A, B);
[dummy, D_idx] = sort(-real(diag(D)));
V = V(:, D_idx(1:ell));
D = diag(D);
D = D(D_idx(1:ell,1));
return
end



