function [LINE handles] = MovePoint(x,y,LINE,handles)

    i = handles.index;
	if handles.M.P{i}.MOVE == 0
		D = [];
		for j = 1:length(LINE(:,1))
			x1 = LINE(j,1);
			y1 = LINE(j,2);
			distance = sqrt((x1-x)^2+(y1-y)^2);
			D = [D distance];
		end
		loc = find(D == min(D));
		handles.M.S{i}.MOVE = loc;
	else
		LINE(handles.M.S{i}.MOVE,1) = x;
		LINE(handles.M.S{i}.MOVE,2) = y;
	end

end