function [eigvector, eigvalue] = myLPP(options, data)
% data��ÿһ��Ϊһ�������㣬data��״Ϊ n*m
% option��
%   options.k:�������ͼʱk-nn��k��ȡֵ
%   options.t:���ݽ���ͼ����Ȩ��ʱ���õ�HotKernel,��Ҫ�Ĳ���t
%   options.ReducedDim:��ά��ά�� r
% Output:eigvector,��Ҫ���ͶӰ����shapeΪ m*d

% ����pcaԤ����
Lpca = pca(data, options.PCARatio);
data = data*Lpca;

% ������������Ŀ����ά�Ͻ�
[N,nFea] = size(data);
K = options.k;
if options.ReducedDim > nFea
    options.ReducedDim = nFea;
end

% ��������֮���Ȩ��
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

% ��������֮��������Ծ���
S = exp(-S/sig);

% ���� XLX', XDX'���������ֽ�
D = zeros(N, N);
for i = 1 : N
    D(i,i) = sum(S(:,i));
end

L = D-S;

% eig(data*L*data',data*D*data',options.ReducedDim)�����ֽ�
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


