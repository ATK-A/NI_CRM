% Calculate milk yield loss for NI. Some manual data tidying is required
% before it is saved as a .csv ready for use in the Shiny App.

%% Load data
if ~exist('THI_reg','var')
    load_arnell_paris_years_THImean
end
if ~exist('counties12','var')
    generate_NI_counties_area
    generate_region_latlon_area
end


%% Find how many days exceed threshold of THI = 70
% Threshold used by Garry et al.

counties_list = {'Antrim and Newtownabbey';'Armagh City, Banbridge and Craigavon';'Belfast';'Causeway Coast and Glens';'Derry City and Strabane';'Fermanagh and Omagh';'Lisburn and Castlereagh';'Mid and East Antrim';'Mid Ulster';'Newry, Mourne and Down';'Ards and North Down'};

THI_days = nan(12,15); % areas x scenario (min, mean, max)

for scen = 1:5
    THI_days(:,1+(scen-1)*3) = nanmin(sum(THI_reg(:,scen,:,:)>70,4),[],3)/30;
    THI_days(:,2+(scen-1)*3) = nanmean(sum(THI_reg(:,scen,:,:)>70,4),3)/30;
    THI_days(:,3+(scen-1)*3) = nanmax(sum(THI_reg(:,scen,:,:)>70,4),[],3)/30;
end



%% Calculate milk loss using lagged method

% Find extreme days where daily mean THI exceeds 68
THI_ex_days = (THI_reg>=68)*1;

% Find lagged effect:
THI_ex_days_max = cat(5,THI_ex_days,cat(4,nan(12,5,12),THI_ex_days(:,:,:,1:end-1)),...
    cat(4,nan(12,5,12,2),THI_ex_days(:,:,:,1:end-2)),cat(4,nan(12,5,12,3),THI_ex_days(:,:,:,1:end-3)));

% Find which daily lagged effect is greatest
THI_ex_days_max = nanmax(THI_ex_days_max,[],5);

% Find how much each daily mean THI exceeds 68 by
data = THI_reg - 68;

% Find lagged effect:
data_max = cat(5,data,cat(4,nan(12,5,12),data(:,:,:,1:end-1)),...
    cat(4,nan(12,5,12,2),data(:,:,:,1:end-2)),cat(4,nan(12,5,12,3),data(:,:,:,1:end-3)));

% Find which daily lagged effect is greatest
data_max = nanmax(data_max,[],5);

% Find equivalent of a degree day metric (THI days)
THI_Ddays = sum(data.*THI_ex_days,4);
THI_Ddays_max = sum(data_max.*THI_ex_days_max,4);

%% Assess variability
data_to_plot = data_max.*THI_ex_days_max;
THI_Ddays_std = std(data_max.*THI_ex_days_max,[],4);
THI_Ddays_mean = mean(data_max.*THI_ex_days_max,4);
THI_Ddays_max = max(data_max.*THI_ex_days_max,[],4);

THI_Ddays_ratio = THI_Ddays_max./THI_Ddays_mean;
THI_Ddays_MMM_std = nanmean(THI_Ddays_std(:,:,:),3);
THI_Ddays_MMM_cv = nanmean(THI_Ddays_std./THI_Ddays_mean,3);
THI_Ddays_MMM_ratio = nanmean(THI_Ddays_ratio(:,:,:),3);

% Figure
figure
set(gcf, 'color', 'w');
for i = 1:12
subplot(4,3,i)
hold on
plot((1:10957)/365.25-0.4,squeeze(data_to_plot(12,3,i,:))','-')
plot((1:10957)/365.25,squeeze(data_to_plot(12,5,i,:))','-')
ylim([0 15])
xlim([0 30])
box on
set(gca,'fontsize',16)
xlabel('Year of simulation')
ylabel('THI degree days > 68')
end


%% Calculate losses of milk yield
THI_Ddays_max = sum(data_max.*THI_ex_days_max,4);

Loss_reg_max = nanmax(THI_Ddays_max(:,:,:),[],3)/30 *-0.15;
Loss_reg_mean = nanmean(THI_Ddays_max(:,:,:),3)/30 *-0.15;
Loss_reg_min = nanmin(THI_Ddays_max(:,:,:),[],3)/30 *-0.15;


%% Calculate change in milk yield
% UK average currently per cow per year:
current_milk_yield = 8000*1.03; % Based on https://ahdb.org.uk/dairy/uk-milk-yield and Googling the density of milk

% % Change in average number of THI/days > 70
% THI_change = mean(THI_days(:,:,2,:),4) - mean(THI_days(:,:,1,:),4);
% THI_change_max = mean(THI_days_max(:,:,2,:),4) - mean(THI_days_max(:,:,1,:),4);
% 
% % Convert to per day
% THI_change = THI_change/10957;
% THI_change_max = THI_change_max/10957;
% 
% % Calculate milk reduction based upon Wildridge et al 2018.
% THI_impact = THI_change*-0.15;
% THI_impact_max = THI_change_max*-0.15;
% 
% % NI monthly average production stats from DAERA:
% annual_prod_cycle = [162.21,155.43,180.36,189.00,208.59,194.05,184.78,164.14,144.75,143.14,140.91,155.13];
% annual_prod_frac = annual_prod_cycle / sum(annual_prod_cycle);
% 
% monthly_milk_yield = annual_prod_frac * current_milk_yield;
% 
% summer_frac_milk_yield = sum(monthly_milk_yield(6:8))/sum(monthly_milk_yield);
% 
% summer_daily_yield = current_milk_yield * summer_frac_milk_yield / 92;


%% Bit of extra variability analysis
% Find annual total DDs with simple assumption that year is 365 days long
% This assumption will only affect any DDs within 1 week of 31st Dec (not
% going to be an issue for THI)

THI_ann = nan(12,30);
for i = 1:12 % Go through each model
    thismod = squeeze(data_to_plot(12,5,i,:)); % ID 12 = NI, 5 = 4 °C
    for j = 1:30 % Go through each year
        ids = 1+(j-1)*365:365+(j-1)*365; % Simple ID, skipping leap year but shouldn't be an issue in this context
        THI_ann(i,j) = sum(thismod(ids));
    end
end

