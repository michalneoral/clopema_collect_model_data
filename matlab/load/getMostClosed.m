% search most closed and return its position
function [ pos ] = getMostClosed( time, msgs, topic, pos )

    end_pos = size(msgs{topic,2},2);
    if pos > end_pos
        pos = end_pos;
    end
    
    best_time = abs (time - getTimeOfImage(msgs, topic, pos));
    % increase search
    change = 1;
    while change ~= 0 && pos < end_pos-1
        cur_time = abs(time - getTimeOfImage(msgs, topic, pos+1));
        if  cur_time < best_time
            best_time = cur_time;
            pos = pos+1;
        else
            change = 0;
        end
    end
    % degrease search
    change = 1;
    while change ~= 0 && pos > 1
        cur_time = abs(time - getTimeOfImage(msgs, topic, pos-1));
        if  cur_time < best_time
            best_time = cur_time;
            pos = pos-1;
        else
            change = 0;
        end
    end
    
%     if pos == end_pos
%         disp('LAST IMAGE, MAY BIG TIME ERROR !!!');
%     end    
%     if pos == 1
%         disp('FIRST IMAGE, MAY BIG TIME ERROR !!!');
%     end
    
end

