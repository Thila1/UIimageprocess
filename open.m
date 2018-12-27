function varargout = open(varargin)
% OPEN MATLAB code for open.fig
%      OPEN, by itself, creates a new OPEN or raises the existing
%      singleton*.
%
%      H = OPEN returns the handle to a new OPEN or the handle to
%      the existing singleton*.
%
%      OPEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPEN.M with the given input arguments.
%
%      OPEN('Property','Value',...) creates a new OPEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before open_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to open_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help open

% Last Modified by GUIDE v2.5 17-Oct-2018 16:42:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @open_OpeningFcn, ...
                   'gui_OutputFcn',  @open_OutputFcn, ...
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


% --- Executes just before open is made visible.
function open_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to open (see VARARGIN)

% Choose default command line output for open
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes open wait for user response (see UIRESUME)
% uiwait(handles.figure1);
 

% --- Outputs from this function are returned to the command line.
function varargout = open_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open_button.
function open_button_Callback(hObject, eventdata, handles)
% hObject    handle to open_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [filename, pathname] =uigetfile({'*.*';'*.dcm';'*.jpg';'*.png';'*.avi'},'Select One or More Files','MultiSelect', 'on');
%  imagesFile=strcat(pathname,filename);
%  
      global imageFiles file;
      [file,path] = uigetfile('*.jpg', 'Select One or More Files','MultiSelect', 'on');
      imageFiles=strcat(path,file);
      
     
      
      


% --------------------------------------------------------------------
function uitoggletool7_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  
  global imageFiles;
  
  imgs=imageFiles;
  
  set(handles.diff1,'string','0');
  set(handles.diff2,'string','0');
  set(handles.diff3,'string','0');
  
  global indexs row position data1 data2 data3;
  global hand hobj;
  global time zoom milimter_plex poisiton_m avg_data fps dimeter_of mili;
  hand=handles;
  hobj=hObject;
  position=1;
  indexs=1;
  
  
    % add data to excel array
  time={};
  fps=10;
  mili=0;
  zoom={};
  milimter_plex={};
  poisiton_m={};
  avg_data={};
  dimeter_of={};
  
  
  data1={};
  data2={};
  data3={};
  data1{indexs}=0;
  data2{indexs}=0;
  data3{indexs}=0;
  
  [~,row]=size(imageFiles);
           clc;
           file_path_charater=char(cell(imgs(indexs)));
           readImage=imread(file_path_charater);
           axes(handles.initImage);
           imgesce_varible=imagesc(readImage); 
           imgesce_varible.ButtonDownFcn=@OnClick_Event;     
           set(handles.initImage,'Units','normalized');
           h = imdistline(gca);
           global api;
           api = iptgetapi(h);
           set(handles.num_images,'string',row);
           set(handles.index_image,'string',indexs);

           
           fps=str2double(get(handles.fps_val,'String'));
           milimter_plex{1}=str2double(get(handles.pixle_pre,'String'));
           mili=str2double(get(handles.pixle_pre,'String'));
           poisiton_m{1}=get(handles.possition_txt,'String');
    
% --- Executes on button press in nextImage.
function nextImage_Callback(hObject, eventdata, handles)
% hObject    handle to nextImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  global indexs row fps dimeter_of mili avg_data data1 data2 data3 d1 d2 d3;
  global imageFiles position;
  imgs=imageFiles;
  
  position=1;
  
   sta_val=get(handles.frist_value,'Value');
   sta_avg_val=get(handles.avg_check ,'Value');
   
  
  if sta_val
       avg_data{indexs}=(data1{indexs});
       dimeter_of{indexs}=(mili)*(avg_data{indexs});
  else
       % calcution before frame analysis
 
       if sta_avg_val
           avg_data{indexs}=(((data1{indexs})+(data2{indexs})+(data3{indexs}))/3);
           dimeter_of{indexs}=(mili)*(avg_data{indexs});
       end
  end
  d1=0;
  d2=0;
  d3=0;
  set(handles.diff1,'string','0');
  set(handles.diff2,'string','0');
  set(handles.diff3,'string','0');
  
  if (indexs<row)
     indexs=indexs+1;
     data1{indexs}=0;
     data2{indexs}=0;
     data3{indexs}=0;
  end
           % set time dispaly
           time_of=(indexs)*(1/fps);
           set(handles.time_l,'string',time_of);
           set(handles.index_image,'string',indexs);
 
           clc;
           file_path_charater=char(cell(imgs(indexs)));
           readImage=imread(file_path_charater);
           axes(handles.initImage);
           imgesce_varible=imagesc(readImage); 
           imgesce_varible.ButtonDownFcn=@OnClick_Event;     
           set(handles.initImage,'Units','normalized');
           h = imdistline(gca);
           global api;
           api = iptgetapi(h);
  

