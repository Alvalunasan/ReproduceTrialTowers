function [] = virmenEngineStop()
%VIRMENENGINESTOP Summary of this function goes here
%   Detailed explanation goes here
% Display engine runtime information
% disp(['Ran ' num2str(vr.iterations-1) ' iterations in ' num2str(vr.timeElapsed,4) ...
%     ' s (' num2str(vr.timeElapsed*1000/(vr.iterations-1),3) ' ms/frame refresh time).']);
% 
% % Run termination code
% try
%       vr.code.termination(vr);
% catch ME
%       drawnow;
%       virmenOpenGLRoutines(2);
%       err = struct;
%       err.message = ME.message;
%       err.stack = ME.stack(1:end-1);
%       return
% end

% Close the window used by ViRMEn
drawnow;
virmenOpenGLRoutines(2);
end

