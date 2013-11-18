function [ topics ] = loadTopic( file )

topic_file=fopen(file);
top=textscan(topic_file,'%s');

topics=top{1,1};
end

