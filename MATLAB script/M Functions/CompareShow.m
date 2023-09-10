function [handles M] = CompareShow(handles)

	figure
	plot([-1 1],[-1 1],'Color','w'); axis equal;
	
	M = handles.M;
	% ALWAYS COMPARE THE SUBSEQUENT IMAGES WITH EACH OTHER (THE FIRST IMAGE IS NOT ROTATED BY DEFAULT AND THE OTHER IMAGES ROTATE WITH REGARD TO THE FIRST IMAGE)
	for i = 1:M.N_FRAME
		LINE = M.S{i}.BOUNDARY;
		x = double(M.P{i}.D);
		y = double(M.P{i}.E);
		r = double(M.P{i}.C);
		rotate = M.P{i}.ROTATE;
		addrotate = 0;
		if i > 1
			for j = 1:(i-1)
				addrotate = addrotate + M.P{j}.ROTATE;
			end
		end
		LINE(:,1) = LINE(:,1) - x;
		LINE(:,2) = LINE(:,2) - y;
		for l = 1:length(LINE(:,1))
			d = sqrt(LINE(l,1)^2 + LINE(l,2)^2)/r;
			angle = atan(LINE(l,2)/LINE(l,1));
			if LINE(l,1) < 0
				angle = angle + pi;
			end
			angle_new = angle + rotate + addrotate;
			x_new = cos(angle_new)*d;
			y_new = sin(angle_new)*d;
			LINE(l,1) = x_new;
			LINE(l,2) = y_new;
		end
		COLOR = 0.1+0.8*(double(i-1)/double(M.N_FRAME-1));
		line(LINE(:,1),LINE(:,2),'LineWidth',2,'Color',[COLOR COLOR COLOR]);
	end
end