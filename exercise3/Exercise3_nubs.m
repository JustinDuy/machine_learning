function Exercise3_nubs(gesture_l, gesture_o, gesture_x,K)
%constant
color_code = ['b','k','r','g','m','y','c'];
%load('gesture_dataset.mat');
%reshape gesture data
[pts_no, rep_no, dim_no] = size(gesture_l);
gesture_l = reshape(gesture_l, [pts_no * rep_no, dim_no]);
gesture_o = reshape(gesture_o, [pts_no * rep_no, dim_no]);
gesture_x = reshape(gesture_x, [pts_no * rep_no, dim_no]);

pts_no = pts_no * rep_no;
%K = 7;
classes_l = binSplit(gesture_l, K);
classes_o = binSplit(gesture_o, K);
classes_x = binSplit(gesture_x, K);

figure(1)
for pts = 1: pts_no
    x = gesture_l(pts,1);
    y = gesture_l(pts,2); 
    z = gesture_l(pts,3);
    scatter3(x,y,z,color_code(classes_l(pts)));
    hold on;
end
title('gesture L Non Uniform Binary Split');
saveas(gcf,'l_nubs.jpeg');

figure(2)
for pts = 1: pts_no
    x = gesture_o(pts,1);
    y = gesture_o(pts,2); 
    z = gesture_o(pts,3);
    scatter3(x,y,z,color_code(classes_o(pts)));
    hold on;
end
title('gesture O Non Uniform Binary Split');
saveas(gcf,'o_nubs.jpeg');

figure(3)
for pts = 1: pts_no
    x = gesture_x(pts,1);
    y = gesture_x(pts,2); 
    z = gesture_x(pts,3);
    scatter3(x,y,z,color_code(classes_x(pts)));
    hold on;
end
title('gesture X Non Uniform Binary Split');
saveas(gcf,'x_nubs.jpeg');
end