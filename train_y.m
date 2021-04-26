clear all
close all

load data_to_train

t          = templateSVM('KernelFunction','polynomial','BoxConstraint',1);
% tle_p(:,2) is all of the y tle data, truth_data(:,4) is all of the y truth 
Mdl        = fitcecoc(tle_p(1:1000,2),truth_data(1:1000,3),'Learners',t);