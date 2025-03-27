function [VP] = hurs2VP(hurs,T)
% [VP] = hurs2VP(hurs,T)
% 
% Convert relative humidity to vapour pressure using the equations listed
% in https://archive.eol.ucar.edu/projects/ceop/dm/documents/refdata_report/eqns.html
% 

% Correct RH to a fraction from % if necessary
if mean(mean(mean(hurs))) > 1
    hurs = hurs/100;
end

%% Calculate saturated vapour pressure
SVP = 6.112*exp((17.67*T)./(T + 243.5));

%% Calculate vapour pressure
VP = hurs .* SVP;

