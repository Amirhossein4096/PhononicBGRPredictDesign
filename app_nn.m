function bgr=app_nn_test(g,net)
% s=load('app_trained_net.mat','bestnet');
% net = s.bestnet;
bgr=net(g');
end