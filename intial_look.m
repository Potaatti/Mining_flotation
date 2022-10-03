% % inital look to the minin flotation data
% Content (taken from kaggle)
% The first column shows time and date range (from march of 2017 until
% september of 2017). Some columns were sampled every 20 second. Others
% were sampled on a hourly base.
% 
% The second and third columns are quality measures of the iron ore pulp
% right before it is fed into the flotation plant. Column 4 until column 8
% are the most important variables that impact in the ore quality in the
% end of the process. From column 9 until column 22, we can see process
% data (level and air flow inside the flotation columns, which also impact
% in ore quality. The last two columns are the final iron ore pulp quality
% measurement from the lab. Target is to predict the last column, which is
% the % of silica in the iron ore concentrate.
clc; clear all; close all

load("mininProcessData.mat");
origData = MiningProcessFlotationPlantDatabase; % this is to get a bit shorter name for the data
origTime = origData.date;
%%
figure;
stackedplot(table2timetable(origData))

%%
dataM = origData(:,2:end).Variables; % get the data to a matrix. excluding datetime, first variable
varNam = origData(:,2:end).Properties.VariableNames;
figure;
boxplot(dataM, varNam)

figure;
boxplot(autosc(dataM),varNam)

%% moving mean filtering
% so the idea is, that there are variables that are samplet just hourly
% so if we take a moving mean from every hour, we get rid of the variation of the variablese in the hour
% with out the with in hour noise the data becomes easer to interpit and we can now pick areas (time ranges) of interest
mmData = movmean(dataM,3600,1);            
         
mmTab =array2timetable( mmData,'RowTimes',origTime); % make 
mmTab.Properties.VariableNames = varNam;

figure;
stackedplot(mmTab);   
% now in this figure basically only the variation that takes more than an hour is shown




