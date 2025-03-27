%% Load data
mort_data = nan(82,112,3,12);

for i = 1:3
    if i == 1
        stat = 'MMM';
    elseif i == 2
        stat = 'MMlow';
    else
        stat = 'MMhigh';
    end

%     mort_data(:,:,i,1) = csvread(['Heat mortality/Baseline/Recent past/',stat,'0-99.csv']);
    mort_data(:,:,i,1) = csvread(['Heat mortality/Baseline/1981-2000/',stat,'0-99.csv']);
    mort_data(:,:,i,2) = csvread(['Heat mortality/Baseline/2C/',stat,'0-99.csv']);
    mort_data(:,:,i,3) = csvread(['Heat mortality/Baseline/4C/',stat,'0-99.csv']);
    mort_data(:,:,i,4) = csvread(['Heat mortality/SSP2/2050 2C/',stat,'0-99.csv']);
    mort_data(:,:,i,5) = csvread(['Heat mortality/SSP2/2080 2C/',stat,'0-99.csv']);
    mort_data(:,:,i,6) = csvread(['Heat mortality/SSP2/2080 4C/',stat,'0-99.csv']);
    mort_data(:,:,i,7) = csvread(['Heat mortality/SSP4/2050 2C/',stat,'0-99.csv']);
    mort_data(:,:,i,8) = csvread(['Heat mortality/SSP4/2080 2C/',stat,'0-99.csv']);
    mort_data(:,:,i,9) = csvread(['Heat mortality/SSP4/2080 4C/',stat,'0-99.csv']);
    mort_data(:,:,i,10) = csvread(['Heat mortality/SSP5/2050 2C/',stat,'0-99.csv']);
    mort_data(:,:,i,11) = csvread(['Heat mortality/SSP5/2080 2C/',stat,'0-99.csv']);
    mort_data(:,:,i,12) = csvread(['Heat mortality/SSP5/2080 4C/',stat,'0-99.csv']);
end

load('UKregions12.mat')
load('urb_frac_RCM.mat')


%% NI totals
NI_totals = nan(3,12,2);

for i = 1:12
    for j = 1:3
        mort_data_temp = squeeze(mort_data(:,:,j,i));
%         id = (UKregions12 == 12)*1 .* (urb_frac_RCM<=0.1)*1; % This rules out Belfast
        id = (UKregions12 == 12)*1 .* (urb_frac_RCM<=0.025)*1; % This rules out Belfast, Bangor, Lisburn, Derry and Newry
        NI_totals(j,i,1) = nansum(nansum(mort_data_temp(UKregions12 == 12)));
        NI_totals(j,i,2) = nansum(nansum(mort_data_temp(id==1)));
    end
end

%% figure
red = [0.850000000000000,0.0872549042105675,0];
orange = [1,0.400000005960465,0.200000002980232];
green = [0.530028571428571,0.749114285714286,0.466114285714286];
blue = [0.0585574759170413,0.364924505352974,0.679114878177643];
grey = [0.6 0.6 0.6];
lgrey = [0.8 0.8 0.8];

figure
subplot(1,2,2)
hold on
mort_pc_diff = NI_totals(:,:,2)./NI_totals(:,:,1)*100;

% Plot for legend
plot(1.5,mort_pc_diff(1,1),'ok','MarkerFaceColor',lgrey,MarkerSize=10)
plot([2],mort_pc_diff(1,[2]),'ok','MarkerFaceColor',blue,MarkerSize=10)
plot([2.5],mort_pc_diff(1,[3]),'ok','MarkerFaceColor',red,MarkerSize=10)

plot([4.5,7.5,10.5],mort_pc_diff(1,[4,7,10]),'^k','MarkerFaceColor',blue,MarkerSize=10)
plot([5,8,11],mort_pc_diff(1,[5,8,11]),'sk','MarkerFaceColor',blue,MarkerSize=10)
plot([5.5,8.5,11.5],mort_pc_diff(1,[6,9,12]),'sk','MarkerFaceColor',red,MarkerSize=10)


