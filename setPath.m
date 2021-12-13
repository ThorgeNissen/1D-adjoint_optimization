function [params] = setPath

    base_path   = pwd;
    lib_folder  = fullfile(base_path, 'lib')
    addpath(genpath(lib_folder))
    
    params.base.user    = 'tnissen';
    params.base.case    = '1D-Burgers';
    %params.base.case    = '1D-Transport';
    
end