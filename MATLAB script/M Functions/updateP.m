function [] = updateP(handles)

	M = handles.M;
    t = handles.M.N_FRAME;
    i = handles.index;
	
    A = M.P{i}.A;
    B = M.P{i}.B;
    C = M.P{i}.C;
    D = M.P{i}.D;
    E = M.P{i}.E;
    F = M.P{i}.F;
    G = M.P{i}.G;
    H = M.P{i}.H;
    I = M.P{i}.I;
    J = M.P{i}.J;
	K = M.P{i}.K;
	L = M.P{i}.L;
	M1 = M.P{i}.M;
	N = M.P{i}.N;
	O = M.P{i}.O;
	P = M.P{i}.P;
	Q = M.P{i}.Q;
	R = M.P{i}.R;
	CENTER = M.P{i}.CENTER;
    
	set(handles.readA,'String',num2str(A));
    set(handles.readB,'String',num2str(B));
    set(handles.readC,'String',num2str(C));
    set(handles.readD,'String',num2str(D));
    set(handles.readE,'String',num2str(E));
    set(handles.readF,'String',num2str(F));
    set(handles.readG,'String',num2str(G));
    set(handles.readH,'String',num2str(H));
    set(handles.readI,'String',num2str(I));
    set(handles.readJ,'String',num2str(J));
	set(handles.readK,'String',num2str(K));
	set(handles.readL,'String',num2str(L));
	set(handles.readM,'String',num2str(M1));
	set(handles.readN,'String',num2str(N));
	set(handles.readO,'String',num2str(O));
	set(handles.readP,'String',num2str(P));
	set(handles.readQ,'String',num2str(Q));
	set(handles.readR,'String',num2str(R));
    set(handles.INDEX,'String',num2str(i));
    set(handles.TOTAL,'String',num2str(t));
	set(handles.readCenter,'String',num2str(CENTER));
	
	%set(handles.Showpoint,'BackgroundColor',[0.9 0.9 0.9]);
	%set(handles.Refinepoint,'BackgroundColor',[0.9 0.9 0.9]);
	%set(handles.Move,'BackgroundColor',[0.9 0.9 0.9]);
	%set(handles.Add,'BackgroundColor',[0.9 0.9 0.9]);
	%set(handles.Delete,'BackgroundColor',[0.9 0.9 0.9]);
		
	if handles.M.P{i}.SEGMENTED == 1, % Statistics only possible when segmented image
		set(handles.inputO,'Enable','on');
		set(handles.inputP,'Enable','on');
		set(handles.Outline,'Enable','on');
		set(handles.Refine,'Enable','off');
		set(handles.Comparison,'Enable','off');
		set(handles.Showcomparison,'Enable','off');
		set(handles.Showpoint,'Enable','off');
		set(handles.Refinepoint,'Enable','off');
		set(handles.Move,'Enable','off');
		set(handles.Add,'Enable','off');
		set(handles.Delete,'Enable','off');
		set(handles.From,'Enable','off');
		set(handles.To,'Enable','off');
		set(handles.DeleteSub,'Enable','off');
		set(handles.RefineSub,'Enable','off');	
	else
		set(handles.inputO,'Enable','off');
		set(handles.inputP,'Enable','off');
		set(handles.Saveoutline,'Enable','off');
		set(handles.Outline,'Enable','off');
		set(handles.Refine,'Enable','off');
		set(handles.Comparison,'Enable','off');
		set(handles.Showcomparison,'Enable','off');
		set(handles.Showpoint,'Enable','off');
		set(handles.Refinepoint,'Enable','off');
		set(handles.Move,'Enable','off');
		set(handles.Add,'Enable','off');
		set(handles.Delete,'Enable','off');
		set(handles.From,'Enable','off');
		set(handles.To,'Enable','off');
		set(handles.DeleteSub,'Enable','off');
		set(handles.RefineSub,'Enable','off');
		set(handles.Showpoint,'BackgroundColor',[0.9 0.9 0.9]);
		set(handles.Refinepoint,'BackgroundColor',[0.9 0.9 0.9]);
		set(handles.Move,'BackgroundColor',[0.9 0.9 0.9]);
		set(handles.Add,'BackgroundColor',[0.9 0.9 0.9]);
		set(handles.Delete,'BackgroundColor',[0.9 0.9 0.9]);
	end
	
	if handles.M.P{i}.BOUNDARY == 1, % Statistics only possible when segmented image
		set(handles.Comparison,'Enable','on');
		set(handles.Refine,'Enable','on');
		set(handles.Showpoint,'Enable','on');
		set(handles.Refinepoint,'Enable','on');
		set(handles.Move,'Enable','on');
		set(handles.Add,'Enable','on');
		set(handles.Delete,'Enable','on');
		set(handles.From,'Enable','on');
		set(handles.To,'Enable','on');
		set(handles.DeleteSub,'Enable','on');
		set(handles.RefineSub,'Enable','on');
	else
		set(handles.Saveoutline,'Enable','off');
		set(handles.Comparison,'Enable','off');
		set(handles.Refinepoint,'Enable','off');
		set(handles.Refine,'Enable','off');
		set(handles.Move,'Enable','off');
		set(handles.Add,'Enable','off');
		set(handles.Delete,'Enable','off');
		set(handles.From,'Enable','off');
		set(handles.To,'Enable','off');
		set(handles.DeleteSub,'Enable','off');
		set(handles.RefineSub,'Enable','off');
		set(handles.Showpoint,'BackgroundColor',[0.9 0.9 0.9]);
		set(handles.Refinepoint,'BackgroundColor',[0.9 0.9 0.9]);
		set(handles.Move,'BackgroundColor',[0.9 0.9 0.9]);
		set(handles.Add,'BackgroundColor',[0.9 0.9 0.9]);
		set(handles.Delete,'BackgroundColor',[0.9 0.9 0.9]);
		set(handles.Current,'String','0');
	end
	
	sum_boundary = 0;
	for j = 1:handles.M.N_FRAME, sum_boundary = sum_boundary + handles.M.P{j}.BOUNDARY; end
	if sum_boundary > 0
		set(handles.Comparison,'Enable','on');
		set(handles.Showcomparison,'Enable','on');
		set(handles.inputQ,'Enable','on');
		set(handles.inputR,'Enable','on');
		set(handles.Saveoutline,'Enable','on');
	else
		set(handles.Comparison,'Enable','off');
		set(handles.Showcomparison,'Enable','off');
		set(handles.inputQ,'Enable','off');
		set(handles.inputR,'Enable','off');
		set(handles.Saveoutline,'Enable','off');
	end
	
end
