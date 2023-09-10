function [M] = CompareImage(handles)

	M = handles.M;
	% ALWAYS COMPARE THE SUBSEQUENT IMAGES WITH EACH OTHER (THE FIRST IMAGE IS NOT ROTATED BY DEFAULT AND THE OTHER IMAGES ROTATE WITH REGARD TO THE FIRST IMAGE)
	for i = 2:M.N_FRAME
		display(i);
		LINE1 = M.S{i-1}.BOUNDARY;
		LINE2 = M.S{i}.BOUNDARY;
		x1 = double(M.P{i-1}.D);
		y1 = double(M.P{i-1}.E); 
		r1 = double(M.P{i-1}.C);
		x2 = double(M.P{i}.D);
		y2 = double(M.P{i}.E);
		r2 = double(M.P{i}.C);
		
		bins 		= max([M.P{i-1}.R M.P{i}.R]);
		degrees 	= linspace(0,2*pi,max([M.P{i-1}.Q M.P{i}.Q]));
		match 		= [];
		REFERENCE   = profile(LINE1,x1,y1,r1,bins);
		for j = 1:(length(degrees)-1)
			NEW_LINE = LINE2;
			%%% rotate set
			for l = 1:length(LINE2(:,1))
				display(l)
				d = sqrt((LINE2(l,1)-x2)^2 + (LINE2(l,2)-y2)^2);
				angle = atan((LINE2(l,2)-y2)/(LINE2(l,1)-x2));
				if LINE2(l,1) - x2 < 0
					angle = angle + pi;
				end
				angle_new = angle + degrees(j);
				x_new = x2 + cos(angle_new)*d;
				y_new = y2 + sin(angle_new)*d;
				NEW_LINE(l,1) = x_new;
				NEW_LINE(l,2) = y_new;
			end
			%%% end rotation
			FIT   = profile(NEW_LINE,x2,y2,r2,bins);
			match = [match sum(abs(REFERENCE - FIT))];
		end
		rotate = degrees(find(match == min(match)));
		M.P{i}.ROTATE = rotate;
	end
end