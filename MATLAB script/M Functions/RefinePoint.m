function [LINE] = RefinePoint(x,y,LINE,h)

	D = [];
	i = h.index;
	r = h.M.P{i}.P;
	
	for j = 1:length(LINE(:,1))
		x1 = LINE(j,1);
		y1 = LINE(j,2);
		distance = sqrt((x1-x)^2+(y1-y)^2);
		D = [D distance];
	end
	loc = find(D == min(D));
	x = LINE(loc,1);
	y = LINE(loc,2);
	
	if loc ~= 1
        x1 = LINE(loc-1,1);
        y1 = LINE(loc-1,2);
    else
        x1 = LINE(end,1);
        y1 = LINE(end,2);    
    end
    if loc ~= length(LINE(:,1))
        x3 = LINE(loc+1,1);
        y3 = LINE(loc+1,2);
    else
        x3 = LINE(1,1);
        y3 = LINE(1,2);
    end
    angle = atan((y3-y1)/(x3-x1)) + 0.5*pi;
    dx1 = cos(angle)*0.5*r + x;
    dy1 = sin(angle)*0.5*r + y;
    dx2 = cos(angle+pi)*0.5*r + x;
    dy2 = sin(angle+pi)*0.5*r + y;
    
	I = load(h.M.FI_n{i});
	I = I.SI_n;
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
	LINE(loc,1) = x_new;
	LINE(loc,2) = y_new;
	
end