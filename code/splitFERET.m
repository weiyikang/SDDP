% �������
clear all
clc

% ��������
load('.\���ݼ�\FERET_80x80_col.mat');
FERET = FERET_80_80_col';

% ��ö�Ӧ�����ı�ǩ
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

% ���滮�ֵ�ѵ��������Լ��±�
path = '.\���ݼ�\FERET4\trainIdx';
save(path,'trainIdx');
path = '.\���ݼ�\FERET4\testIdx';
save(path,'testIdx');
path = '.\���ݼ�\FERET4\gnd';
save(path,'gnd');




