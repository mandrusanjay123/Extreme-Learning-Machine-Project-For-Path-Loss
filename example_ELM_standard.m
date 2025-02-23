
clear;clc
%addpath('codes','dataset');
%addpath('I:\Soft_computing code\ELM\ELM_updated1\html');
%addpath('I:\');
%% Load data
%load Dataset
%Xdata=Antenna_microstrip(:,1:4);% training and testing input data
%Ydata=Antenna_microstrip(:,5);   % training and testing output/target data
%  
%
load modified_real_value_data.mat
data(:,1:3)=data(:,1:3)/1000;
 Xdata=data(:,1:4);
%  Xdata=mapminmax(Xdata',-1,1);
 %Xdata=Xdata';
 Ydata=data(:,5);
%% define Options
%In the dats sets, Instances will be in the rows and attributes/variables will be in the columns
 %Y is actual training output data,Y_hat is the training targets/output/predicted data generated by ELM
 %Yts is actual testing output data,Yts_hat is the test targets/output/predicted data generated by ELM
 %These are available in net in workspace

Opts.fixed=0;  % 1 for fixed training and testing input and output data, 0 for random training and testing data

%number_neurons=200;   % Maximam number of neurons
Opts.Tr_ratio=0.80;       % training ratio for fixing training and testing data randomly

%Opts.ActivationFunction='tribas';% Activation functions to be used one of them: 'sig','tansig','logsig',elliotsig',radbas','tribas','sin','cos','hardlim'

Opts.Regularisation=1; % 1 for inverting with regularisation; 0 for other e.g.Moore-Penrose pseudoinverse of matrix
%C=1/(50*eps);% C value required in the calculation of inversion of matrix in regularization
%C=10^13;
seed=0;% seed for random number

 
 if Opts.Regularisation==1
 C=10.^(-18:1:0);  % exp(-18:0.1:1) or 10.^(-18:0.1:1) or 2.^(-18:0.1:1);
else
 C=0;
end
 activation={'sigmoid','sine','hardlim','tribas','radbas','tansig','logsig','cos','elliotsig'};
%i=0;
minm=100000;%    
%for number_neurons=50:200
%        i=i+1
for number_neurons=100:1:300
for C_optimal=C(1:size(C,1)) 
for x=1:9
Opts.ActivationFunction=activation{x};
[net]= elm_standard(Xdata,Ydata,Opts,number_neurons,C_optimal,seed);
if(net.training_accuracy<minm)
minm=net.training_accuracy;

Optimal_C=C_optimal;
Optimal_neurons=number_neurons;
af=net.Opts.ActivationFunction;
New_net=net;
end%             
 
end
end%
end
net=New_net
number_neurons=Optimal_neurons;
C=Optimal_C;
Opts.ActivationFunction=af;








