function [nfiles] = showNamesInDictionaty( path )

    names=getNamesInDictionaty(path);
    nfiles=size(names,2);
    for i=1:nfiles
        disp(names(i))
    end

end

