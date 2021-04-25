% Two-line element set
clc;
clear all;
mu = 398600.4418; %  Standard gravitational parameter for the earth
% TLE file name 
fname = 'ajisai 20210415-20210420.txt';
% Open the TLE file and read TLE elements
fid = fopen(fname, 'rb');
% 19-32	04236.56031392	Element Set Epoch (UTC)
% 3-7	25544	Satellite Catalog Number
% 9-16	51.6335	Orbit Inclination (degrees)
% 18-25	344.7760	Right Ascension of Ascending Node (degrees)
% 27-33	0007976	Eccentricity (decimal point assumed)
% 35-42	126.2523	Argument of Perigee (degrees)
% 44-51	325.9359	Mean Anomaly (degrees)
% 53-63	15.70406856	Mean Motion (revolutions/day)
% 64-68	32890	Revolution Number at Epoch 
inum = 1;
fname = 'ajisai_OE.txt';
fid1 = fopen(fname, 'w');
fprintf(fid1, 'epoch [day]           a [km]            e           inc [deg]        RAAN [deg]            w[deg]          M [deg]        Rev  \n ')
while 1
    % read first line
    tline = fgetl(fid);
    if ~ischar(tline), break, end
%     epochY = str2num(tline(19:20));                             % Epoch year
%     epochD = str2num(tline(21:32));                             % Epoch day
%     epoch = epochY * 365.25 + epochD;                           % Epoch (day)
    epoch = str2num(tline(19:32));
    
    % read second line
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    inc = str2num(tline(9:16));                                 % Orbit Inclination (degrees)
    raan = str2num(tline(18:25));                               % Right Ascension of Ascending Node (degrees)
    ecc = str2num(strcat('0.',tline(27:33)));                   % Eccentricity
    w = str2num(tline(35:42));                                  % Argument of Perigee (degrees)
    M = str2num(tline(44:51));                                  % Mean Anomaly (degrees)
    sma = ( mu/(str2num(tline(53:63))*2*pi/86400)^2 )^(1/3);    % semi major axis
    rNo = str2num(tline(64:68));                                % Revolution Number at Epoch 
    
    % Orbit elements data 8 dimension
    OE = [epoch sma ecc inc raan w M rNo];
    fprintf(fid1, '%12.12f      %12.12f     %12.12f   %12.12f       %12.12f     %12.12f    %12.12f      %12.12f\n', OE);   
    OutputOE(inum,:) = OE;
    inum = inum + 1;
end
fclose(fid);
fclose(fid1);
save('ajisai_OE.mat','OutputOE');