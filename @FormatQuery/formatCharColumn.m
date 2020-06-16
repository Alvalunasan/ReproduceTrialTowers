function query_string = formatCharColumn(obj, column_name, value)

str_patt = '"\S+"';
if isempty(regexp(value, str_patt, 'match'))
    value = strcat('"', value, '"');
end

query_string = strcat(column_name, ' = ', value);

end

