%
color_code = ['b','k','r','g','m','y','c'];

load('gesture_dataset.mat');
%gesture_l
[pts_no, rep_no, dim_no] = size(gesture_l);
K = 7;
classes_l = kmeans(gesture_l, init_cluster_l, K);

figure(1);
for r=1:rep_no
    x = gesture_l(:,r,1);
    x = reshape(x, [pts_no, 1]);
    y = gesture_l(:,r,2); 
    y = reshape(y, [pts_no, 1]);
    plot(x,y,color_code(classes_l(r)));
    hold on;
end
