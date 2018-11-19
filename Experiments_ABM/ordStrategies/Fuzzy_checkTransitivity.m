function [flag]=Fuzzy_checkTransitivity(M)
%Checks the transivity of a matrix
%
% date: 1-Mar-2017
% authors: Andrea, Felipe


flag=true;
nFunctions = size(M,1);
display('Checking transitivity...')
for xx=1:nFunctions % First function visited
    for  zz=1:nFunctions % Second function visited
        if ~(all(min([M(xx,:);M(:,zz)']) <= M(xx,zz)))
            flag=false;
        end
    end
end

end
