function query_string = formatColumn(obj, column_name, column_datatype, value)

    abv_datatype = obj.get_abv_datatype(column_datatype);

    if ischar(value)
        
    elseif isnumeric(value)
        
    elseif iscell(value)
        if length(value) == 1 && (ischar(value{1}) || isnumeric(value{1}))
            value = value{1};
        else
            error("Cell value must be a 1x1 string or numeric cell for Column value")
        end
    else
        error("Column value must be string, number or cell to formatQuery")
    end
    
    if strcmp(abv_datatype, 'CHAR')
        query_string = obj.formatCharColumn(column_name, value);
    elseif strcmp(abv_datatype, 'DATE')
        query_string = obj.formatDateColumn(column_name, value);
    elseif strcmp(abv_datatype, 'NUM')
        query_string = obj.formatNumColumn(column_name, value);
    end

end

