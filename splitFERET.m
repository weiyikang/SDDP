% 清除环境
clear all
clc

% 加载数据
load('.\数据集\FERET_80x80_col.mat');
FERET = FERET_80_80_col';

% 获得对应样本的标签
trainIdx = [];
testIdx = [];
gnd = [];
trainI=1;
testI=1;
i=1;
for l=1:200
    for j=1:7
        if j<5
            trainIdx(trainI)=i;
            trainI=trainI+1;
        else
            testIdx(testI)=i;
            testI=testI+1;
        end
        gnd(i)=l;
        i=i+1;
    end
end
trainIdx = trainIdx';
testIdx = testIdx';
gnd = gnd';

% 保存划分的训练集与测试集下标
path = '.\数据集\FERET4\trainIdx';
save(path,'trainIdx');
path = '.\数据集\FERET4\testIdx';
save(path,'testIdx');
path = '.\数据集\FERET4\gnd';
save(path,'gnd');




