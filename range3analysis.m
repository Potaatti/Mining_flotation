% minin flotation range 3 analysis
% data divided in data_selection.m
clc; close all;

% pwd
addpath("datana-1.1.3",pwd) % note I use the functions found in the datana package provided in moodle page

%%
origData3 = origRange3.Variables;
data   = range3.Variables;
varNam = range3.Properties.VariableNames;
figure; stackedplot(range3);

%% 


[t,p,r2] = pca(autosc(origData3));

figure; plotmatrix(t(:,1:8))

figure; biplot(p(:,1:2),"Scores", t(:,1:2) , "VarLabels",varNam)
figure; biplot(p(:,3:4),"Scores", t(:,3:4) , "VarLabels",varNam)

figure;bar(p(1:8,:),'DisplayName','p')

% figure; stackedplot(t)

%%

%%

adata = autosc(data(:,[1:7 22:23]));

bsave = [];
ypred_save =[];
for i = 1:length(adata)-100
X = adata(i:i+99,2:end);
Y = adata(i:i+99,1);
% [T,P,Q,W,U,ypred,b,R2Y] = ppls(X,Y,5);
[ypred,b,T,P,Q,W,U] = plsreg(X,Y,5);
bsave(:,i) = b;
ypred_save = [ypred_save; ypred];
% ypred_save(:,i) = ypred;
end

yreds = ypred_save(:);

% x = 1:length(adata);
figure;
plot(adata(:,1))
hold on
plot(yreds,'r')


% bsave = [bsave; bsave(end,:)];
%%
% some kind of constraption, where the model is taught with previuous block and tested with the next

dim = 5;
bsave = [];
ypred_save =[];
yhat_save = [];
ivals = 1:5000:length(adata);
ni = length(ivals);

for K = 1 : ni -2
    i  = [ivals(K):ivals(K+1)];
    ii = [ivals(K+1):ivals(K+2)];
    X = adata(i,1:end-2);
    Y = adata(i,end);
    Xpred = adata(ii,1:end-2);
    [ypred,b,T,P,Q,W,U] = plsreg(X,Y,dim);
    [yhat,b,that] = plspred(Xpred,P,Q,W,dim);
    bsave(:,K) = b;
    ypred_save = [ypred_save; ypred];
    yhat_save = [yhat_save; yhat];
end


figure;
plot(adata(:,end))
hold on
plot(ypred_save,'r')
hold on
plot([ones(length(Y),1); yhat_save],'g')

figure;
h = heatmap(bsave(2:end,:),'Colormap', jet);
% h.YDisplayLabels = varNam(1:end-2);
h.YDisplayLabels = varNam(1:7);

%%
% some kind of constraption, where the model is taught with previuous block and tested with the next

dim = 5;
bsave = [];
bbsave = [];
ypred_save =[];
yhat_save = [];
ivals = 1:5000:length(adata);
ni = length(ivals);
X = [];
Y = [];
for K = 1 : ni -2
    i  = [ivals(K):ivals(K+1)];
    ii = [ivals(K+1):ivals(K+2)];
    Xi = adata(i,1:end-2);
    X = [X; Xi ];
    Yi = adata(i,end);
    Y = [Y; Yi];
    Xpred = adata(ii,1:end-2);
    [ypred,bb,T,P,Q,W,U] = plsreg(X,Y,dim);
    y_p = ypred;
    bbsave(:,K) = bb;
    [yhat,b,that] = plspred(Xpred,P,Q,W,dim);
    bsave(:,K) = b;
    ypred_save = [ypred_save; ypred];
    yhat_save = [yhat_save; yhat];
end


figure;
plot(adata(:,end))
hold on
plot(y_p,'r')
hold on
plot([ones(length(Yi),1); yhat_save],'g') %ones(length(Yi),1);

figure;
h = heatmap(bsave(2:end,:),'Colormap', jet);
h.YDisplayLabels = varNam(1:7);

figure;
h = heatmap(bbsave(2:end,2:end),'Colormap', jet);
h.YDisplayLabels = varNam(1:7);


