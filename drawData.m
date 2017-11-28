function [] = drawData(dataCell, mu, sigma, compNo)
%This function plots the graphs for data and mixture of gaussians for each
%case
    xCoordinates = dataCell{1}';
    yCoordinates = dataCell{2}';

    for k=1:3   % For each gaussian case
        figure(k);
        hold on;

        plot(xCoordinates(1:1000), yCoordinates(1:1000), 'bo');
        plot(xCoordinates(1001:2000), yCoordinates(1001:2000), 'r+');
        plot(xCoordinates(2001:3000), yCoordinates(2001:3000), 'g*');
        legend('sample A', 'sample B', 'sample C');
        xlabel('x1')
        ylabel('x2')

        % Draw mixture of gaussians
        for i=1:3   % For each class
            muD = mu{i,k};
            sigmaD = sigma{i,k};
            for j=1:compNo  % For each component
                h = plotGaussianEllipsoid(muD(j,:), sigmaD(:,:,j));
                plot(muD(j,1), muD(j,2), 'k.');
                set(h, 'color' , 'k', 'linewidth', 2); 
            end
        end

        hold off;
    end

end

