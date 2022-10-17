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

adata = autosc(data);

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
h.YDisplayLabels = varNam(1:end-2);


%%
% some kind of constraption, where the model is taught with previuous block and tested with the next

dim = 8;
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
plot([ yhat_save],'g') %ones(length(Yi),1);

figure;
h = heatmap(bsave(2:end,:),'Colormap', jet);
h.YDisplayLabels = varNam(1:end-2);
figure;
h = heatmap(bbsave(2:end,2:end),'Colormap', jet);
h.YDisplayLabels = varNam(1:end-2);
