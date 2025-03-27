%% Heat mortality figures
load('population_SSP2_2D.mat')
load('population_SSP4_2D.mat')
load('population_SSP5_2D.mat')
load('long_UK_RCM.mat')
load('lat_UK_RCM.mat')
load('datamask12.mat')
load("lajolla.mat")
HeatMortality
close all
generate_UK_latlon

if ~exist('S_SNI_mask','var')
    generate_coastline
end

lat_UK_RCMa = reshape(lat_UK_RCM,82*112,1);
long_UK_RCMa = reshape(long_UK_RCM,82*112,1);

latlim = [53.9 55.4];
lonlim = [-8.5 -5];


%% No pop change
figure
set(gcf, 'color', 'w');

% subplot(1,3,1)
subplot('position',[0.01,0.66,0.28,0.3])
mort_580_MMM = squeeze(mort_data(:,:,1,1));
popsize = squeeze(population_SSP5_2D(:,:,1,1));

hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
mort_nan = mort_580_MMM;
mort_nan(mort_580_MMM<=0) = nan;
mort_nana = reshape(mort_nan,82*112,1);
popsize_nan = popsize;
popsize_nan(popsize<=0) = nan;
popsizea = reshape(popsize_nan,82*112,1);
scatterm(lat_UK_RCMa,long_UK_RCMa,sqrt(popsizea),mort_nana,'filled')

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([0 15])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

scatterm(54.7083, -7.5934,150,'k','filled')
scatterm(54.7083, -7.5934,50,'w','filled')
scatterm(54.7083, -7.5934,10,'k','filled')
textm(54.7083, -7.5934,"Castlederg   ",'horizontalalignment','right','fontsize',14)

title('(a) Baseline')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])



% subplot(1,3,2)
subplot('position',[0.31,0.66,0.28,0.3])
mort_580_MMM = squeeze(mort_data(:,:,1,2));

hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
mort_nan = mort_580_MMM;
mort_nan(mort_580_MMM<=0) = nan;
mort_nana = reshape(mort_nan,82*112,1);
% scatterm(lat_UK_RCMa,long_UK_RCMa,mort_nana*150,mort_nana,'filled')
popsize_nan = popsize;
popsize_nan(popsize<=0) = nan;
popsizea = reshape(popsize_nan,82*112,1);
scatterm(lat_UK_RCMa,long_UK_RCMa,sqrt(popsizea),mort_nana,'filled')

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([0 15])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

% scatterm(54.7083, -7.5934,150,'k','filled')
% scatterm(54.7083, -7.5934,50,'w','filled')
% scatterm(54.7083, -7.5934,10,'k','filled')
title('(b) 2 °C warming, no population change')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])





% subplot(1,3,3)
subplot('position',[0.61,0.66,0.28,0.3])
mort_580_MMM = squeeze(mort_data(:,:,1,3));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
mort_nan = mort_580_MMM;
mort_nan(mort_580_MMM<=0) = nan;
mort_nana = reshape(mort_nan,82*112,1);
% scatterm(lat_UK_RCMa,long_UK_RCMa,mort_nana*150,mort_nana,'filled')
popsize = squeeze(population_SSP5_2D(:,:,1,1));
popsize_nan = popsize;
popsize_nan(popsize<=0) = nan;
popsizea = reshape(popsize_nan,82*112,1);
scatterm(lat_UK_RCMa,long_UK_RCMa,sqrt(popsizea),mort_nana,'filled')

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([0 15])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

% scatterm(54.7083, -7.5934,150,'k','filled')
% scatterm(54.7083, -7.5934,50,'w','filled')
% scatterm(54.7083, -7.5934,10,'k','filled')
title('(c) 4 °C warming, no population change')


cbar = colorbar('Location','eastoutside');
ylabel(cbar,'Deaths per year')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])


% Heat deaths at 2 °C

