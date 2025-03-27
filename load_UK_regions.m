% load_England_regions.m
%
% Load a raster version of the English regions, produced from ONS shapefile
% downloaded from http://geoportal.statistics.gov.uk/datasets/4fcca2a47fed4bfaa1793015a18537ac_4.
%
% Save an output at RCM, GCM and WFDEI resolution.
%

%% Load files if they exist to save time
if exist('UKregionsERA5.mat','file')
    load('UKregionsERA5.mat')
    load('UKregions2.mat')
    load('UKregions12.mat')
    load('UKregions1.mat')
    load('UKregions60.mat')
else
    
    %% Read in the regions file
    % Generated using ONS data and QGIS (shapefile converted to .tif raster
    % with 300 x 300 pixels).
    [EnglandRegions,R] = geotiffread('../OtherData/Regions/EnglandRegions2.tif');
    
    %% Extremities of data are for england only
    % These locations from Wikipedia:
    % https://en.wikipedia.org/wiki/List_of_extreme_points_of_the_United_Kingdom#England
    
    % England most southerly point: 49°51?N 6°24?W = 49+51/60
    southerly = 49+51/60;
    [S_E,S_N] = ll2os(49+51/60, -(6+24/60));
    
    % England most northerly point: 55°48?N 2°02?W = 55+48/60
    northerly = 55+48/60;
    [N_E,N_N] = ll2os(55+48/60, -(2+2/60));
    
    % England most westerly point: 49°53?N 6°27?W = -(6+27/60)
    westerly = -(6+27/60);
    [W_E,W_N] = ll2os(49+53/60, -(6+27/60));
    
    % England most easterly point: 52°29?N 1°46?E = 1+46/60
    easterly = 1+46/60;
    [E_E,E_N] = ll2os(52+29/60, 1+46/60);
    
    
    %% Find out grid spacing, assuming it is lat-long
    % % Note: this could be wrong and it could be in OS-grid, but results look
    % % okay for now.
    % lon_space = (easterly-westerly)/299;
    % lat_space = (northerly-southerly)/299;
    lon_space = (E_E-W_E)/300;
    lat_space = (N_N-S_N)/300;
    
    % lon_regions = westerly:lon_space:westerly+299*lon_space;
    % lat_regions = southerly:lat_space:southerly+299*lat_space;
    lon_regions = W_E+0.5*lon_space:lon_space:W_E+0.5*lon_space+299*lon_space;
    lat_regions = S_N+0.5*lat_space:lat_space:S_N+0.5*lat_space+299*lat_space;
    
    [lons_regions_OS,lats_regions_OS]=meshgrid(lon_regions,lat_regions);
    % [lons_regions,lats_regions]=meshgrid(lon_regions,lat_regions);
    
    % Convert OS coordinate to lat-long
    [lats_regions,lons_regions] = os2ll(lons_regions_OS,lats_regions_OS);
    
    
    
    %% Find which machine is being used
    curdir = pwd;
    if strcmp(curdir(1:14),'/Users/ak0920/')
        ncdatadir1 = '/Users/ak0920/Data/IMPRES/';
        ncdatadir2 = '/huss/run01/';
    else
        if srtcmp(curdir(1:14),'/home/bridge/a')
            ncdatadir1 = '/export/anthropocene/array-01/ak0920/ukcp18_data/';
            ncdatadir2 = '/huss/day/run01/';
        end
    end
    
    
    %% Load lat-long and coast data for plotting
    generate_UK_latlon
    generate_UK_datamask
    
    
    %% Interpolate regions onto other grids
    EnglandRegions_ERA5 = griddata(lons_regions,lats_regions,flipud(EnglandRegions),long_UK_ERA5,lat_UK_ERA5,'nearest');
    EnglandRegions_HadUK = griddata(lons_regions,lats_regions,flipud(EnglandRegions),long_UK_HadUK1,lat_UK_HadUK1,'nearest');
    EnglandRegions_GCM = griddata(lons_regions,lats_regions,flipud(EnglandRegions),long_UK_GCM,lat_UK_GCM,'nearest');
    EnglandRegions_RCM = griddata(lons_regions,lats_regions,flipud(EnglandRegions),long_UK_RCM,lat_UK_RCM,'nearest');
    EnglandRegions_CPM = griddata(lons_regions,lats_regions,flipud(EnglandRegions),long_UK_CPM,lat_UK_CPM,'nearest');
    
    %% Tidy up
    % ERA5
    UKregionsERA5 = datamaskERA5 .* EnglandRegions_ERA5==0;
    UKregionsERA5 = UKregionsERA5*1;
    
    UKregionsERA5(49:59,58:61) = UKregionsERA5(49:59,58:61)*12; % Northern Ireland
    UKregionsERA5(61:70,47:54) = UKregionsERA5(61:70,47:54)*11; % Wales
    UKregionsERA5(63,58) = UKregionsERA5(63,58)*13; % Isle of Mann
    
    UKregionsERA5(63,45) = UKregionsERA5(63,45)*10; % SW coasts
    UKregionsERA5(88,51) = UKregionsERA5(88,51)*7; % E coasts
    UKregionsERA5(81,56) = UKregionsERA5(81,56)*4; % Y&H coasts
    
    EnglandRegions_ERA5(EnglandRegions_ERA5>0) = EnglandRegions_ERA5(EnglandRegions_ERA5>0) + 1;
    
    UKregionsERA5 = (EnglandRegions_ERA5+UKregionsERA5).*datamaskERA5;
    
    
    % RCM
    UKregions12 = datamask12 .* EnglandRegions_RCM==0;
    UKregions12 = UKregions12*1;
    
    UKregions12(19:33,48:59) = UKregions12(19:33,48:59)*12; % Northern Ireland
    UKregions12(34:47,24:42) = UKregions12(34:47,24:42)*11; % Wales
    UKregions12(38,49:51) = UKregions12(38,49:51)*13; % Isle of Mann
    
    UKregions12(47,41) = 3; % Odd point near Liverpool
    UKregions12(65,24) = UKregions12(65,24)*8; % Odd point near London
    UKregions12(37:43,15:20) = UKregions12(37:43,15:20)*10; % SW coasts
    UKregions12(40:41,22) = UKregions12(40:41,22)*10; % SW coasts
    UKregions12(68:72,37:38) = UKregions12(68:72,37:38)*7; % E coasts
    UKregions12(62:63,43:45) = UKregions12(62:63,43:45)*4; % Y&H coasts
    UKregions12(54:57,53:61) = UKregions12(54:57,53:61)*2; % NE coasts
    
    EnglandRegions_RCM(EnglandRegions_RCM>0) = EnglandRegions_RCM(EnglandRegions_RCM>0) + 1;
    
    UKregions12 = (EnglandRegions_RCM+UKregions12).*datamask12;
    
    % GCM
    UKregions60 = datamask60 .* EnglandRegions_GCM==0;
    UKregions60 = UKregions60*1;
    
    UKregions60(5:7,10:12) = UKregions60(5:7,10:12)*12; % Northern Ireland
    UKregions60(8:10,6:8) = UKregions60(8:10,6:8)*11; % Wales
    
    UKregions60(13:14,4) = UKregions60(13:14,4)*9; % SE coasts
    UKregions60(15,6) = UKregions60(15,6)*7; % E coasts
    UKregions60(10,10) = UKregions60(10,10)*3; % NW coasts
    UKregions60(9,5) = UKregions60(9,5)*10; % SW coasts
    
    EnglandRegions_GCM(EnglandRegions_GCM>0) = EnglandRegions_GCM(EnglandRegions_GCM>0) + 1;
    
    UKregions60 = (EnglandRegions_GCM+UKregions60).*datamask60;
    UKregions60(13,5) = 8; % Add London
    
    
    % CPM
    UKregions2 = datamask2 .* EnglandRegions_CPM==0;
    UKregions2 = UKregions2*1;
    
    % Note: too many coastal points to correct them all - only add major
    % missing regions (Scotland, Wales, NI)
    UKregions2(217:237,295:319) = UKregions2(217:237,295:319)*13; % Isle of Man
    
    UKregions2(122:202,297:359) = UKregions2(122:202,297:359)*12; % Northern Ireland
    UKregions2(180,362) = UKregions2(180,362)*12; % Northern Ireland    
    
    
    UKregions2(198:281,169:257) = UKregions2(198:281,169:257)*11; % Wales
    UKregions2(198:268,258:267) = UKregions2(198:268,258:267)*11; % Wales
    UKregions2(198:277,164:168) = UKregions2(198:277,164:168)*11; % Wales

    % Remove all stray coastal points in England
    otherpoints = (UKregions2>10) * 11;
    otherpoints(122:202,297:359) = otherpoints(122:202,297:359)/11*12;
    otherpoints(217:237,295:319) = otherpoints(217:237,295:319)/11*13;
    UKregions2(:,1:327) = otherpoints(:,1:327);
    UKregions2(298:325,325:386) = 0; % Bit of NE coast
    
    % Fix glitch in Scotland
    UKregions2(297,450:477) = -1;

    % Add English regions
    EnglandRegions_CPM(EnglandRegions_CPM>0) = EnglandRegions_CPM(EnglandRegions_CPM>0) + 1;
    UKregions2 = (EnglandRegions_CPM+UKregions2).*datamask2;
    UKregions2(:,606) = nan; % omit points in Shetland that lie at the very edge
    
    % HadUK (1km)
    EnglandRegions_HadUK(594:595,855:1450) = 0;
    UKregions1 = datamask1 .* EnglandRegions_HadUK==0;
    UKregions1 = UKregions1*1;

    % Note: too many coastal points to correct them all - only add major
    % missing regions (Scotland, Wales, NI)
    UKregions1(410:463,657:712) = UKregions1(410:463,657:712)*13; % Isle of Man
    
    UKregions1(190:385,650:804) = UKregions1(190:385,650:804)*12; % Northern Ireland
    UKregions1(328:339,805:814) = UKregions1(328:339,805:814)*12; % Northern Ireland    
    
    
    UKregions1(360:554,378:576) = UKregions1(360:554,378:576)*11; % Wales
    UKregions1(360:527,577:588) = UKregions1(360:527,577:588)*11; % Wales
    UKregions1(360:460,589:600) = UKregions1(360:460,589:600)*11; % Wales
    UKregions1(360:554,360:377) = UKregions1(360:554,360:377)*11; % Wales

    % Remove all stray coastal points in England
    otherpoints = (UKregions1>10) * 11;
    otherpoints(190:385,650:804) = otherpoints(190:385,650:804)/11*12;
    otherpoints(410:463,657:712) = otherpoints(410:463,657:712)/11*13;
    UKregions1(:,1:730) = otherpoints(:,1:730);
    UKregions1(598:676,731:853) = 0; % Bit of NE coast
    


    % Add English regions
    EnglandRegions_HadUK(EnglandRegions_HadUK>0) = EnglandRegions_HadUK(EnglandRegions_HadUK>0) + 1;
    UKregions1 = (EnglandRegions_HadUK+UKregions1).*datamask1;

    
    
    %% Save files to speed up in future
    save('UKregions60.mat','UKregions60')
    save('UKregions12.mat','UKregions12')
    save('UKregions2.mat','UKregions2')
    save('UKregionsERA5.mat','UKregionsERA5')
    save('UKregions1.mat','UKregions1')
end



