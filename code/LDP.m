function [W] = LDP(X_train,y_train,options)
% LDP
% options.k: knn����
% options.t: heatKernel����
% options.ReducedDim: ��άά��

% ������Ŀ
[n,d] = size(X_train);
% k���ڲ���
k = 5;
if isfield(options,'k')
   k = options.k; 
end

% ����֮��ľ���D
D = EuDist2(X_train,X_train,0);

% Ĭ���Ⱥ˺���tֵ
t = mean(mean(D));
if isfield(options,'t')
   t = options.t*t; 
end

% ����knn����ѡȡ��Ч�ľ���
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
% ���������ֽ�
opt = [];
opt.PCARatio = options.PCARatio;
opt.ReducedDim = options.ReducedDim;
[W,~] = LPP(W,opt,X_train);


