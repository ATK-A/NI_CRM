%% Load data
% Hydrology data
Q50 = readtable('Q50.csv');
Q01 = readtable('Q01.csv');
Q99 = readtable('Q99.csv');

% Load catchment data
catchments = shaperead('NI_shape/NI_catchments.shp');

if ~exist('S_NI_mask','var')
    load_masks
end


%% Plotting
close all

latlim = [53.9 55.4];
lonlim = [-8.5 -5];
% collims = [40 80];
collims = [30 60];
scenarios = [2 6];
locations = [0.01,0.5,0.28,0.5;0.31,0.5,0.28,0.5;0.61,0.5,0.28,0.5;...
    0.01,0,0.28,0.5;0.31,0,0.28,0.5;0.61,0,0.28,0.5];
figure_ids = {'a', 'b', 'c', 'd', 'e', 'f'};
model_ids = {'HBV model', 'SHETRAN model'};
model_id = [0 30];

for m = 1:2
    count = 1;

    figure
    set(gcf, 'color', 'w');
    for s = 1:length(scenarios)

        % subplot(1,3,1)
        subplot('position',locations(count,:))
        % mort_580_MMM = squeeze(mort_data(:,:,1,1));
        % popsize = squeeze(population_SSP5_2D(:,:,1,1));

        hold on

        % Set up axes
        axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
            'MapLonLim', lonlim, 'MLineLocation', 30,...
            'PlineLocation', 30, 'MLabelParallel', 'south')

        geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
        geoshow(S_lakes_mask,'FaceColor','white');


        S_temp = catchments;

        load('romamod.mat')
        colors = romamod;

        scatter_points = nan(3,30);
        for i = 1:length(catchments)
            for j = 1:length(catchments)

                if string(S_temp(i).ID_STRING) == num2str(table2array(Q99(j+2+model_id(m),1)))

                    vals1 = table2array(Q99(j+2+model_id(m),(4:8:92)+scenarios(s))); % +3 for 2°C, +7 for 4°C
                    vals0 = table2array(Q99(j+2+model_id(m),4:8:92));
                    vals = vals1-vals0;
                    valsm_plot = mean(vals./vals0*100);


                    NSEVal = table2array(Q99(j+2+model_id(m),99));
                    NSECal = table2array(Q99(j+2+model_id(m),100));


                    if ~isnan(valsm_plot) && NSECal >= 0.7 && NSEVal >= 0.7
                        col = round((valsm_plot+collims(1))/max(collims(2))*255)+1;
                        if col<1 || col>256
                            col = 1;
                        end
                        col_ = colors(col,:);

                        [lat,lon] = os2ll( [catchments(i).X], [catchments(i).Y] );

                        S_temp = catchments;
                        S_temp(i).Lat = lat;
                        S_temp(i).Lon = lon;

                        geoshow(S_temp(i),'FaceColor',col_,'EdgeColor',col_);
                        scatter_points(1,i)=nanmean(lat);
                        scatter_points(2,i)=nanmean(lon);
                        scatter_points(3,i)=valsm_plot;

                    end
                end
            end
        end

        % geoshow(S_lakes_mask,'FaceColor','white');
