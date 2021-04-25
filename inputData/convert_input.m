% Purpose: Align TLE data with Truth Data
% Truth data samples at 240 sec increments, from 0 -> 86,160 
% and contains 360 pts/day

% This script: 
% 1.) Converts TLE Epoch data from Epoch Day of Year to Hr/Min/Sec format to second format
% 2.) Extracts index's of the TLE data that match closely to the Truth data(TO DO)
% 3.) Outputs updated input values to new .txt file (TO DO)
%--------------------------------------------------------------------------------------------------------
%InputData_1 = 'ajisai 20200320-20200920.txt';
%input_file_1 = load('ajisai 20200320-20200920.txt');
%input_file_2 = load('ajisai 20200920-20201020.txt');
% Note: 'load' does not work. get an error or 'Number of columns on line 2 of ASCII file TestData.txt must be the same as previous lines.'
% Going with textscan method to put into cell array. 
%--------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------
format long
fid = fopen('ajisai 20200320-20200920.txt');
C = textscan(fid, '%d8%s%s%f32%f32%f32%f32%d8%d8');
fclose(fid);
%--------------------------------------------------------------------------
E = C{1,4}; % Pull Epoch/RA values from Cell; store as single data type
ind = ~isnan(E);% Remove 'NaNs' from array; data is consistent w/ original .txt file with NaN's removed
E = E(ind);
%--------------------------------------------------------------------------
% Run loop to extract every odd row of TLE data for Epoch
E_Epoch = zeros(size(E));
RA = E_Epoch;
for i = 1:2:size(E,1)
        E_Epoch(i,1) = E(i,1); % Removing every other row to look only at Epoch values
end

% Run loop to extract every even row of TLE data for RA
for i = 2:2:size(E,1)
      RA(i,1) = E(i,1); % Extract even rows for RA to add back into vector when ready to save new .txt
end
%--------------------------------------------------------------------------
% Convert Epoch Day of Year to Hr/Min/Sec format
% i.e. deceimal value gives the hour, minute, and second
E_Epoch = E_Epoch - fix(E_Epoch); % Grab Decimal value of the Epoch for: hours, minutes, seconds
E_Epoch_Hrs = E_Epoch*24; % 3 sample pts per day i.e. every 3 samples 24 hr clock resets. We have 952/2 samples so with curent file we have a total of 317 samples at most. This is probably importance of 2nd file so that we get 6 months of data for more samples
E_Epoch_Min = (E_Epoch_Hrs-fix(E_Epoch_Hrs))*60;
E_Epoch_Sec = (E_Epoch_Min-fix(E_Epoch_Min))*60;
% Combine H/M/S into a single unit of 'Seconds'
E_Epoch_Sec_Converted = E_Epoch_Hrs*3600 + E_Epoch_Min*60 + E_Epoch_Sec; 
%--------------------------------------------------------------------------
% NOTE: EXTRACTING INDICIES (lines 51:57) NEEDS MORE WORK
%--------------------------------------------------------------------------
% Extract sample indicies that are close to 240 sample
% Ideally, want 360 pts to match TLE data
% for i = 1:size(E_Epoch_Sec_Converted ,1)
%     Input_Truth_Index_Match_Lower = find(E_Epoch_Final>239);
%     Input_Truth_Index_Match_Upper = find(E<241);
%     Input_Truth_Index_Match = find( Input_Truth_Index_Match_Upper == Input_Truth_Index_Match_Lower); % Find index's that overlap in the given range
% end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Put Epoch data back into original .txt file with Epoch values converted
% from Epoch day of Year to Seconds

% NOTE: NEED TO UPDATE LOGIC TO PULL CLOSE TO EVERY 240 SEC TO MATCH TRUTH
% (Lines 51-55 above)
E_Epoch_Final = E_Epoch_Sec_Converted + RA;
C{1,4} = E_Epoch_Final;
converted_input_file_1 = writecell(C,'ajisai 20200320-20200920_converted.txt') % NOTE: Needs more work to write to .txt

%save('ajisai 20200320-20200920_converted.txt','converted_input_file_1');
 