classdef FormatQuery
    %REPRODUCETRIALTOWERS Summary of this class goes here
    %   Detailed explanation goes here

    properties (Constant, Access = private)
        datatypes = {'VARCHAR', 'CHAR', 'DATE', 'DATETIME', 'TIMESTAMP', 'INT', 'BIGINT', 'FLOAT'}
        abv_datatypes = {'CHAR', 'CHAR', 'DATE', 'DATE',      'DATE',   'NUM', 'NUM', 'NUM'}
        datatype_dict = containers.Map(FormatQuery.datatypes,FormatQuery.abv_datatypes)
    end
    properties 
        query_string
    end
    methods (Access = private)
        query_string = formatColumn(obj, column_name, column_datatype, value);
        query_string = formatCharColumn(obj, column_name, value);
        query_string = formatDateColumn(obj, column_name, value);
        query_string = formatNumColumn(obj, column_name, value);
        
    end
    methods
        function obj = FormatQuery(column_name, column_datatype, value)
            obj.query_string = obj.formatColumn(column_name, column_datatype, value);
        end
        
    end
end

