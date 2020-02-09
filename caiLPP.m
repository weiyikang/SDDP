function [eigvector,eigvalue] = caiLPP(options, data)
% data��ÿһ��Ϊһ�������㣬data��״Ϊ n*m
% option��
%   k:�������ͼʱk-nn��k��ȡֵ
%   t:���ݽ���ͼ����Ȩ��ʱ���õ�HotKernel,��Ҫ�Ĳ���t
%   r:��ά��ά�� r
% Output:eigvector,��Ҫ���ͶӰ����shapeΪ m*d
% ����Cai Deng������ʵ�ֵ�LPP(Locality Preserving Projection)�㷨


% ������Ŀn,ԭʼά��m
[nSmp,nFea] = size(data);

% ��������֮���ŷ�Ͼ�������������ͼ
W_dist = EuDist2(data);


% t = mean(mean(data));
% if isfield(options,'t')
%    t = options.t*t; 
% end
t = options.t;

% ����Ȩ�ؾ���
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
% ����ԽǾ���D��Laplacian����L
D = diag(sum(W));
L = D - W;

% �ֽ����inv��data'*D*data��(data'*L*data)��ͶӰ����
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