% % subplot(1,3,1)
% subplot('position',[0.01,0.5,0.28,0.5])
% mort_580_MMM = squeeze(mort_data(:,:,1,1));
% popsize = squeeze(population_SSP5_2D(:,:,1,1));
% 
% hold on
% 
% % Set up axes
% axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
%     'MapLonLim', lonlim, 'MLineLocation', 30,...
%     'PlineLocation', 30, 'MLabelParallel', 'south')
% geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
% geoshow(S_lakes_mask,'FaceColor','white');
% 
% % Plot the data
% mort_nan = mort_580_MMM;
% mort_nan(mort_580_MMM<=0) = nan;
% mort_nana = reshape(mort_nan,82*112,1);
% popsize_nan = popsize;
% popsize_nan(popsize<=0) = nan;
% popsizea = reshape(popsize_nan,82*112,1);
% scatterm(lat_UK_RCMa,long_UK_RCMa,sqrt(popsizea),mort_nana,'filled')
% 
% % pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
% colormap(lajolla)
% clim([0 15])
% 
% 
% % mapshow(S_NI_lakes,'FaceColor',[1 1 1])
% 
% % Adjust the plot
% framem('FEdgeColor', 'black', 'FLineWidth', 1)
% gridm('Gcolor',[0.3 0.3 0.3])
% tightmap
% box off
% axis off
% 
% geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);
% 
% geoshow([S_NI.Y], [S_NI.X],'Color','black');
% geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');
% 
% scatterm(54.7083, -7.5934,150,'k','filled')
% scatterm(54.7083, -7.5934,50,'w','filled')
% scatterm(54.7083, -7.5934,10,'k','filled')
% textm(54.7083, -7.5934,"Castlederg   ",'horizontalalignment','right','fontsize',14)
% 
% title('(a) Baseline')
% 
% set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])
% 




% subplot(1,3,2)
subplot('position',[0.31,0.33,0.28,0.3])
mort_580_MMM = squeeze(mort_data(:,:,1,11));
popsize = squeeze(population_SSP5_2D(:,:,1,5));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
mort_nan = mort_580_MMM;
mort_nan(mort_580_MMM<=0) = nan;
mort_nana = reshape(mort_nan,82*112,1);
% scatterm(lat_UK_RCMa,long_UK_RCMa,mort_nana*150,mort_nana,'filled')
popsize_nan = popsize;
popsize_nan(popsize<=0) = nan;
popsizea = reshape(popsize_nan,82*112,1);
scatterm(lat_UK_RCMa,long_UK_RCMa,sqrt(popsizea),mort_nana,'filled')

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([0 15])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

% scatterm(54.7083, -7.5934,150,'k','filled')
% scatterm(54.7083, -7.5934,50,'w','filled')
% scatterm(54.7083, -7.5934,10,'k','filled')
title('(d) 2 °C warming, SSP5 2080 population')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])





% subplot(1,3,3)
subplot('position',[0.61,0.33,0.28,0.3])
mort_580_MMM = squeeze(mort_data(:,:,1,12));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
mort_nan = mort_580_MMM;
mort_nan(mort_580_MMM<=0) = nan;
mort_nana = reshape(mort_nan,82*112,1);
% scatterm(lat_UK_RCMa,long_UK_RCMa,mort_nana*150,mort_nana,'filled')
popsize = squeeze(population_SSP5_2D(:,:,1,5));
popsize_nan = popsize;
popsize_nan(popsize<=0) = nan;
popsizea = reshape(popsize_nan,82*112,1);
scatterm(lat_UK_RCMa,long_UK_RCMa,sqrt(popsizea),mort_nana,'filled')

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([0 15])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

% scatterm(54.7083, -7.5934,150,'k','filled')
% scatterm(54.7083, -7.5934,50,'w','filled')
% scatterm(54.7083, -7.5934,10,'k','filled')
title('(e) 4 °C warming, SSP5 2080 population')


