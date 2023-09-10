function [handles] = ImageRefine(ref_start,ref_end,handles)

	warning('off','all')
	D = [];
	i = handles.index;
	r = handles.M.P{i}.P;
	I = load(handles.M.FI_n{i});
	I = I.SI_n;
	LINE = handles.M.S{i}.BOUNDARY;
	NEW_LINE = LINE;
	for l = ref_start:ref_end
		display(l);
		x = LINE(l,1);
		y = LINE(l,2);
		
		if l ~= 1
			x1 = LINE(l-1,1);
			y1 = LINE(l-1,2);
		else
			x1 = LINE(end,1);
			y1 = LINE(end,2);    
		end
		if l ~= length(LINE(:,1))
			x3 = LINE(l+1,1);
			y3 = LINE(l+1,2);
		else
			x3 = LINE(1,1);
			y3 = LINE(1,2);
		end
		angle = atan((y3-y1)/(x3-x1)) + 0.5*pi;
		dx1 = cos(angle)*0.5*r + x;
		dy1 = sin(angle)*0.5*r + y;
		dx2 = cos(angle+pi)*0.5*r + x;
		dy2 = sin(angle+pi)*0.5*r + y;
		
		lx = int64(linspace(dx1,dx2,r));
		ly = int64(linspace(dy1,dy2,r));
		lp = [];
		for j = 1:r
			lp = [lp I(ly(j),lx(j))];
		end

		f = @(p,xx) p(1) + p(2) ./ (1 + exp(-(xx-p(3))/p(4)));
		p1 = nlinfit(1:r,lp,f,[0 1 0 r]); 
		p2 = nlinfit(1:r,lp,f,[1 -1 0 r]); 
		MSE1 = mean((f(p1,1:r) - lp).^2); %% MEAN SQUARE ERROR OF FIRST CURVE FIT
		MSE2 = mean((f(p2,1:r) - lp).^2); %% MEAN SQUARE ERROR OF SECOND CURVE FIT
		
		if MSE1 < MSE2, p = p1; end
		if MSE1 > MSE2, p = p2; end
		
		syms xx;
		g = diff(diff(f(p,xx),xx),xx);
		inflection = solve(g,xx);
		if inflection > r || inflection < 0
			inflection = r/2;
		end
		
		x_new = inflection/r*(dx2-dx1) + dx1;
		y_new = inflection/r*(dy2-dy1) + dy1;
		NEW_LINE(l,1) = x_new;
		NEW_LINE(l,2) = y_new;
	end
	
	LINE = NEW_LINE;
	handles.M.S{i}.BOUNDARY = LINE;
	warning('on','all')
end