function [ names ] = getNamesInDictionaty( path )

    allFiles = dir( path );
    names = { allFiles.name };
    

end

