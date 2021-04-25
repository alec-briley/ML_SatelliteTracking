truth_file = load('ajisai truth 20200320-20200920.txt');

time_MJD = truth_file(:,3)+truth_file(:,4)/86400;
time_epoch = time_MJD-38848;

X = truth_file(:,6);
Y = truth_file(:,7);
Z = truth_file(:,8);

converted_file = [time_epoch X Y Z];
save('ajisai truth converted 20200320-20200920.mat','converted_file');