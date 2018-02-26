clear all
close all
clc

load train_data

kerneloption  = 9;
c=1000;
lambda=1e-7;
kernel='rbf';
verbose=0;
nbclass=max(group);

[xsup,w,b,nbsv]=svmmulticlassoneagainstall(ciri_latih,group,nbclass,c,lambda,kernel,kerneloption,verbose);
save training_result.mat xsup w b nbsv kernel kerneloption target