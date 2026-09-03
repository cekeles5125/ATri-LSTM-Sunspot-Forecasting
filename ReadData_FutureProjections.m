clear all;
load FuturPre_10Veri_no1

YPred_f1=YPred;

load FuturPre_10Veri_no2

YPred_f2=YPred;

load FuturPre_10Veri_no3

YPred_f3=YPred;

load FuturPre_10Veri_no4

YPred_f4=YPred;

load FuturPre_10Veri_no5

YPred_f5=YPred;

load FuturPre_10Veri_no6

YPred_f6=YPred;

load FuturPre_10Veri_no7

YPred_f7=YPred;

load FuturPre_10Veri_no8

YPred_f8=YPred;

load FuturPre_10Veri_no9

YPred_f9=YPred;

load FuturPre_10Veri_no10

YPred_f10=YPred;

load FuturPre_10Veri_no11

YPred_f11=YPred;

load FuturPre_10Veri_no12

YPred_f12=YPred;

load FuturPre_10Veri_no13

YPred_f13=YPred;

load FuturPre_10Veri_no14

YPred_f14=YPred;

load FuturPre_10Veri_no15

YPred_f15=YPred;

load FuturPre_10Veri_no16

YPred_f16=YPred;

load FuturPre_10Veri_no17

YPred_f17=YPred;

load FuturPre_10Veri_no18

YPred_f18=YPred;

load FuturPre_10Veri_no19

YPred_f19=YPred;

load FuturPre_10Veri_no20

YPred_f20=YPred;

load FuturPre_10Veri_no21

YPred_f21=YPred;

load FuturPre_10Veri_no22

YPred_f22=YPred;

load FuturPre_10Veri_no23

YPred_f23=YPred;

load FuturPre_10Veri_no24

YPred_f24=YPred;

load FuturPre_10Veri_no25

YPred_f25=YPred;

load FuturPre_10Veri_no26

YPred_f26=YPred;

load FuturPre_10Veri_no27

YPred_f27=YPred;

load FuturPre_10Veri_no28

YPred_f28=YPred;

load FuturPre_10Veri_no29

YPred_f29=YPred;

load FuturPre_10Veri_no30

YPred_f30=YPred;

load FuturPre_10Veri_no31

YPred_f31=YPred;

load FuturPre_10Veri_no32

YPred_f32=YPred;

load FuturPre_10Veri_no33

YPred_f33=YPred;

load FuturPre_10Veri_no34

YPred_f34=YPred;

load FuturPre_10Veri_no35

YPred_f35=YPred;

load FuturPre_10Veri_no36

YPred_f36=YPred;

load FuturPre_10Veri_no37

YPred_f37=YPred;

load FuturPre_10Veri_no38

YPred_f38=YPred;

load FuturPre_10Veri_no39

YPred_f39=YPred;

load FuturPre_10Veri_no40

YPred_f40=YPred;

YPred_m=[YPred_f1;YPred_f2;YPred_f3;YPred_f4;YPred_f5;YPred_f6;YPred_f7;YPred_f8;YPred_f9;YPred_f10;YPred_f11;YPred_f12;YPred_f13;YPred_f14;YPred_f15;YPred_f16;YPred_f17;YPred_f18;YPred_f19;YPred_f20;YPred_f21;YPred_f22;YPred_f23;YPred_f24;YPred_f25;YPred_f26;YPred_f27;YPred_f28;YPred_f29;YPred_f30;YPred_f31;YPred_f32;YPred_f33;YPred_f34;YPred_f35;YPred_f36;YPred_f37;YPred_f38;YPred_f39;YPred_f40];

YPred_avg=mean(YPred_m);

figure
plot(YPred_avg,'r')
hold on
plot(YPred_m','b')
hold off
legend(["Observed" "Forecast"])
ylabel("Sunspot")
title("Triple LSTM Forecast")

