function gaborArray = createGaborfilter(u,v,m,n)
global gaborFigFil
if (nargin ~= 4)
    error('The number of parameters must be 4, that is number of scales, number of orientations, and 2 dimensional size of the filter')
end

gaborArray = cell(u,v);
fmax = 0.25;
gama = sqrt(2);
eta = sqrt(2);

for i = 1:u    
    fu = fmax/((sqrt(2))^(i-1));
    alpha = fu/gama;
    beta = fu/eta;
    
    for j = 1:v
        tetav = ((j-1)/v)*pi;
        gFilter = zeros(m,n);
        
        for x = 1:m
            for y = 1:n
                xprime = (x-((m+1)/2))*cos(tetav)+(y-((n+1)/2))*sin(tetav);
                yprime = -(x-((m+1)/2))*sin(tetav)+(y-((n+1)/2))*cos(tetav);
                gFilter(x,y) = (fu^2/(pi*gama*eta))*exp(-((alpha^2)*(xprime^2)+(beta^2)*(yprime^2)))*exp(1i*2*pi*fu*xprime);
            end
        end
        
        gaborArray{i,j} = gFilter;
        gaborFigFil{i,j} = gaborArray{i,j};
    end
end

% %% Show Gabor filter results if needed
% 
% % Show magnitudes of Gabor filters:
% figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
% for i = 1:u
%     for j = 1:v        
%         subplot(u,v,(i-1)*v+j);        
%         imshow(abs(gaborArray{i,j}),[]);
%     end
% end
% 
% % Show real parts of Gabor filters:
% figure('NumberTitle','Off','Name','Real parts of Gabor filters');
% for i = 1:u
%     for j = 1:v        
%         subplot(u,v,(i-1)*v+j);        
%         imshow(real(gaborArray{i,j}),[]);
%     end
% end