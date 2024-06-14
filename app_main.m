function app_main()
 % Create the figure and grid layout
s=load('app_trained_net.mat','bestnet');
net = s.bestnet;
% load('app_trained_net.mat','bestnet');
% net = bestnet;
fig = uifigure('Position', [100 100 900 500],'Icon','app_icon.png','Resize','off');
% fig.Color='#0A0A0A';
fig.Renderer ="opengl";
fig.FileName = 'bandgap ratio Prediction and inverse design of pillared phononic crystal';
fig.Name = 'bandgap ratio Prediction and inverse design of pillared phononic crystal';
grid1 = uigridlayout(fig, [1 2]);
grid1.ColumnWidth = {320, '1x'};
movegui(fig, 'center');

% Create the tab group for configuration on the left side
tabGroup = uitabgroup(grid1);
tabGroup.Layout.Row = 1;
tabGroup.Layout.Column = 1;
% Create tabs
tab1 = uitab(tabGroup, 'Title', 'Prediction');
tab1.Scrollable = 'on';
tab2 = uitab(tabGroup, 'Title', 'Inverse design');
tab2.Scrollable = 'on';
% tab1.Tooltip = 'Prediction of bandgap ratio based on geometric characteristics with trained neural network';
% tab2.Tooltip = 'Inverse design of phononic crystal for desired bandgap ratio by optimization of neural network trained with particle swarm algorithm';
% Create grid layout for the first tab
grid2_tab1 = uigridlayout(tab1, [6 2]);
grid2_tab1.RowHeight = {50, 50, 50, 30, 30, 30};
grid2_tab1.ColumnWidth = {90, '1x'};

% Create grid layout for the second tab
grid2_tab2 = uigridlayout(tab2, [9 2]);
grid2_tab2.RowHeight = {50, 50, 50, 50, 30, 30, 30, 30, 30};
grid2_tab2.ColumnWidth = {90, '1x'};
% Create the axes on the right side
ax = uiaxes(grid1);
title(ax,'Unit Cell Geometry','FontName','Times New Roman','FontSize',16);
camproj(ax, 'perspective'); % Set perspective projection
camPos = [9.62125894215963, 4.35696410151135, 3.77379898270116];  % Example camera position
campos(ax, camPos);         % Set camera position
fig.UserData.pars = [0.3, 0.2, 1];  % Initialize pars and store in UserData
fig.UserData.opars = 0;
fig.UserData.MinEdgeLength = 0.01;
fig.UserData.MaxEdgeLength = 0.05;
app_plot_unitcell(ax, fig.UserData.pars);

% Prediction Tab UI Elements
gelabel1 = uilabel(grid2_tab1);
gelabel1.HorizontalAlignment = 'center';
gelabel1.Text = 'e/a Parameter';

geomesld1 = uislider(grid2_tab1);
geomesld1.Limits = [0.02 1];
geomesld1.MajorTicks = [0.02 0.2 0.4 0.6 0.8 1];
geomesld1.Value = 0.3;


grlabel1 = uilabel(grid2_tab1);
grlabel1.HorizontalAlignment = 'center';
grlabel1.Text = 'r/a Parameter';

geomrsld1 = uislider(grid2_tab1);
geomrsld1.Limits = [0.02, 0.5];
geomrsld1.MajorTicks = [0.02 0.1 0.2 0.3 0.4 0.5];
geomrsld1.Value = 0.2;


ghlabel1 = uilabel(grid2_tab1);
ghlabel1.HorizontalAlignment = 'center';
ghlabel1.Text = 'h/a Parameter';

geomhsld1 = uislider(grid2_tab1);
geomhsld1.Limits = [0.02 5];
geomhsld1.MajorTicks = [0.02 1 2 3 4 5];
geomhsld1.Value = 1;


% Inverse Design Tab UI Elements
gelabel2 = uilabel(grid2_tab2);
gelabel2.HorizontalAlignment = 'center';
gelabel2.Text = 'e/a Parameter';
gelabel2.Tooltip = 'Setting the desired range of parameter e/a for inverse design';


geomesld2 = uislider(grid2_tab2, "range");
geomesld2.Limits = [0.02 1];
geomesld2.MajorTicks = [0.02 0.2 0.4 0.6 0.8 1];
geomesld2.Value = [0.02 1];

