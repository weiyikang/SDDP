function [W] = WLDA(gnd,data,options)

% 样本，特征数目，类别数目，降维上界
[nSmp,nFea] = size(data);
classLabel = unique(gnd);
nClass = length(classLabel);
Dim = nClass - 1;

% 可调节的参数
k = options.ReducedDim;
k1 = options.k1;
k2 = options.k2;
D = EuDist2(data);
t1 = mean(mean(D));
t2 = mean(mean(D));


% Sw,Sb
Sw = zeros(nFea,nFea);
Sb = zeros(nFea,nFea);

% 计算类内，类间离散度Sw,Sb
for i = 1:nClass
    idx = gnd==i;
    per_class = data(idx,:);
    per_mean = mean(per_class,1);
    
    % 计算类内离散度
    % 计算样本均值与同类样本的欧氏距离
    dist = [];
    for j = 1:nSmp
        dist = [dist,norm(data(j)-per_mean)];
    end
    
    % 计算Sw,Sb
    [~,idx1] = sort(dist,'descend');
    [~,idx2] = sort(dist);
    count1 = 0;
    count2 = 0;
    for j = 1:nSmp
        if count1 > k1 && count2 > k2
            break;
        end
        if count1 <= k1 && gnd(idx1(j))==i
%           计算Ww 与对应的 Sw
            temp = data(gnd(idx1(j)))-per_mean;
            Ww = exp(norm(temp)/t1);
            Sw = Sw + (data(gnd(idx1(j)))-per_mean)'*(data(gnd(idx1(j)))-per_mean)*Ww;
            count1 = count1 + 1;
        end
        if count2 <= k2 && gnd(idx2(j))==i
%           计算Wb 与对应的 Sb
            temp = data(gnd(idx2(j)))-per_mean;
            Wb = exp(norm(temp)/t2);
            Sb = Sb + (data(gnd(idx2(j)))-per_mean)'*(data(gnd(idx2(j)))-per_mean)*Wb;
            count2 = count2 + 1;
        end
    end
end

Sw = Sw/(nClass*k1);
Sb = Sb/(nClass*k2);

% 分解特征值
[V,D] = eig(Sb-Sw);
% A = repmat(0.01,[1,size(Sw,1)]);
% B = diag(A);
% [V,D] = eig(inv(Sw+B)*Sb);
[~,idx] = sort(diag(D),'descend');
W = [];
for i = 1:k
    W = [W,real(V(:,idx(i)))];
end

