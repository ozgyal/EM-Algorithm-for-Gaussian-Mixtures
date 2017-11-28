function [train, test] = pickRandom(classNo, dataCell)
%This function picks random 500 samples from given class.
xCoordinates = dataCell{1};
yCoordinates = dataCell{2};

% Find specified class samples
endPoint = classNo * 1000;
startPoint = endPoint - 999;
xCoordinates = xCoordinates(startPoint:endPoint);
yCoordinates = yCoordinates(startPoint:endPoint);

% Create random indices
randomNo = randperm(1000);
trainNo = randomNo(1:500);
testNo = randomNo(501:1000);

% Create random samples' set
train = [xCoordinates(trainNo) yCoordinates(trainNo)];
test = [xCoordinates(testNo) yCoordinates(testNo)];
end

