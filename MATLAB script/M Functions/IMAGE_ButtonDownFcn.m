function [] = IMAGE_ButtonDownFcn(hObject,eventdata,handles)

i = handles.index;
LINE = handles.M.S{i}.BOUNDARY;
p = get(handles.IMAGE,'CurrentPoint');
x = p(1,1);
y = p(1,2);
type = handles.M.P{i}.PUSH;
display(type)

if type == 0
	display(x);
	display(y);
	I = load(handles.M.FI_n{i});
	I = I.SI_n;
	SIZE = size(I);
	p = I(floor(y),floor(x));
	set(handles.xtag,'String',num2str(floor(x)));
	set(handles.ytag,'String',num2str(floor(y)));
	set(handles.ptag,'String',num2str(round(p*100)/100));
	set(handles.xtagi,'String',['(' num2str(round(100*x/SIZE(2))/100) ')']);
	set(handles.ytagi,'String',['(' num2str(round(100*y/SIZE(1))/100) ')']);
	set(handles.Pixel,'BackgroundColor',[p p p]);
	if handles.M.P{i}.BOUNDARY == 1
		CurrentPoint(x,y,LINE,handles);
	end
end

if type == 1
	display(x);
	display(y);
	ShowPoint(x,y,LINE,handles);
	%figure(handles.figure1);
end

if type == 2
	display(x);
	display(y);
	[L] = RefinePoint(x,y,LINE,handles);
	handles.M.S{i}.BOUNDARY = L;
	L = [];
	[H] = updateF(handles);
	handles = H;
	H   = [];
end

if type == 3
	display(x);
	display(y);
	[L H] = MovePoint(x,y,LINE,handles);
	if handles.M.P{i}.MOVE == 1
		H.M.S{i}.BOUNDARY = L;
		H.M.P{i}.MOVE = 0;
		[H] = updateF(H);
		handles = H;
		H   = [];
	else
		H.M.P{i}.MOVE = 1;
		set(handles.iIMAGE,'ButtonDownFcn',{@IMAGE_ButtonDownFcn,H})
		handles = H;
		H   = [];
	end
	L = [];
end

if type == 4
	display(x);
	display(y);
	[L] = AddPoint(x,y,LINE);
	handles.M.S{i}.BOUNDARY = L;
	set(handles.To,'String',num2str(length(L(:,1))))
	set(handles.From,'String','1')
	L = [];
	[H] = updateF(handles);
	handles = H;
	H   = [];
end

if type == 5
	display(x);
	display(y);
	[L] = DeletePoint(x,y,LINE);
	handles.M.S{i}.BOUNDARY = L;
	set(handles.To,'String',num2str(length(L(:,1))))
	set(handles.From,'String','1')
	L = [];
	[H] = updateF(handles);
	handles = H;
	H   = [];
end

guidata(handles.IMAGE,handles);