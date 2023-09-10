function varargout = CA_GUI(varargin)
% CA_GUI MATLAB code for CA_GUI.fig
%      CA_GUI, by itself, creates a new CA_GUI or raises the existing
%      singleton*.
%
%      H = CA_GUI returns the handle to a new CA_GUI or the handle to
%      the existing singleton*.
%
%      CA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CA_GUI.M with the given input arguments.
%
%      CA_GUI('Property','Value',...) creates a new CA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CA_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CA_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CA_GUI

% Last Modified by GUIDE v2.5 12-Oct-2018 13:25:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CA_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CA_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CA_GUI is made visible.
function CA_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CA_GUI (see VARARGIN)
addpath(genpath(pwd))

set(handles.figure1,'toolbar','figure'); % allows to zoom in and out of figure
set(handles.readA,'String',num2str(0));
set(handles.readB,'String',num2str(0));
set(handles.readC,'String',num2str(0));
set(handles.readD,'String',num2str(0));
set(handles.readE,'String',num2str(0));
set(handles.readF,'String',num2str(0));
set(handles.readG,'String',num2str(0));
set(handles.readH,'String',num2str(0));
set(handles.readI,'String',num2str(0));
set(handles.readJ,'String',num2str(0));
set(handles.readK,'String',num2str(0));
set(handles.readL,'String',num2str(0));
set(handles.readM,'String',num2str(0));
set(handles.readN,'String',num2str(0));
set(handles.readO,'String',num2str(0));
set(handles.readP,'String',num2str(0));
set(handles.readQ,'String',num2str(0));
set(handles.readR,'String',num2str(0));
set(handles.Current,'String',num2str(0));

set(handles.inputA,'String',num2str(0));
set(handles.inputB,'String',num2str(0));
set(handles.inputC,'String',num2str(0));
set(handles.inputD,'String',num2str(0));
set(handles.inputE,'String',num2str(0));
set(handles.inputF,'String',num2str(0));
set(handles.inputG,'String',num2str(0));
set(handles.inputH,'String',num2str(0));
set(handles.inputI,'String',num2str(0));
set(handles.inputJ,'String',num2str(0));
set(handles.inputK,'String',num2str(0));
set(handles.inputL,'String',num2str(0));
set(handles.inputM,'String',num2str(0));
set(handles.inputN,'String',num2str(0));
set(handles.inputO,'String',num2str(0));
set(handles.inputP,'String',num2str(0));
set(handles.inputQ,'String',num2str(0));
set(handles.inputR,'String',num2str(0));

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
set(handles.Centralization,'Value',1);

set(handles.Showpoint,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.Refinepoint,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.Move,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.Add,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.Delete,'BackgroundColor',[0.9 0.9 0.9]);

handles.index 	  = 1;
handles.start 	  = 1;
[H M]   	  	  = CA_startup(hObject,handles);

handles   		  = H;
handles.M		  = M;

[H]				  = SaveF(handles,1);
handles   		  = H;
H = []; M = [];
    
[H] = updateF(handles);
handles = H;
H   = [];
updateP(handles);
updateR(handles);
% Choose default command line output for CA_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% --- Executes on mouse press over axes background.

% UIWAIT makes CA_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = CA_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
display('Loading...');
LOAD = load([handles.LOAD_STR 'M.mat']);
handles.M = LOAD.M;
updateP(handles);
updateR(handles);
handles.start = 1;
[H] = updateF(handles);
handles = H;
H   = [];
display('Loaded structures');
guidata(hObject,handles);

% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
display('Saving...');
M = handles.M;
save([handles.SAVE_STR datestr(now,'yyyy.mm.dd_HH.MM.SS') '_M.mat'], 'M');
display('Structures are saved');
guidata(hObject,handles);

% --- Executes on button press in Previous.
function Previous_Callback(hObject, eventdata, handles)
if handles.index > 1
    handles.index = handles.index - 1;
	set(handles.INDEX,'String',num2str(handles.index))
	if handles.M.P{handles.index}.BOUNDARY == 1
		set(handles.From,'String','1');
		set(handles.To,'String',num2str(length(handles.M.S{handles.index}.BOUNDARY(:,1))));
	else
		set(handles.From,'String','0');
		set(handles.To,'String','0');
	end
