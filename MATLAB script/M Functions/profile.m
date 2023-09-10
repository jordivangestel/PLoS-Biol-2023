function [list_all] = profile(xy,x_central,y_central,r,bins)
    list_a = [];
    list_d = [];
    for i = 1:length(xy(:,1))
        d = sqrt((xy(i,1)-x_central)^2 + (xy(i,2)-y_central)^2)/r;
        angle = atan((xy(i,2)-y_central)/(xy(i,1)-x_central));
        if xy(i,1)-x_central < 0
            angle = angle + pi;
        end
        if angle < 0
            angle = 2*pi + angle;
        end
        list_a = [list_a angle];
        list_d = [list_d d];
    end
    %list_all = sortrows([list_a; list_d]',1);
    range = linspace(0,2*pi,bins);
    list_all = [];
    for i = 2:length(range)
        ind = find(list_a > range(i-1) & list_a <= range(i));
        list_all = [list_all mean(list_d(ind))];
    end
end