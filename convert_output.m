function [result,boxa] = convert_output (path_output,path_pics,path_annotation,visualize)


S=load(path_annotation);

boxa = S.adn;
clear S;



[box_type,ymin,xmin,ymax,xmax] = import_ocr_result(path_output);

% detecting different frames
breaks = find (isnan(ymax(:)));

temps = [];
for i=1:length(breaks);
    
    temps(i).start = breaks(i)+1;
    temps(i).frame = str2num(box_type{breaks(i)});
    if i == length(breaks)
        temps(i).end = length(ymax);
    else
        temps(i).end   = breaks(i+1)-1;
    end
end


col   = {'m'};


result = [];
for i = 1:length(temps)
    result(i).frame = temps(i).frame;
    temp = [];
    temp.box = [ymin(temps(i).start:temps(i).end),xmin(temps(i).start:temps(i).end),ymax(temps(i).start:temps(i).end),xmax(temps(i).start:temps(i).end)];
    temp.boxr = [xmin(temps(i).start:temps(i).end),ymin(temps(i).start:temps(i).end),xmax(temps(i).start:temps(i).end)-xmin(temps(i).start:temps(i).end),ymax(temps(i).start:temps(i).end)-ymin(temps(i).start:temps(i).end)];
    temp.names = {box_type{temps(i).start:temps(i).end}};
    a =[];
    a = cell2struct(temp.names,'name',1);
    result(i).names = temp.names;
    result(i).boxn  = temp.box;
    result(i).box   = temp.boxr;
    
end

if visualize
    % visualize results
    
    frame_index = dir(([path_pics,'*.jpeg']));
    
    for i = 1:length(result)
        im = imread([path_pics,frame_index(i).name]);
        figure(1);
        imshow(im);
        for j = 1:length(result(i).names)
            rectangle('Position',result(i).box(j,:),'EdgeColor',col{1});
        end
        waitforbuttonpress();
    end
    
end