cbar = colorbar('Location','eastoutside');
ylabel(cbar,'Deaths per year')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])



% Heat discomfort

t22base = csvread('../OpenCLIM/NI_results/Heat days/Tmean22 baseline MMM.csv');
t222c = csvread('../OpenCLIM/NI_results/Heat days/Tmean22 2C MMM.csv');
t224c = csvread('../OpenCLIM/NI_results/Heat days/Tmean22 4C MMM.csv');


latlim = [53.9 55.4];
lonlim = [-8.5 -5];

% figure
set(gcf, 'color', 'w');

% subplot(1,3,1)
subplot('position',[0.01,0,0.28,0.3])
% mort_580_MMM = squeeze(mort_data(:,:,1,1));
% popsize = squeeze(population_SSP5_2D(:,:,1,1));

hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
% mort_nan = mort_580_MMM;
t22basea =t22base;
mask = t22base<=0.5;
t22basea(mask) = nan;
% mort_nana = reshape(mort_nan,82*112,1);
% popsize_nan = popsize;
% popsize_nan(popsize<=0) = nan;
% popsizea = reshape(popsize_nan,82*112,1);
% scatterm(lat_UK_RCMa,long_UK_RCMa,sqrt(popsizea),mort_nana,'filled')
pcolorm(lat_UK_RCM,long_UK_RCM,t22basea.*datamask12)

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([0 15])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

% scatterm(54.7083, -7.5934,150,'k','filled')
% scatterm(54.7083, -7.5934,50,'w','filled')
% scatterm(54.7083, -7.5934,10,'k','filled')
% textm(54.7083, -7.5934,"Castlederg   ",'horizontalalignment','right','fontsize',14)

title('(f) Baseline')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])





% subplot(1,3,2)
subplot('position',[0.31,0,0.28,0.3])
mort_580_MMM = squeeze(mort_data(:,:,1,3));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
% mort_nan = mort_580_MMM;
t222ca =t222c;
mask = t222c<=0.5;
t222ca(mask) = nan;
% mort_nana = reshape(mort_nan,82*112,1);
% popsize_nan = popsize;
% popsize_nan(popsize<=0) = nan;
% popsizea = reshape(popsize_nan,82*112,1);
% scatterm(lat_UK_RCMa,long_UK_RCMa,sqrt(popsizea),mort_nana,'filled')
pcolorm(lat_UK_RCM,long_UK_RCM,t222ca.*datamask12)

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([0 15])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

% scatterm(54.7083, -7.5934,150,'k','filled')
% scatterm(54.7083, -7.5934,50,'w','filled')
% scatterm(54.7083, -7.5934,10,'k','filled')
title('(g) 2 °C warming')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])





% subplot(1,3,3)
subplot('position',[0.61,0,0.28,0.3])
mort_580_MMM = squeeze(mort_data(:,:,1,12));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
% mort_nan = mort_580_MMM;
t224ca =t224c;
mask = t224c<=0.5;
t224ca(mask) = nan;
% mort_nana = reshape(mort_nan,82*112,1);
% popsize_nan = popsize;
% popsize_nan(popsize<=0) = nan;
% popsizea = reshape(popsize_nan,82*112,1);
% scatterm(lat_UK_RCMa,long_UK_RCMa,sqrt(popsizea),mort_nana,'filled')
pcolorm(lat_UK_RCM,long_UK_RCM,t224ca.*datamask12)

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([0 15])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

% scatterm(54.7083, -7.5934,150,'k','filled')
% scatterm(54.7083, -7.5934,50,'w','filled')
% scatterm(54.7083, -7.5934,10,'k','filled')
title('(h) 4 °C warming')


cbar = colorbar('Location','eastoutside');
ylabel(cbar,'Days T_m_e_a_n > 22 °C per year')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])


