function [eigvector, eigvalue] = myLDA(gnd,options,data)

% 先用pca预处理
cutoff = options.PCARatio;
Lpca = pca(data, cutoff);
data = data*Lpca;

% 样本，特征数目，类别数目，降维上界
[nSmp,nFea] = size(data);
classLabel = unique(gnd);
nClass = length(classLabel);
if options.ReducedDim > nFea
    options.ReducedDim = nFea;
end


% 构建类内离散度Sw与类间离散度Sb
Sw = zeros(nFea,nFea);
Sb = zeros(nFea,nFea);

% 样本总均值
sampleMean = mean(data,1);

for i = 1:nClass
    idx = gnd==i;
    per_class = data(idx,:);
    per_mean = mean(per_class,1);
    % 计算类内离散度
    temp = per_class - repmat(per_mean,size(per_class,1),1);
    Sw = Sw + temp'*temp;
    % 计算类间离散度
    Sb = Sb + size(per_class,1)*(per_mean-sampleMean)'*(per_mean-sampleMean);
end

Sw = Sw/nSmp;
Sb = Sb/nSmp;

% 分解特征值
% if options.ReducedDim > nFea
%    options.ReducedDim = nFea;
% end
[eigvector, eigvalue] = eig_large_g(Sb, Sw, options.ReducedDim);
eigvector = Lpca*eigvector;

%%%%%%%%%%%%%%%
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






