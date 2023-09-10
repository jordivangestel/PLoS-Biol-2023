function [handles] = updateF(handles)
    
	% Update figures shown on screen based on index that is given
    i = handles.index;
	if handles.start == 0
		xlim = get(handles.IMAGE, 'XLim');
		ylim = get(handles.IMAGE, 'YLim');
	end
	
	if handles.start == 0
		check = allchild(handles.IMAGE);
		delete(check(1:(length(check)-1))); 
	end
	
	if handles.start == 1
		check = allchild(handles.IMAGE);
		delete(check); 
		I = load(handles.M.FI_n{i});
		SIZE = size(I.SI_n);
		handles.iIMAGE = imshow(I.SI_n,'parent',handles.IMAGE);
		set(handles.IMAGE, 'XLim', [0 double(SIZE(2))]);
		set(handles.IMAGE, 'YLim', [0 double(SIZE(1))]);		
	end
	
	set(handles.iIMAGE,'ButtonDownFcn',{@IMAGE_ButtonDownFcn,handles})
	
	if handles.start == 0
		set(handles.IMAGE, 'XLim', xlim);
		set(handles.IMAGE, 'YLim', ylim);
	end

	ifLines  = get(handles.Lines,'Value');
	ifPoints = get(handles.Points,'Value'); 
	ifSegmentation = get(handles.Segmentation,'Value'); 
	ifCentralization = get(handles.Centralization,'Value');
	
	%%% EXPRESS IMAGE CENTER
	if ifCentralization, line([(handles.M.P{i}.D - 20) (handles.M.P{i}.D + 20)],[(handles.M.P{i}.E) (handles.M.P{i}.E)],'LineWidth',1,'Color',[1 1 0]); end
    if ifCentralization, line([(handles.M.P{i}.D) (handles.M.P{i}.D)],[(handles.M.P{i}.E+20) (handles.M.P{i}.E-20)],'LineWidth',1,'Color',[1 1 0]); end
	
	%%% EXPRESS CUT-OFF OF ANLASYSIS
	y_middle = double(handles.M.P{i}.E);
	x_middle = double(handles.M.P{i}.D);
	radius = double(handles.M.P{i}.F);
	[columnsInImage rowsInImage] = meshgrid(1:(2*handles.M.P{i}.C+1),1:(2*handles.M.P{i}.C+1));
	PLATE = (rowsInImage - y_middle).^2 + (columnsInImage - x_middle).^2 <= radius.^2;
	CIRCLE = bwboundaries(PLATE);
	if ifCentralization, line(CIRCLE{1,1}(:,2),CIRCLE{1,1}(:,1),'LineWidth',1,'Color',[1 1 0]); end
		
	if handles.start == 1, handles.start = 0; end
	set(handles.FileName,'String',handles.M.NA{i});
	I = [];
	
	%%% EXPRESS BOUNDARY THAT COMES FROM SEGMENTATION ANALYSIS
	if handles.M.P{i}.SEGMENTED == 1
		if ifSegmentation
			OUTLINE = handles.M.S{i}.OUTLINE;
			line(OUTLINE(:,2),OUTLINE(:,1),'LineWidth',1,'Color',[0 0 1]);
		end
	end
	
	%%% EXPRESS BOUNDARY THAT COMES FROM BOUNDARY ANALYSIS + REFINEMENT AXES
	if handles.M.P{i}.BOUNDARY == 1
		xy_r = handles.M.S{i}.BOUNDARY;
		if ifLines, line(xy_r(:,1),xy_r(:,2),'LineWidth',1,'Color',[0 1 0]); end
		r = handles.M.P{i}.P;
		for j = 1:length(xy_r(:,1))
			if j ~= 1
				x1 = xy_r(j-1,1);
				y1 = xy_r(j-1,2);
			else
				x1 = xy_r(end,1);
				y1 = xy_r(end,2);    
			end
			if j ~= length(xy_r(:,1))
				x3 = xy_r(j+1,1);
				y3 = xy_r(j+1,2);
			else
				x3 = xy_r(1,1);
				y3 = xy_r(1,2);
			end
			angle = atan((y3-y1)/(x3-x1)) + 0.5*pi;
			dx1 = cos(angle)*0.5*r + xy_r(j,1);
			dy1 = sin(angle)*0.5*r + xy_r(j,2);
			dx2 = cos(angle+pi)*0.5*r + xy_r(j,1);
			dy2 = sin(angle+pi)*0.5*r + xy_r(j,2);
			if ifLines, line([dx1 dx2],[dy1 dy2],'LineWidth',1,'Color',[1 1 0]); end
		end
		hold on
		if ifPoints, plot(xy_r(:,1),xy_r(:,2),'r.','MarkerSize',5);end
	end
	display('plot');
	whos
end