%         scatterm(scatter_points(1,:),scatter_points(2,:),50,scatter_points(3,:),'filled','MarkerEdgeColor','k')
        clim([-collims(1) collims(1)])
        colormap(romamod)
        % cbh = colorbar();
        % % set(cbh,'XTick',(0:64:256)/256,'XTickLabel',{'0','64','128','192','256'})
        % ylabel(cbh,'Change in Q99 flow (%)','FontSize',16)



        % pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
        % colormap(lajolla)
        % clim([0 15])


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

        title(['(',char(figure_ids(count)),') ',num2str(scenarios(s)/2+1),' °C Q99 (',char(model_ids(m)),')'])

        set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])

        count = count+1;



        subplot('position',locations(count,:))
        % mort_580_MMM = squeeze(mort_data(:,:,1,1));
        % popsize = squeeze(population_SSP5_2D(:,:,1,1));

        hold on

        % Set up axes
        axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
            'MapLonLim', lonlim, 'MLineLocation', 30,...
            'PlineLocation', 30, 'MLabelParallel', 'south')

        geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
        geoshow(S_lakes_mask,'FaceColor','white');


        S_temp = catchments;

        colors = romamod;

        scatter_points = nan(3,30);

        for i = 1:length(catchments)
            for j = 1:length(catchments)

                if string(S_temp(i).ID_STRING) == num2str(table2array(Q50(j+2+model_id(m),1)))

                    vals1 = table2array(Q50(j+2+model_id(m),(4:8:92)+scenarios(s))); % +3 for 2°C, +7 for 4°C
                    vals0 = table2array(Q50(j+2+model_id(m),4:8:92));
                    vals = vals1-vals0;
                    valsm_plot = mean(vals./vals0*100);

                    NSEVal = table2array(Q50(j+2+model_id(m),99));
                    NSECal = table2array(Q50(j+2+model_id(m),100));

                    if ~isnan(valsm_plot) && NSECal >= 0.7 && NSEVal >= 0.7
                        col = round((valsm_plot+collims(1))/max(collims(2))*255)+1;
                        if col<1 || col>256
                            col = 1;
                        end

                        disp([S_temp(i).ID_STRING,' = ', num2str(valsm_plot),' at i=',num2str(i),' and j=',num2str(j)])

                        col_ = colors(col,:);

                        [lat,lon] = os2ll( [catchments(i).X], [catchments(i).Y] );

                        S_temp = catchments;
                        S_temp(i).Lat = lat;
                        S_temp(i).Lon = lon;

                        geoshow(S_temp(i),'FaceColor',col_,'EdgeColor',col_);
                        scatter_points(1,i)=nanmean(lat);
                        scatter_points(2,i)=nanmean(lon);
                        scatter_points(3,i)=valsm_plot;

                    end
                end
            end
        end

        % geoshow(S_lakes_mask,'FaceColor','white');
%         scatterm(scatter_points(1,:),scatter_points(2,:),50,scatter_points(3,:),'filled','MarkerEdgeColor','k')
        clim([-collims(1) collims(1)])
        colormap(romamod)
        % cbh = colorbar();
        % % set(cbh,'XTick',(0:64:256)/256,'XTickLabel',{'0','64','128','192','256'})
        % ylabel(cbh,'Change in Q50 flow (%)','FontSize',16)



        % pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
        % colormap(lajolla)
        % clim([0 15])


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

        title(['(',char(figure_ids(count)),') ',num2str(scenarios(s)/2+1),' °C Q50 (',char(model_ids(m)),')'])

        set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])

        count = count+1;



        subplot('position',locations(count,:))

        hold on

        % Set up axes
        axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
            'MapLonLim', lonlim, 'MLineLocation', 30,...
            'PlineLocation', 30, 'MLabelParallel', 'south')

        geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
        geoshow(S_lakes_mask,'FaceColor','white');


        S_temp = catchments;

        colors = romamod;

        scatter_points = nan(3,30);

        for i = 1:length(catchments)
            for j = 1:length(catchments)

                if string(S_temp(i).ID_STRING) == num2str(table2array(Q01(j+2+model_id(m),1)))

                    vals1 = table2array(Q01(j+2+model_id(m),(4:8:92)+scenarios(s))); % +3 for 2°C, +7 for 4°C
                    vals0 = table2array(Q01(j+2+model_id(m),4:8:92));
                    vals = vals1-vals0;
                    valsm_plot = mean(vals./vals0*100);


                    NSEVal = table2array(Q01(j+2+model_id(m),99));
                    NSECal = table2array(Q01(j+2+model_id(m),100));

                    if ~isnan(valsm_plot) && NSECal >= 0.7 && NSEVal >= 0.7
                        col = round((valsm_plot+collims(1))/max(collims(2))*255)+1;
                        if col<1 || col>256
                            col = 1;
                        end
                        col_ = colors(col,:);

                        [lat,lon] = os2ll( [catchments(i).X], [catchments(i).Y] );

                        S_temp = catchments;
                        S_temp(i).Lat = lat;
                        S_temp(i).Lon = lon;

                        geoshow(S_temp(i),'FaceColor',col_,'EdgeColor',col_);
                        scatter_points(1,i)=nanmean(lat);
                        scatter_points(2,i)=nanmean(lon);
                        scatter_points(3,i)=valsm_plot;

                    end
                end
            end
        end

        % geoshow(S_lakes_mask,'FaceColor','white');
