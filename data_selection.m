%% miningdata analayis
clc; clear all; close all

load("mininProcessData.mat");
origData = MiningProcessFlotationPlantDatabase; % this is to get a bit shorter name for the data
origTime = origData.date;

load("mmTab.mat")


%% select time intervals for analysis

TR1 = timerange("2017-04-02","2017-05-12"); % first
TR2 = timerange("2017-06-15","2017-07-21");
TR3 = timerange("2017-08-15","2017-09-09");
range1 = mmTab(TR1,:);
range2 = mmTab(TR2,:);
range3 = mmTab(TR3,:);

% figure; boxplot(zscore(range3.Variables))

%% some initial this and that
data1  = range1.Variables;

figure;
stackedplot(range1)

[coeff, score, latent, tsquared, explained, mu] = pca(zscore(data1));
% figure;plotmatrix(score(:,1:7))