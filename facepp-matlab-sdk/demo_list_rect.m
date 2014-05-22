function  demo_list_rect

API_KEY = 'd45344602f6ffd77baeab05b99fb7730';
API_SECRET = 'jKb9XJ_GQ5cKs0QOk6Cj1HordHFBWrgL';
api = facepp(API_KEY, API_SECRET);
options.faceApi = api;


image_list = 'fddb-all-image.list';
rect_list = 'fddb-all-rect.facepp';

fptr_rt = fopen(rect_list, 'a+');
fptr_im = fopen(image_list, 'r');
lines = 0;

tic
while  ~feof(fptr_im)
    lines = lines + 1;
    input_file = fgetl(fptr_im);
    rects = getFaceRect(input_file, options);
    fprintf(fptr_rt, input_file);
    fprintf(fptr_rt, ' ');
    fprintf(fptr_rt, '%d ', rects');
    fprintf(fptr_rt, '\n');
end
toc

fclose(fptr_rt);
fclose(fptr_im);