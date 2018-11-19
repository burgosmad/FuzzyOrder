function [equalizedW,memW]=alignMat(equalizedW,memW,indices)
[s1,s2,s3]=size(memW);
for k=1:s3
    temp=zeros(s1,s2);
    %memW(:,j,1);
    for j=1:s1

        temp(:,j)=(memW(:,indices(k,j),k));
        temp2(:,j)=(equalizedW(:,indices(k,j),k));
        
    end
    memW(:,:,k)=temp;
    equalizedW(:,:,k)=temp2;
end

end
