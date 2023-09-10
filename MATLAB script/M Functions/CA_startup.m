function [handles M] = CA_startup(hObject,handles)
	
	PATH                = pwd;
	display(PATH)
	addpath(genpath(PATH)); % Add folder and subfolders to path
	NAMES               = dir([PATH,'\M Images\*.JPG']);
	display(NAMES)
	handles.SAVE_STR    = [PATH,'\M Output\'];
    handles.SAVE_IMA    = [PATH,'\M Images\'];
    handles.LOAD_STR    = [PATH,'\M Load\'];
		
	%display(int2str(length(NAMES)))	
	M.N_FRAME           = length([NAMES.datenum]);
	M.N_DIM             = size(imread([PATH,'\M Images\',NAMES(1).name]));
	M.N_SAVED			= 1;
			
	M.NA				= cell(1,length(NAMES));
	M.NAMES         	= cell(1,length(NAMES));
	
	for i = 1:length(M.NAMES)
		M.NAMES{i} = [PATH,'\M Images\', NAMES(i).name];
		M.NA{i}	   = NAMES(i).name;
		display(['FIG SET ',int2str(i),':']) % CHECK IF FILES ARE CORRECTLY ASSOCIATED AND LOADED IN THE CORRECT ORDER
		display(NAMES(i).name);   
	end
	
	%%% LOAD PICTURES TO STRUCTURE

	%%%%%%%% SETUP M-STRUCTURE
    %%% SAVE IMAGES OUTSIDE OF STRUCTURE (TO REDUCE THE SIZE OF THE
    %%% STRUCTURE AND ALLOW FOR THE ANALYSIS OF THOUSANDS OF IMAGES AT THE
    %%% SAME TIME
    
	N 		 = M.N_FRAME;
    M.FI     = cell(1,N);
	M.FI_n   = cell(1,N);
	
	%%% LOAD VARIABLES; these are default variable settings used for all frames
	%%% then there should also be the possibility of having frame-specific
	%%% adjustments of the parameter settings.
	P.A         = int64(M.N_DIM(2)/2);  %(A)  x coordinate that indicates center of plate
	P.B         = int64(M.N_DIM(1)/2);  %(B)  y coordinate that indicates center of plate
	P.C         = int64(M.N_DIM(1)/4);  %(C)  radius of plate
	P.D         = int64(P.C);    		%(D)  x coordinate that indicates center of colony
	P.E         = int64(P.C);    		%(E)  y coordinate that indicates center of colony
	P.F         = int64(0.9*P.C);      %(F)  radius of colony
	P.G         = 0.15;   	  			%(G)  lower pixel value intensity for normalization
	P.H         = 0.65;      			%(H)  upper pixel value intensity for normalization
	P.I         = 1;    				%(I)  gamma of contrast adjustment (linear = 1)
	P.J         = 0.6;    				%(J)  threshold of colony image (0-1)
	P.K		    = 3;      				%(K)  dilate conditions (size disk)
	P.L		    = 2000;      			%(L)  fill small open areas (area size)
	P.M		    = 4;      				%(M)  erode (size disk)
	P.N		    = 3;      				%(N)  dilate (size disk)
	P.O		    = 40;      				%(O)  distance between points on outline (pixel)
	P.P		    = P.O;      			%(P)  length of axis on which sigmoidal curve is fitted
	P.Q		    = 100;				    %(Q)  degree steps by which boundaries are rotated to find best fit
	P.R		    = 20;				    %(R)  bins used to make histograms for fitting two colonies
	
	P.SEGMENTED = 0;      % PARAMETER THAT KEEPS TRACK IF PICTURE IS SEGMENTED
	P.REFINE	= 0;	  % PARAMETER THAT KEEPS TRACK IF BOUNDARY IS ALREADY REFINED
	P.BOUNDARY  = 0; 	  % PARAMETER THAT KEEPS TRACK IF SYSTEM BOUNDARY IS ESTABLISHED
	P.SAVED     = 0; 	  % PARAMETER THAT KEEPS TRACK IF PICTURE IS SAVED
	P.ID	    = 0; 	  % Keep track of ID number (this is necessary for saving the ImageAnalysis to the proper file in case some images get deleted)
	P.PUSH	    = 0;      % Keep track of the button
	P.MOVE		= 0;	  % Keep track if move button has been hit before
    P.CENTER	= 0.45;   % Threshold used for centralizing the plate in the image
	P.ROTATE	= 0; 	  % Rotate of outline to match other images in the same batch
	
	%%% STATISTICS VARIABLES THAT ARE MEASURED:
	S.OUTLINE    = 0;     %(1)  OULTINE AFTER SEGMENTATION
	S.BOUNDARY   = 0;     %(2)  OUTLINE AFTER SETTING BOUNDARY
	S.REFINE     = 0; 	  %(3)  OUTLINE AFTER REFINEMENT
	S.MOVE 		 = 0; 	  %(4)  WHAT POINT IN THE OUTLINE SHOULD BE MOVED
	S.OUTLINE_A  = 0;     %(5)  OUTLINE INFORMATION THAT WILL BE SAVED (A): THE RAW OUTLINE DATA, SHOWING THE PIXEL VALUES INSIDE THE PLATE CONTEXT
	S.OUTLINE_B  = 0;     %(6)  OUTLINE INFORMATION THAT WILL BE SAVED (B): THE OUTLINE RELATIVE TO PLATE SIZE AND CORRECTED FOR CENTER
	S.OUTLINE_C  = 0;     %(7)  OUTLINE INFORMATION THAT WILL BE SAVED (C): THE OUTLINE CORRECTED FOR ROTATION
	
	%%% SAVE GLOBAL PARAMETER SETTINGS TO FRAME; WHERE THEY CAN BE ADJUSTED
	M.P = cell(1,N);
	M.S = cell(1,N);
	for i = 1 : N,
		M.P{i} 	  = P;
		M.P{i}.ID = i;
		M.S{i} 	  = S;
    end
		
    set(handles.TOTAL,'String',num2str(M.N_FRAME)); % Necessary to display total number of frames
    set(handles.INDEX,'String',num2str(1));			% Necessary to set index of frame number to one
    
end