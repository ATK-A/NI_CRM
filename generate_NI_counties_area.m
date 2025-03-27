%% Create area weigthing
if ~exist('counties_all_12_tidy','var')
    generate_NI_counties
end
generate_UK_latlon_area

% lats_ERA5a = rot90(lats_ERA5,3);
% lons_ERA5a = rot90(lons_ERA5,3);
% lats_ERA5La = rot90(lats_ERA5L,3);
% lons_ERA5La = rot90(lons_ERA5L,3);

% Calculate absolute area
% areas_ERA5_sub = calc_latlon_area(lats_ERA5a,lons_ERA5a,'areaquad');
% areas_ERA5_sub = calc_latlon_area(lats_ERA5,lons_ERA5,'areaquad');
% areas_ERA5L_sub = calc_latlon_area(lats_ERA5La,lons_ERA5La,'areaquad');
% areas_ERA5L_sub = calc_latlon_area(lats_ERA5L,lons_ERA5L,'areaquad');
areas_Had12_sub = areas_RCM_abs(18:33,48:60);

% areas_counties = nan(29,17,12);
% areas_countiesL = nan(41,21,12);
areas_counties12 = nan(16,13,12);

for c = 1:11
%     areas_counties(:,:,c) = areas_ERA5_sub.*(rot90(counties_all_ERA5,3) == c)./nansum(nansum(areas_ERA5_sub(rot90(counties_all_ERA5,3) == c)));
%     areas_countiesL(:,:,c) = areas_ERA5L_sub.*(rot90(counties_all_ERA5L_tidy,3) == c)./nansum(nansum(areas_ERA5L_sub(rot90(counties_all_ERA5L_tidy,3) == c)));
    areas_counties12(:,:,c) = areas_Had12_sub.*((counties_all_12_tidy) == c)./nansum(nansum(areas_Had12_sub((counties_all_12_tidy) == c)));
end

% areas_counties_12a = areas_counties12(18:33,48:60,:);

% areas_countiesL(:,:,12) = areas_ERA5L_sub.*((NI_mask_ERA5La))./nansum(nansum(areas_ERA5L_sub((NI_mask_ERA5La==1))));
areas_counties12(:,:,12) = areas_Had12_sub.*(NI_mask_12)./nansum(nansum(areas_Had12_sub(NI_mask_12)));
