clear;
clc;

[~,~,data_txt] = xlsread('train.csv');
data_live = data_txt(2:end , 2);
data_pclass = data_txt(2:end , 3);
data_sex = data_txt(2:end , 5);
data_age = data_txt(2:end , 6);
data_sibsp = data_txt(2:end , 7);
data = [data_pclass , data_sex , data_age , data_sibsp];

[~,~,test_txt] = xlsread('test.csv');
test_pclass = test_txt(2:end , 2);
test_sex = test_txt(2:end , 4);
test_age = test_txt(2:end , 5);
test_sibsp = test_txt(2:end , 6);
test = [test_pclass , test_sex , test_age , test_sibsp];

New      = y30211004_3(data);
New_test = y30211004_3(test);
[len,~]  = size(New_test);
New_zero = zeros(len,1);

New = [cell2mat(data_live),New];
New_test = [New_zero ,New_test];


[live_pclass,death_pclass] = y30211004_1(New,2);
[live_sex,death_sex]       = y30211004_1(New,3);
[live_age,death_age]       = y30211004_1(New,4);
[live_sibsp,death_silbsp]  = y30211004_1(New,5);

live_pclass_vale  = y30211004_2(New_test(:,2),live_pclass);
live_sex_vale     = y30211004_2(New_test(:,3),live_sex);
live_age_vale     = y30211004_2(New_test(:,4),live_age);
live_sibsp_vale   = y30211004_2(New_test(:,5),live_sibsp);

death_pclass_vale =  y30211004_2(New_test(:,2),death_pclass);
death_sex_vale    =  y30211004_2(New_test(:,3),death_sex);
death_age_vale    =  y30211004_2(New_test(:,4),death_age);
death_sibsp_vale  =  y30211004_2(New_test(:,5),death_silbsp);

live_death_pro  = tabulate(New(:,1));
live_pro  = (live_death_pro(2,2)+1)/(live_death_pro(2,2)+1+live_death_pro(1,2)+1);
death_pro = (live_death_pro(1,2)+1)/(live_death_pro(2,2)+1+live_death_pro(1,2)+1);

[test_col,~] = size(New_test);
for i = 1:test_col
    live_death = live_pro*live_pclass_vale(i,2)*live_sex_vale(i,2)*live_age_vale(i,2)*death_sibsp_vale(i,2);%活下的概率
    death_live = death_pro*death_pclass_vale(i,2)*death_sex_vale(i,2)*death_age_vale(i,2)*death_sibsp_vale(i,2);%死了的概率
    if live_death>=death_live
        result_lable(i,1)= 1;
    else
        result_lable(i,1)= 0;
    end
end

[~,~,lable] = xlsread('gender_submission.csv');
right_lable = lable(2:end , 2);
[lable_col,~] = size(right_lable);
for i=1:lable_col
    lable_num(i,1) = cell2mat(right_lable(i,1));
end
A = [result_lable(:,1),lable_num(:,1)];
right = 0;
for i = 1:lable_col
    if result_lable(i ,1)== lable_num(i ,1)
        right = right +1;
    end
end
Accuary = right/lable_col;