%         scatterm(scatter_points(1,:),scatter_points(2,:),50,scatter_points(3,:),'filled','MarkerEdgeColor','k')
        clim([-collims(1) collims(1)])
        colormap(romamod)
        cbh = colorbar();
        % set(cbh,'XTick',(0:64:256)/256,'XTickLabel',{'0','64','128','192','256'})
        ylabel(cbh,'Change in flow (%)','FontSize',16)



        % pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
        % colormap(lajolla)
        % clim([0 15])


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

        title(['(',char(figure_ids(count)),') ',num2str(scenarios(s)/2+1),' °C Q01 (',char(model_ids(m)),')'])

        set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])

        count = count+1;
    end
end


%% Agreement of both models
latlim = [53.9 55.4];
lonlim = [-8.5 -5];
collims = [100 200];
scenarios = [2 6];
locations = [0.01,0.5,0.28,0.5;0.31,0.5,0.28,0.5;0.61,0.5,0.28,0.5;...
    0.01,0,0.28,0.5;0.31,0,0.28,0.5;0.61,0,0.28,0.5];
figure_ids = {'a', 'b', 'c', 'd', 'e', 'f'};
model_ids = {'HBV model', 'SHETRAN model'};
model_id = [0 30];

    count = 1;

    figure
    set(gcf, 'color', 'w');
    for s = 1:length(scenarios)

        % subplot(1,3,1)
        subplot('position',locations(count,:))
        % mort_580_MMM = squeeze(mort_data(:,:,1,1));
        % popsize = squeeze(population_SSP5_2D(:,:,1,1));

        hold on

        % Set up axes
        axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
            'MapLonLim', lonlim, 'MLineLocation', 30,...
            'PlineLocation', 30, 'MLabelParallel', 'south')

        geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
        geoshow(S_lakes_mask,'FaceColor','white');


        S_temp = catchments;

        load('romamod.mat')
        colors = flipud(romamod);

        scatter_points = nan(3,30);
        for i = 1:length(catchments)
            for j = 1:length(catchments)

                if string(S_temp(i).ID_STRING) == num2str(table2array(Q99(j+2,1)))

                    vals1 = table2array(Q99([j+2, j+32],(4:8:92)+scenarios(s))); % +3 for 2°C, +7 for 4°C
                    vals0 = table2array(Q99([j+2, j+32],4:8:92));
                    vals = vals1-vals0;
                    valsm_plot = mean(mean(vals./vals0*100)); % This calculates MMM
                    % Instead I want % agreeing on drying or wetting
                    valsm_plot = (sum(sum(vals<0)) - 12)/12*100;

                    NSEVal = table2array(Q99([j+2, j+32],99));
                    NSECal = table2array(Q99([j+2, j+32],100));


                    if ~isnan(valsm_plot) && mean(NSECal >= 0.7)==1 && mean(NSEVal >= 0.7)==1
                        col = round((valsm_plot+collims(1))/max(collims(2))*255)+1;
                        if col<1 || col>256
                            col = 1;
                        end
                        col_ = colors(col,:);

                        [lat,lon] = os2ll( [catchments(i).X], [catchments(i).Y] );

                        S_temp = catchments;
                        S_temp(i).Lat = lat;
                        S_temp(i).Lon = lon;

                        geoshow(S_temp(i),'FaceColor',col_,'EdgeColor',col_);
                        scatter_points(1,i)=nanmean(lat);
                        scatter_points(2,i)=nanmean(lon);
                        scatter_points(3,i)=valsm_plot;


                    end
                end
            end
        end

        % geoshow(S_lakes_mask,'FaceColor','white');
%         scatterm(scatter_points(1,:),scatter_points(2,:),50,scatter_points(3,:),'filled','MarkerEdgeColor','k')
        clim([-collims(1) collims(1)])
        colormap(romamod)
        % cbh = colorbar();
        % % set(cbh,'XTick',(0:64:256)/256,'XTickLabel',{'0','64','128','192','256'})
        % ylabel(cbh,'Change in Q99 flow (%)','FontSize',16)



        % pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
        % colormap(lajolla)
        % clim([0 15])


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

        title(['(',char(figure_ids(count)),') ',num2str(scenarios(s)/2+1),' °C Q99'])

        set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])

        count = count+1;



        subplot('position',locations(count,:))
        % mort_580_MMM = squeeze(mort_data(:,:,1,1));
        % popsize = squeeze(population_SSP5_2D(:,:,1,1));

        hold on

        % Set up axes
        axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
            'MapLonLim', lonlim, 'MLineLocation', 30,...
            'PlineLocation', 30, 'MLabelParallel', 'south')

        geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
        geoshow(S_lakes_mask,'FaceColor','white');


        S_temp = catchments;

        colors = flipud(romamod);

        scatter_points = nan(3,30);

        for i = 1:length(catchments)
            for j = 1:length(catchments)

                if string(S_temp(i).ID_STRING) == num2str(table2array(Q50(j+2,1)))

                    vals1 = table2array(Q50([j+2, j+32],(4:8:92)+scenarios(s))); % +3 for 2°C, +7 for 4°C
                    vals0 = table2array(Q50([j+2, j+32],4:8:92));
                    vals = vals1-vals0;