end
if handles.M.P{handles.index}.SAVED == 0
	[H] = SaveF(handles,handles.index);
	handles = H;
end
updateP(handles);
updateR(handles);
handles.start = 1;
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject, handles);

% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
n = handles.M.N_FRAME;
if handles.index < n
    handles.index = handles.index + 1;
	set(handles.INDEX,'String',num2str(handles.index))
	if handles.M.P{handles.index}.BOUNDARY == 1
		set(handles.From,'String','1');
		set(handles.To,'String',num2str(length(handles.M.S{handles.index}.BOUNDARY(:,1))));
	else
		set(handles.From,'String','0');
		set(handles.To,'String','0');
	end
end
if handles.M.P{handles.index}.SAVED == 0
	[H] = SaveF(handles,handles.index);
	handles = H;
end
updateP(handles);
updateR(handles);
handles.start = 1;
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject, handles);

function INDEX_Callback(hObject, eventdata, handles)
i = str2double(get(handles.INDEX,'String'));
handles.index = i;
n = handles.M.N_FRAME;
if handles.index > n
    handles.index = n;
end
if handles.index < 1
    handles.index = 1;
end
if handles.M.P{handles.index}.SAVED == 0
	[H] = SaveF(handles,handles.index);
	handles = H;
end
updateP(handles);
updateR(handles);
handles.start = 1;
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function INDEX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to INDEX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Saveoutline.
function Saveoutline_Callback(hObject, eventdata, handles)
SaveOutline(handles);


