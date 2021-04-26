

%This fuction finds the date and time for the given epoch from Two Line
%element(TLE)data


% Author: Sudeera Wijetunga
% inputs        description
% epoch         from TLE file

% output
% datevec=[year,month,date,hh,mm,ss]
    % year          year of the TLE data
    % month         month
    % date          date
    % hh            hour
    % mm            minute
    % ss            seconds


%intermidiate
% temp         temporary variable to keep data
% nd           last day of each month
% ymd          year and month data from TLE
% yr           year from TLE
% dofyr        day of the year 
% decidy       decimal day
%--------------------------------------------------------------------------
function date_time=epoch2datevec(tle_epoch)


ymd=floor(tle_epoch);
yr=fix(ymd/1000);
dofyr=mod(ymd,1000);

    if (yr < 57)
         year=  yr+ 2000;
    else
         year=  yr+ 1900;
    end;
   

decidy=round((tle_epoch-ymd)*10^8)/10^8;

temp=decidy*24;
hh=fix(temp);
temp=(temp-hh)*60;
mm=fix(temp);
temp=(temp-mm)*60;
ss=(temp);


nd = eomday(year,1:12);
temp = cumsum(nd);
month=find(temp>=dofyr, 1 );
temp=temp(month)-dofyr;
date=nd(month)-temp;

datevec=[year,month,date,hh,mm,ss];
date_time = datetime(year,month,date,hh,mm,ss);
end