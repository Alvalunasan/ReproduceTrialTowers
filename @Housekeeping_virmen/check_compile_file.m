function check_compile_file(obj, file, ext)

[mex_path, mex_base_name] = fileparts(file);

if ~exist(fullfile(mex_path, [mex_base_name ext]), 'file')
    ac_dir = pwd;
    cd(mex_path)
    mex(file)
    cd(ac_dir);
end
