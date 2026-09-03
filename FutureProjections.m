clear all; %close all;

filename = 'SN_ms_tot_V2.0.xlsx';   
dataRange = 'D7:D3313';
data = readmatrix(filename, 'Range', dataRange);

figure
plot(data)
xlabel("Month")
ylabel("Sunspot")


TestDataNum=1; % Test kümesi sayısı
TrainSetRate=(1-(TestDataNum/numel(data)));
numTimeStepsTrain = floor(TrainSetRate*numel(data));


dataTrain = data(1:numTimeStepsTrain);
dataTest = data(numTimeStepsTrain+1:end);

mu = mean(dataTrain);
sig = std(dataTrain);

dataTrainStandardized = (dataTrain - mu) / sig;

% YTrain,XTrain'in bir ötelenmiş hali.

XTrain = dataTrainStandardized(1:end-1)';    
YTrain = dataTrainStandardized(2:end)';   



numFeatures = 1;
numResponses = 1;
numHiddenUnits = 200;

lgraph = layerGraph();

% Giriş katmanı
tempLayers = sequenceInputLayer(1,"Name","sequence");
lgraph = addLayers(lgraph,tempLayers);

% LSTM 1 (16 -> 64)
tempLayers = [
    lstmLayer(16,"Name","lstm")
    fullyConnectedLayer(64,"Name","fc_lstm")];
lgraph = addLayers(lgraph,tempLayers);

% LSTM 2 (64 -> 64)
tempLayers = [
    lstmLayer(64,"Name","lstm_1")
    fullyConnectedLayer(64,"Name","fc_lstm1")];
lgraph = addLayers(lgraph,tempLayers);

% LSTM 3 (128 -> 64)
tempLayers = [
    lstmLayer(128,"Name","lstm_2")
    fullyConnectedLayer(64,"Name","fc_lstm2")];
lgraph = addLayers(lgraph,tempLayers);

% Toplama + Çıkış
tempLayers = [
    additionLayer(3,"Name","addition")
    fullyConnectedLayer(1,"Name","fc")
    regressionLayer("Name","regressionoutput")];
lgraph = addLayers(lgraph,tempLayers);

% Bağlantılar
lgraph = connectLayers(lgraph,"sequence","lstm");
lgraph = connectLayers(lgraph,"sequence","lstm_1");
lgraph = connectLayers(lgraph,"sequence","lstm_2");

lgraph = connectLayers(lgraph,"fc_lstm","addition/in1");
lgraph = connectLayers(lgraph,"fc_lstm1","addition/in2");
lgraph = connectLayers(lgraph,"fc_lstm2","addition/in3");

% Grafiği çiz
plot(lgraph);

options = trainingOptions('adam', ...
    'MaxEpochs', 500, ...
    'GradientThreshold', 1, ...
    'InitialLearnRate', 0.005, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropPeriod' ,125, ...
    'LearnRateDropFactor', 0.2, ...
    'Verbose', 0, ...
    'Plots','training-progress'); %,'L2Regularization',3e-1


net = trainNetwork(XTrain,YTrain,lgraph,options);
[net,YPredTrain] = predictAndUpdateState(net,XTrain);
% Gerçek sıcaklık tahmini (bir sonraki)
YPredTrain = sig*YPredTrain + mu;

dataTestStandardized = (dataTest - mu) / sig;
XTest = dataTestStandardized(1:end-1)';   % gelen hatayı yazdığımda internette transpozu alınmalı dedi. çünkü sütun vektörü olunca böyle olmalıymış.

%net = predictAndUpdateState(net,XTrain);
[net,YPred] = predictAndUpdateState(net,YTrain(end));
% Test kümesinin ilk verisi oldu
% Gelecek yıl tahminleri
%numTimeStepsTest = numel(XTest);
numTimeStepsTest=120;
for i = 2:numTimeStepsTest
    [net,YPred(i)] = predictAndUpdateState(net,YPred(i-1),'ExecutionEnvironment','cpu');
end
% Test performance analizi
%[net,YPredx] = predictAndUpdateState(net,XTest(2:end));
%YPred=[YPred YPredx]
YPred = sig*YPred + mu;

YTest = dataTest(1:end);%2
%rmse = sqrt(mean((YPred-YTest').^2))

YTrainx = dataTrainStandardized(2:end)';
YTrain = sig*YTrainx + mu;

figure
plot(dataTrain(2:end))
hold on
plot(YPredTrain(1:end-1))
hold off
xlabel("Month")
ylabel("Sunspot")
title("Forecast")
legend(["Observed" "Forecast"])

figure
subplot(2,1,1)
plot(YTest)
hold on
plot(YPred,'.-')
hold off
legend(["Observed" "Forecast"])
ylabel("Sunspot")
title("Forecast")

subplot(2,1,2)
stem(YPred - YTest')
xlabel("Month")
ylabel("Error")
% title("RMSE = " + rmse)


YTrain_sift=dataTrain(2:end)'
% Trainig dataset performanse
RMSE_train = sqrt(mean((YPredTrain-YTrain_sift).^2));
MSE_train = mean((YPredTrain-YTrain_sift).^2);
MAE_train = mean(abs(YPredTrain-YTrain_sift));
MAPE_train = mean(abs(YPredTrain-YTrain_sift)./abs(YTrain_sift));
mean_yd=mean(YTrain_sift);
R2_train=1-(sum((YPredTrain-YTrain_sift).^2))/(sum((YTrain_sift-mean_yd).^2));

%Model performance reports
fprintf('-------------------------------------- \n');
fprintf('*** Model Performance for Train Dataset \n');
fprintf('Root Mean Square Error (RMSE): %f \n',RMSE_train);
fprintf('Mean Square Error (MSE): %f \n',MSE_train);
fprintf('Mean Absualte Error (MAE): %f \n',MAE_train);
fprintf('Mean Relative Error (MRE): %f \n',MAPE_train);
fprintf('Mean Relative Error (R^2): %f \n',R2_train);

RMSE = sqrt(mean((YPred - YTest').^2,"all"));
MSE = mean((YPred - YTest').^2,"all");
MAE = mean(abs(YPred - YTest'),"all");
MAPE = mean(abs(YPred - YTest')./abs(YTest'),"all");
mean_yd=mean(YTest',"all");
R2=1-((sum((YPred - YTest').^2,"all"))/(sum((YTest'-mean_yd).^2,"all")));

%Model performance reports
fprintf('-------------------------------------- \n');
fprintf('*** Model Performance for Test Dataset \n');
fprintf('Root Mean Square Error (RMSE): %f \n',RMSE);
fprintf('Mean Square Error (MSE): %f \n',MSE);
fprintf('Mean Absualte Error (MAE): %f \n',MAE);
fprintf('Mean Relative Error (MRE): %f \n',MAPE);
fprintf('Mean Relative Error (R^2): %f \n',R2);

save FuturPre_10Veri_no1