% generate_region_latlon_area.m
% 
% Creates the absolute and fractional areas for doing spatial averages
% etc., except for individual regions of England/UK. This is done for the
% RCM, GCM and ERA5 resolutions.
% 

%% Load data to start with
load_UK_regions % region masks
generate_UK_latlon_area % absolute areas for each resolution

% Regions for reference:
regs = {'Scotland','North East','North West','Yorkshire and the Humber','East Midlands','West Midlands','East of England','Greater London','South East','South West','Wales','Northern Ireland','Isle of Mann'};

% Create blank array to fill
% areas_ERA5_abs_regions = zeros(length(areas_ERA5_abs(:,1)),length(areas_ERA5_abs(1,:)),12);
% areas_ERA5_frac_regions = zeros(length(areas_ERA5_abs(:,1)),length(areas_ERA5_abs(1,:)),12);
areas_RCM_abs_regions = zeros(length(areas_RCM_abs(:,1)),length(areas_RCM_abs(1,:)),12);
areas_RCM_frac_regions = zeros(length(areas_RCM_abs(:,1)),length(areas_RCM_abs(1,:)),12);
areas_GCM_abs_regions = zeros(length(areas_GCM_abs(:,1)),length(areas_GCM_abs(1,:)),12);
areas_GCM_frac_regions = zeros(length(areas_GCM_abs(:,1)),length(areas_GCM_abs(1,:)),12);


for reg=1:12
%     areas_ERA5_abs_regions(:,:,reg) = areas_ERA5_abs.*(UKregionsERA5 == reg);
%     areas_ERA5_frac_regions(:,:,reg) = areas_ERA5_abs_regions(:,:,reg)./nansum(nansum(areas_ERA5_abs_regions(:,:,reg)));
    areas_RCM_abs_regions(:,:,reg) = areas_RCM_abs.*(UKregions12 == reg);
    areas_RCM_frac_regions(:,:,reg) = areas_RCM_abs_regions(:,:,reg)./nansum(nansum(areas_RCM_abs_regions(:,:,reg)));
    areas_GCM_abs_regions(:,:,reg) = areas_GCM_abs.*(UKregions60 == reg);
    areas_GCM_frac_regions(:,:,reg) = areas_GCM_abs_regions(:,:,reg)./nansum(nansum(areas_GCM_abs_regions(:,:,reg)));
end