%% Very cold days
figure
t22base = 365-csvread('../OpenCLIM/NI_results/Heat days/Tmean0 baseline MMM.csv');
t222c = 365-csvread('../OpenCLIM/NI_results/Heat days/Tmean0 2C MMM.csv');
t224c = 365-csvread('../OpenCLIM/NI_results/Heat days/Tmean0 4C MMM.csv');


latlim = [53.9 55.4];
lonlim = [-8.5 -5];

% figure
set(gcf, 'color', 'w');

% subplot(1,3,1)
subplot('position',[0.01,0,0.28,1])
% mort_580_MMM = squeeze(mort_data(:,:,1,1));
% popsize = squeeze(population_SSP5_2D(:,:,1,1));

hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
% mort_nan = mort_580_MMM;
t22basea =t22base;
mask = t22base<=0.5;
t22basea(mask) = nan;
% mort_nana = reshape(mort_nan,82*112,1);
% popsize_nan = popsize;
% popsize_nan(popsize<=0) = nan;
% popsizea = reshape(popsize_nan,82*112,1);
% scatterm(lat_UK_RCMa,long_UK_RCMa,sqrt(popsizea),mort_nana,'filled')
pcolorm(lat_UK_RCM,long_UK_RCM,t22basea.*datamask12)

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(flipud(bone))
clim([0 10])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

% scatterm(54.7083, -7.5934,150,'k','filled')
% scatterm(54.7083, -7.5934,50,'w','filled')
% scatterm(54.7083, -7.5934,10,'k','filled')
% textm(54.7083, -7.5934,"Castlederg   ",'horizontalalignment','right','fontsize',14)

title('(a) Baseline')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])





% subplot(1,3,2)
subplot('position',[0.31,0,0.28,1])
mort_580_MMM = squeeze(mort_data(:,:,1,3));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
% mort_nan = mort_580_MMM;
t222ca =t222c;
mask = t222c<=0.5;
t222ca(mask) = nan;
% mort_nana = reshape(mort_nan,82*112,1);
% popsize_nan = popsize;
% popsize_nan(popsize<=0) = nan;
% popsizea = reshape(popsize_nan,82*112,1);
% scatterm(lat_UK_RCMa,long_UK_RCMa,sqrt(popsizea),mort_nana,'filled')
pcolorm(lat_UK_RCM,long_UK_RCM,t222ca.*datamask12)

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(flipud(bone))
clim([0 10])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

% scatterm(54.7083, -7.5934,150,'k','filled')
% scatterm(54.7083, -7.5934,50,'w','filled')
% scatterm(54.7083, -7.5934,10,'k','filled')
title('(b) 2 °C warming')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])





% subplot(1,3,3)
subplot('position',[0.61,0,0.28,1])
mort_580_MMM = squeeze(mort_data(:,:,1,12));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
% mort_nan = mort_580_MMM;
t224ca =t224c;
mask = t224c<=0.5;
t224ca(mask) = nan;
% mort_nana = reshape(mort_nan,82*112,1);
% popsize_nan = popsize;
% popsize_nan(popsize<=0) = nan;
% popsizea = reshape(popsize_nan,82*112,1);
% scatterm(lat_UK_RCMa,long_UK_RCMa,sqrt(popsizea),mort_nana,'filled')
pcolorm(lat_UK_RCM,long_UK_RCM,t224ca.*datamask12)

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(flipud(bone))
clim([0 10])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

% scatterm(54.7083, -7.5934,150,'k','filled')
% scatterm(54.7083, -7.5934,50,'w','filled')
% scatterm(54.7083, -7.5934,10,'k','filled')
title('(c) 4 °C warming')


cbar = colorbar('Location','eastoutside');
ylabel(cbar,'Days T_m_e_a_n < 0 °C per year')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])



%% Agri plots
crop_county_stats

latlim = [53.9 55.4];
lonlim = [-8.5 -5];

figure
set(gcf, 'color', 'w');

