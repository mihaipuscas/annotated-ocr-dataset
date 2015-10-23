function vis_ocr(path_pics,boxa,result, step)

    frame_index = dir(([path_pics,'*.jpeg']));
    types = {'loc750'};
    col   = {'m'};
    figure(1);
    
    for i = 1 :step: length(frame_index)
        im = imread([path_pics,frame_index(i).name]);
        
        imshow(im);
        for j = 1:length(result(i).names)
            for k = 1:length(types)
                if strcmp(types{k},result(i).names{j})
                    rectangle('Position',result(i).box(j,:),'EdgeColor',col{k});
                end
            end
        end
        
        for j = 1 :length(boxa)
            if i >= boxa(j).startfr && i <=boxa(j).stopfr
                rectangle('Position',boxa(j).coord,'EdgeColor','y');
            end
        end
    
        aaa = waitforbuttonpress;
    end
end
