function query_string = formatNumColumn(obj, column_name, value)

if isnumeric(value)
    value = num2str(value);
end

query_string = strcat(column_name, ' = ', value);

end

