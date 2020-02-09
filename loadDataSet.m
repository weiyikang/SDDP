function [imgs, labels] = loadDataSet(dataSet)
% �������ݼ�
% dataSet == 'ORL'��32x32��ORL���ݼ�
% dataSet == 'Yale':32x32��Yale���ݼ�
% dataSet == 'YaleB':32x32��YaleB���ݼ�

% ORL
if (strcmpi(dataSet,'ORL'))
    imgs = load('./���ݼ�/ORL_32x32.mat', 'fea');
    labels = load('./���ݼ�/ORL_32x32.mat', 'gnd');
% Yale
elseif (strcmpi(dataSet,'Yale'))
    imgs = load('./���ݼ�/Yale_64x64.mat', 'fea');
    labels = load('./���ݼ�/Yale_64x64.mat', 'gnd');
% YaleB
elseif (strcmpi(dataSet,'YaleB'))
    imgs = load('./���ݼ�/YaleB_32x32.mat', 'fea');
    labels = load('./���ݼ�/YaleB_32x32.mat', 'gnd');
end
