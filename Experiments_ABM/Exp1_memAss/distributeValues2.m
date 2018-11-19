function [m]=distributeValues2(membership) 
    for j=1:6
        minValue = min(membership(:,j));
        maxValue = max(membership(:,j))+0.05;
        for i=1:6
           m(i,j)=(membership(i,j)-minValue)/(maxValue-minValue); 
           
        end
    end
end