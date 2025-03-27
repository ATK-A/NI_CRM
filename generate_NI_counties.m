% generate_NI_counties.m
%
% Loads the 11 council areas for NI from a shape file then converts them
% into the appropriate grids for compaison to UKCP18 and ERA-5.


% if ~exist('counties_all_ERA5L','var')
    
    % Load data
    S = shaperead('Counties/CTYUA_DEC_2021_UK_BFC.shp');
    generate_UK_latlon
    long_ERA5 = -10:0.25:-3;
    lat_ERA5 = 53:0.25:57;
    [lons_ERA5,lats_ERA5] = meshgrid(long_ERA5,lat_ERA5);
    long_ERA5L = -9:0.1:-5;
    lat_ERA5L = 53.7:0.1:55.7;
    [lons_ERA5L,lats_ERA5L] = meshgrid(long_ERA5L,lat_ERA5L);
    
    
    % Create empty array to save each county
    counties12 = nan(82,112,11);
    countiesERA5 = nan(17,29,11);
    countiesERA5L = nan(21,41,11);
    
    % Convert eastings and northings to lat-lon
    for c = 153:163 % These are the UA/counties in NI
        [LAT,LON] = os2ll(S(c).X,S(c).Y);
        
        % Set raster resolution
        dimsize = 50;
        
        % Convert shapefile to raster
        [Z,R] = vec2mtx(LAT,LON,dimsize,'filled');
        
        % Make lat-lon grid
        rastersize = size(Z);
%         lat_Z = R(2)-(rastersize(1)-1)*(1/dimsize):1/dimsize:R(2);
%         lon_Z = R(3):1/dimsize:R(3)+(rastersize(2)-1)*(1/dimsize);
        lat_Z = R.LatitudeLimits(1)+0.01:0.02:R.LatitudeLimits(2)-0.01;
        lon_Z = R.LongitudeLimits(1)+0.01:0.02:R.LongitudeLimits(2)-0.01;

        % Turn lat and long into 2D grids
        [lons_Z,lats_Z] = meshgrid(lon_Z,lat_Z);
        
        % Take only interior of shapefiles
        Z_fill = Z == 0;
        Z_fill = Z_fill*1;
        
        % Regrid to UKCP18 resolution
        counties12(:,:,c-152) = griddata(lons_Z,lats_Z,Z_fill,long_UK_RCM,lat_UK_RCM);
%         countiesERA5(:,:,c-152) = griddata(lons_Z,lats_Z,Z_fill,lons_ERA5,lats_ERA5);
%         countiesERA5L(:,:,c-152) = griddata(lons_Z,lats_Z,Z_fill,lons_ERA5L,lats_ERA5L);
        
    end
    
    
    % Combine into single layer
    counties_all_12 = zeros(82,112);
%     counties_all_ERA5 = zeros(17,29);
%     counties_all_ERA5L = zeros(21,41);
    for i = 1:11
        counties_all_12(counties12(:,:,i)>0) = i;
%         counties_all_ERA5(countiesERA5(:,:,i)>0) = i;
%         counties_all_ERA5L(countiesERA5L(:,:,i)>0) = i;
    end
    
    % Tidy up
%     counties_all_ERA5L(12,28) = 8;
%     counties_all_ERA5(6,15) = 2;
%     counties_all_ERA5(7,16) = 7;
    counties_all_12(25,55) = 9;
    counties_all_12(31,54) = 3;
    
% end

%% Correct masks
% Clip only a subset of the data for HadUK-Grid
counties_all_12a = counties_all_12(18:33,48:60,:);
counties_12a = counties12(18:33,48:60,:);

% Manually correct HadUK-Grid county masks
% Correct DCSDC
counties_all_12_tidy = counties_all_12(18:33,48:60,:);
% counties_all_12_tidy([2],[7]) = 5;
% counties_all_12_tidy([3],[7]) = 5;
% counties_all_12_tidy([3],[8]) = 5;
% counties_all_12_tidy([3],[9]) = 5;
% counties_all_12_tidy([4],[9]) = 5;
% counties_all_12_tidy([5],[9]) = 5;
% counties_all_12_tidy([6],[11]) = 5;
% % Correct Fermanagh
% counties_all_12_tidy([2],[5]) = 6;
% counties_all_12_tidy([3],[4]) = 6;
% counties_all_12_tidy([4],[3]) = 6;
% counties_all_12_tidy([6],[3]) = 6;
% counties_all_12_tidy([7],[3]) = 6;
% % Correct Mid Ulster
% counties_all_12_tidy([7],[4]) = 9;
% counties_all_12_tidy([8],[4]) = 9;
% counties_all_12_tidy([8],[5]) = 9;
% % Correct ABC
% counties_all_12_tidy([9],[3]) = 2;
% % Correct NMD
% counties_all_12_tidy([9],[2]) = 10;
% counties_all_12_tidy([12],[2]) = 10;
% counties_all_12_tidy([11],[2]) = 0;
% % Correc Mid and East Antrim
% counties_all_12_tidy([15],[8]) = 7;
% % Correct Ards
% counties_all_12_tidy([15],[7]) = 0;
% % Remove Lough Neagh
% counties_all_12_tidy([11 11],[6 7]) = 0;

% Whole NI mask for HadUK-Grid
NI_mask_12 = counties_all_12_tidy>0;


% % Manually correct ERA5L counties mask
% counties_all_ERA5L_tidy = counties_all_ERA5L;
% counties_all_ERA5L_tidy(5,32) = 10;
% counties_all_ERA5L_tidy(15,31) = 4;
% counties_all_ERA5L_tidy(11,32) = 1;
% counties_all_ERA5L_tidy(11,33) = 8;
% 
% % Whole NI mask for HadUK-Grid
% NI_mask_ERA5L = counties_all_ERA5L_tidy>0;
% 
% data_dir = '/Volumes/DataDrive/ERA5L/';
%     
% mask_ERA5L = ncread([data_dir,'ERA5L_NI_multivar_1960.nc'],'t2m',[1 1 1],[Inf Inf 1]);
% mask_ERA5L = ~isnan(mask_ERA5L);        
% 
% NI_mask_ERA5La = rot90(NI_mask_ERA5L,3) .* mask_ERA5L;
% % %% For each grid cell, find out which council area represents most
% %     counties_12b = nan(16,13,12);
% %     for a = 1:16
% %         for b = 1:13
% %             main_council_ab = find(counties_12a(a,b,:) == nanmax(counties_12a(a,b,:),[],3),1);
% %             counties_12b(a,b,main_council_ab) = 1;
% %         end
% %     end
% %     
% %     %% Load data masks
% %         data_dir = '/Volumes/DataDrive/HadUK-Grid/v1.1.0.0/tasmax/12km/';
% %     file_had = [data_dir,'tasmax_hadukgrid_uk_12km_day_19600501-19600531.nc'];
% %     data_had = ncread(file_had,'tasmax',[18,48,1],[16,13,1]);
% %     
% %     Had_mask = ~isnan(data_had);
% %     
% %     counties_12b = counties_12b .* Had_mask;
% %     % Correct missing point
% %     counties_12b(9,2,10) = 1;
% %     
% %     counties_all_12b = nan(16,13);
% %     for i = 1:11
% %         mask = counties_12b(:,:,i) == 1;
% %         counties_all_12b(mask) = i;
% %     end
% 



