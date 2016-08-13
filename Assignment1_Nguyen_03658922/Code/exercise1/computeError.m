function [pos_err, ori_err] = computeError(A, p1, p2, a_x,a_y, a_theta, out)
    %estimate error
    x_pred = A(:,1:3*p1+1)*a_x;
    y_pred = A(:,1:3*p1+1)*a_y;
    pos_err = sqrt((out(1,:)' - x_pred).^2 + (out(2,:)' - y_pred).^2);
    pos_err = sum(pos_err(:))/ size(A,1);
    theta_pred = A(:,1:3*p2+1)*a_theta;
    ori_err = sqrt((out(3,:)' - theta_pred).^2);
    ori_err = sum(ori_err(:))/ size(A,1);
end