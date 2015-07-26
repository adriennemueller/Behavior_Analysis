function rslt = get_filegenned_difficulties( session )
    [trials tos] = size(session.TaskObject);

    degree_list = [];
    
    for i = 1:trials
        t1 = extract_degree( session.TaskObject( i, 2 ) );
        t2 = extract_degree( session.TaskObject( i, 3 ) );
        degree = clip_angle( t1, t2 );
        degree_list = [degree_list degree];
    end
    
    rslt = degree_list(session.ConditionNumber);
    rslt = rslt';
    
end

function [rslt, success] = extract_degree( taskobject )
    taskobject = taskobject{1};
    [a, b] = regexp(taskobject, 'rect_(\d+),');
    if length(a) ~= 1
        rslt = [];
        success = false;
        return;
    end

    numstr = taskobject((a+5):(b-1));
    [num, ok] = str2num(numstr);
    if ~ok
        rslt = [];
        success = false;
    end

    
    rslt = num;
    success = true;

end

function degree = clip_angle( t1, t2 )

    degree = max(t1,t2) - min(t1,t2);

    if degree > 90
        degree = 180-degree;
    end

end

