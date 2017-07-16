function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
% J = sum( -(y).*(log(sigmoid(X*theta)))-(ones(m,1)-y).*(log(ones(m,1)-sigmoid(X*theta))) )/m + (lambda/(2*m))*(sum(theta.^2)-(theta(1)^2) );
% grad = ( (X')*(sigmoid(X*theta)-y) )/m +(lambda/m)*(theta) ;
% 
% grad(1) = grad(1) - (lambda/m)*(theta(1)) ;

%  a1 = X;
 a1 = [ones(m,1) X];
% a2 = sigmoid(a1*Theta1');
 a2 = [ones(m,1) sigmoid(a1*Theta1')];
 a3 = sigmoid(a2 * Theta2');

for k = 1:num_labels
   J = J + sum (-(y==k).*( log( a3(:,k) ) )-( 1.0 -(y==k)).*(log( 1.0 - a3(:,k) )) ) /m ;
end

the1 = Theta1( : , 2:size(Theta1,2) );
the2 = Theta2( : , 2:size(Theta2,2) );

J = J + (lambda/(2*m))*( sum(sum(the1.^2),2) + sum(sum(the2.^2),2) );


 Del2 = Theta2_grad;%%Basically just zeroes
     Del1 = Theta1_grad;
for t = 1:m
   aa1 = [1 ; X(t,:)'];
   zz2 = Theta1*aa1;
   aa2 = [1 ; sigmoid(zz2)];
   zz3 = Theta2*aa2; 
   aa3 = sigmoid(zz3);
   
   yk = zeros(num_labels,1);
   yk(y(t,:)) = 1;
   delta3 = aa3 - (yk);
   
   
   the2 = Theta2( : , 2:size(Theta2,2) );

   delta2 = ((the2')*delta3).*(sigmoidGradient(zz2));
   
%    the1 = Theta1( : , 2:size(Theta1,2) );
    Del2 = Del2 + delta3*aa2';
    Del1 = Del1 + delta2*aa1';

end

   

    %%But Del1 and 2 should be a matrix
    
    Theta1_grad = (Del1)/m + (lambda/m)*(Theta1);
    Theta2_grad = (Del2)/m + (lambda/m)*(Theta2);
    Theta1_grad(:,1) = Theta1_grad(:,1) - (lambda/m)*(Theta1(:,1));
    Theta2_grad(:,1) = Theta2_grad(:,1) - (lambda/m)*(Theta2(:,1));
% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