grlabel2 = uilabel(grid2_tab2);
grlabel2.HorizontalAlignment = 'center';
grlabel2.Text = 'd/a Parameter';
grlabel2.Tooltip = 'Setting the desired range of parameter d/a for inverse design';


geomrsld2 = uislider(grid2_tab2, "range");
geomrsld2.Limits = [0.04, 1];
geomrsld2.MajorTicks = [0.04 0.2 0.4 0.6 0.8 1];
geomrsld2.Value = [0.04 1];

ghlabel2 = uilabel(grid2_tab2);
ghlabel2.HorizontalAlignment = 'center';
ghlabel2.Text = 'h/a Parameter';
ghlabel2.Tooltip = 'Setting the desired range of parameter h/a for inverse design';


geomhsld2 = uislider(grid2_tab2, "range");
geomhsld2.Limits = [0.02 5];
geomhsld2.MajorTicks = [0.02 1 2 3 4 5];
geomhsld2.Value = [0.02 5];

% Common Rate Label and edit field for both tabs
plotlabel1 = uilabel(grid2_tab1);
plotlabel1.Visible = "on";
plotlabel1.HorizontalAlignment = 'center';
plotlabel1.Text = 'bandgap ratio';

bgref1 = uieditfield(grid2_tab1, "numeric");
bgref1.HorizontalAlignment = 'center';
bgref1.Editable = "off";
bgref1.Tooltip = 'Predicted bandgap ratio based on geometric characteristics with trained neural network';
bgref1.Value = app_nn(fig.UserData.pars,net);
geomesld1.ValueChangingFcn = {@changee, ax, fig,bgref1,net};
geomrsld1.ValueChangingFcn = {@changer, ax, fig,bgref1,net};
geomhsld1.ValueChangingFcn = {@changeh, ax, fig,bgref1,net};
% geomesld1.ValueChangedFcn = {@(src, event) bgrfield(src, bgref1, fig,net);};
% geomrsld1.ValueChangedFcn = {@(src, event) bgrfield(src, bgref1, fig,net);};
% geomhsld1.ValueChangedFcn = {@(src, event) bgrfield(src, bgref1, fig,net);};

plotlabel2 = uilabel(grid2_tab2);
plotlabel2.Visible = "on";
plotlabel2.HorizontalAlignment = 'center';
plotlabel2.Text = 'bandgap ratio';
plotlabel2.Tooltip = 'desired bandgap ratio';


bgrsld2 = uislider(grid2_tab2);
bgrsld2.Limits = [0 0.5];
bgrsld2.MajorTicks = [0 0.1 0.2 0.3 0.4 0.5];
bgrsld2.Value = app_nn(fig.UserData.pars,net);

calcoptlabel1 = uilabel(grid2_tab2);
calcoptlabel1.Visible = "on";
calcoptlabel1.HorizontalAlignment = 'center';
calcoptlabel1.Text = 'Inverse design';
calcoptbtn = uibutton(grid2_tab2,"push","Text",'Calclulate');
calcoptbtn.Tooltip = 'Performing inverse design based on optimization of neural network trained with particle swarm algorithm';

ealabel2 = uilabel(grid2_tab2);
ealabel2.Visible = "on";
ealabel2.HorizontalAlignment = 'center';
ealabel2.Text = 'e/a Parameter';
eaef2 = uieditfield(grid2_tab2, "numeric");
eaef2.HorizontalAlignment = 'center';
eaef2.Editable = "off";
eaef2.Tooltip = 'The e/a parameter obtained from the inverse design';

ralabel2 = uilabel(grid2_tab2);
ralabel2.Visible = "on";
ralabel2.HorizontalAlignment = 'center';
ralabel2.Text = 'r/a Parameter';
raef2 = uieditfield(grid2_tab2, "numeric");
raef2.HorizontalAlignment = 'center';
raef2.Editable = "off";
raef2.Tooltip = 'The r/a parameter obtained from the inverse design';

