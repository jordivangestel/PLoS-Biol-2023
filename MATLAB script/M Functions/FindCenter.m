function [x_par,y_par,r_par] = FindCenter(FILE,T)

	SI = imread(FILE);
	SI	= rgb2gray(SI);
    SI  = im2double(SI);
	IM1 = SI;
	SIZE = size(IM1);
	IM2   = im2bw(IM1,T);  
	%IM3   = imcomplement(IM2);
	IM4   = ~bwareaopen(~IM2,100000);                                                     % FILL OPEN HOLES OF CERTAIN SIZE INSIDE COLONIES
	CC    = bwconncomp(IM4);
	IM5   = zeros(size(IM4)); 
	% find the component that is central
	j = 0;
	central = sub2ind([SIZE(1) SIZE(1)],round(0.5*SIZE(1)),round(0.5*SIZE(2)));
	for l = 1:length(CC.PixelIdxList)
		if any(CC.PixelIdxList{1,l} == central)
			j = l;
		end
	end
	IM5(CC.PixelIdxList{1,j}) = 1;
	[y,x] = find(IM5 == 1);
	x_par = round(mean(x));
	y_par = round(mean(y));
	r_par = mean([(max(x)-min(x)) (max(y)-min(y))])/2;
	
	figure;
    axes('units','normalized','position',[0,0.5,0.25,0.5]);
    imshow(IM1,[]);
    axes('units','normalized','position',[0.25,0.5,0.25,0.5]);
    imshow(IM2,[]);
    axes('units','normalized','position',[0.5,0.5,0.25,0.5]);
    imshow(IM4,[]);
    axes('units','normalized','position',[0.75,0.5,0.25,0.5]);
    imshow(IM5,[]);
	axes('units','normalized','position',[0,0.1,1,0.5]);
	imhist(IM1);

	SI=[]; IM1=[]; IM2=[]; IM4=[]; IM5=[];
end
