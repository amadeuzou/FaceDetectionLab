function rects = getFaceRect(input_file, options)


%%
rects = [];
try
    im = imread(input_file);
catch
    disp('cannot load image!');
    return;
end

warning off

%%
api = options.faceApi;
try
    results = detect_file(options.faceApi, input_file, 'all');
catch
    return;
end
if length(results) < 1
    return;
end

faces = results{1}.face;
nfaces = length(faces);
%[pathstr,name,ext]=fileparts(imgFile);

if nfaces < 1
    return;
end

%%
img_width = results{1}.img_width;
img_height = results{1}.img_height;

rects = zeros(length(faces), 4);
for i = 1 : length(faces)
    % Draw face rectangle on the image
    face_i = faces{i};
    att = face_i.attribute;
    %[att.gender.value num2str(att.age.value) att.race.value]

    %
    center = face_i.position.center;
    w = face_i.position.width / 100 * img_width;
    h = face_i.position.height / 100 * img_height;
    %rectangle('Position', ...
    %    [center.x * img_width / 100 -  w/2, center.y * img_height / 100 - h/2, w, h], ...
    %    'Curvature', 0.4, 'LineWidth',2, 'EdgeColor', 'g');
    rects(i,:) = round([center.x * img_width / 100 -  w/2, center.y * img_height / 100 - h/2, w, h]);
end