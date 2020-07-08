function [experCode, experFile, protocolTitle, protocolFun] =  getExperimentInfo(obj, acqTable)


session_protocol = split(acqTable{1,'session_protocol'}," ");
experCode = session_protocol{1};
experCode = str2func(strrep(experCode,'.m',''));
experFile = session_protocol{2};
protocolFile = session_protocol{3};
protocolTitle = strrep(protocolFile,'.m','');
protocolFun = str2func(protocolTitle);

end