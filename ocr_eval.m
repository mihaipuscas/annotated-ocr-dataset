% OCR EVAL

clc; clear all;

path_pics = 'euronews_frames/';                     % dataset folder
path_output = 'results_captioncapture.txt';         % raw  output path
path_annotation ='adnotari_ocr.mat';                % annotation path


% standardize
vis = 0;

[result,boxa]       = convert_output (path_output,path_pics,path_annotation,vis);
[precision,recall]  = ocr_pr(path_pics,boxa,result);

display(['Precision = ', num2str(precision)]);
display(['Recall    = ', num2str(recall)]);

%% visualize results & annotation
step = 1; % frame iteration step
vis_ocr(path_pics,boxa,result,step);


    