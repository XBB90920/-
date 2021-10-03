function [output1,output2] = y30211004_1(Date,Col)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
[col_num , ~] = size(Date);
live_num = 0;
death_num = 0;
for i = 1:col_num
   if  Date(i,1) == 1
       live_num = live_num + 1;
       live(live_num,1) = Date(i,Col);
   else
       death_num = death_num + 1;
       death(death_num,1) = Date(i,Col);
   end
end
% 不加拉普拉斯平滑
% output = tabulate(live(:,1)) ;
% output1=[output(:,1),output(:,3)];
% output3 = tabulate(death(:,1)) ;
% output2=[output3(:,1),output3(:,3)];

%加拉普拉斯平滑
output = tabulate(live(:,1)) ;
output3 = tabulate(death(:,1)) ;
[a,~] = size(output);
[b,~] = size(output3);
for i = 1: a
    output1(i ,1) = output(i ,1);
    output1(i ,2) = (output(i ,2) + 1)/(live_num + a);
end
for i = 1: b
    output2(i ,1) = output3(i ,1);
    output2(i ,2) = (output3(i ,2) + 1)/(death_num + b);
end

end

