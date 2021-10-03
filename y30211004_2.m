function [outputArg1] = y30211004_2(test_data,train_result)
[test_data_Col,~]=size(test_data);
for i =1:test_data_Col
    if find(train_result==test_data(i,1))
        [goal_col,~]=find(train_result==test_data(i,1));
        test(i,1)=test_data(i,1);
        test(i,2)=train_result(goal_col,2);
    else
        test(i,1)=test_data(i,1);
        test(i,2)=0;
    end
end
a = 1;
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说
outputArg1 = test;
end