halabel2 = uilabel(grid2_tab2);
halabel2.Visible = "on";
halabel2.HorizontalAlignment = 'center';
halabel2.Text = 'h/a Parameter';
haef2 = uieditfield(grid2_tab2, "numeric");
haef2.HorizontalAlignment = 'center';
haef2.Editable = "off";
haef2.Tooltip = 'The h/a parameter obtained from the inverse design';
calcoptbtn.ButtonPushedFcn = @(src, event) calculateOptimization(src, geomesld2, geomrsld2, geomhsld2,bgrsld2, eaef2, raef2, haef2, ax, fig, net);
tabGroup.SelectionChangedFcn = @(src, event) tabSelectionChanged(src, event,fig,ax , tab1, tab2, eaef2, raef2, haef2);

viewlabel1 = uilabel(grid2_tab1);
viewlabel1.Visible = "on";
viewlabel1.HorizontalAlignment = 'center';
viewlabel1.Text = 'View type';
viewbtn1 = uibutton(grid2_tab1,"state",Text="Perspective");
viewbtn1.ValueChangedFcn = @(src,event) viewButtonclicked(src,event,viewbtn1,ax);

exportsetbtn1 = uibutton(grid2_tab1,"push",Text="STL Setting");
exportsetbtn1.ButtonPushedFcn = @(src,event) openSmallWindow(src,event,fig);
exportbtn1 = uibutton(grid2_tab1,"push",Text="Save STL file");
exportbtn1.ButtonPushedFcn = @(src,event) exportButtonPushed(src,event,fig);
exportsetbtn1 = uibutton(grid2_tab2,"push",Text="STL Setting");
exportsetbtn1.ButtonPushedFcn = @(src,event) openSmallWindow(src,event,fig);
exportbtn1 = uibutton(grid2_tab2,"push",Text="Save STL file");
exportbtn1.ButtonPushedFcn = @(src,event) exportButtonPushedopt(src,event,fig);


% grid1.BackgroundColor='#0A0A0A';
% grid2_tab1.BackgroundColor='#0A0A0A';
% grid2_tab2.BackgroundColor='#0A0A0A';
% tab1.BackgroundColor='#0A0A0A';
% tab1.ForegroundColor='#0A0A0A';
% tab2.BackgroundColor='#0A0A0A';
% tab2.ForegroundColor='#0A0A0A';
% ax.Color ='#0A0A0A';
% ax.XColor = 'w';
% ax.YColor = 'w';
% ax.ZColor = 'w';
% gelabel1.FontColor = 'w';
% grlabel1.FontColor = 'w';
% ghlabel1.FontColor = 'w';
% gelabel2.FontColor = 'w';
% grlabel2.FontColor = 'w';
% ghlabel2.FontColor = 'w';
% geomesld1.FontColor = 'w';
% geomrsld1.FontColor = 'w';
% geomhsld1.FontColor = 'w';
% geomesld2.FontColor = 'w';
% geomrsld2.FontColor = 'w';
% geomhsld2.FontColor = 'w';
% ealabel2.FontColor='w';
% ralabel2.FontColor='w';
% halabel2.FontColor='w';
% ax.Title.Color='w';
% plotlabel1.FontColor = 'w';
% plotlabel2.FontColor = 'w';
% bgrsld2.FontColor = 'w';
% viewlabel1.FontColor = 'w';
% calcoptlabel1.FontColor ='w';

function openSmallWindow(~,~,fig)
        % Create the small figure window
        smallFig = uifigure('Name', 'Small Window', 'Position', [500, 300, 500, 200],'Resize','off');
        grid_small = uigridlayout(smallFig, [3 2],"ColumnWidth",{130,'1x'});
        % Create two sliders in the small window
        minlabel1 = uilabel(grid_small);
        minlabel1.HorizontalAlignment = 'left';
        minlabel1.Text = 'Minimum Edge Length';
        minlabel1.Tooltip = 'Minimum edge length of triangles in mesh';
        minslider1 = uislider(grid_small);
        minslider1.Limits = [0.002 0.1];
        minslider1.Value = fig.UserData.MinEdgeLength;
        maxlabel1 = uilabel(grid_small);
        maxlabel1.HorizontalAlignment = 'left';
        maxlabel1.Text = 'Maximum Edge Length';
        maxlabel1.Tooltip = 'Maximum edge length of triangles in mesh';
        maxslider1 = uislider(grid_small);
        maxslider1.Limits = [0.002 0.1];
        maxslider1.Value = fig.UserData.MaxEdgeLength;
        % Create a button to close the small window
        btnClose = uibutton(grid_small,'Text', 'Save STL Configuration', 'ButtonPushedFcn', @(src, event) saveAndClose(fig, smallFig, minslider1, maxslider1));
        btnClose.Layout.Row = 3;
        btnClose.Layout.Column = [1,2];
    end

