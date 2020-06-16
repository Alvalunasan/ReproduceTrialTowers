function abv_datatype = get_abv_datatype(obj, datatype)

    if ~contains(obj.datatypes,datatype)
        error(strcat("datatype must be one of the following", strjoin(obj.datatypes,", ")))
    end
    
    abv_datatype = obj.datatype_dict(datatype);

end

