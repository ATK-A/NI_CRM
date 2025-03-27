% load_paris_years.m
% 
% This script loads climate data for the years that correspond to Paris
% Agreement emissions targets.
% 
% The 30 year climate baseline is taken as 1990-2019, taken to be 0.767°C
% warmer than pre-industrial, based upon HadCRUT4 data and the offset being
% 0.61°C for 1981-2010 (Arnell et al. 2019).
% 
% 1.5°C and 2.0°C warming scenarios are taken using a time slice approach
% based upon the bias corrected global HadGEM3-GC3.05 simulations. 
% 
% The midpoint of each 30 year climatology that exceeds each threshold is
% calculated by calc_global_temp_threshs_BC.m.


%% Set defaults if necessary
% summer = 'MO';

if exist('tas_GCM_glob_thresh_arr_arnell.mat','file')
    load('tas_GCM_glob_thresh_arr_arnell.mat')
else
    calc_global_temp_threshs_BC
end

if ~exist('counties12','var')
    generate_NI_counties_area
    generate_region_latlon_area
end


% Create empty array to fill
SP_data = nan(4,5,12,10957); % areas x scenarios x models x days

% Model simulations which are to be loaded
modelslist = {'run01','run04','run05','run06','run07','run08','run09','run10','run11','run12','run13','run15'};


%% Load each simulation in turn
for i = 1:length(modelslist)
    
    % Find years of threshold exceedance for each model
    startyr_past = 1990;
    endyr_past = 2019;
    
    startyr_15 = tas_GCM_glob_thresh_arr_arnell(1,i);
    endyr_15 = tas_GCM_glob_thresh_arr_arnell(1,i) + 29;
    
    startyr_20 = tas_GCM_glob_thresh_arr_arnell(2,i);
    endyr_20 = tas_GCM_glob_thresh_arr_arnell(2,i) + 29;
    
    startyr_30 = tas_GCM_glob_thresh_arr_arnell(4,i);
    endyr_30 = tas_GCM_glob_thresh_arr_arnell(4,i) + 29;

    startyr_40 = tas_GCM_glob_thresh_arr_arnell(6,i);
    if startyr_40>2050
        startyr_40 = 2050;
    end
    endyr_40 = startyr_40 + 29;

    % Convert cells into useable string
    model_cell = modelslist(i);
    model_name = sprintf('%s',model_cell{:});
    
    model = ['rcm85',model_name(4:5)];
    
    
    %% Load variables
    disp(['Loading ',model_name])
    % Dates
    load('/Volumes/DataDrive/BiasCorrection/RCM_dates_365.mat');
    modeldates = RCM_dates_365;
    
    % Climate variables
    load(['/Volumes/DataDrive/BiasCorrection/',model_name,'/RCM_tas_BC.mat']);
    load(['/Volumes/DataDrive/BiasCorrection/',model_name,'/RCM_tasmax_BC.mat']);
    load(['/Volumes/DataDrive/BiasCorrection/',model_name,'/RCM_tasmin_BC.mat']);
    load(['/Volumes/DataDrive/BiasCorrection/',model_name,'/RCM_hurs_BC.mat']);

    % Extract required years from RCM and GCM runs
    [T_past] = extract_years(RCM_tas_BC,modeldates,startyr_past,endyr_past,'Jan');
    [VP_past] = extract_years(RCM_hurs_BC,modeldates,startyr_past,endyr_past,'Jan');
    [Tmax_past] = extract_years(RCM_tasmax_BC,modeldates,startyr_past,endyr_past,'Jan');
    [Tmin_past,keptdates_past] = extract_years(RCM_tasmin_BC,modeldates,startyr_past,endyr_past,'Jan');