function saveAndClose(fig, smallFig, minslider1, maxslider1)
        % Save slider values to the main figure's UserData
        fig.UserData.MinEdgeLength = minslider1.Value;
        fig.UserData.MaxEdgeLength = maxslider1.Value;
        % Close the small window
        close(smallFig);
end

function exportButtonPushedopt(~,~,fig)
if size(fig.UserData.opars,2)==3
pars = fig.UserData.opars;
meshout = app_export_stl(pars,fig);
[p,t] = exportMesh(meshout);
tr = triangulation(t(:,1:3),p);
filter = {'*.stl'};
[file,location,~] = uiputfile(filter,'Export unitcell as STL file','unitcell');
filename = fullfile(location,file);
stlwrite(tr,filename);
end
end

function exportButtonPushed(~,~,fig)
pars = fig.UserData.pars;
meshout = app_export_stl(pars,fig);
[p,t] = exportMesh(meshout);
tr = triangulation(t(:,1:3),p);
filter = {'*.stl'};
[file,location,~] = uiputfile(filter,'Export unitcell as STL file','unitcell');
filename = fullfile(location,file);
stlwrite(tr,filename);
end
% Callback functions
function viewButtonclicked(~,~,viewbtn,ax)
if viewbtn.Value==0
    camproj(ax, 'Perspective');
    viewbtn.Text = 'Perspective';
else
    camproj(ax, 'Orthographic');
    viewbtn.Text = 'Orthographic';
end
end

function changee(~, event, ax, fig,bgref1,net)
    pars = fig.UserData.pars;
    pars(1) = event.Value;
    fig.UserData.pars = pars;
    cla(ax);
    app_plot_unitcell(ax, pars);
    bgref1.Value = app_nn(pars,net);
end

function changer(~, event, ax, fig,bgref1,net)
    pars = fig.UserData.pars;
    pars(2) = event.Value;
    fig.UserData.pars = pars;
    cla(ax);
    app_plot_unitcell(ax, pars);
    bgref1.Value = app_nn(pars,net);
end

function changeh(~, event, ax, fig,bgref1,net)
    pars = fig.UserData.pars;
    pars(3) = event.Value;
    fig.UserData.pars = pars;
    cla(ax);
    app_plot_unitcell(ax, pars);
    bgref1.Value = app_nn(pars,net);
end

% function bgrfield(~, event, fig,net)
%     pars = fig.UserData.pars;
%     bgr = app_nn(pars,net);
%     event.Value = bgr;
% end

function tabSelectionChanged(src, ~,fig, ax, tab1, tab2, eaef2, raef2, haef2)
    if src.SelectedTab == tab1
        pars = fig.UserData.pars;
        cla(ax)
        app_plot_unitcell(ax, pars);
        % Perform actions specific to Prediction tab
    elseif src.SelectedTab == tab2
        if eaef2.Value==0 || raef2.Value==0 || haef2.Value==0
            cla(ax)
        else
            cla(ax)
            app_plot_unitcell(ax, [eaef2.Value,raef2.Value,haef2.Value]);
        end
        % Perform actions specific to Inverse Design tab
    end
end

% Callback function for the "Calculate" button
function calculateOptimization(~, geomesld2, geomrsld2, geomhsld2,bgrsld2, eaef2, raef2, haef2, ax,fig,net)
    bounds = [geomesld2.Value;geomrsld2.Value/2;geomhsld2.Value];
    pars = app_opt(bgrsld2.Value,bounds,net);
    fig.UserData.opars = pars;
    % Optionally, update other parameters or perform calculations
    % based on the updated values.
    eaef2.Value = pars(1);
    raef2.Value = pars(2);
    haef2.Value = pars(3);
    % Update the plot with the new parameters
    cla(ax);
    app_plot_unitcell(ax, pars);
end
end