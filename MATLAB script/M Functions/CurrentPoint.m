function [] = CurrentPoint(x,y,LINE,h)

	D = [];
	i = h.index;
	r = h.M.P{i}.O;
	
	for j = 1:length(LINE(:,1))
		x1 = LINE(j,1);
		y1 = LINE(j,2);
		distance = sqrt((x1-x)^2+(y1-y)^2);
		D = [D distance];
	end
	loc = find(D == min(D));
	set(h.Current,'String',num2str(loc));
end