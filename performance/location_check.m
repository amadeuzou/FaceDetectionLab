function location_check

result_file = 'fddb-all-rect.facepp';
truth_file = 'fddb-all-rect.list';

fptr_rt = fopen(result_file, 'r');
fptr_th = fopen(truth_file, 'r');

ntruth = 0;
nresult = 0;
nTP = 0;
nFP = 0;
nOM = 0;
warning off
while ~feof(fptr_rt) & ~feof(fptr_th)
    
    result_line = fgetl(fptr_rt);
    truth_line = fgetl(fptr_th);
    [result_name, result_rects] = parase_line(result_line);
    [truth_name, truth_rects] = parase_line(truth_line);
    if ~strcmp(result_name, truth_name)
        fprintf('maybe not the same image on the same line.\n');
        continue;
    end
    
    ntruth = ntruth + size(truth_rects, 1);
    nresult = nresult + size(result_rects, 1);
    [TP, FP, OM] = check_rects(truth_rects, result_rects);
    nTP = nTP + TP;
    nFP = nFP + FP;
    nOM = nOM + OM;
end

fprintf('truth=%d result=%d TP=%d FP=%d OM=%d\n', ntruth, nresult, nTP, nFP, nOM);
if ntruth ~= nTP + nOM || nresult ~= nTP + nFP
    fprintf('calc error!\n');
end
fprintf('TPR=%f FPR=%f OMR=%f PR=%f\n', nTP/nresult, nFP/nresult, nOM/ntruth, nTP/ntruth);


function [TP, FP, OM] = check_rects(truth_rects, result_rects)
%True-Postive False-Postive Omission-ratio
TP = 0;
FP = 0;
OM = 0;
ntruth = size(truth_rects, 1);
nresult = size(result_rects, 1);
ratio = 0.6;

if ntruth<1
    TP = 0;
    FP = nresult;
    OM = 0;
    return;
end

if nresult<1
    TP = 0;
    FP = 0;
    OM = ntruth;
    return;
end

i = 1;
while i <= size(truth_rects, 1)
    truth_area = truth_rects(i,3)*truth_rects(i,4);
    
    is_inter = 0;
    j = 1;
    while j <= size(result_rects, 1)
        result_area = result_rects(j,3)*result_rects(j,4);
        if rectint(truth_rects(i,:), result_rects(j,:))>ratio*min(truth_area, result_area) 
            TP = TP + 1;
            truth_rects(i,:) = [];
            result_rects(j,:) = [];
            is_inter = 1;
            break;
        else
            j = j +1;
        end
        
    end%for-j
    
    if ~is_inter
        i = i + 1;
    end
    
end%for-i

OM = size(truth_rects, 1);
FP = size(result_rects, 1);


function [name, rects] = parase_line(line_str)

vec = strsplit(line_str, ' ');
name = char(vec{1});
if length(vec)<2
    rects = [];
    return;
end

loc = vec(2:end);
nrects = length(loc)/4;
rects = zeros(nrects, 4);

for i=1:nrects
    rects(i,1) = str2num(loc{4*i-3});
    rects(i,2) = str2num(loc{4*i-2});
    rects(i,3) = str2num(loc{4*i-1});
    rects(i,4) = str2num(loc{4*i});
end