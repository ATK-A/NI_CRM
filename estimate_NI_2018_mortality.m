% estimate_NI_2018_mortality
load('Mortality_MMT_2D.mat')
load('Mortality_RR_2D.mat')
load('population_SSP5_2D.mat')
load('dailyDeathRate_2D.mat')
Mortality_RR = Mortality_RR_2D;
population = population_SSP5_2D;

%% Load data
Tmax18 = ncread('/Volumes/DataDrive/HadUK-Grid/v1.1.0.0/tasmax/12km/tasmax_hadukgrid_uk_12km_day_20180601-20180630.nc','tasmax',[1 1 17],[Inf Inf 14]);
Tmax18 = cat(3,Tmax18,ncread('/Volumes/DataDrive/HadUK-Grid/v1.1.0.0/tasmax/12km/tasmax_hadukgrid_uk_12km_day_20180701-20180731.nc','tasmax',[1 1 1],[Inf Inf 14]));

Tmin18 = ncread('/Volumes/DataDrive/HadUK-Grid/v1.1.0.0/tasmin/12km/tasmin_hadukgrid_uk_12km_day_20180601-20180630.nc','tasmin',[1 1 17],[Inf Inf 14]);
Tmin18 = cat(3,Tmin18,ncread('/Volumes/DataDrive/HadUK-Grid/v1.1.0.0/tasmin/12km/tasmin_hadukgrid_uk_12km_day_20180701-20180731.nc','tasmin',[1 1 1],[Inf Inf 14]));

% Take daily mean
Tmean18 = (Tmax18 + Tmin18)/2;

% Subset just NI
T_NI_2018 = Tmean18.*(UKregions12==12)*1;


%% Calculate mortality
total_grid_mortality = nan(82,112); % lon x lat

% Go through each grid cell
for i = 1:82
    for j = 1:112
        T = squeeze(T_NI_2018(i,j,:));
        
        % Find when T exceeds MMT
        T_ex = T - Mortality_MMT_2D(i,j);
        % Otherwise make 0
        T_ex(T_ex<0) = 0;
        
        % Do the mortality calculation
        dailyMort = (((T_ex) .* Mortality_RR(i,j,1))/100).*dailyDeathRate_2D(i,j,1).*population(i,j,1);
        
        total_grid_mortality(i,j) = nansum(dailyMort);
    end
end

nansum(nansum((total_grid_mortality)))