function inputQ_Callback(hObject, eventdata, handles)
% hObject    handle to inputQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.Q = round(str2double(get(hObject,'String')));
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputQ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Comparison.
function Comparison_Callback(hObject, eventdata, handles)
% hObject    handle to Comparison (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
M = CompareImage(handles);
handles.M = M;
guidata(hObject,handles);

% --- Executes on button press in Showcomparison.
function Showcomparison_Callback(hObject, eventdata, handles)
% hObject    handle to Showcomparison (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CompareShow(handles);

% --- Executes on button press in Outline.
function Outline_Callback(hObject, eventdata, handles)
i   = handles.index;
[H M] = ImageOutline(handles,i);
handles   = H;
handles.M = M;
updateP(handles);
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes on button press in Refine.
function Refine_Callback(hObject, eventdata, handles)
ref_start   = 1;
ref_end 	= length(handles.M.S{handles.index}.BOUNDARY(:,1));
[H] = ImageRefine(ref_start,ref_end,handles);
handles   = H;
updateP(handles);
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

function inputO_Callback(hObject, eventdata, handles)
% hObject    handle to inputO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.O = str2double(get(hObject,'String'));
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputP_Callback(hObject, eventdata, handles)
% hObject    handle to inputP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.P = str2double(get(hObject,'String'));
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function inputG_Callback(hObject, eventdata, handles)
% hObject    handle to inputG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.G = str2double(get(hObject,'String'));
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputJ_Callback(hObject, eventdata, handles)
% hObject    handle to inputJ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.J = str2double(get(hObject,'String'));
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputJ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputJ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputK_Callback(hObject, eventdata, handles)
% hObject    handle to inputK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.K = str2double(get(hObject,'String'));
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputL_Callback(hObject, eventdata, handles)
% hObject    handle to inputL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.L = str2double(get(hObject,'String'));
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputM_Callback(hObject, eventdata, handles)
% hObject    handle to inputM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.M = str2double(get(hObject,'String'));
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputN_Callback(hObject, eventdata, handles)
% hObject    handle to inputN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.N = str2double(get(hObject,'String'));
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function inputA_Callback(hObject, eventdata, handles)
% hObject    handle to inputA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.A = str2double(get(hObject,'String'));
if M.P{i}.A - M.P{i}.C < 1, M.P{i}.A = M.P{i}.C + 1; end
if M.P{i}.A + M.P{i}.C > M.N_DIM(2), M.P{i}.A = M.N_DIM(2) - M.P{i}.C; end
handles.M = M;
updateP(handles);
[H]		= SaveF(handles,i);
handles = H;
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputB_Callback(hObject, eventdata, handles)
% hObject    handle to inputB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.B = str2double(get(hObject,'String'));
if M.P{i}.B - M.P{i}.C < 1, M.P{i}.B = M.P{i}.C + 1; end
if M.P{i}.B + M.P{i}.C > M.N_DIM(1), M.P{i}.B = M.N_DIM(1) - M.P{i}.C; end
handles.M = M;
updateP(handles);
[H]		= SaveF(handles,i);
handles = H;
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputC_Callback(hObject, eventdata, handles)
% hObject    handle to inputC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.C = str2double(get(hObject,'String'));
if M.P{i}.C < 10, M.P{i}.F = 10; end
if M.P{i}.A + M.P{i}.C > M.N_DIM(2), M.P{i}.C = M.N_DIM(2) - M.P{i}.A; end
if M.P{i}.A - M.P{i}.C < 1, M.P{i}.C = M.P{i}.A-1; end
if M.P{i}.B + M.P{i}.C > M.N_DIM(1), M.P{i}.C = M.N_DIM(1) - M.P{i}.B; end
if M.P{i}.B - M.P{i}.C < 1, M.P{i}.C = M.P{i}.B-1; end
M.P{i}.D = int64(M.P{i}.C);
M.P{i}.E = int64(M.P{i}.C);
M.P{i}.F = int64(0.95*M.P{i}.C)
handles.M = M;
updateP(handles);
[H]		= SaveF(handles,i);
handles = H;
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputD_Callback(hObject, eventdata, handles)
% hObject    handle to inputD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.D = str2double(get(hObject,'String'));
if M.P{i}.D + M.P{i}.F > 2*M.P{i}.C, M.P{i}.D = 2*M.P{i}.C - M.P{i}.F; end
if M.P{i}.D - M.P{i}.F < 1, M.P{i}.D = M.P{i}.F + 1; end
handles.M = M;
updateP(handles);
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputE_Callback(hObject, eventdata, handles)
% hObject    handle to inputE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.E = str2double(get(hObject,'String'));
if M.P{i}.E + M.P{i}.F > 2*M.P{i}.C, M.P{i}.E = 2*M.P{i}.C - M.P{i}.F; end
if M.P{i}.E - M.P{i}.F < 1, M.P{i}.E = M.P{i}.F + 1; end
handles.M = M;
updateP(handles);
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputF_Callback(hObject, eventdata, handles)
% hObject    handle to inputF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.F = str2double(get(hObject,'String'));
if M.P{i}.F > M.P{i}.C, M.P{i}.F = M.P{i}.C; end
if M.P{i}.F < 10, M.P{i}.F = 10; end
if M.P{i}.D + M.P{i}.F > 2*M.P{i}.C, M.P{i}.F = 2*M.P{i}.C - M.P{i}.D; end
if M.P{i}.D - M.P{i}.F < 1, M.P{i}.F = M.P{i}.D; end
if M.P{i}.E + M.P{i}.F > 2*M.P{i}.C, M.P{i}.F = 2*M.P{i}.C - M.P{i}.E; end
if M.P{i}.E - M.P{i}.F < 1, M.P{i}.F = M.P{i}.E; end
handles.M = M;
updateP(handles);
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Showimage.
function Showimage_Callback(hObject, eventdata, handles)

M = handles.M;
i = handles.index;
figure
SI = imread(M.NAMES{i});	% NEW CODE TO NOT SAVE RAW DATA EXTRA
SI = rgb2gray(SI);			% NEW CODE TO NOT SAVE RAW DATA EXTRA
SI = im2double(SI);			% NEW CODE TO NOT SAVE RAW DATA EXTRA
imshow(SI);					% NEW CODE TO NOT SAVE RAW DATA EXTRA
%I = load(M.FI{i});
%imshow(I.SI);

x_middle = double(M.P{i}.A);
y_middle = double(M.P{i}.B);
radius = double(M.P{i}.C);

line([(x_middle - 20) (x_middle + 20)],[y_middle y_middle],'LineWidth',1,'Color',[0 1 0]);
line([x_middle x_middle],[(y_middle+20) (y_middle-20)],'LineWidth',1,'Color',[0 1 0]);
[columnsInImage rowsInImage] = meshgrid(1:M.N_DIM(1),1:M.N_DIM(2));
PLATE = (rowsInImage - x_middle).^2 + (columnsInImage - y_middle).^2 <= radius.^2;
CIRCLE = bwboundaries(PLATE);
line(CIRCLE{1,1}(:,1),CIRCLE{1,1}(:,2),'LineWidth',1,'Color',[0 1 0],'LineStyle',':');

line([(x_middle - radius) (x_middle + radius)],[(y_middle + radius) (y_middle + radius)],'LineWidth',1.5,'Color',[0 1 0]);
line([(x_middle - radius) (x_middle + radius)],[(y_middle - radius) (y_middle - radius)],'LineWidth',1.5,'Color',[0 1 0]);
line([(x_middle + radius) (x_middle + radius)],[(y_middle - radius) (y_middle + radius)],'LineWidth',1.5,'Color',[0 1 0]);
line([(x_middle - radius) (x_middle - radius)],[(y_middle - radius) (y_middle + radius)],'LineWidth',1.5,'Color',[0 1 0]);

I = [];	
figure(handles.figure1);	
guidata(hObject,handles);

% --- Executes on button press in Histogram.
function Histogram_Callback(hObject, eventdata, handles)
i   = handles.index;
ImageHisto(handles,i);
figure(handles.figure1);
guidata(hObject,handles);

% --- Executes on button press in Showsegmentation.
function Showsegmentation_Callback(hObject, eventdata, handles)

i   = handles.index;
[H M] = ImageAnalysis(handles,i);
close(gcf);
figure(handles.figure1);
handles   = H;
handles.M = M;
updateP(handles);
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

function inputH_Callback(hObject, eventdata, handles)
% hObject    handle to inputH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.H = str2double(get(hObject,'String'));
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputI_Callback(hObject, eventdata, handles)
% hObject    handle to inputI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = handles.M;
i = handles.index;
M.P{i}.I = str2double(get(hObject,'String'));
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Deleteimage.
function Deleteimage_Callback(hObject, eventdata, handles)
i = handles.index;
if handles.M.N_FRAME > 1
    handles.M.N_FRAME = handles.M.N_FRAME - 1;
    handles.M.NAMES(i) = [];
    handles.M.NA(i)	   = [];
	handles.M.FI(i)    = [];
    handles.M.FI_n(i)  = [];
    handles.M.P(i)     = [];
    handles.M.S(i)     = [];
	if i > handles.M.N_FRAME
        i = handles.M.N_FRAME;
    end
    handles.index = i;
	if handles.M.P{handles.index}.SAVED == 0
		[H] = SaveF(handles,handles.index);
		handles = H;
	end
    updateP(handles);
    updateR(handles);
	handles.start = 1;
	[H] = updateF(handles);
	handles = H;
	H   = [];
end
guidata(hObject,handles);

function inputR_Callback(hObject, eventdata, handles)
% hObject    handle to inputR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
M = handles.M;
i = handles.index;
M.P{i}.R = round(str2double(get(hObject,'String')));
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function inputR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Showpoint.
function Showpoint_Callback(hObject, eventdata, handles)
% hObject    handle to Showpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i = handles.index;
if handles.M.P{i}.PUSH ~= 1
	set(handles.Showpoint,'BackgroundColor','g');
	set(handles.Refinepoint,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Move,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Add,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Delete,'BackgroundColor',[0.9 0.9 0.9]);
	handles.M.P{i}.PUSH = 1;
else
	set(handles.Showpoint,'BackgroundColor',[0.9 0.9 0.9]);
	handles.M.P{i}.PUSH = 0;
end
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes on button press in Refinepoint.
function Refinepoint_Callback(hObject, eventdata, handles)
% hObject    handle to Refinepoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i = handles.index;
if handles.M.P{i}.PUSH ~= 2
	set(handles.Showpoint,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Refinepoint,'BackgroundColor','g');
	set(handles.Move,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Add,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Delete,'BackgroundColor',[0.9 0.9 0.9]);
	handles.M.P{i}.PUSH = 2;
else
	set(handles.Refinepoint,'BackgroundColor',[0.9 0.9 0.9]);
	handles.M.P{i}.PUSH = 0;
end
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes on button press in Move.
function Move_Callback(hObject, eventdata, handles)
% hObject    handle to Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i = handles.index;
if handles.M.P{i}.PUSH ~= 3
	set(handles.Showpoint,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Refinepoint,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Move,'BackgroundColor','g');
	set(handles.Add,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Delete,'BackgroundColor',[0.9 0.9 0.9]);
	handles.M.P{i}.PUSH = 3;
else
	set(handles.Move,'BackgroundColor',[0.9 0.9 0.9]);
	handles.M.P{i}.PUSH = 0;
end
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes on button press in Add.
function Add_Callback(hObject, eventdata, handles)
% hObject    handle to Add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i = handles.index;
if handles.M.P{i}.PUSH ~= 4
	set(handles.Showpoint,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Refinepoint,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Move,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Add,'BackgroundColor','g');
	set(handles.Delete,'BackgroundColor',[0.9 0.9 0.9]);
	handles.M.P{i}.PUSH = 4;
else
	set(handles.Add,'BackgroundColor',[0.9 0.9 0.9]);
	handles.M.P{i}.PUSH = 0;
end
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);
	
% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
% hObject    handle to Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i = handles.index;
if handles.M.P{i}.PUSH ~= 5
	set(handles.Showpoint,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Refinepoint,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Move,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Add,'BackgroundColor',[0.9 0.9 0.9]);
	set(handles.Delete,'BackgroundColor','g');
	handles.M.P{i}.PUSH = 5;
else
	set(handles.Delete,'BackgroundColor',[0.9 0.9 0.9]);
	handles.M.P{i}.PUSH = 0;
end
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);