subplot(1,3,1)
subplot('position',[0.01,0,0.28,1])
mort_580_MMM = squeeze(mort_data(:,:,1,1));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
pcolorm(lat_UK_HadUK1,long_UK_HadUK1,grass_yield(:,:,1))

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([5 13])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');




scatterm(54.598,-7.309,150,'k','filled')
scatterm(54.598,-7.309,50,'w','filled')
scatterm(54.598,-7.309,10,'k','filled')
textm(54.598,-7.309,"Omagh   ",'horizontalalignment','right','fontsize',14)
scatterm(55.071,-6.508,150,'k','filled')
scatterm(55.071,-6.508,50,'w','filled')
scatterm(55.071,-6.508,10,'k','filled')
% textm(55.071,-6.508,"Ballymoney   ",'horizontalalignment','right','fontsize',12)
textm(55.071,-6.508,"   Ballymoney",'horizontalalignment','left','fontsize',14)
scatterm(54.50,-6.77,150,'k','filled')
scatterm(54.50,-6.77,50,'w','filled')
scatterm(54.50,-6.77,10,'k','filled')
textm(54.50,-6.77,"Dungannon   ",'horizontalalignment','right','fontsize',14)
scatterm(54.395,-5.886,150,'k','filled')
scatterm(54.395,-5.886,50,'w','filled')
scatterm(54.395,-5.886,10,'k','filled')
textm(54.395,-5.886,"Ballynahinch   ",'horizontalalignment','right','fontsize',14)

title('(a) Baseline')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])



subplot(1,3,2)
subplot('position',[0.31,0,0.28,1])
mort_580_MMM = squeeze(mort_data(:,:,1,1));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
pcolorm(lat_UK_HadUK1,long_UK_HadUK1,grass_yield(:,:,3))

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([5 13])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');


title('(b) 2 °C warming')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])



subplot(1,3,3)
subplot('position',[0.61,0,0.28,1])
mort_580_MMM = squeeze(mort_data(:,:,1,1));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
pcolorm(lat_UK_HadUK1,long_UK_HadUK1,grass_yield(:,:,7))

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([5 13])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

title('(c) 4 °C warming')


cbar = colorbar('Location','eastoutside');
ylabel(cbar,'Grass yield t/ha')
colormap(flipud(summer))

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])



%% Agri plots wheat
latlim = [53.9 55.4];
lonlim = [-8.5 -5];

figure
set(gcf, 'color', 'w');

subplot(1,3,1)
subplot('position',[0.01,0,0.28,1])
mort_580_MMM = squeeze(mort_data(:,:,1,1));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
pcolorm(lat_UK_HadUK1,long_UK_HadUK1,wheat_yield(:,:,1))

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([5 13])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');



% 
% scatterm(54.598,-7.309,150,'k','filled')
% scatterm(54.598,-7.309,50,'w','filled')
% scatterm(54.598,-7.309,10,'k','filled')
% textm(54.598,-7.309,"Omagh   ",'horizontalalignment','right','fontsize',14)
% scatterm(55.071,-6.508,150,'k','filled')
% scatterm(55.071,-6.508,50,'w','filled')
% scatterm(55.071,-6.508,10,'k','filled')
% % textm(55.071,-6.508,"Ballymoney   ",'horizontalalignment','right','fontsize',12)
% textm(55.071,-6.508,"   Ballymoney",'horizontalalignment','left','fontsize',14)
% scatterm(54.50,-6.77,150,'k','filled')
% scatterm(54.50,-6.77,50,'w','filled')
% scatterm(54.50,-6.77,10,'k','filled')
% textm(54.50,-6.77,"Dungannon   ",'horizontalalignment','right','fontsize',14)
% scatterm(54.395,-5.886,150,'k','filled')
% scatterm(54.395,-5.886,50,'w','filled')
% scatterm(54.395,-5.886,10,'k','filled')
% textm(54.395,-5.886,"Ballynahinch   ",'horizontalalignment','right','fontsize',14)

