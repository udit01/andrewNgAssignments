function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
% below matrix suggestion given in the course
valuesP = [0.01 0.03 0.1 0.3 1 3 10 30]';

 predErrMatrix = zeros(size(8,8));
for i = 1:length(valuesP)
    cItr = valuesP(i,1);
   for j = 1:length(valuesP) 
        sigmaItr = valuesP(j,1);
        Model= svmTrain(X, y, cItr, @(x1, x2) gaussianKernel(x1, x2, sigmaItr)); 
        pred = svmPredict(Model,Xval);
        err = mean(double(pred ~= yval));
        predErrMatrix(i,j) = err;
   end
end    

% M=[4 5 6;2 1 4;1 0 5]
[min_validationSet_err,idx]=min(predErrMatrix(:));
[row,col]=ind2sub(size(predErrMatrix),idx);

C = valuesP(row,1);
sigma = valuesP(col,1);
% C = 1;
% sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%







% =========================================================================

end