%                     valsm_plot = mean(mean(vals./vals0*100));
                    valsm_plot = (sum(sum(vals<0)) - 12)/12*100;


                    NSEVal = table2array(Q50([j+2, j+32],99));
                    NSECal = table2array(Q50([j+2, j+32],100));


                    if ~isnan(valsm_plot) && mean(NSECal >= 0.7)==1 && mean(NSEVal >= 0.7)==1
                        col = round((valsm_plot+collims(1))/max(collims(2))*255)+1;
                        if col<1 || col>256
                            col = 1;
                        end
                        col_ = colors(col,:);

                        [lat,lon] = os2ll( [catchments(i).X], [catchments(i).Y] );

                        S_temp = catchments;
                        S_temp(i).Lat = lat;
                        S_temp(i).Lon = lon;

                        geoshow(S_temp(i),'FaceColor',col_,'EdgeColor',col_);
                        scatter_points(1,i)=nanmean(lat);
                        scatter_points(2,i)=nanmean(lon);
                        scatter_points(3,i)=valsm_plot;

                    end
                end
            end
        end

        % geoshow(S_lakes_mask,'FaceColor','white');
%         scatterm(scatter_points(1,:),scatter_points(2,:),50,scatter_points(3,:),'filled','MarkerEdgeColor','k')
        clim([-collims(1) collims(1)])
        colormap(romamod)
        % cbh = colorbar();
        % % set(cbh,'XTick',(0:64:256)/256,'XTickLabel',{'0','64','128','192','256'})
        % ylabel(cbh,'Change in Q50 flow (%)','FontSize',16)



        % pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
        % colormap(lajolla)
        % clim([0 15])


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

        title(['(',char(figure_ids(count)),') ',num2str(scenarios(s)/2+1),' °C Q50'])

        set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])

        count = count+1;



        subplot('position',locations(count,:))

        hold on

        % Set up axes
        axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
            'MapLonLim', lonlim, 'MLineLocation', 30,...
            'PlineLocation', 30, 'MLabelParallel', 'south')

        geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
        geoshow(S_lakes_mask,'FaceColor','white');


        S_temp = catchments;

        colors = flipud(romamod);

        scatter_points = nan(3,30);

        for i = 1:length(catchments)
            for j = 1:length(catchments)

                if string(S_temp(i).ID_STRING) == num2str(table2array(Q01(j+2,1)))

                    vals1 = table2array(Q01([j+2, j+32],(4:8:92)+scenarios(s))); % +3 for 2°C, +7 for 4°C
                    vals0 = table2array(Q01([j+2, j+32],4:8:92));
                    vals = vals1-vals0;
%                     valsm_plot = mean(mean(vals./vals0*100));
                    valsm_plot = (sum(sum(vals<0)) - 12)/12*100;


                    NSEVal = table2array(Q01([j+2, j+32],99));
                    NSECal = table2array(Q01([j+2, j+32],100));


                    if ~isnan(valsm_plot) && mean(NSECal >= 0.7)==1 && mean(NSEVal >= 0.7)==1
                        col = round((valsm_plot+collims(1))/max(collims(2))*255)+1;
                        if col<1 || col>256
                            col = 1;
                        end
                        col_ = colors(col,:);

                        [lat,lon] = os2ll( [catchments(i).X], [catchments(i).Y] );

                        S_temp = catchments;
                        S_temp(i).Lat = lat;
                        S_temp(i).Lon = lon;

                        geoshow(S_temp(i),'FaceColor',col_,'EdgeColor',col_);
                        scatter_points(1,i)=nanmean(lat);
                        scatter_points(2,i)=nanmean(lon);
                        scatter_points(3,i)=valsm_plot;

                    end
                end
            end
        end

        % geoshow(S_lakes_mask,'FaceColor','white');
