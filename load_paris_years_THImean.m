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

if exist('tas_GCM_glob_thresh_arr.mat','file')
    load('tas_GCM_glob_thresh_arr.mat')
else
    calc_global_temp_threshs_BC
end

if ~exist('counties12','var')
    generate_NI_counties_area
    generate_region_latlon_area
end


% Create empty array to fill
THI_reg = nan(12,4,12,10957); % areas x scenarios x models x days

% Model simulations which are to be loaded
modelslist = {'run01','run04','run05','run06','run07','run08','run09','run10','run11','run12','run13','run15'};


%% Load each simulation in turn
for i = 1:length(modelslist)
    
    % Find years of threshold exceedance for each model
    startyr_past = 1990;
    endyr_past = 2019;
    
    startyr_15 = tas_GCM_glob_thresh_arr(1,i);
    endyr_15 = tas_GCM_glob_thresh_arr(1,i) + 29;
    
    startyr_20 = tas_GCM_glob_thresh_arr(2,i);
    endyr_20 = tas_GCM_glob_thresh_arr(2,i) + 29;
    
    startyr_30 = tas_GCM_glob_thresh_arr(4,i);
    endyr_30 = tas_GCM_glob_thresh_arr(4,i) + 29;
    
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
%     load(['/Volumes/DataDrive/BiasCorrection/',model_name,'/RCM_tasmax_BC.mat']);
%     load(['/Volumes/DataDrive/BiasCorrection/',model_name,'/RCM_tasmin_BC.mat']);
    load(['/Volumes/DataDrive/BiasCorrection/',model_name,'/RCM_hurs_BC.mat']);

    % Extract required years from RCM and GCM runs
    [VP_past] = extract_years(RCM_hurs_BC,modeldates,startyr_past,endyr_past,'Jan');
    [T_past] = extract_years(RCM_tas_BC,modeldates,startyr_past,endyr_past,'Jan');
%     [Tmax_past] = extract_years(RCM_tasmax_BC,modeldates,startyr_past,endyr_past,'Jan');
%     [Tmin_past,keptdates_past] = extract_years(RCM_tasmin_BC,modeldates,startyr_past,endyr_past,'Jan');
%     VP_past = extract_summers(VP_past,keptdates_past,summer);
%     T_past = extract_summers(T_past,keptdates_past,summer);
%     Tmax_past = extract_summers(Tmax_past,keptdates_past,summer);
%     Tmin_past = extract_summers(Tmin_past,keptdates_past,summer);
    
    [VP_15] = extract_years(RCM_hurs_BC,modeldates,startyr_15,endyr_15,'Jan');
    [T_15] = extract_years(RCM_tas_BC,modeldates,startyr_15,endyr_15,'Jan');
%     [Tmax_15] = extract_years(RCM_tasmax_BC,modeldates,startyr_15,endyr_15,'Jan');
%     [Tmin_15,keptdates_15] = extract_years(RCM_tasmin_BC,modeldates,startyr_15,endyr_15,'Jan');
%     VP_15 = extract_summers(VP_15,keptdates_15,summer);
%     T_15 = extract_summers(T_15,keptdates_15,summer);
%     Tmax_15 = extract_summers(Tmax_15,keptdates_15,summer);
%     Tmin_15 = extract_summers(Tmin_15,keptdates_15,summer);
    
    [VP_20] = extract_years(RCM_hurs_BC,modeldates,startyr_20,endyr_20,'Jan');
    [T_20] = extract_years(RCM_tas_BC,modeldates,startyr_20,endyr_20,'Jan');
%     [Tmax_20] = extract_years(RCM_tasmax_BC,modeldates,startyr_20,endyr_20,'Jan');
%     [Tmin_20,keptdates_20] = extract_years(RCM_tasmin_BC,modeldates,startyr_20,endyr_20,'Jan');
%     VP_20 = extract_summers(VP_20,keptdates_20,summer);
%     T_20 = extract_summers(T_20,keptdates_20,summer);
%     Tmax_20 = extract_summers(Tmax_20,keptdates_20,summer);
%     Tmin_20 = extract_summers(Tmin_20,keptdates_20,summer);
    
    [VP_30] = extract_years(RCM_hurs_BC,modeldates,startyr_30,endyr_30,'Jan');
    [T_30] = extract_years(RCM_tas_BC,modeldates,startyr_30,endyr_30,'Jan');
%     [Tmax_30] = extract_years(RCM_tasmax_BC,modeldates,startyr_30,endyr_30,'Jan');
%     [Tmin_30,keptdates_30] = extract_years(RCM_tasmin_BC,modeldates,startyr_30,endyr_30,'Jan');
%     VP_30 = extract_summers(VP_30,keptdates_30,summer);
%     T_30 = extract_summers(T_30,keptdates_30,summer);
%     Tmax_30 = extract_summers(Tmax_30,keptdates_30,summer);
%     Tmin_30 = extract_summers(Tmin_30,keptdates_30,summer);
    
    clear RCM_tas_BC RCM_hurs_BC
    
    %% Heat stress metrics
    % Calculate mean sWBGT
    THI_past = TempHumIndex(T_past,VP_past);
    THI_15 = TempHumIndex(T_15,VP_15);
    THI_20 = TempHumIndex(T_20,VP_20);
    THI_30 = TempHumIndex(T_30,VP_30);
    
    
    for k = 12%1:12
        if k < 12
            areas = areas_counties12;
        else
            areas = areas_RCM_frac_regions;
        end
        THI_reg(k,1,i,:) = squeeze(nansum(nansum(THI_past(:,:,1:10957) .* areas(:,:,k),2),1));
        THI_reg(k,2,i,:) = squeeze(nansum(nansum(THI_15(:,:,1:10957) .* areas(:,:,k),2),1));
        THI_reg(k,3,i,:) = squeeze(nansum(nansum(THI_20(:,:,1:10957) .* areas(:,:,k),2),1));
        THI_reg(k,4,i,:) = squeeze(nansum(nansum(THI_30(:,:,1:10957) .* areas(:,:,k),2),1));
    end
    
end