function To_Callback(hObject, eventdata, handles)
value_from = str2num(get(handles.From,'String'));
value_to   = str2num(get(handles.To,'String'));
n_points   = length(handles.M.S{handles.index}.BOUNDARY(:,1));
if value_to < value_from
	set(handles.To,'String',num2str(value_from+1));
end
if value_to > n_points
	set(handles.To,'String',num2str(n_points));
end

% --- Executes during object creation, after setting all properties.
function To_CreateFcn(hObject, eventdata, handles)
% hObject    handle to To (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RefineSub.
function RefineSub_Callback(hObject, eventdata, handles)
ref_start   = str2num(get(handles.From,'String'));
ref_end 	= str2num(get(handles.To,'String'));
[H] = ImageRefine(ref_start,ref_end,handles);
handles   = H;
updateP(handles);
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes on button press in DeleteSub.
function DeleteSub_Callback(hObject, eventdata, handles)
i 			= handles.index;
del_start   = str2double(get(handles.From,'String'));
del_end     = str2double(get(handles.To,'String'));
del_length  = del_end - del_start + 1;
if del_length > (length(handles.M.S{i}.BOUNDARY)-1)
	handles.M.P{i}.BOUNDARY = 0;
	handles.M.S{i}.BOUNDARY = 0;
	handles.M.P{i}.PUSH 	= 0;
	handles.M.P{i}.MOVE 	= 0;
	set(handles.Current,'String','0')
else
	LINE = handles.M.S{i}.BOUNDARY;
	LINE = LINE(setdiff(1:length(LINE(:,1)),del_start:del_end),:);
	handles.M.S{i}.BOUNDARY = LINE;
end
if length(handles.M.S{i}.BOUNDARY) ~= 1
	set(handles.From,'String','1')
	set(handles.To,'String',num2str(length(LINE(:,1))))
else
	set(handles.From,'String','0')
	set(handles.To,'String','0')
end
updateP(handles);
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

function From_Callback(hObject, eventdata, handles)
value_from = str2num(get(handles.From,'String'));
value_to   = str2num(get(handles.To,'String'));
if value_from > value_to
	set(handles.From,'String',num2str(value_to - 1));
end
if value_from < 1
	set(handles.From,'String','1');
end

% --- Executes during object creation, after setting all properties.
function From_CreateFcn(hObject, eventdata, handles)
% hObject    handle to From (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Points.
function Points_Callback(hObject, eventdata, handles)
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes on button press in Lines.
function Lines_Callback(hObject, eventdata, handles)
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes on button press in Segmentation.
function Segmentation_Callback(hObject, eventdata, handles)
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);

% --- Executes on button press in Centralization.
function Centralization_Callback(hObject, eventdata, handles)
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);