%         scatterm(scatter_points(1,:),scatter_points(2,:),50,scatter_points(3,:),'filled','MarkerEdgeColor','k')
        clim([-collims(1) collims(1)])
        colormap(romamod)
        cbh = colorbar();
        set(cbh,'XTick',[-100,-50,0,50,100],'XTickLabel',{'100','75','0','75','100'})
        ylabel(cbh,{'Drier                                       Wetter';'Agreement on direction of change (%)'},'FontSize',16)



        % pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
        % colormap(lajolla)
        % clim([0 15])


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

        title(['(',char(figure_ids(count)),') ',num2str(scenarios(s)/2+1),' °C Q01'])

        set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])

        count = count+1;
    end


%     %% Mean of both models
% latlim = [53.9 55.4];
% lonlim = [-8.5 -5];
% collims = [30 60];
% scenarios = [2 6];
% locations = [0.01,0.5,0.28,0.5;0.31,0.5,0.28,0.5;0.61,0.5,0.28,0.5;...
%     0.01,0,0.28,0.5;0.31,0,0.28,0.5;0.61,0,0.28,0.5];
% figure_ids = {'a', 'b', 'c', 'd', 'e', 'f'};
% model_ids = {'HBV model', 'SHETRAN model'};
% model_id = [0 30];
% 
%     count = 1;
% 
%     figure
%     set(gcf, 'color', 'w');
%     for s = 1:length(scenarios)
% 
%         % subplot(1,3,1)
%         subplot('position',locations(count,:))
%         hold on
% 
%         % Set up axes
%         axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
%             'MapLonLim', lonlim, 'MLineLocation', 30,...
%             'PlineLocation', 30, 'MLabelParallel', 'south')
% 
%         geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
%         geoshow(S_lakes_mask,'FaceColor','white');
% 
%         S_temp = catchments;
% 
%         load('romamod.mat')
%         colors = flipud(romamod);
% 
%         scatter_points = nan(3,30);
%         for i = 1:length(catchments)
%             for j = 1:length(catchments)
% 
%                 if string(S_temp(i).ID_STRING) == num2str(table2array(Q99(j+2,1)))
% 
%                     vals1 = table2array(Q99([j+2, j+32],(4:8:92)+scenarios(s))); % +3 for 2°C, +7 for 4°C
%                     vals0 = table2array(Q99([j+2, j+32],4:8:92));
%                     vals = vals1-vals0;
%                     valsm_plot = mean(mean(vals./vals0*100)); % This calculates MMM
% 
%                     NSEVal = table2array(Q99([j+2, j+32],99));
%                     NSECal = table2array(Q99([j+2, j+32],100));
% 
% 
%                     if ~isnan(valsm_plot) && mean(NSECal >= 0.7)==1 && mean(NSEVal >= 0.7)==1
%                         col = round((valsm_plot+collims(1))/max(collims(2))*255)+1;
%                         if col<1 || col>256
%                             col = 1;
%                         end
%                         col_ = colors(col,:);
% 
%                         [lat,lon] = os2ll( [catchments(i).X], [catchments(i).Y] );
% 
%                         S_temp = catchments;
%                         S_temp(i).Lat = lat;
%                         S_temp(i).Lon = lon;
% 
%                         geoshow(S_temp(i),'FaceColor',col_,'EdgeColor',col_);
%                         scatter_points(1,i)=nanmean(lat);
%                         scatter_points(2,i)=nanmean(lon);
%                         scatter_points(3,i)=valsm_plot;
% 
% 
%                     end
%                 end
%             end
%         end
% 
%         % geoshow(S_lakes_mask,'FaceColor','white');
% %         scatterm(scatter_points(1,:),scatter_points(2,:),50,scatter_points(3,:),'filled','MarkerEdgeColor','k')
%         clim([-collims(1) collims(1)])
%         colormap(romamod)
%         % cbh = colorbar();
%         % % set(cbh,'XTick',(0:64:256)/256,'XTickLabel',{'0','64','128','192','256'})
%         % ylabel(cbh,'Change in Q99 flow (%)','FontSize',16)
% 
% 
% 
%         % pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
%         % colormap(lajolla)
%         % clim([0 15])
% 
% 
%         % mapshow(S_NI_lakes,'FaceColor',[1 1 1])
% 
%         % Adjust the plot
%         framem('FEdgeColor', 'black', 'FLineWidth', 1)
%         gridm('Gcolor',[0.3 0.3 0.3])
%         tightmap
%         box off
%         axis off
% 
%         geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);
% 
%         geoshow([S_NI.Y], [S_NI.X],'Color','black');
%         geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');
% 
%         % scatterm(54.7083, -7.5934,150,'k','filled')
%         % scatterm(54.7083, -7.5934,50,'w','filled')
%         % scatterm(54.7083, -7.5934,10,'k','filled')
%         % textm(54.7083, -7.5934,"Castlederg   ",'horizontalalignment','right','fontsize',14)
% 
%         title(['(',char(figure_ids(count)),') ',num2str(scenarios(s)/2+1),' °C Q99'])
% 
%         set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])
% 
%         count = count+1;
% 
% 
% 
%         subplot('position',locations(count,:))
%         % mort_580_MMM = squeeze(mort_data(:,:,1,1));
%         % popsize = squeeze(population_SSP5_2D(:,:,1,1));
% 
%         hold on
% 
%         % Set up axes
%         axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
%             'MapLonLim', lonlim, 'MLineLocation', 30,...
%             'PlineLocation', 30, 'MLabelParallel', 'south')
% 
%         geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
%         geoshow(S_lakes_mask,'FaceColor','white');
% 
% 
%         S_temp = catchments;
% 
%         colors = flipud(romamod);
% 
%         scatter_points = nan(3,30);
% 
%         for i = 1:length(catchments)
%             for j = 1:length(catchments)
% 
%                 if string(S_temp(i).ID_STRING) == num2str(table2array(Q50(j+2,1)))
% 
%                     vals1 = table2array(Q50([j+2, j+32],(4:8:92)+scenarios(s))); % +3 for 2°C, +7 for 4°C
%                     vals0 = table2array(Q50([j+2, j+32],4:8:92));
%                     vals = vals1-vals0;
%                     valsm_plot = mean(mean(vals./vals0*100));
% 
% 
%                     NSEVal = table2array(Q50([j+2, j+32],99));
%                     NSECal = table2array(Q50([j+2, j+32],100));
% 
% 
%                     if ~isnan(valsm_plot) && mean(NSECal >= 0.7)==1 && mean(NSEVal >= 0.7)==1
%                         col = round((valsm_plot+collims(1))/max(collims(2))*255)+1;
%                         if col<1 || col>256
%                             col = 1;
%                         end
%                         col_ = colors(col,:);
% 
%                         [lat,lon] = os2ll( [catchments(i).X], [catchments(i).Y] );
% 
%                         S_temp = catchments;
%                         S_temp(i).Lat = lat;
%                         S_temp(i).Lon = lon;
% 
%                         geoshow(S_temp(i),'FaceColor',col_,'EdgeColor',col_);
%                         scatter_points(1,i)=nanmean(lat);
%                         scatter_points(2,i)=nanmean(lon);
%                         scatter_points(3,i)=valsm_plot;
% 
%                     end
%                 end
%             end
%         end
% 
%         % geoshow(S_lakes_mask,'FaceColor','white');
% %         scatterm(scatter_points(1,:),scatter_points(2,:),50,scatter_points(3,:),'filled','MarkerEdgeColor','k')
%         clim([-collims(1) collims(1)])
%         colormap(romamod)
%         % cbh = colorbar();
%         % % set(cbh,'XTick',(0:64:256)/256,'XTickLabel',{'0','64','128','192','256'})
%         % ylabel(cbh,'Change in Q50 flow (%)','FontSize',16)
% 
% 
% 
%         % pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
%         % colormap(lajolla)
%         % clim([0 15])
% 
% 
%         % mapshow(S_NI_lakes,'FaceColor',[1 1 1])
% 
%         % Adjust the plot
%         framem('FEdgeColor', 'black', 'FLineWidth', 1)
%         gridm('Gcolor',[0.3 0.3 0.3])
%         tightmap
%         box off
%         axis off
% 
%         geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);
% 
%         geoshow([S_NI.Y], [S_NI.X],'Color','black');
%         geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');
% 
%         % scatterm(54.7083, -7.5934,150,'k','filled')
%         % scatterm(54.7083, -7.5934,50,'w','filled')
%         % scatterm(54.7083, -7.5934,10,'k','filled')
%         % textm(54.7083, -7.5934,"Castlederg   ",'horizontalalignment','right','fontsize',14)
% 
%         title(['(',char(figure_ids(count)),') ',num2str(scenarios(s)/2+1),' °C Q50'])
% 
%         set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])
% 
%         count = count+1;
% 
% 
% 
%         subplot('position',locations(count,:))
% 
%         hold on
% 
%         % Set up axes
%         axesm('MapProjection','Tranmerc', 'MapLatLim', latlim,...
%             'MapLonLim', lonlim, 'MLineLocation', 30,...
%             'PlineLocation', 30, 'MLabelParallel', 'south')
% 
%         geoshow(S_NI_mask,'FaceColor',[0.8 0.8 0.8]);
%         geoshow(S_lakes_mask,'FaceColor','white');
% 
% 
%         S_temp = catchments;
% 
%         colors = flipud(romamod);
% 
%         scatter_points = nan(3,30);
% 
%         for i = 1:length(catchments)
%             for j = 1:length(catchments)
% 
%                 if string(S_temp(i).ID_STRING) == num2str(table2array(Q01(j+2,1)))
% 
%                     vals1 = table2array(Q01([j+2, j+32],(4:8:92)+scenarios(s))); % +3 for 2°C, +7 for 4°C
%                     vals0 = table2array(Q01([j+2, j+32],4:8:92));
%                     vals = vals1-vals0;
%                     valsm_plot = mean(mean(vals./vals0*100));
% 
% 
%                     NSEVal = table2array(Q01([j+2, j+32],99));
%                     NSECal = table2array(Q01([j+2, j+32],100));
% 
% 
%                     if ~isnan(valsm_plot) && mean(NSECal >= 0.7)==1 && mean(NSEVal >= 0.7)==1
%                         col = round((valsm_plot+collims(1))/max(collims(2))*255)+1;
%                         if col<1 || col>256
%                             col = 1;
%                         end
%                         col_ = colors(col,:);
% 
%                         [lat,lon] = os2ll( [catchments(i).X], [catchments(i).Y] );
% 
%                         S_temp = catchments;
%                         S_temp(i).Lat = lat;
%                         S_temp(i).Lon = lon;
% 
%                         geoshow(S_temp(i),'FaceColor',col_,'EdgeColor',col_);
%                         scatter_points(1,i)=nanmean(lat);
%                         scatter_points(2,i)=nanmean(lon);
%                         scatter_points(3,i)=valsm_plot;
% 
%                     end
%                 end
%             end
%         end
% 
%         % geoshow(S_lakes_mask,'FaceColor','white');
% %         scatterm(scatter_points(1,:),scatter_points(2,:),50,scatter_points(3,:),'filled','MarkerEdgeColor','k')
%         clim([-collims(1) collims(1)])
%         colormap(romamod)
%         cbh = colorbar();
% %         set(cbh,'XTick',[-100,-50,0,50,100],'XTickLabel',{'100','75','0','75','100'})
% %         ylabel(cbh,{'Drier                                       Wetter';'Agreement on direction of change (%)'},'FontSize',16)
% 
% 
% 
%         % pcolorm(lat_UK_RCM,long_UK_RCM,mort_580_MMM)
%         % colormap(lajolla)
%         % clim([0 15])
% 
% 
%         % mapshow(S_NI_lakes,'FaceColor',[1 1 1])
% 
%         % Adjust the plot
%         framem('FEdgeColor', 'black', 'FLineWidth', 1)
%         gridm('Gcolor',[0.3 0.3 0.3])
%         tightmap
%         box off
%         axis off
% 
%         geoshow([S_NI_counties.Y], [S_NI_counties.X],'Color',[0.5 0.5 0.5]);
% 
%         geoshow([S_NI.Y], [S_NI.X],'Color','black');
%         geoshow([S_NI_lakes.Y], [S_NI_lakes.X],'Color','black');
% 
%         % scatterm(54.7083, -7.5934,150,'k','filled')
%         % scatterm(54.7083, -7.5934,50,'w','filled')
%         % scatterm(54.7083, -7.5934,10,'k','filled')
%         % textm(54.7083, -7.5934,"Castlederg   ",'horizontalalignment','right','fontsize',14)
% 
%         title(['(',char(figure_ids(count)),') ',num2str(scenarios(s)/2+1),' °C Q01'])
% 
%         set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])
% 
%         count = count+1;
%     end