title('(a) Baseline')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])



subplot(1,3,2)
subplot('position',[0.31,0,0.28,1])
mort_580_MMM = squeeze(mort_data(:,:,1,1));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
pcolorm(lat_UK_HadUK1,long_UK_HadUK1,wheat_yield(:,:,3))

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([5 13])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');


title('(b) 2 °C warming')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])



subplot(1,3,3)
subplot('position',[0.61,0,0.28,1])
mort_580_MMM = squeeze(mort_data(:,:,1,1));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
pcolorm(lat_UK_HadUK1,long_UK_HadUK1,wheat_yield(:,:,7))

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([5 13])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

title('(c) 4 °C warming')


cbar = colorbar('Location','eastoutside');
ylabel(cbar,'Wheat yield t/ha')
colormap(flipud(summer))

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])



%% Agri plots OSR
latlim = [53.9 55.4];
lonlim = [-8.5 -5];

figure
set(gcf, 'color', 'w');

subplot(1,3,1)
subplot('position',[0.01,0,0.28,1])


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
pcolorm(lat_UK_HadUK1,long_UK_HadUK1,osr_yield(:,:,1))

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([5 13])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');




% scatterm(54.598,-7.309,150,'k','filled')
% scatterm(54.598,-7.309,50,'w','filled')
% scatterm(54.598,-7.309,10,'k','filled')
% textm(54.598,-7.309,"Omagh   ",'horizontalalignment','right','fontsize',14)
% scatterm(55.071,-6.508,150,'k','filled')
% scatterm(55.071,-6.508,50,'w','filled')
% scatterm(55.071,-6.508,10,'k','filled')
% % textm(55.071,-6.508,"Ballymoney   ",'horizontalalignment','right','fontsize',12)
% textm(55.071,-6.508,"   Ballymoney",'horizontalalignment','left','fontsize',14)
% scatterm(54.50,-6.77,150,'k','filled')
% scatterm(54.50,-6.77,50,'w','filled')
% scatterm(54.50,-6.77,10,'k','filled')
% textm(54.50,-6.77,"Dungannon   ",'horizontalalignment','right','fontsize',14)
% scatterm(54.395,-5.886,150,'k','filled')
% scatterm(54.395,-5.886,50,'w','filled')
% scatterm(54.395,-5.886,10,'k','filled')
% textm(54.395,-5.886,"Ballynahinch   ",'horizontalalignment','right','fontsize',14)

title('(d) Baseline')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])



subplot(1,3,2)
subplot('position',[0.31,0,0.28,1])
mort_580_MMM = squeeze(mort_data(:,:,1,1));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
pcolorm(lat_UK_HadUK1,long_UK_HadUK1,osr_yield(:,:,3))

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([5 13])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');


title('(e) 2 °C warming')

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])



subplot(1,3,3)
subplot('position',[0.61,0,0.28,1])
mort_580_MMM = squeeze(mort_data(:,:,1,1));


hold on

% Set up axes
axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
    'MapLonLim', lonlim, 'MLineLocation', 30,...
    'PlineLocation', 30, 'MLabelParallel', 'south')
geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
geoshow(S_lakes_mask,'FaceColor','white');

% Plot the data
pcolorm(lat_UK_HadUK1,long_UK_HadUK1,osr_yield(:,:,7))

% pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
colormap(lajolla)
clim([5 13])


% mapshow(S_NI_lakes,'FaceColor',[1 1 1])

% Adjust the plot
framem('FEdgeColor', 'black', 'FLineWidth', 1)
gridm('Gcolor',[0.3 0.3 0.3])
tightmap
box off
axis off

geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);

geoshow([S_NI.Y], [S_NI.X],'Color','black');
geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');

title('(f) 4 °C warming')


cbar = colorbar('Location','eastoutside');
ylabel(cbar,'Oil seed rape yield t/ha')
colormap(flipud(summer))

set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])

