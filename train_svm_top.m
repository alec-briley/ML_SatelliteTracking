clear all
close all

addpath('SGP4');

%% READ TRUTH

truth_mat  = read_truth('ajisai truth 20210320-20210420.txt');
Ntr        = length(truth_mat);
for ii = 1:Ntr
  truth_data(ii).jul_day = truth_mat(ii,3);
  truth_data(ii).sec     = truth_mat(ii,4);
  truth_data(ii).pos     = truth_mat(ii,end-2:end)/1e3; % convert to km
end

%% READ TLE SET

fname     = 'ajisai 20200320-20210320.txt';
tle_data  = read_tle(fname);
N         = length(tle_data);
t_forward = 1440; % minutes

%% COMPUTE POSITION AND VELOCITY
for ii = 1:N
  [pos_km(ii,:),vel_km_s(ii,:)] = sgp4(t_forward,tle_data(ii));
end




