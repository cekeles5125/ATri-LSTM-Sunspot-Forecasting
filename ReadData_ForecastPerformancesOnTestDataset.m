clear all;
load TestSet_10Veri_no1

RMSE_train_x(1)=RMSE_train;
MSE_train_x(1)=MSE_train;
MAE_train_x(1)=MAE_train;
MAPE_train_x(1)=MAPE_train;
R2_train_x(1)=R2_train;

RMSE_x(1)=RMSE;
MSE_x(1)=MSE;
MAE_x(1)=MAE;
MAPE_x(1)=MAPE;
R2_x(1)=R2;

load TestSet_10Veri_no2

RMSE_train_x(2)=RMSE_train;
MSE_train_x(2)=MSE_train;
MAE_train_x(2)=MAE_train;
MAPE_train_x(2)=MAPE_train;
R2_train_x(2)=R2_train;

RMSE_x(2)=RMSE;
MSE_x(2)=MSE;
MAE_x(2)=MAE;
MAPE_x(2)=MAPE;
R2_x(2)=R2;

load TestSet_10Veri_no3

RMSE_train_x(3)=RMSE_train;
MSE_train_x(3)=MSE_train;
MAE_train_x(3)=MAE_train;
MAPE_train_x(3)=MAPE_train;
R2_train_x(3)=R2_train;

RMSE_x(3)=RMSE;
MSE_x(3)=MSE;
MAE_x(3)=MAE;
MAPE_x(3)=MAPE;
R2_x(3)=R2;

load TestSet_10Veri_no4

RMSE_train_x(4)=RMSE_train;
MSE_train_x(4)=MSE_train;
MAE_train_x(4)=MAE_train;
MAPE_train_x(4)=MAPE_train;
R2_train_x(4)=R2_train;

RMSE_x(4)=RMSE;
MSE_x(4)=MSE;
MAE_x(4)=MAE;
MAPE_x(4)=MAPE;
R2_x(4)=R2;

load TestSet_10Veri_no5

RMSE_train_x(5)=RMSE_train;
MSE_train_x(5)=MSE_train;
MAE_train_x(5)=MAE_train;
MAPE_train_x(5)=MAPE_train;
R2_train_x(5)=R2_train;

RMSE_x(5)=RMSE;
MSE_x(5)=MSE;
MAE_x(5)=MAE;
MAPE_x(5)=MAPE;
R2_x(5)=R2;

load TestSet_10Veri_no6

RMSE_train_x(6)=RMSE_train;
MSE_train_x(6)=MSE_train;
MAE_train_x(6)=MAE_train;
MAPE_train_x(6)=MAPE_train;
R2_train_x(6)=R2_train;

RMSE_x(6)=RMSE;
MSE_x(6)=MSE;
MAE_x(6)=MAE;
MAPE_x(6)=MAPE;
R2_x(6)=R2;

load TestSet_10Veri_no7

RMSE_train_x(7)=RMSE_train;
MSE_train_x(7)=MSE_train;
MAE_train_x(7)=MAE_train;
MAPE_train_x(7)=MAPE_train;
R2_train_x(7)=R2_train;

RMSE_x(7)=RMSE;
MSE_x(7)=MSE;
MAE_x(7)=MAE;
MAPE_x(7)=MAPE;
R2_x(7)=R2;

load TestSet_10Veri_no8

RMSE_train_x(8)=RMSE_train;
MSE_train_x(8)=MSE_train;
MAE_train_x(8)=MAE_train;
MAPE_train_x(8)=MAPE_train;
R2_train_x(8)=R2_train;

RMSE_x(8)=RMSE;
MSE_x(8)=MSE;
MAE_x(8)=MAE;
MAPE_x(8)=MAPE;
R2_x(8)=R2;

load TestSet_10Veri_no9

RMSE_train_x(9)=RMSE_train;
MSE_train_x(9)=MSE_train;
MAE_train_x(9)=MAE_train;
MAPE_train_x(9)=MAPE_train;
R2_train_x(9)=R2_train;

RMSE_x(9)=RMSE;
MSE_x(9)=MSE;
MAE_x(9)=MAE;
MAPE_x(9)=MAPE;
R2_x(9)=R2;

load TestSet_10Veri_no10

RMSE_train_x(10)=RMSE_train;
MSE_train_x(10)=MSE_train;
MAE_train_x(10)=MAE_train;
MAPE_train_x(10)=MAPE_train;
R2_train_x(10)=R2_train;

RMSE_x(10)=RMSE;
MSE_x(10)=MSE;
MAE_x(10)=MAE;
MAPE_x(10)=MAPE;
R2_x(10)=R2;


RMSE_train_Ort=mean(RMSE_train_x);
MSE_train_Ort=mean(MSE_train_x);
MAE_train_Ort=mean(MAE_train_x);
MAPE_train_Ort=mean(MAPE_train_x);
R2_train_Ort=mean(R2_train_x);

RMSE_Ort=mean(RMSE_x);
MSE_Ort=mean(MSE_x);
MAE_Ort=mean(MAE_x);
MAPE_Ort=mean(MAPE_x);
R2_Ort=mean(R2_x);

fprintf('-------------------------------------- \n');
fprintf('*** 10 Test Average Model Performance for Train Dataset \n');
fprintf('Root Mean Square Error (RMSE): %f \n',RMSE_train_Ort);
fprintf('Mean Square Error (MSE): %f \n',MSE_train_Ort);
fprintf('Mean Absualte Error (MAE): %f \n',MAE_train_Ort);
fprintf('Mean Relative Error (MRE): %f \n',MAPE_train_Ort);
fprintf('Mean Relative Error (R^2): %f \n',R2_train_Ort);

fprintf('-------------------------------------- \n');
fprintf('*** 10 Test Average Model Performance for Test Dataset \n');
fprintf('Not: Lower Bound for 10 Future Prediction Performans \n');
fprintf('Root Mean Square Error (RMSE): %f \n',RMSE_Ort);
fprintf('Mean Square Error (MSE): %f \n',MSE_Ort);
fprintf('Mean Absualte Error (MAE): %f \n',MAE_Ort);
fprintf('Mean Relative Error (MRE): %f \n',MAPE_Ort);
fprintf('Mean Relative Error (R^2): %f \n',R2_Ort);
