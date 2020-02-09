function L = myMFA(X_train, Y, options)

K1 = options.K1;
K2 = options.K2;
cutoff = options.cutoff;

N = size(X_train,1);
NC = length(unique(Y));

Lpca = pca(X_train, cutoff);

ell = options.ell;
if options.ell > size(Lpca, 2)
    ell = size(Lpca, 2);
end

X = zeros(size(Lpca, 2), N);
for i = 1 : N
    X(:, i) = Lpca'*X_train(i,:)';
end

% D1 为本征图权重，D2 为惩罚图权重
S1 = repmat(inf, N, N);
S2 = repmat(inf, N, N);
for i = 1 : N
    for j = i : N
        if Y(i) == Y(j)            
            S1(i, j) = sum((X(:, i) - X(:, j)).^2);
        else
            S2(i, j) = sum((X(:, i) - X(:, j)).^2);
        end
    end
end
S1 = min(S1,S1'); 
S2 = min(S2,S2'); 


[dummy, ind] = sort(S1);
for i = 1 : N
    S1(i, ind((2+K1):end,i)) = inf;
end
S1 = min(S1,S1');

[dummy, ind] = sort(S2);
for i = 1 : N
    S2(i, ind((1+K2):end,i)) = inf;
end
S2 = min(S2,S2'); 

t = 30;
if isfield(options,'t')
    t = options.t;
end

sig1 = median(S1((S1(:)~=inf & S1(:)~=0)))*t;

D1 = exp(-S1/sig1);
D2 = exp(-S2/sig1);


effd = size(Lpca, 2);    
ML = zeros(effd, effd);
MLD = zeros(effd, effd);
for i = 1 : N
    for j = i+1 : N
        if Y(i) == Y(j)
            if D1(i,j) == 0 
                continue
            end
            tmpX = X(:, i) - X(:, j);
            ML = ML + D1(i,j)*tmpX*tmpX';
        else
            if D2(i,j) == 0
                continue
            end
            tmpX = X(:, i) - X(:, j);
            MLD = MLD + D2(i,j)*tmpX*tmpX';
        end
    end
end


MLD = 0.5*(MLD + MLD');
ML = 0.5*(ML + ML');

[L, Ei] = eig_large_g(MLD, ML, ell);


L = Lpca*L;


return


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

