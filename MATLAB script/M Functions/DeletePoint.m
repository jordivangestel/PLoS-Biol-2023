function [LINE] = AddPoint(x,y,LINE)

	D = [];
	for j = 1:length(LINE(:,1))
		x1 = LINE(j,1);
		y1 = LINE(j,2);
		distance = sqrt((x1-x)^2+(y1-y)^2);
		D = [D distance];
	end
	loc = find(D == min(D));
	if and(loc ~= 1,loc ~= length(LINE(:,1))),LINE_NEW = [LINE(1:(loc-1),:); LINE((loc+1):length(LINE(:,1)),:)]; end
	if loc == 1,LINE_NEW = LINE(2:length(LINE(:,1)),:); end
	if loc == length(LINE(:,1)),LINE_NEW = LINE(1:(length(LINE(:,1))-1)); end
	LINE = LINE_NEW;
	
end