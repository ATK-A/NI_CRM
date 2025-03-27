S_all = shaperead('GSHHS_h_L1.shp');

latlim = [54 55.4];
lonlim = [-8.5 -5];

ids = zeros(length(S_all),1);

for i = 1:length(S_all)
    box = S_all(i).BoundingBox;
    if box(1,1) >= min(lonlim) && box(1,1) <= max(lonlim) || box(2,1) >= min(lonlim) && box(2,1) <= max(lonlim)
        if box(1,2) >= min(latlim) && box(1,2) <= max(latlim) || box(2,2) >= min(latlim) && box(2,2) <= max(latlim)
            ids(i) = 1;

        end
    end
end

S_NI = S_all(ids==1);


%%


S_counties = shaperead('georef-united-kingdom-county-unitary-authority-millesime.shp');

ids = zeros(length(S_counties),1);



for i = 1:length(S_counties)
    box = S_counties(i).BoundingBox;
    if box(1,1) >= min(lonlim) && box(1,1) <= max(lonlim) || box(2,1) >= min(lonlim) && box(2,1) <= max(lonlim)
        if box(1,2) >= min(latlim) && box(1,2) <= max(latlim) || box(2,2) >= min(latlim) && box(2,2) <= max(latlim)
            ids(i) = 1;

        end
    end
end

S_NI_counties = S_counties(ids==1);
S_NI_counties = S_NI_counties([1,3:5,8:14]);


%%
oldnames = {'Geometry','X','Y'};
newnames = {'Geometry','Lon','Lat'};

for j = 1:length(S_NI_lakes)
    for k=1:length(oldnames)

        S_lakes_mask(j).(newnames{k}) = S_NI_lakes(j).(oldnames{k}) ;
    end
end

for j = 1:length(S_NI)
    for k=1:length(oldnames)

        S_NI_mask(j).(newnames{k}) = S_NI(j).(oldnames{k}) ;
    end
end


