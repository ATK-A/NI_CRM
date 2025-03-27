% generate_UK_LSM.m
%
% Uses the elevation data from generate_elevation.m to produce a land-sea
% mask for the UK region (for UKCP18 CPM, RCM and GCM simulations and for
% ERA5 and HadUK-Grid data).
%


if exist('LSM1.mat','file')
    load('LSM1.mat')
    load('LSM2.mat')
    load('LSM12.mat')
    load('LSM60.mat')
    
else

%% Outside of Ireland, use datamask at appropriate resolution
generate_UK_datamask

% Assign areas where there is data as land
% LSM1 = datamask1;
LSM2 = datamask2;
LSM12 = datamask12;
LSM60 = datamask60;
% LSMERA5 = datamaskERA5;
% LSMERA5a = LSMERA5(49:88,42:83,:);

%% In R.O.I., use elevation for LSM
generate_elevation

% Create first LSM based on anywhere higher than sea level
Land_CPM = ht_CPM > 0;
Land_RCM = ht_RCM > 0;
Land_GCM = ht_GCM > 0;
% Land_ERA5 = ht_ERA5 > 0;
% Land_HadUK1 = ht_HadUK1 > 0;
% Land_HadUK12a = ht_HadUK12 > 0;
% Land_HadUK12 = HadUK2UKCP18(Land_HadUK12a); % Correct the grid
% Land_HadUK60 = ht_HadUK60 > 0;

% Match GCM/RCM with HadUK12/HadUK60 RCM 
% There are fractional differences between the lat-long (and so also
% elevation for each):
Land_RCM = Land_RCM .* Land_HadUK12;
Land_GCM = Land_GCM .* Land_HadUK60;

% Add Ireland based on elevation
LSM60(1:6,6:12) = Land_GCM(1:6,6:12);

% LSMERA5(1:57,46:61) = Land_ERA5(1:57,46:61);
% LSMERA5(1:51,46:62) = Land_ERA5(1:51,46:62);

LSM12(1:30,26:58) = Land_RCM(1:30,26:58);
LSM12(1:24,26:60) = Land_RCM(1:24,26:60);

LSM2(1:187,162:345) = Land_CPM(1:187,162:345);
LSM2(1:160,162:371) = Land_CPM(1:160,162:371);

LSM1(1:346,370:780) = Land_HadUK1(1:346,370:780);
LSM1(1:287,370:824) = Land_HadUK1(1:287,370:824);

% Tidy up
clear Land_CPM Land_RCM Land_GCM Land_ERA5 Land_HadUK1 Land_HadUK12 Land_HadUK12a Land_HadUK60


%% Change zeros to NaNs to make averaging easier
LSM1 = double(LSM1);
LSM1(LSM1 == 0) = nan;
LSM2 = double(LSM2);
LSM2(LSM2 == 0) = nan;
LSM12 = double(LSM12);
LSM12(LSM12 == 0) = nan;
LSM60 = double(LSM60);
LSM60(LSM60 == 0) = nan;
LSMERA5 = double(LSMERA5);
LSMERA5(LSMERA5 == 0) = nan;

%% Remove Shetland land points on edge of domain in LSM2 
LSM2a = LSM2;
LSM2a(:,606) = nan;

end
