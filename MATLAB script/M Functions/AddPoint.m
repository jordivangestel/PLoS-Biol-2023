function [LINE] = AddPoint(x,y,LINE)

	D = [];
	for j = 2:length(LINE(:,1))
		x1 = LINE(j-1,1);
		y1 = LINE(j-1,2);
		x2 = LINE(j,1);
		y2 = LINE(j,2);
		xline = linspace(x1,x2,1000);
		yline = linspace(y1,y2,1000); 
		xline = xline(2:999);
		yline = yline(2:999);
		distance = [];
		for k = 1:length(xline)
			distance = [distance sqrt((xline(k)-x)^2+(yline(k)-y)^2)];
		end
		D = [D min(distance)];
	end
	loc = find(D == min(D));
	distance_start = sqrt((LINE(1,1)-x)^2+(LINE(1,2)-y)^2);
	distance_end   = sqrt((LINE(length(LINE(:,1)),1)-x)^2+(LINE(length(LINE(:,1)),2)-y)^2);
	
	if and(min(D) < distance_start, min(D) < distance_end), 		LINE_NEW = [LINE(1:(loc),:);[x y]; LINE((loc+1):length(LINE(:,1)),:)]; end
	if and(distance_start < min(D), distance_start < distance_end), LINE_NEW = [[x y]; LINE]; end
	if and(distance_end < min(D), distance_end < distance_start), 	LINE_NEW = [LINE; [x y]]; end
	
	LINE = LINE_NEW;
	
end