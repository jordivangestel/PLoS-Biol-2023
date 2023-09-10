function [handles M] = ImageAnalysis(handles,i)

	M = handles.M;
	IM1 = load(M.FI_n{i});
	IM1 = IM1.SI_n;
	SIZE = size(IM1);
	display(SIZE(1))
	display(SIZE(2))
	
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
	%imshow(IM1)
	%imhist(IM1(CIRCLE));
	IM2 = imadjust(IM1,[lower upper],[0 1],gamma); 
	IM2(CIRCLE_INV) = 1;
	T   = double(M.P{i}.J);

    IM3 = im2bw(IM2,T);    
	IM4 = imcomplement(IM3);
	IM5 = imdilate(IM4,strel('disk',double(M.P{i}.K)));   % DILATE IMAGE
	IM6 = ~bwareaopen(~IM5,double(M.P{i}.L));             % FILL OPEN HOLES OF CERTAIN SIZE INSIDE COLONIES
	IM7 = imerode(IM6,strel('disk',double(M.P{i}.M)));    % ERODE 
	IM8 = imdilate(IM7,strel('disk',double(M.P{i}.N)));
	CC  = bwconncomp(IM8);

	j   = 0;
	IM9 = zeros(size(IM8));
    
   	% find the component that is central
	% central = int64(length(IM9)^2/2);
    central = int64(length(IM9)*x_middle + y_middle); % Problem with the above line is that image is not always perfectly centralized, this equation corrects for this
    for l = 1:length(CC.PixelIdxList)
		if any(CC.PixelIdxList{1,l}==central)
            j = l;
		end
    end
    
    IM9(CC.PixelIdxList{1,j}) = 1;
	OUTLINE = bwboundaries(IM9);
	OUTLINE = OUTLINE{1,1};
	
	figure;
    axes('units','normalized','position',[0,0.5,0.2,0.5]);
    imshow(IM1,[]);
    axes('units','normalized','position',[0.20,0.5,0.2,0.5]);
    imshow(IM2,[]);
    axes('units','normalized','position',[0.40,0.5,0.2,0.5]);
    imshow(IM3,[]);
    axes('units','normalized','position',[0.60,0.5,0.2,0.5]);
    imshow(IM4,[]);
    axes('units','normalized','position',[0.80,0.5,0.2,0.5]);
    imshow(IM5,[]);
    axes('units','normalized','position',[0,0,0.2,0.5]);
    imshow(IM6,[]);
    axes('units','normalized','position',[0.20,0,0.2,0.5]);
    imshow(IM7,[]);
    axes('units','normalized','position',[0.40,0,0.2,0.5]);
    imshow(IM8,[]);
    axes('units','normalized','position',[0.60,0,0.2,0.5]);
    imshow(IM9);
	
	set(handles.Lines,'Value',0);
	set(handles.Points,'Value',0);
	set(handles.Segmentation,'Value',1);
	
   	M.P{i}.SEGMENTED = 1;
	M.S{i}.OUTLINE = OUTLINE;
	
    IM1  = []; IM2  = []; IM3  = []; IM4  = []; IM5  = []; IM6  = []; IM7  = []; IM8  = []; IM9  = [];
end