clear all; clc;

% ======== Veri Yükleme ========
filename = 'SN_ms_tot_V2.0.xlsx';
dataRange = 'D7:D3313';
data = readmatrix(filename, 'Range', dataRange);

figure
plot(data)
xlabel("Month")
ylabel("Sunspot")

% ======== Train / Test Ayırma ========
TestDataNum = 300;
TrainSetRate = (1 - (TestDataNum / numel(data)));
numTimeStepsTrain = floor(TrainSetRate * numel(data));

dataTrain = data(1:numTimeStepsTrain);
dataTest = data(numTimeStepsTrain+1:end);

% Normalizasyon
mu = mean(dataTrain);
sig = std(dataTrain);
dataTrainStandardized = (dataTrain - mu) / sig;

% Giriş ve çıkış dizileri
XTrain = {dataTrainStandardized(1:end-1)'};
YTrain = {dataTrainStandardized(2:end)'};

% ======== Layer Graph ========
lgraph = layerGraph();

% Giriş
tempLayers = sequenceInputLayer(1,"Name","sequence");
lgraph = addLayers(lgraph,tempLayers);

% LSTM 1
tempLayers = [
    lstmLayer(16,"Name","lstm")
    fullyConnectedLayer(64,"Name","fc_lstm")
];
lgraph = addLayers(lgraph,tempLayers);

% LSTM 2
tempLayers = [
    lstmLayer(64,"Name","lstm_1")
    fullyConnectedLayer(64,"Name","fc_lstm1")
];
lgraph = addLayers(lgraph,tempLayers);

% LSTM 3
tempLayers = [
    lstmLayer(128,"Name","lstm_2")
    fullyConnectedLayer(64,"Name","fc_lstm2")
];
lgraph = addLayers(lgraph,tempLayers);

% Toplama + Çıkış
tempLayers = [
    additionLayer(3,"Name","addition")
    fullyConnectedLayer(1,"Name","fc")
    regressionLayer("Name","regressionoutput")
];
lgraph = addLayers(lgraph,tempLayers);

% Bağlantılar
lgraph = connectLayers(lgraph,"sequence","lstm");
lgraph = connectLayers(lgraph,"sequence","lstm_1");
lgraph = connectLayers(lgraph,"sequence","lstm_2");
lgraph = connectLayers(lgraph,"fc_lstm","addition/in1");
lgraph = connectLayers(lgraph,"fc_lstm1","addition/in2");
lgraph = connectLayers(lgraph,"fc_lstm2","addition/in3");

% ======== Eğitim Ayarları ========
options = trainingOptions('adam', ...
    'MaxEpochs', 500, ...
    'GradientThreshold', 1, ...
    'InitialLearnRate', 0.005, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropPeriod', 125, ...
    'LearnRateDropFactor', 0.2, ...
    'Verbose', 0, ...
    'Plots', 'training-progress');

% ======== Eğitim ========
net = trainNetwork(XTrain,YTrain,lgraph,options);

% ======== Train Tahmin ========
[net, yPredCell] = predictAndUpdateState(net,XTrain);
YPredTrain = sig * yPredCell{1} + mu;

% ======== Test Tahmin ========
dataTestStandardized = (dataTest - mu) / sig;
XTest = dataTestStandardized(1:end-1)';

numTimeStepsTest = numel(XTest);
YPred = zeros(1, numTimeStepsTest);

[net, yPredValue] = predictAndUpdateState(net, XTest(1));
YPred(1) = yPredValue;

for i = 2:numTimeStepsTest
    [net, yPredValue] = predictAndUpdateState(net, YPred(i-1));
    YPred(i) = yPredValue;
end

YPred = sig * YPred + mu;
YTest = dataTest(2:end);

% ======== Grafikler ========
figure
plot(dataTrain(2:end))
hold on
plot(YPredTrain(1:end-1))
hold off
xlabel("Month")
ylabel("Sunspot")
title("Train Forecast")
legend(["Observed" "Forecast"])

figure
subplot(2,1,1)
plot(YTest)
hold on
plot(YPred,'.-')
hold off
legend(["Observed" "Forecast"])
ylabel("Sunspot")
title("Test Forecast")

subplot(2,1,2)
stem(YPred - YTest')
xlabel("Month")
ylabel("Error")

% ======== Performans Metrikleri ========
% Train
YTrain_sift = dataTrain(2:end)';
RMSE_train = sqrt(mean((YPredTrain - YTrain_sift).^2));
MSE_train = mean((YPredTrain - YTrain_sift).^2);
MAE_train = mean(abs(YPredTrain - YTrain_sift));
MAPE_train = mean(abs(YPredTrain - YTrain_sift) ./ abs(YTrain_sift));
mean_yd = mean(YTrain_sift);
R2_train = 1 - (sum((YPredTrain - YTrain_sift).^2)) / (sum((YTrain_sift - mean_yd).^2));

% Test
RMSE = sqrt(mean((YPred - YTest').^2,"all"));
MSE = mean((YPred - YTest').^2,"all");
MAE = mean(abs(YPred - YTest'),"all");
MAPE = mean(abs(YPred - YTest') ./ abs(YTest'),"all");
mean_yd = mean(YTest',"all");
R2 = 1 - (sum((YPred - YTest').^2,"all")) / (sum((YTest' - mean_yd).^2,"all"));

% ======== Sonuç Yazdırma ========
fprintf('-------------------------------------- \n');
fprintf('*** Model Performance for Train Dataset \n');
fprintf('RMSE: %f \n',RMSE_train);
fprintf('MSE : %f \n',MSE_train);
fprintf('MAE : %f \n',MAE_train);
fprintf('MAPE: %f \n',MAPE_train);
fprintf('R^2 : %f \n',R2_train);

fprintf('-------------------------------------- \n');
fprintf('*** Model Performance for Test Dataset \n');
fprintf('RMSE: %f \n',RMSE);
fprintf('MSE : %f \n',MSE);
fprintf('MAE : %f \n',MAE);
fprintf('MAPE: %f \n',MAPE);
fprintf('R^2 : %f \n',R2);

save TestSet_10Veri_no1