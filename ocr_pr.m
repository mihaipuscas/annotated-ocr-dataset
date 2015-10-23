function [precision,recall] = ocr_pr(path_pics,boxa,result) 


    frame_index = dir(([path_pics,'*.jpeg']));
    obj = [];           % detected object vector initialization
    nr_prec   = 0;      % nr of hits
    nr_obj    = 0;      % nr of results
    
    for i = 1 :length(frame_index)-1
        % get adno
        annotations = [];
        for j = 1 :length(boxa)
            if i >= boxa(j).startfr && i <=boxa(j).stopfr
                annotations = vertcat(annotations,boxa(j).coordn); 
            end
        end
        
        % annotated object detection vector init
        nr_recall = zeros(1,size(annotations,1));
        
        for j = 1 : length(result(i).names)
            
            nr_obj = nr_obj+1;
            bboxr = result(i).boxn(j,:);
            for k = 1 : size(annotations,1)
                bboxa = annotations(k,:);
                
                if IoU(bboxa,bboxr)>0
%                     display(IoU(bboxa,bboxr));
                end
                
                if IoU(bboxa,bboxr) >= 0.5
                    
                    nr_prec      = nr_prec+1;
                    nr_recall(k) = 1;
                    
                end
            end  
        end     
        obj = [obj, nr_recall];      
    end
    
     
    precision = nr_prec/nr_obj;
    recall    = mean(obj);