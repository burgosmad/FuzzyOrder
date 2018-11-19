function [aimed]=generateAimedOrder(s,y)
    [ss,ss2]=size(s);
    [sy,sy2]=size(y);
    w=[0.05 0.1 0.5 1 0.25 0.25];
   % w=[0.05 0.1 0.5 1 0.25 ];
    SW=zeros(1,sy);
    for i=1:sy
        for j=1:sy
            if i>=5
                similitude(j,i)=1-max(xcorr(s(i,:),y(j,:),'coeff'));
                
            else
                similitude(j,i)=max(xcorr(s(i,:),y(j,:),'coeff'));
            end
            similitudew(j,i)=w(i)*similitude(j,i);
            SW(1,i)=SW(1,i)+similitudew(j,i);
        end
        %SW(i)=sum(similitudew(:,i));
        
    end
    r=(max(SW))/sy;
    SWtemp=SW;
    rTemp=0;
    for i=1:sy
        rTemp=r+rTemp;
        
        if i==sy
            groups{i,1}(1,:)=find(SW>rTemp-r);
            temp=find(SW>rTemp-r);
            
            %for k=1:length(temp)
             %   groups{i,1}(1,k)=SW(temp(1,k));
            %end
        else
             groups{i,1}(1,:)=intersect(find(SW<rTemp),find(SW>rTemp-r));
            temp=intersect(find(SW<rTemp),find(SW>rTemp-r));
            
        end
        for k=1:length(temp)
                groups{i,1}(2,k)=SW(temp(1,k));
            end
    end
    aimed=zeros(sy,sy);
    %sort(groups{2,1}(2,:))
    for i=1:sy
        clear a;
        clear val;
        if not(isempty(groups{i,1}))
             a=sort(groups{i,1}(2,:));
             for k=length(a):-1:1
                temp=find(groups{i,1}(2,:)==a(k));
                 val(k)=groups{i,1}(1,temp);
                
            end
            for l=length(val):-1:1
               for m=1:l-1
                   aimed(val(l),val(m))=1;
               end

            end
        end
        
    end
        %AGREGAR BOTTOM
    aimed=vertcat(aimed,[0,0,0,0,0,0]);
    %AGREGAR UN CRITERIO EN CEROS PARA QUE SEA MATRIZ CUADRADA
    aimed(:,7)=1;
    aimedDraw=aimed;
    %G=digraph(aimedDraw,'OmitSelfLoops');
    
    for i=1:sy
        for j=1:sy
            if i==j
                aimed(i,j)=1;
            end
        end
    end
  ind=1;
    
    for i=1:7
     %if not(isempty(aimed{1,i}))
         
         if i==7
             name{1,ind}=char(8869);
             %?
            
         else
             name{1,ind}=num2str(i);
            
         end
         ind=ind+1;
     %end
    end
    
     G=digraph(aimedDraw,name,'OmitSelfLoops');
     close all;
% % % figure;
% % % plot(G);
% % % %G=rmedge(G,2,7)
% % % %plot(G);
% % % gcf
% % % h = findobj(gca,'Type','line')
% % % h=get(gca,'Children')
% % % set(h,'MarkerSize',10)
% % % gca
% % % h=get(gca,'Children')
% % % gca
% % % set(gca,'FontSize',20)
% % % nl = h.NodeLabel;
% % % xd = get(h, 'XData');
% % % yd = get(h, 'YData');
% % % text(xd, yd, nl, 'FontSize',15,'Rotation',-45)
% % % title('Aimed');
% % % h.NodeLabel = '';
end