function diff1_Callback(hObject, eventdata, handles)
% hObject    handle to diff1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of diff1 as text
%        str2double(get(hObject,'String')) returns contents of diff1 as a double


% --- Executes during object creation, after setting all properties.
function diff1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diff1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function diff3_Callback(hObject, eventdata, handles)
% hObject    handle to diff3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of diff3 as text
%        str2double(get(hObject,'String')) returns contents of diff3 as a double


% --- Executes during object creation, after setting all properties.
function diff3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diff3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function diff2_Callback(hObject, eventdata, handles)
% hObject    handle to diff2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of diff2 as text
%        str2double(get(hObject,'String')) returns contents of diff2 as a double


% --- Executes during object creation, after setting all properties.
function diff2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diff2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function initImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate initImage



% --- Executes on mouse press over axes background.
function initImage_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to initImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on pushbutton4 and none of its controls.
function pushbutton4_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function uipanel1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function OnClick_Event(hObject, eventdata,handles)
global api;
global hand;
global position data1 data2 data3 d1 d2 d3;
global indexs time zoom milimter_plex poisiton_m fps;

status_val=get(hand.frist_value,'Value');
        d1=0;
        d2=0;
        d3=0;
if status_val
    position=1;
    dist =api.getDistance();
    data1{indexs}=dist;
    set(hand.diff1,'string',dist);
    
end

if (eventdata.Button==3)   
     dist =api.getDistance();
    if (position==3)
        data3{indexs}=dist;
        set(hand.diff3,'string',dist);
        d3=1;
    end   
    if (position==1)
        data1{indexs}=dist;
        set(hand.diff1,'string',dist);
        d1=1;
        
    end
    if (position==2)
        data2{indexs}=dist;
        d2=1;
        set(hand.diff2,'string',dist);
    end
    
    position=position+1;
    if position==4
        position=1;
    end
 
    fps=str2double(get(hand.fps_val,'String'));
    time{indexs}=(indexs)*(1/fps);
    zoom{indexs}=get(hand.zoom,'String');
    milimter_plex{indexs}=str2double(get(hand.pixle_pre,'String'));
    poisiton_m{indexs}=get(hand.possition_txt,'String');    
end



function num_images_Callback(hObject, eventdata, handles)
% hObject    handle to num_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_images as text
%        str2double(get(hObject,'String')) returns contents of num_images as a double


% --- Executes during object creation, after setting all properties.
function num_images_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function index_image_Callback(hObject, eventdata, handles)
% hObject    handle to index_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of index_image as text
%        str2double(get(hObject,'String')) returns contents of index_image as a double


% --- Executes during object creation, after setting all properties.
function index_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to index_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fileWriterButton.
function fileWriterButton_Callback(hObject, eventdata, handles)
% hObject    handle to fileWriterButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  clc;
  extention='.xlsx';
  global data1 data2 data3 d1 d2 d3;
  global time zoom milimter_plex poisiton_m indexs avg_data dimeter_of mili;
  sta_val=get(handles.frist_value,'Value');
  sta_avg_val=get(handles.avg_check ,'Value');
  d1=0;
  d2=0;
  d3=0;
  if sta_val
       avg_data{indexs}=(data1{indexs});
       dimeter_of{indexs}=(mili)*(avg_data{indexs});
  else
       
      if sta_avg_val
        % calcution for frame current frame
        avg_data{indexs}=(((data1{indexs})+(data2{indexs})+(data3{indexs}))/3); % first code
        dimeter_of{indexs}=(mili)*(avg_data{indexs}); % second code
      end
      
      if ~sta_avg_val
          % calcution for frame current frame