%     VP_past = extract_summers(VP_past,keptdates_past,summer);
%     T_past = extract_summers(T_past,keptdates_past,summer);
%     Tmax_past = extract_summers(Tmax_past,keptdates_past,summer);
%     Tmin_past = extract_summers(Tmin_past,keptdates_past,summer);
    
    [T_15] = extract_years(RCM_tas_BC,modeldates,startyr_15,endyr_15,'Jan');
    [VP_15] = extract_years(RCM_hurs_BC,modeldates,startyr_15,endyr_15,'Jan');
    [Tmax_15] = extract_years(RCM_tasmax_BC,modeldates,startyr_15,endyr_15,'Jan');
    [Tmin_15,keptdates_15] = extract_years(RCM_tasmin_BC,modeldates,startyr_15,endyr_15,'Jan');
%     VP_15 = extract_summers(VP_15,keptdates_15,summer);
%     T_15 = extract_summers(T_15,keptdates_15,summer);
%     Tmax_15 = extract_summers(Tmax_15,keptdates_15,summer);
%     Tmin_15 = extract_summers(Tmin_15,keptdates_15,summer);
    
    [T_20] = extract_years(RCM_tas_BC,modeldates,startyr_20,endyr_20,'Jan');
    [VP_20] = extract_years(RCM_hurs_BC,modeldates,startyr_20,endyr_20,'Jan');
    [Tmax_20] = extract_years(RCM_tasmax_BC,modeldates,startyr_20,endyr_20,'Jan');
    [Tmin_20,keptdates_20] = extract_years(RCM_tasmin_BC,modeldates,startyr_20,endyr_20,'Jan');
%     VP_20 = extract_summers(VP_20,keptdates_20,summer);
%     T_20 = extract_summers(T_20,keptdates_20,summer);
%     Tmax_20 = extract_summers(Tmax_20,keptdates_20,summer);
%     Tmin_20 = extract_summers(Tmin_20,keptdates_20,summer);
    
    [T_30] = extract_years(RCM_tas_BC,modeldates,startyr_30,endyr_30,'Jan');
    [VP_30] = extract_years(RCM_hurs_BC,modeldates,startyr_30,endyr_30,'Jan'),T_30;
    [Tmax_30] = extract_years(RCM_tasmax_BC,modeldates,startyr_30,endyr_30,'Jan');
    [Tmin_30,keptdates_30] = extract_years(RCM_tasmin_BC,modeldates,startyr_30,endyr_30,'Jan');

    [T_40] = extract_years(RCM_tas_BC,modeldates,startyr_40,endyr_40,'Jan');
    [VP_40] = extract_years(RCM_hurs_BC,modeldates,startyr_40,endyr_40,'Jan');
    [Tmax_40] = extract_years(RCM_tasmax_BC,modeldates,startyr_40,endyr_40,'Jan');
    [Tmin_40,keptdates_40] = extract_years(RCM_tasmin_BC,modeldates,startyr_40,endyr_40,'Jan');
