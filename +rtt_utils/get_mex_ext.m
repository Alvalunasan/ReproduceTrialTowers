function ext = get_mex_ext()

if ispc
    ext = '.mexw64';
elseif ismac
    ext = '.mexmaci64';
else
    ext = '.mexa64';
end