% This script is the main process script.
%   In this script data is read from .dat file and train and test 
%   samples are picked randomly for each class. Then, gaussian mixtures 
%   are found by EM algorithm for each model (spherical, diagonal,
%   arbitrary). After that, confusion matrices are computed.

clear
clc

addpath('lib')

% Determine parameters
compNo = 5; % Number of gaussians
iteNo = 100; % Iteration number for EM

% Read data
dataCell = readData();

% Pick 500 random samples from classes(1,2,3) for training and testing sets
[class1Train, class1Test] = pickRandom(1, dataCell);
[class2Train, class2Test] = pickRandom(2, dataCell);
[class3Train, class3Test] = pickRandom(3, dataCell);

% Create cells for each class's parameters and final likelihood.
% Each cell includes alpha, mu and sigma values for each component.
% Each cell column includes these values for one gaussian case
alpha = cell(3,3);
mu = cell(3,3);
sigma = cell(3,3);
logLH = zeros(3,3);
logLHArray = cell(3,3);
convergedIte = cell(3,3);

for i=1:3   % For each gaussian case: Spherical(1), diagonal(2), arbitrary(3)
    % Initialize alpha mu and sigma for each class
    [mu{1,i}, sigma{1,i}, alpha{1,i}] = initializeParameters(class1Train, compNo);
    [mu{2,i}, sigma{2,i}, alpha{2,i}] = initializeParameters(class2Train, compNo);
    [mu{3,i}, sigma{3,i}, alpha{3,i}] = initializeParameters(class3Train, compNo);

    % Call EM algorithm for each class to find final log-likelihood and parameters
    % Fit gaussians
    [mu{1,i}, sigma{1,i}, alpha{1,i}, logLH(1,i), convergedIte{1,i}, logLHArray{1,i}] = EM(class1Train, compNo, i, iteNo, ...
        mu{1,i}, sigma{1,i}, alpha{1,i});
    [mu{2,i}, sigma{2,i}, alpha{2,i}, logLH(2,i), convergedIte{2,i}, logLHArray{2,i}] = EM(class2Train, compNo, i, iteNo, ...
        mu{2,i}, sigma{2,i}, alpha{2,i});
    [mu{3,i}, sigma{3,i}, alpha{3,i}, logLH(3,i), convergedIte{3,i}, logLHArray{3,i}] = EM(class3Train, compNo, i, iteNo, ...
        mu{3,i}, sigma{3,i}, alpha{3,i});
end


% Draw data
drawData(dataCell, mu, sigma, compNo);
