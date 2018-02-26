function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 26-Feb-2018 14:52:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
clc;
axes(handles.axes4);
imshow(imread('tooth_vector.jpg'));
set(handles.instruction,'String','Please Browse for Radiograph Input Image');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im filename pathname m n
[filename, pathname]=uigetfile({'*.jpg;*.jpeg;*.tif;*.png;*.gif;'},'Choose Input Data');
image=[filename pathname];
if filename ~=0
    im=imread([pathname, filename]);
    %im=imrotate(im,180);
    axes(handles.axes1);
    imshow(im);
    set(handles.edit1,'string',filename);
    [m,n,o]=size(im);
    sizeori=([num2str(m),'x',num2str(n)]);
    set(handles.edit4,'string',sizeori);
else
    return
end

set(handles.prepro,'Enable','on')
set(handles.crop,'Enable','on')
set(handles.save,'Enable','on')
set(handles.instruction,'String','Click on Crop or Pre Processing');


% --- Executes on button press in prepro.
function prepro_Callback(hObject, eventdata, handles)
% hObject    handle to prepro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im gbrgray timeprep gaborFB
tic
uk=32;
%gambar=im;
gbrresize=imresize(im,[uk uk]);
%gbradjust=imadjust(gbrresize,stretchlim(gbrresize),[])
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);
gbrgray=rgb2gray(gbrresize);
Gray = gbrgray(:,:,1);
axes(handles.axes3);
imshow(gbrgray);
[m,n,o]=size(gbrgray);
sizeprepro=([num2str(m),'x',num2str(n)]);
set(handles.edit4,'string',sizeprepro);
set(handles.edit5,'string','OK!');
set(handles.gabor,'Enable','on');
timeprep = toc;
set(handles.edit3,'String',timeprep);
set(handles.instruction,'String','Click on Gabor Process to Process Image');
%textLabel = sprintf('Feature Extracted using %f scale and %f orientation', gaborFB.u, gaborFB.v);
%set(handles.text1, 'String', textLabel);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in crop.
function crop_Callback(hObject, eventdata, handles)
% hObject    handle to crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im imnocrop
set(handles.instruction,'String','Adjust Cropping Area and Click Twice to Complete');
[m,n,o]=size(im);
imnocrop=im;
axes(handles.axes1)
imshow(im);
h = imrect(gca,[n/2 m/2 0.2*m 0.2*m]); %crop size
wait(h);
mask = createMask(h);

axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
imshow(im);

hold on

[B,~] = bwboundaries(mask,'noholes');
    for k = 1:length(B)
        boundary = B{k};
        plot(boundary(:,2), boundary(:,1), 'b', 'LineWidth', 2)
    end
    
hold off

        R = im(:,:,1);
        G = im(:,:,2);
        B = im(:,:,3);
        R(~mask) = 0;
        G(~mask) = 0;
        B(~mask) = 0;
        RGB = cat(3,R,G,B);
        [row,col] = find(mask==1);
        im = imcrop(RGB,[min(col) min(row) max(col)-min(col) max(row)-min(row)]);%crop rectangle
        axes(handles.axes1)
        imshow(im);
[m,n,o]=size(im);
sizecrop=([num2str(max(col)-min(col)),'x',num2str(max(row)-min(row))]);
cropcoordinate=(['[',num2str(min(col)),'-', num2str(max(col)),']',' ','[', num2str(min(row)),'-', num2str(max(row)),']']);
set(handles.edit4,'string',sizecrop);
set(handles.undocrop,'Enable','on');
set(handles.edit15,'string',cropcoordinate);
set(handles.instruction,'String','Proceed to Pre Processing or Undo if unsatisfied');


% --- Executes on button press in undocrop.
function undocrop_Callback(hObject, eventdata, handles)
% hObject    handle to undocrop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im imnocrop
im=imnocrop;
axes(handles.axes1)
imshow(im);
set(handles.edit2,'String','');
set(handles.edit15,'string','');
set(handles.instruction,'String','Crop Again');

% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
clear all;
close(main)


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
box on
axes(handles.axes3)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
box on
set(handles.edit1,'String',''); %empty file name
set(handles.edit2,'String',''); %empty result
set(handles.edit4,'String',''); %empty size
set(handles.edit5,'String',''); %empty ok
set(handles.edit3,'String',''); %empty time
set(handles.edit9,'String',''); %empty gabor verification
set(handles.edit15,'string','');
set(handles.crop,'Enable','off');
set(handles.save,'Enable','off');
set(handles.prepro,'Enable','off');
set(handles.gabor,'Enable','off');
set(handles.displayfilter,'Enable','off')
set(handles.displayfiltered,'Enable','off')
set(handles.testresult,'Enable','off');
set(handles.undocrop,'Enable','off');
set(handles.instruction,'String','Please Browse for Input Image');
clear all

% --- Executes on button press in gabor.
function gabor_Callback(hObject, eventdata, handles)
% hObject    handle to gabor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im m n gbrgray textMean textStd textSkew textVar textKurtosis timeprep timeeks matriksFeature gaborFB
tic
textEntropy=entropy(gbrgray);
%gabor parameters
gaborFB.u = 5; %scale
gaborFB.v = 8; %orientation
gaborFB.m = 39; %form matriks filter size
gaborFB.n = 39; %form matriks filter size
gaborFE.d1 = 4; %downsampling
gaborFE.d2 = 4; %downsampling
%gabor calling
[matriksFeature] = GaborFilter(gaborFB, gaborFE, gbrgray);
set(handles.edit6,'String',textMean);
set(handles.edit7,'String',textStd);
set(handles.edit8,'String',textSkew);
set(handles.edit11,'String',textVar);
set(handles.edit12,'String',textKurtosis);
set(handles.edit13,'String',textEntropy);
%x=1;
%while 1
%    file = sprintf('ciri_%d.mat',x);
%    if exist(file)
%        x=x+1;
%    else
%        break
%    end
%end
%file = sprintf('ciri_%d.mat',x);
%save(file, 'featVecOri');
set(handles.displayfilter,'Enable','on')
set(handles.displayfiltered,'Enable','on')
set(handles.edit9,'String','Gabor Matrix Obtained');
timeeks=toc;
timetot = timeprep + timeeks;
set(handles.edit3,'String',timetot);
set(handles.testresult,'Enable','on');
set(handles.instruction,'String','Test Result using SVM Classification');



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in testresult.
function testresult_Callback(hObject, eventdata, handles)
% hObject    handle to testresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global timeprep timeeks matriksFeature
tic
load training_result.mat
num_test = 0;
num_correct = 0;
kerneloption  = 9;
kernel='rbf';
id_class_test = svmmultival(matriksFeature', xsup, w, b, nbsv, kernel, kerneloption);
result = target(id_class_test);
set(handles.edit2,'String',result);
timeclas=toc;
timetot= timeprep + timeeks + timeclas;
set(handles.edit3,'String',timetot);
set(handles.instruction,'String','Result Obtained');



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
imwrite(im, 'Data Coba\test_01.jpg' , 'jpg');


% --- Executes on button press in displayfilter.
function displayfilter_Callback(hObject, eventdata, handles)
% hObject    handle to displayfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gaborFigFil gaborFB
figure('NumberTitle','Off','Name','Real parts of Gabor filters');
for i = 1:gaborFB.u
     for j = 1:gaborFB.v        
         subplot(gaborFB.u,gaborFB.v,(i-1)*gaborFB.v+j);        
         imshow(real(gaborFigFil{i,j}),[]);
     end
end
figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
for i = 1:gaborFB.u
    for j = 1:gaborFB.v        
        subplot(gaborFB.u,gaborFB.v,(i-1)*gaborFB.v+j);        
        imshow(abs(gaborFigFil{i,j}),[]);
    end
end



% --- Executes on button press in displayfiltered.
function displayfiltered_Callback(hObject, eventdata, handles)
% hObject    handle to displayfiltered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gaborFigRes gaborFB
figure('NumberTitle','Off','Name','Real parts of Gabor filtered image');
for i = 1:gaborFB.u
    for j = 1:gaborFB.v        
        subplot(gaborFB.u,gaborFB.v,(i-1)*gaborFB.v+j)    
        imshow(real(gaborFigRes{i,j}),[]);
    end
end
figure('NumberTitle','Off','Name','Magnitudes of Gabor filtered image');
for i = 1:gaborFB.u
    for j = 1:gaborFB.v        
        subplot(gaborFB.u,gaborFB.v,(i-1)*gaborFB.v+j)    
        imshow(abs(gaborFigRes{i,j}),[]);
    end
end


function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end