plot(repmat([1.5 2 2.5 4.5 5 5.5 7.5 8 8.5 10.5 11 11.5],2,1),mort_pc_diff([2,3],:),'-k','linewidth',3)

plot(1.5,mort_pc_diff(1,1),'ok','MarkerFaceColor',lgrey,MarkerSize=10)
plot([2],mort_pc_diff(1,[2]),'ok','MarkerFaceColor',blue,MarkerSize=10)
plot([4.5,7.5,10.5],mort_pc_diff(1,[4,7,10]),'^k','MarkerFaceColor',blue,MarkerSize=10)
plot([5,8,11],mort_pc_diff(1,[5,8,11]),'sk','MarkerFaceColor',blue,MarkerSize=10)
plot([5.5,8.5,11.5],mort_pc_diff(1,[6,9,12]),'sk','MarkerFaceColor',red,MarkerSize=10)
plot([2.5],mort_pc_diff(1,[3]),'ok','MarkerFaceColor',red,MarkerSize=10)

set(gca,'XTick',[2,5,8,11],'XTickLabel',{'Baseline','SSP2','SSP4','SSP5'})
ylabel('Percentage of deaths in rural areas')
box on
legend('Baseline population and climate','Baseline population, 2 °C','Baseline population, 4 °C','2050 population, 2 °C','2080 population, 2 °C','2080 population, 4 °C')
title('(b)')
set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])


subplot(1,2,1)
hold on
% Plot for legend
mort_pc_diff = NI_totals(:,:,1);

plot(1.5,mort_pc_diff(1,1),'ok','MarkerFaceColor',lgrey,MarkerSize=10)
plot([2],mort_pc_diff(1,[2]),'ok','MarkerFaceColor',blue,MarkerSize=10)
plot([2.5],mort_pc_diff(1,[3]),'ok','MarkerFaceColor',red,MarkerSize=10)

plot([4.5,7.5,10.5],mort_pc_diff(1,[4,7,10]),'^k','MarkerFaceColor',blue,MarkerSize=10)
plot([5,8,11],mort_pc_diff(1,[5,8,11]),'sk','MarkerFaceColor',blue,MarkerSize=10)
plot([5.5,8.5,11.5],mort_pc_diff(1,[6,9,12]),'sk','MarkerFaceColor',red,MarkerSize=10)


plot(repmat([1.5 2 2.5 4.5 5 5.5 7.5 8 8.5 10.5 11 11.5],2,1),mort_pc_diff([2,3],:),'-k','linewidth',3)

plot(1.5,mort_pc_diff(1,1),'ok','MarkerFaceColor',lgrey,MarkerSize=10)
plot([2],mort_pc_diff(1,[2]),'ok','MarkerFaceColor',blue,MarkerSize=10)
plot([4.5,7.5,10.5],mort_pc_diff(1,[4,7,10]),'^k','MarkerFaceColor',blue,MarkerSize=10)
plot([5,8,11],mort_pc_diff(1,[5,8,11]),'sk','MarkerFaceColor',blue,MarkerSize=10)
plot([5.5,8.5,11.5],mort_pc_diff(1,[6,9,12]),'sk','MarkerFaceColor',red,MarkerSize=10)
plot([2.5],mort_pc_diff(1,[3]),'ok','MarkerFaceColor',red,MarkerSize=10)

set(gca,'XTick',[2,5,8,11],'XTickLabel',{'Baseline','SSP2','SSP4','SSP5'})
ylabel('Annual heat-related mortality')
box on
% legend('Baseline population and climate','Baseline population, 2 °C','Baseline population, 4 °C','2050 population, 2 °C','2080 population, 2 °C','2080 population, 4 °C')
title('(a)')

set(gcf, 'color', 'w');
set(gca,'fontsize',16)% set(gca,'xlim',[1 12],'ylim',[36 39])