%%
% moving window of teaching and predicting, 
% so that both lenghts can be adjusted
% write Q2 and R2 
close all
train_window = 1000;
test_window  = 10;
dim = 7;
bsave = [];
bbsave = [];
ypred_save =[];
yhat_save = [];
ivals   = 1:train_window:length(adata);
plotvas = 1:length(adata);
ni = length(ivals);
pvals_save = [];
X = [];
Y = [];
R2 = [];
Q2 = [];
Xp = [];
for K = 1 : ni -2
    i  = [ivals(K):ivals(K+1)];
    ii = [ivals(K+1):ivals(K+1)+test_window]; % test the ex 500 next values
    Xi = adata(i,1:end-2);
    X  = [X; Xi ];
    Xp = [Xp; plotvas(i)']; % not used yet
    Yi = adata(i,end);
    Y = [Y; Yi];
    Xpred = adata(ii,1:end-2);
    xpredplot = plotvas(ii)';
    Ypred = adata(ii,end);
    [ypred,bb,T,P,Q,W,U] = plsreg(X,Y,dim);
    y_p = ypred;
    bbsave(:,K) = bb;
    [yhat,b,that] = plspred(Xpred,P,Q,W,dim);
    bsave(:,K) = b;
    ypred_save = [ypred_save; ypred];
    yhat_save  = [yhat_save; yhat];
    pvals_save = [pvals_save; xpredplot];
    rss = sum((Y-ypred).^2);
    tss = sum((Y - mean(Y)).^2);
    R2(K) = 1 - (rss/tss);
    press = sum((Ypred-yhat).^2);
    tssq = sum((Ypred - mean(Ypred)).^2);
    Q2(K) = 1 - (press/tss);


end


figure;
plot(adata(:,end))
hold on
plot(y_p,'r') % the final model with most data. really the piece by pievce model look a bit different
% hold on
% plot(Xp,ypred_save ,'r')
hold on
% plot([ones(length(Yi),1); yhat_save],'g') %ones(length(Yi),1);
plot(pvals_save, yhat_save,'g') %ones(length(Yi),1);


figure;
h = heatmap(bsave(2:end,:),'Colormap', jet);
h.YDisplayLabels = varNam(1:7);

figure;
h = heatmap(bbsave(2:end,2:end),'Colormap', jet);
h.YDisplayLabels = varNam(1:7);

figure;
subplot(2,1,1); plot(Q2(2:end)); title('Q2')
subplot(2,1,2); plot(R2); title('R2')

%%
% moving window of teaching and predicting, 
% so that both lenghts can be adjusted
% write Q2 and R2 
close all
train_window = 5000;
test_window  = 1000;
dim = 2;
bsave = [];
bbsave = [];
ypred_save =[];
yhat_save = [];
ivals   = 1:train_window:length(adata);
plotvas = 1:length(adata);
ni = length(ivals);
pvals_save = [];
X = [];
Y = [];
R2 = [];
Q2 = [];
Xp = [];
for K = 1 : ni -2
    i  = [ivals(K):ivals(K+1)];
    ii = [ivals(K+1):ivals(K+1)+test_window]; % test the ex 500 next values
    Xi = adata(i,1:end-2);
    X  = [ Xi ];
    Xp = [Xp; plotvas(i)']; % not used yet
    Yi = adata(i,end);
    Y = [ Yi];
    Xpred = adata(ii,1:end-2);
    xpredplot = plotvas(ii)';
    Ypred = adata(ii,end);
    [ypred,bb,T,P,Q,W,U] = plsreg(X,Y,dim);
    y_p = ypred;
    bbsave(:,K) = bb;
    [yhat,b,that] = plspred(Xpred,P,Q,W,dim);
    bsave(:,K) = b;
    ypred_save = [ypred_save; ypred];
    yhat_save  = [yhat_save; yhat];
    pvals_save = [pvals_save; xpredplot];
    rss = sum((Y-ypred).^2);
    tss = sum((Y - mean(Y)).^2);
    R2(K) = 1 - (rss/tss);
    press = sum((Ypred-yhat).^2);
    tssq = sum((Ypred - mean(Ypred)).^2);
    Q2(K) = 1 - (press/tss);


end


figure;
plot(adata(:,end))
% hold on
% plot(y_p,'r') % the final model with most data. really the piece by pievce model look a bit different
hold on
plot(Xp,ypred_save ,'r')
hold on
% plot([ones(length(Yi),1); yhat_save],'g') %ones(length(Yi),1);
plot(pvals_save, yhat_save,'g') %ones(length(Yi),1);


figure;
h = heatmap(bsave(2:end,:),'Colormap', jet);
h.YDisplayLabels = varNam(1:7);

figure;
h = heatmap(bbsave(2:end,2:end),'Colormap', jet);
h.YDisplayLabels = varNam(1:7);

figure;
subplot(2,1,1); plot(Q2(2:end)); title('Q2')
subplot(2,1,2); plot(R2); title('R2')