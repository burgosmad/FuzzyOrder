function [indices]=RMSE_perm(MatMez,memW)
    [s1,s2,s3]=size(MatMez);
    indices=zeros(s3,6)
    for k=1:s3
        for i=1:s1
           % RMSE=1;
            RMSEw=1;
            y=MatMez(:,i,k);
            for j=1:s1
                
                yhat=memW(:,j,k);

                RMSE = sqrt(mean((y - yhat).^2));
                if (RMSE<RMSEw)&&(not(ismember(j,indices(k,:))))
                    indices(k,i)=j;
                    RMSEw=RMSE
                end
            end
        end
        
    end
end