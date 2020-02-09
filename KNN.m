function [accuracy] = KNN(X_train, y_train, X_test, y_test, k)
% 使用KNN(最近邻)预测结果

mdl = fitcknn(X_train, y_train, 'NumNeighbors', k);
total_num = size(X_test, 1);
acc = 0;
for i = 1:total_num
    label = predict(mdl, X_test(i,:));
    if label == y_test(i);
        acc = acc + 1;
    end
end

accuracy = acc/total_num;


