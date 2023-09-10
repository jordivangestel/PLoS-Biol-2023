function [handles] = SaveF(handles,i)

	j			  = handles.M.P{i}.ID
	M             = handles.M;
	M.P{i}.SAVED  = 1;
	handles.start = 1;
    SI            = imread(M.NAMES{i});
	SI			  = rgb2gray(SI);
    SI            = im2double(SI);
	SIZE          = size(SI);
	y_middle      = M.P{i}.B;
	x_middle      = M.P{i}.A;
	radius        = M.P{i}.C;
	SI_n          = SI((y_middle-radius):(y_middle+radius),(x_middle-radius):(x_middle+radius));
	%save([handles.SAVE_IMA num2str(j) 'SI.mat'], 'SI'   );
    save([handles.SAVE_IMA num2str(j) 'SI_n.mat'], 'SI_n' );
    %M.FI{i}      = [handles.SAVE_IMA num2str(j) 'SI.mat'   ]; %% DO NOT SHOW RAW FILE
    M.FI_n{i}     = [handles.SAVE_IMA num2str(j) 'SI_n.mat' ];
	handles.M     = M;

end