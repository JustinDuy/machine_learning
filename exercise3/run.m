%
color_code = ['b','k','r','g','m','y','c'];

load('gesture_dataset.mat');
%reshape gesture data
[pts_no, rep_no, dim_no] = size(gesture_l);
gesture_l = reshape(gesture_l, [pts_no * rep_no, dim_no]);
gesture_o = reshape(gesture_o, [pts_no * rep_no, dim_no]);
gesture_x = reshape(gesture_x, [pts_no * rep_no, dim_no]);

pts_no = pts_no * rep_no;
K = 7;
classes_l = kmeans(gesture_l, init_cluster_l, K);
classes_o = kmeans(gesture_o, init_cluster_o, K);
classes_x = kmeans(gesture_x, init_cluster_x, K);

figure(1)
subplot(3,2,1)
title('k-means - l gesture');
for pts = 1: pts_no
    x = gesture_l(pts,1);
    y = gesture_l(pts,2); 
    scatter(x,y,color_code(classes_l(pts)));
    hold on;
end

subplot(3,2,2)
title('k-means - o gesture');
for pts = 1: pts_no
    x = gesture_o(pts,1);
    y = gesture_o(pts,2); 
    scatter(x,y,color_code(classes_o(pts)));
    hold on;
end
subplot(3,2,3)
title('k-means - x gesture');
for pts = 1: pts_no
    x = gesture_x(pts,1);
    y = gesture_x(pts,2); 
    scatter(x,y,color_code(classes_x(pts)));
    hold on;
end

classes_l = binSplit(gesture_l, K);
classes_o = binSplit(gesture_l, K);
classes_x = binSplit(gesture_l, K);

subplot(3,2,4)
title('Uniform Binary Split - l gesture');
for pts = 1: pts_no
    x = gesture_l(pts,1);
    y = gesture_l(pts,2); 
    scatter(x,y,color_code(classes_l(pts)));
    hold on;
end
subplot(3,2,5)
title('Uniform Binary Split - o gesture');
for pts = 1: pts_no
    x = gesture_o(pts,1);
    y = gesture_o(pts,2); 
    scatter(x,y,color_code(classes_o(pts)));
    hold on;
end
subplot(3,2,6)
title('Uniform Binary Split - x gesture');
for pts = 1: pts_no
    x = gesture_x(pts,1);
    y = gesture_x(pts,2); 
    scatter(x,y,color_code(classes_x(pts)));
    hold on;
end