%     VP_30 = extract_summers(VP_30,keptdates_30,summer);
%     T_30 = extract_summers(T_30,keptdates_30,summer);
%     Tmax_30 = extract_summers(Tmax_30,keptdates_30,summer);
%     Tmin_30 = extract_summers(Tmin_30,keptdates_30,summer);
    
    clear RCM_tas_BC RCM_hurs_BC
    
    % Extract values for Sheffield Park
    % ID = (64,20) from
    % [lon_id,lat_id] = find_location(0.020013,50.998938, long_UK_RCM,lat_UK_RCM)

    

    SP_data(1,1,i,:) = squeeze(T_past(64,20,1:10957));
    SP_data(1,2,i,:) = squeeze(T_15(64,20,1:10957));
    SP_data(1,3,i,:) = squeeze(T_20(64,20,1:10957));
    SP_data(1,4,i,:) = squeeze(T_30(64,20,1:10957));
    SP_data(1,5,i,:) = squeeze(T_40(64,20,1:10957));

    SP_data(2,1,i,:) = squeeze(Tmax_past(64,20,1:10957));
    SP_data(2,2,i,:) = squeeze(Tmax_15(64,20,1:10957));
    SP_data(2,3,i,:) = squeeze(Tmax_20(64,20,1:10957));
    SP_data(2,4,i,:) = squeeze(Tmax_30(64,20,1:10957));
    SP_data(2,5,i,:) = squeeze(Tmax_40(64,20,1:10957));

    SP_data(3,1,i,:) = squeeze(Tmin_past(64,20,1:10957));
    SP_data(3,2,i,:) = squeeze(Tmin_15(64,20,1:10957));
    SP_data(3,3,i,:) = squeeze(Tmin_20(64,20,1:10957));
    SP_data(3,4,i,:) = squeeze(Tmin_30(64,20,1:10957));
    SP_data(3,5,i,:) = squeeze(Tmin_40(64,20,1:10957));

    SP_data(4,1,i,:) = squeeze(VP_past(64,20,1:10957));
    SP_data(4,2,i,:) = squeeze(VP_15(64,20,1:10957));
    SP_data(4,3,i,:) = squeeze(VP_20(64,20,1:10957));
    SP_data(4,4,i,:) = squeeze(VP_30(64,20,1:10957));
    SP_data(4,5,i,:) = squeeze(VP_40(64,20,1:10957));

    
end

%% Calculate some mean values
% Calculate daily range
SP_data2 = cat(1,SP_data,SP_data(2,:,:,:)-SP_data(3,:,:,:));

% Calculate annual mean
annmeans = mean(SP_data2,4);

% IDs for summer and winter
startt = datetime(1990,1,1);
endt = datetime(2019,12,31);
allt = startt:endt;

ids = month(allt) == 1 | month(allt) == 11 | month(allt) == 12 ;
ids2 = month(allt) == 7 | month(allt) == 7 | month(allt) == 8 ;

summeans = mean(SP_data2(:,:,:,ids2),4);
winmeans = mean(SP_data2(:,:,:,ids),4);

outputsummer = nan(9,4);
outputwinter = nan(9,4);

outputsummer(1,:) = mean(summeans(1,2:5,:) - summeans(1,1,:),3);
outputsummer(2,:) = max(summeans(1,2:5,:) - summeans(1,1,:),[],3);
outputsummer(3,:) = min(summeans(1,2:5,:) - summeans(1,1,:),[],3);

outputsummer(4,:) = mean(summeans(5,2:5,:) - summeans(5,1,:),3);
outputsummer(5,:) = max(summeans(5,2:5,:) - summeans(5,1,:),[],3);
outputsummer(6,:) = min(summeans(5,2:5,:) - summeans(5,1,:),[],3);

outputsummer(7,:) = mean(summeans(4,2:5,:) - summeans(4,1,:),3);
outputsummer(8,:) = max(summeans(4,2:5,:) - summeans(4,1,:),[],3);
outputsummer(9,:) = min(summeans(4,2:5,:) - summeans(4,1,:),[],3);

outputwinter(1,:) = mean(winmeans(1,2:5,:) - winmeans(1,1,:),3);
outputwinter(2,:) = max(winmeans(1,2:5,:) - winmeans(1,1,:),[],3);
outputwinter(3,:) = min(winmeans(1,2:5,:) - winmeans(1,1,:),[],3);

outputwinter(4,:) = mean(winmeans(5,2:5,:) - winmeans(5,1,:),3);
outputwinter(5,:) = max(winmeans(5,2:5,:) - winmeans(5,1,:),[],3);
outputwinter(6,:) = min(winmeans(5,2:5,:) - winmeans(5,1,:),[],3);

outputwinter(7,:) = mean(winmeans(4,2:5,:) - winmeans(4,1,:),3);
outputwinter(8,:) = max(winmeans(4,2:5,:) - winmeans(4,1,:),[],3);
outputwinter(9,:) = min(winmeans(4,2:5,:) - winmeans(4,1,:),[],3);

