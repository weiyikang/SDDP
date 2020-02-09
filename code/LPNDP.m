function [eigvector] = LPNDP(X_train,y_train,options)
% LGSDP
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

% % Ĭ���Ⱥ˺���tֵ
% t = mean(mean(D));
% if isfield(options,'t')
%    t = options.t*t; 
% end

% ����knn����ѡȡ��Ч�ľ���
Ww = zeros(n,n);
Wb = zeros(n,n);

[dump,idx] = sort(D,2);
% idx = idx(:,1:k+1);
% dump = dump(:,1:k+1);

% Ĭ���Ⱥ˺���tֵ
t = median(dump((dump(:)~=inf & dump(:)~=0)));
if isfield(options,'t')
   t = options.t*t; 
end

% Ȩ�ؼ���
for i=1:n
    for j=2:k+1
        temp = exp(-dump(i,j)/(t));
        tran = exp(-t/dump(i,j));
        if y_train(i)==y_train(idx(i,j))
            Ww(i,idx(i,j))= temp*(1+temp);
        else
            Wb(i,idx(i,j))= tran*(1-tran);
        end
    end
end

for i=1:n
    for j=k+2:n
        temp = exp(-dump(i,j)/(t));
        tran = exp(-t/dump(i,j));
        if y_train(i)==y_train(idx(i,j))
            Ww(i,idx(i,j)) = temp*(1-temp);
        else
            Wb(i,idx(i,j)) = tran*(1+tran);
        end
    end
end


% ����ֽ�
Db = full(sum(Wb,2));
Dw = diag(sum(Ww,2));
Wb = -Wb;
for i=1:size(Wb,1)
    Wb(i,i) = Wb(i,i) + Db(i);
end
W = sparse((beta/(1-beta))*Wb+Ww);

% ============================ %
% ���������ֽ�
[eigvector, eigvalue] = LGE(W, Dw, options, X_train);
% eigIdx = find(eigvalue < 1e-10);
% eigvalue (eigIdx) = [];
% eigvector(:,eigIdx) = [];


