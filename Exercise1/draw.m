 ip = [0, 0.05;
       1, 0;
       1, 0.05;
       -1, -0.05];
ip_no = size(ip,1);
close all;
for i = 1:ip_no
    Simulate_robot(ip(i,1), ip(i,2));
    file = sprintf('pic_%.2f_%.2f.jpeg', ip(i,1), ip(i,2) );
    label = sprintf('(%.2f,%.2f)', ip(i,1), ip(i,2) );
    title(label);
    saveas(gcf,file);
end

 