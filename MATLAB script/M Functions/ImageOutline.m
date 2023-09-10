function [handles M] = ImageOutline(handles,i)

	M = handles.M;
	r = M.P{i}.O;
	OUTLINE = M.S{i}.OUTLINE;
	
	xy_r = [OUTLINE(1,2) OUTLINE(1,1)];
	for j = 2:length(OUTLINE(:,1))
		x = OUTLINE(j,2);
		y = OUTLINE(j,1);
		if sqrt((x-xy_r(end,1))^2 + (y-xy_r(end,2))^2) > r
			xy_r = [xy_r; [OUTLINE(j-1,2) OUTLINE(j-1,1)]];
		end
	end

	M.P{i}.BOUNDARY = 1;
	M.S{i}.BOUNDARY = xy_r;
	set(handles.Lines,'Value',1);
	set(handles.Points,'Value',1);
	set(handles.Segmentation,'Value',1);
	
	set(handles.From,'String','1')
	set(handles.To,'String',num2str(length(xy_r(:,1))))
end