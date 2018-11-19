function [SHT]=Fuzzy_TransitiveHull(SH)
%Transitive hull of subsethood
%
%
%% Parameters
%
% SH - Matrix of subsethoods
%
%% Output
%
% SHT - Transitive hull of the matrix of subsethoods SH
%
%
% date: 1-Mar-2017
% authors: Andrea, Felipe

flagTransitive = false;

nFunctions = size(SH,1);
SHT=SH;
while ~flagTransitive
    for xx=1:nFunctions % First function visited
        for  zz=1:nFunctions % Second function visited
            SHT(xx,zz)=max(min([SHT(xx,:);SHT(:,zz)']));
        end
    end
    flagTransitive = Fuzzy_checkTransitivity(SHT);
end

end
