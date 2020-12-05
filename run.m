epsilon = 1e-8;

%Simulated Samples
X = [mvnrnd([1,1],eye(2)*0.5,50); mvnrnd([-1,-1],eye(2)*0.5,50)];
Y = [ones(50,1);-1*ones(50,1)];
[A,b,c] = construct_svm_lp(X,Y);
% Get Initial point for Short Path Following
[x0, y0, s0] = construct_starting_point_svm(X);

%Solve using 2 IPM algos and base Matlab Solver
[x_sp,y_sp,s_sp] = short_path(x0,y0,s0, A, epsilon);
[x_pc,y_pc,s_pc] = predictor_correct(A,b,c, epsilon);
x_lp = linprog(c,[],[],A,b,zeros(size(x0,1),1),[]);

%Handwritten Digits
data = csvread('optdigits_tra.csv');

%Construct Instance
X = [data(:,1:64), ones(size(data,1),1)];
Y = (data(:,65) == 5)*2 - 1;
[A,b,c] = construct_svm_lp(X,Y);
[x0, y0, s0] = construct_starting_point_svm(X);

%Solve using 2 IPM and LP Solver
[x_sp,y_sp,s_sp] = short_path(x0,y0,s0, A, epsilon);
[x_pc,y_pc,s_pc] = predictor_correct(A,b,c, epsilon);
x_lp = linprog(c,[],[],A,b,zeros(size(x0,1),1),[]);
