function [SH]=Fuzzy_getSubsethood(M)
%Transitive hull of subsethood
%
%
%% Parameters
%
% M - Matrix of memberships of functions (rows) to criteria (columns)
%
%% Output
%
% SH - Matrix of pairwise subsethoods SH between functions
%
%
% date: 1-Mar-2017
% authors: Andrea, Felipe


nFunctions = size(M,1);
SH=nan(nFunctions);
for xx=1:nFunctions % First function visited
    denominator = sum(M(xx,:));
    if denominator==0;
        SH(xx,:)=1;
    else
        for  yy=1:nFunctions % Second function visited
            numerator=sum(min([M(xx,:);M(yy,:)]));
            SH(xx,yy)=numerator/denominator;
        end
    end
end


end
