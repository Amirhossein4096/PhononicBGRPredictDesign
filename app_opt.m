function g = app_opt(bgr, bounds, net)
    % Load the neural network model
    % s = load('app_trained_net.mat', 'bestnet');
    % net = s.bestnet;
    
    % Set up the optimization bounds
    lb = [bounds(1,1), bounds(2,1), bounds(3,1)];
    ub = [bounds(1,2), bounds(2,2), bounds(3,2)];
    
    % Set nondefault solver options
    options = optimoptions("particleswarm", "PlotFcn", "pswplotbestf");
    
    % Solve using particleswarm, passing additional parameters
    [x, ~] = particleswarm(@(x) funs(x, bgr, net), 3, lb, ub, options);
    
    % Clear variables
    clearvars options
    
    % Return the result
    g = x;
end

% function y = fun(x, net)
%     y = -net(x');
% end

function y = funs(x, bgr, net)
    y = abs(bgr - net(x'));
end
