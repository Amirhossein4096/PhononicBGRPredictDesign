function app_plot_unitcell(ax,pars)
% substrate_thick = 0.3;
% pillar_radius = 0.2;
% pillar_height = 1;
substrate_thick = pars(1);
pillar_radius = pars(2);
pillar_height = pars(3);
% Define the parameters for the box
position = [-0.5, -0.5, 0]; % Position of the box [x, y, z]
size = [1, 1, substrate_thick]; % Size of the box [width, height, depth]
transparency = 1; % Transparency level (0 for fully transparent, 1 for fully opaque)
FaceColor = [0.8,0.8,0.8];

% Create a figure
% figure;

% Define the vertices of the box
vertices = [position(1), position(2), position(3);
            position(1) + size(1), position(2), position(3);
            position(1) + size(1), position(2) + size(2), position(3);
            position(1), position(2) + size(2), position(3);
            position(1), position(2), position(3) + size(3);
            position(1) + size(1), position(2), position(3) + size(3);
            position(1) + size(1), position(2) + size(2), position(3) + size(3);
            position(1), position(2) + size(2), position(3) + size(3)];

% Define the faces of the box
faces = [1, 2, 3, 4;
         5, 6, 7, 8;
         1, 2, 6, 5;
         2, 3, 7, 6;
         3, 4, 8, 7;
         4, 1, 5, 8];
% Draw the box
hold(ax,'on')
patch(ax,'Vertices', vertices, 'Faces', faces, 'FaceColor', FaceColor, 'FaceAlpha', transparency, 'EdgeColor', [0,0,0],'LineWidth',0.5);
[X,Y,Z] = cylinder(pillar_radius,100);
Z=Z*pillar_height;
surf(ax,X,Y,Z+substrate_thick,EdgeColor="none",FaceColor=FaceColor)
hold(ax,'on')
fill3(ax,X,Y,Z(1,:)+substrate_thick,FaceColor)
hold(ax,'on')
fill3(ax,X,Y,Z(2,:)+substrate_thick,FaceColor)
axis(ax,"equal")
% camproj(ax,'perspective'); % Set perspective projection
% camPos = [9.62125894215963	4.35696410151135	3.77379898270116];  % Example camera position
% camTgt = [0	0	0.75];     % Example camera target
% campos(ax,camPos);         % Set camera position
% camtarget(ax,camTgt);      % Set camera target
xlim(ax,[-0.6,0.6])
ylim(ax,[-0.6,0.6])
zlim(ax,[0,substrate_thick+pillar_height+0.1])
camlight(ax)
% material(ax,"metal")
end