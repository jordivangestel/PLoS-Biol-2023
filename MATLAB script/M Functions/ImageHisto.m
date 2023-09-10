function [] = ImageAnalysis(handles,i)

	M = handles.M;
	IM1 = load(M.FI_n{i});
	IM1 = IM1.SI_n;
	SIZE = size(IM1);
	
	%%% SEGMENT IMAGE %%%
	x_middle = double(M.P{i}.D);
	y_middle = double(M.P{i}.E);
	radius = double(M.P{i}.F);
	[columnsInImage rowsInImage] = meshgrid(1:SIZE(2),1:SIZE(1));
	PLATE = (rowsInImage - y_middle).^2 + (columnsInImage - x_middle).^2 <= radius.^2;
	PLATE_INV  = imcomplement(PLATE);
	CIRCLE_INV = find(PLATE_INV);
	CIRCLE = find(PLATE);

	lower = double(M.P{i}.G);
	upper = double(M.P{i}.H);
	gamma = double(M.P{i}.I);

	IM1 = imadjust(IM1,[0 1],[1 0],1); 
	IM2 = imadjust(IM1,[lower upper],[0 1],gamma); 
	figure
	imhist(IM2(CIRCLE));
	IM1  = []; IM2 = [];
end