%           avg_data{indexs}=(((data1{indexs})+(data2{indexs})+(data3{indexs}))/3); % first code
%           dimeter_of{indexs}=(mili)*(avg_data{indexs}); % second code
      end
  end
  
  write_array=[];
  value=get(handles.avg_check,'Value');
  if value
      if sta_val
        write_array=['Time of Frame(s)',time;'Zoom(X)',zoom;'Posipion',poisiton_m;'Pixel_Milimiter',milimter_plex;'Value_01',data1;'Avg_Pixel',avg_data;'Dimeter(mm)',dimeter_of;]';   
      else
        write_array=['Time of Frame(s)',time;'Zoom(X)',zoom;'Posipion',poisiton_m;'Pixel_Milimiter',milimter_plex;'Value_01',data1;'Value_02',data2;'Value_03',data3;'Avg_Pixel',avg_data;'Dimeter(mm)',dimeter_of;]';
      end
  else
      if sta_val
         write_array=['Time of Frame(s)',time;'Zoom(X)',zoom;'Posipion',poisiton_m;'Pixel_Milimiter',milimter_plex;'Value_01',data1;]';   
      else
         write_array=['Time of Frame(s)',time;'Zoom(X)',zoom;'Posipion',poisiton_m;'Pixel_Milimiter',milimter_plex;'Value_01',data1;'Value_02',data2;'Value_03',data3;]';
% write_array=['Time of Frame(s)',time;'Zoom(X)',zoom;'Posipion',poisiton_m;'Pixel_Milimiter',milimter_plex;'Value_01',data1;]';

      end
  end
  
  
  
  % add data to excel array
  selpath = uigetdir;
  nameValue=get(handles.fileName,'String');
  saveFilePath=strcat(selpath,strcat('\',strcat(nameValue,extention)));

  
   status=xlswrite(saveFilePath,write_array);
   if(status==1)
       set(handles.dispalyWrite,'String','Succes...');
   end
   if(status==0)
       set(handles.dispalyWrite,'String','Error...');
   end

function fileName_Callback(hObject, eventdata, handles)
% hObject    handle to fileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileName as text
%        str2double(get(hObject,'String')) returns contents of fileName as a double


% --- Executes during object creation, after setting all properties.
function fileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in avg_check.
function avg_check_Callback(hObject, eventdata, handles)
% hObject    handle to avg_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of avg_check



function zoom_Callback(hObject, eventdata, handles)
% hObject    handle to zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zoom as text
%        str2double(get(hObject,'String')) returns contents of zoom as a double


% --- Executes during object creation, after setting all properties.
function zoom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_l_Callback(hObject, eventdata, handles)
% hObject    handle to time_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_l as text
%        str2double(get(hObject,'String')) returns contents of time_l as a double


% --- Executes during object creation, after setting all properties.
function time_l_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fps_val_Callback(hObject, eventdata, handles)
% hObject    handle to fps_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fps_val as text
%        str2double(get(hObject,'String')) returns contents of fps_val as a double


% --- Executes during object creation, after setting all properties.
function fps_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fps_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over nextImage.
function nextImage_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to nextImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function pixle_pre_Callback(hObject, eventdata, handles)
% hObject    handle to pixle_pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pixle_pre as text
%        str2double(get(hObject,'String')) returns contents of pixle_pre as a double


% --- Executes during object creation, after setting all properties.
function pixle_pre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pixle_pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function possition_txt_Callback(hObject, eventdata, handles)
% hObject    handle to possition_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of possition_txt as text
%        str2double(get(hObject,'String')) returns contents of possition_txt as a double


% --- Executes during object creation, after setting all properties.
function possition_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to possition_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in frist_value.
function frist_value_Callback(hObject, eventdata, handles)
% hObject    handle to frist_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frist_value
