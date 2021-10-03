function [outputArg1] = y30211004_3(data)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
%计算男人和女人的总数。
%对年龄缺少的男人和女人进行估计。
male_num = 0;     %男人的总数量
male_age_num =0;  %有年龄的男人的数量
female_num = 0;   %女人的总数量
female_age_num =0;%有年龄的女人的数量
male_age =0;      
female_age =0;
[all_num , feature_num] = size(data);
New = zeros(all_num , feature_num );
for i = 1:all_num
    if strcmp(data(i,2),'male')
        male_num = male_num+1;
        New(i,1) = cell2mat(data(i,1));
        New(i,2) = 1;
        if isnan(cell2mat(data(i,3)))== 0
            male_age_num = male_age_num + 1;
            male_age = male_age + cell2mat(data(i,3));
        end
    end
    if strcmp(data(i,2),'female')
        New(i,1) = cell2mat(data(i,1));
        New(i,2) = 0;
        female_num = female_num +1; 
        if isnan(cell2mat(data(i,3)))== 0
            female_age_num = female_age_num + 1;
            female_age = female_age + cell2mat(data(i,3));
        end
    end
end

%将未知男女年龄填入。
female_ave_age = round(female_age/female_age_num); %女人平均年龄
male_ave_age = round(male_age/male_age_num);       %男人平均年龄
for i = 1:all_num
    if isnan(cell2mat(data(i,3)))== 0
       New(i,3) = cell2mat(data(i,3));
    else
        if New(i,2) == 1
          New(i,3) = male_ave_age ;
        else
          New(i,3) = female_ave_age ;
        end
    end
    New(i,4) = cell2mat(data(i,4));
end
outputArg1 = New;
end

