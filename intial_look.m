% % inital look to the minin flotation data
% Content (taken from kaggle)
% The first column shows time and date range (from march of 2017 until september of 2017). Some columns were sampled every 20 second. Others were sampled on a hourly base.
% 
% The second and third columns are quality measures of the iron ore pulp right before it is fed into the flotation plant. Column 4 until column 8 are the most important variables that impact in the ore quality in the end of the process. From column 9 until column 22, we can see process data (level and air flow inside the flotation columns, which also impact in ore quality. The last two columns are the final iron ore pulp quality measurement from the lab.
% Target is to predict the last column, which is the % of silica in the iron ore concentrate.
clc; clear all; close all

load("mininProcessData.mat");
origData = MiningProcessFlotationPlantDatabase; % this is to get a bit shorter name for the data
%%

stackedplot(table2timetable(origData))