% --- Executes on button press in Find.
function Find_Callback(hObject, eventdata, handles)
% hObject    handle to Find (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i = handles.index;
M = handles.M;
[x_par,y_par,r_par] = FindCenter(handles.M.NAMES{i},handles.M.P{i}.CENTER);
if (x_par + r_par) < M.N_DIM(2) & (x_par - r_par) > 1 & (y_par + r_par) < M.N_DIM(1) & (y_par - r_par) > 1
	M.P{i}.A    = round(x_par);
	M.P{i}.B    = round(y_par);
	M.P{i}.C    = round(r_par);
	M.P{i}.D	= M.P{i}.C;
	M.P{i}.E	= M.P{i}.C;
	M.P{i}.F	= int64(0.9*M.P{i}.C);
end
figure(handles.figure1);
handles.M = M;
updateP(handles);
[H] = SaveF(handles,i);
[H] = updateF(H);
handles = H;
H   = [];
guidata(hObject,handles);

function FindCenter_Callback(hObject, eventdata, handles)
M = handles.M;
i = handles.index;
M.P{i}.CENTER = str2double(get(hObject,'String'));
if M.P{i}.CENTER > 1, M.P{i}.CENTER = 1; end
if M.P{i}.CENTER < 0, M.P{i}.CENTER = 0; end
handles.M = M;
updateP(handles);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function FindCenter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FindCenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LoadAll.
function LoadAll_Callback(hObject, eventdata, handles)
% hObject    handle to LoadAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% for i = 1:handles.M.N_FRAME
	% display(i)
	% display('Save image...')
	% % SAVE IMAGE THE FIRST TIME
	% handles.index = i;
	% if handles.M.P{handles.index}.SAVED == 0
		% [H] = SaveF(handles,handles.index);
		% handles = H;
	% end
	% updateP(handles);
	% updateR(handles);
	% handles.start = 1;
	% [H] = updateF(handles);
	% handles = H;
	% H   = [];
	% guidata(hObject, handles);
% end

for i = 1:handles.M.N_FRAME
	display(i)	
	display('Find center...')
	% FIND CENTER
	M = handles.M;
	[x_par,y_par,r_par] = FindCenter(handles.M.NAMES{i},handles.M.P{i}.CENTER);
	close(gcf);
	if (x_par + r_par) < M.N_DIM(2) & (x_par - r_par) > 1 & (y_par + r_par) < M.N_DIM(1) & (y_par - r_par) > 1
		M.P{i}.A    = round(x_par);
		M.P{i}.B    = round(y_par);
		M.P{i}.C    = round(r_par);
		M.P{i}.D	= M.P{i}.C;
		M.P{i}.E	= M.P{i}.C;
		M.P{i}.F	= int64(0.9*M.P{i}.C);
	end
	figure(handles.figure1);
	handles.M = M;
	updateP(handles);
	[H] = SaveF(handles,i);
	[H] = updateF(H);
    handles = H;
	H   = [];
    guidata(hObject, handles);
end

% --- Executes on button press in CenterCoor.
function CenterCoor_Callback(hObject, eventdata, handles)
% hObject    handle to CenterCoor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i = handles.index;
M = handles.M;
x = str2double(get(handles.xtag,'String'));
y = str2double(get(handles.ytag,'String'));
if x > 0 && y > 0
	M.P{i}.D	= x;
	M.P{i}.E	= y;
end
handles.M = M;

[H M] = ImageAnalysis(handles,i);
close(gcf);
figure(handles.figure1);
handles   = H;
handles.M = M;

i   = handles.index;
[H M] = ImageOutline(handles,i);
handles   = H;
handles.M = M;

ref_start   = 1;
ref_end 	= length(handles.M.S{handles.index}.BOUNDARY(:,1));
[H] = ImageRefine(ref_start,ref_end,handles);
handles   = H;
updateP(handles);
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);


% --- Executes on button press in Recenter.
function Recenter_Callback(hObject, eventdata, handles)
% hObject    handle to Recenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i = handles.index;
M = handles.M;
x = str2double(get(handles.xtag,'String'));
y = str2double(get(handles.ytag,'String'));
if x > 0 && y > 0
	M.P{i}.D	= x;
	M.P{i}.E	= y;
end
handles.M = M;
updateP(handles);
[H] = updateF(handles);
handles = H;
H   = [];
guidata(hObject,handles);


