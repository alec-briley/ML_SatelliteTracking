function OutputOE = read_tle(fname);
% Two-line element set
% 19-32	04236.56031392	Element Set Epoch (UTC)
% 3-7	25544	Satellite Catalog Number
% 9-16	51.6335	Orbit Inclination (degrees)
% 18-25	344.7760	Right Ascension of Ascending Node (degrees)
% 27-33	0007976	Eccentricity (decimal point assumed)
% 35-42	126.2523	Argument of Perigee (degrees)
% 44-51	325.9359	Mean Anomaly (degrees)
% 53-63	15.70406856	Mean Motion (revolutions/day)
% 64-68	32890	Revolution Number at Epoch 

  % fname = 'ajisai.txt';
  % fid1 = fopen(fname, 'w');
  % fprintf(fid1, 'epoch [day]           a [km]            e           inc [deg]        RAAN [deg]            w[deg]          M [deg]        Rev  \n ')

  mu = 398600.4418; %  Standard gravitational parameter for the earth
  MINUTES_PER_DAY = 1440;
  
  % Open the TLE file and read TLE elements
  fid = fopen(fname, 'rb');
  inum = 1;
  
  while 1
      % read first line
      tline = fgetl(fid);
      if ~ischar(tline), break, end
      epochY = str2num(tline(19:20));              % Epoch year
      epochD = str2num(tline(21:32));              % Epoch day
      dat.epoch = epochY * 365.25 + epochD;        % Epoch (day)
      BStar = str2num(tline(54:59));               % Bstar/drag Term
      ExBStar = str2num(tline(60:61));             % Exponent of Bstar/drag Term
      dat.bstar = BStar*1e-5*10^ExBStar;

      % read second line
      tline = fgetl(fid);
      if ~ischar(tline), break, end
      dat.xincl = str2num(tline(9:16))*pi/180;            % Orbit Inclination (degrees)
      dat.xnodeo = str2num(tline(18:25))*pi/180;   % Right Ascension of Ascending Node (degrees)
      dat.eo = str2num(strcat('0.',tline(27:33))); % Eccentricity
      dat.omegao = str2num(tline(35:42))*pi/180;   % Argument of Perigee (degrees)
      dat.xmo = str2num(tline(44:51))*pi/180;      % Mean Anomaly (degrees)
      no = str2num(tline(53:63));                  % Mean Motion
      dat.xno = no*2*pi/MINUTES_PER_DAY;
      %dat.sma = ( mu/(str2num(tline(53:63))*2*pi/86400)^2 )^(1/3);    % semi major axis
      %dat.rNo = str2num(tline(64:68));                                % Revolution Number at Epoch 

      % Orbit elements data 8 dimension
      %OE = [dat.epoch dat.sma dat.ecc dat.inc dat.raan dat.w dat.M dat.rNo];
      
      %fprintf(fid1, '%12.12f      %12.12f     %12.12f   %12.12f       %12.12f     %12.12f    %12.12f      %12.12f\n', OE);   
      
      OutputOE(inum,:) = dat;
      inum = inum + 1;
  end
  fclose(fid);
  %fclose(fid1);

end
