function [imgs, labels] = loadDataSet(dataSet)
% 加载数据集
% dataSet == 'ORL'：32x32的ORL数据集
% dataSet == 'Yale':32x32的Yale数据集
% dataSet == 'YaleB':32x32的YaleB数据集

% ORL
if (strcmpi(dataSet,'ORL'))
    imgs = load('./数据集/ORL_32x32.mat', 'fea');
    labels = load('./数据集/ORL_32x32.mat', 'gnd');
% Yale
elseif (strcmpi(dataSet,'Yale'))
    imgs = load('./数据集/Yale_64x64.mat', 'fea');
    labels = load('./数据集/Yale_64x64.mat', 'gnd');
% YaleB
elseif (strcmpi(dataSet,'YaleB'))
    imgs = load('./数据集/YaleB_32x32.mat', 'fea');
    labels = load('./数据集/YaleB_32x32.mat', 'gnd');
end
