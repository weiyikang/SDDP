function [eigvector] = SLSDA(X_train,y_train,options)
% SLSDA
% options.k: knn����
% options.t: heatKernel����
% options.beta: ƽ���������laplace����
% options.ReducedDim: ��άά��

% ������Ŀ
[n,d] = size(X_train);
% k���ڲ���
k = 3;
if isfield(options,'k')
   k = options.k; 
end

beta = 0.06;
if isfield(options,'beta')
   beta = options.beta; 
end

% ����֮��ľ���D
D = EuDist2(X_train,X_train,0);

% Ĭ���Ⱥ˺���tֵ
t = mean(mean(D));
if isfield(options,'t')
   t = options.t*t; 
end

% ����knn����ѡȡ��Ч�ľ���
Sw = zeros(n,n);
Hw = zeros(n,n);
Wb = zeros(n,n);

[dump,idx] = sort(D,2);
idx = idx(:,1:k+1);
dump = dump(:,1:k+1);

% Ȩ�ؼ���
for i=1:n
    for j=2:k+1
        temp = exp(-dump(i,j)/t);
        if y_train(i)==y_train(idx(i,j))
            Sw(i,idx(i,j))= temp;
            Hw(i,idx(i,j))=1-temp;
        else
            Wb(i,idx(i,j))= 1-temp;
        end
    end
end


% ����ֽ�
Db = full(sum(Wb,2));
Dh = full(sum(Hw,2));
Ds = diag(sum(Sw,2));
Wb = -Wb;
Hw = -Hw;
for i=1:size(Wb,1)
    Wb(i,i) = Wb(i,i) + Db(i);
    Hw(i,i) = Hw(i,i) + Dh(i);
end

W = sparse(beta*Wb+Hw+(1-beta)*Sw);


% ============================ %
% ���������ֽ�
[eigvector, eigvalue] = LGE(W, Ds, options, X_train);
eigIdx = find(eigvalue < 1e-10);
eigvalue (eigIdx) = [];
eigvector(:,eigIdx) = [];

