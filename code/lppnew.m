function [eigvector, eigvalue] = lppnew(options,X)
% LPP: Locality Preserving Projections
%
%       [eigvector, eigvalue] = LPP(X, W, options)
% 
%             Input:
%               X       - Data matrix. Each row vector of fea is a data point.
%               W       - Affinity matrix. You can either call "constructW"
%                         to construct the W, or construct it by yourself.
%               options - Struct value in Matlab. The fields in options
%                         that can be set:
%                            ReducedDim   -  The dimensionality of the
%                                            reduced subspace. If 0,
%                                            all the dimensions will be
%                                            kept. Default is 0.
%                            PCARatio     -  The percentage of principal
%                                            component kept in the PCA
%                                            step. The percentage is
%                                            calculated based on the
%                                            eigenvalue. Default is 1
%                                            (100%, all the non-zero
%                                            eigenvalues will be kept.
%             Output:
%               eigvector - Each column is an embedding function, for a new
%                           data point (row vector) x,  y = x*eigvector
%                           will be the embedding result of x.
%               eigvalue  - The eigvalue of LPP eigen-problem. sorted from
%                           smallest to largest. 
% 
% 
%       [eigvector, eigvalue, Y] = LPP(X, W, options) 		
%               
%               Y:  The embedding results, Each row vector is a data point.
%                   Y = X*eigvector
%
%
%    Examples:
%
%       fea = rand(50,70);
%       options = [];
%       options.Metric = 'Euclidean';
%       options.NeighborMode = 'KNN';
%       options.k = 5;
%       options.WeightMode = 'HeatKernel';
%       options.t = 1;
%       W = constructW(fea,options);
%       options.PCARatio = 0.99
%       [eigvector, eigvalue, Y] = LPP(fea, W, options);
%       
%       
%       fea = rand(50,70);
%       gnd = [ones(10,1);ones(15,1)*2;ones(10,1)*3;ones(15,1)*4];
%       options = [];
%       options.Metric = 'Euclidean';
%       options.NeighborMode = 'Supervised';
%       options.gnd = gnd;
%       options.bLDA = 1;
%       W = constructW(fea,options);      
%       options.PCARatio = 1;
%       [eigvector, eigvalue, Y] = LPP(fea, W, options);
% 
% 
% Note: After applying some simple algebra, the smallest eigenvalue problem:
%				X^T*L*X = \lemda X^T*D*X
%      is equivalent to the largest eigenvalue problem:
%				X^T*W*X = \beta X^T*D*X
%		where L=D-W;  \lemda= 1 - \beta.
% Thus, the smallest eigenvalue problem can be transformed to a largest 
% eigenvalue problem. Such tricks are adopted in this code for the 
% consideration of calculation precision of Matlab.
% 
%
% See also constructW, pca.


%Reference:
%	Xiaofei He, and Partha Niyogi, "Locality Preserving Projections"
%	Advances in Neural Information Processing Systems 16 (NIPS 2003),
%	Vancouver, Canada, 2003.
%
%   Xiaofei He, Shuicheng Yan, Yuxiao Hu, Partha Niyogi, and Hong-Jiang
%   Zhang, "Face Recognition Using Laplacianfaces", IEEE PAMI, Vol. 27, No.
%   3, Mar. 2005. 
%
%   Deng Cai, Xiaofei He and Jiawei Han, "Document Clustering Using
%   Locality Preserving Indexing" IEEE TKDE, Dec. 2005.
%
%   Deng Cai, Xiaofei He and Jiawei Han, "Using Graph Model for Face Analysis",
%   Technical Report, UIUCDCS-R-2005-2636, UIUC, Sept. 2005
% 
%    Written by Deng Cai (dengcai@gmail.com), April/2004, Feb/2006

if (~exist('options','var'))
   options = [];
else
   if ~strcmpi(class(options),'struct') 
       error('parameter error!');
   end
end

if ~isfield(options,'PCARatio')
    [eigvector_PCA, eigvalue_PCA] = PCA(X,[]);
else
    PCAoptions = [];
    PCAoptions.PCARatio = options.PCARatio;
    [eigvector_PCA, eigvalue_PCA] = PCA(X,PCAoptions);
end
    
old_X = X;
X = X*eigvector_PCA;

[nSmp,nFea] = size(X);

if nFea > nSmp
    error('X is not of full rank in column!!');
end

if ~isfield(options,'ReducedDim')
    ReducedDim = nFea; 
else
    ReducedDim = options.ReducedDim; 
end

if ReducedDim > nFea
    ReducedDim = nFea; 
end

% ����Ȩ�ؾ���
opt = [];
opt.NeighborMode = 'KNN';
opt.k = 2;
opt.WeightMode = 'HeatKernel';
W = constructW(X,opt);

D = diag(sum(W));
L = D - W;
% L = W;

DPrime = X'*D*X;
DPrime = (DPrime+DPrime')/2;
LPrime = X'*L*X;
LPrime = (LPrime+LPrime')/2;    

dimMatrix = size(DPrime,2);
if dimMatrix > 200 & ReducedDim < dimMatrix/2  % using eigs to speed up!
    option = struct('disp',0);
    [eigvector, eigvalue] = eigs(LPrime,DPrime,ReducedDim,'la',option);
    eigvalue = diag(eigvalue);
else
    [eigvector, eigvalue] = eig(LPrime,DPrime);
    eigvalue = diag(eigvalue);
end    
[junk, index] = sort(-eigvalue);
eigvalue = eigvalue(index);
eigvector = eigvector(:,index);


eigvalue = ones(length(eigvalue),1) - eigvalue;

if ReducedDim < size(eigvector,2)
    eigvector = eigvector(:, 1:ReducedDim);
    eigvalue = eigvalue(1:ReducedDim);
end

for i = 1:size(eigvector,2)
    eigvector(:,i) = eigvector(:,i)./norm(eigvector(:,i));
end

eigvector = eigvector_PCA*eigvector;


% if nargout == 3
%     Y = old_X * eigvector;
% end

