function [err,vr,vradd] = virmenEngineStartup(obj, exper)

vradd = struct;
% Clean up in case of an incorrect exit (e.g. user terminated Virmen by stopping debug mode)
drawnow;
virmenOpenGLRoutines(2);

% No error by default
err = -1;

% Load experiment
vr.exper = exper;
vr.code = exper.experimentCode(); %#ok<*STRNU>
[letterGrid, letterFont, letterAspectRatio] = virmenLoadFont;
[windows, transformations] = virmenLoadWindows(exper);


% Load worlds
vr.worlds = struct([]);
for wNum = 1:length(vr.exper.worlds)
    vr.worlds{wNum} = loadVirmenWorld(vr.exper.worlds{wNum});
    if size(vr.worlds{wNum}.surface.colors,1) == 4
        vr.worlds{wNum}.surface.colors(4,isnan(vr.worlds{wNum}.surface.colors(4,:))) = 1-eps;
    end
end

% Initialize parameters
vr.experimentEnded = false;
vr.currentWorld = 1;
vr.position = vr.worlds{vr.currentWorld}.startLocation;
vr.velocity = [0 0 0 0];
vr.dt = NaN;
vr.dp = NaN(1,4);
vr.dpResolution = inf;
vr.collision = false;
vr.text = struct('string',{},'position',{},'size',{},'color',{},'window',{});
vr.plot = struct('x',{},'y',{},'color',{},'window',{});
vr.textClicked = NaN;
vr.keyPressed = NaN;
vr.keyReleased = NaN;
vr.buttonPressed = NaN;
vr.buttonReleased = NaN;
vr.modifiers = NaN;
vr.activeWindow = NaN;
vr.cursorPosition = NaN;
vr.iterations = 0;
vr.timeStarted = NaN;
vr.timeElapsed = 0;
vr.sensorData = [];

% Configurations that depend on user functions
if exist(func2str(vr.exper.transformationFunction),'file') == 3   % MEX programs don't report nargin
  numTransformInputs = 1;
else
  numTransformInputs = nargin(vr.exper.transformationFunction);
end
numMovementOutputs = nargout(vr.exper.movementFunction);
if numMovementOutputs == 3
  vr.movementExtras = [];
end

% Initialize an OpenGL window
drawnow;
virmenOpenGLRoutines(0,windows,ismac);

try
    vr = vr.code.initialization(vr); %#ok<*NASGU>
catch ME
    drawnow;
    virmenOpenGLRoutines(2);
    err = struct;
    err.message = ME.message;
    err.stack = ME.stack(1:end-1);
    return
end

% Initialize engine
oldWorld = NaN;
oldBackgroundColor = [NaN NaN NaN];
oldColorSize = NaN;
vr.timeStarted = now;

% Timing related info
firstTic = tic;
vr.dt = 0; % Don't move on the first time step


vradd.letterGrid = letterGrid;
vradd.letterFont = letterFont;
vradd.letterAspectRatio = letterAspectRatio;
vradd.windows = windows;
vradd.transformations = transformations;
vradd.oldWorld = oldWorld;
vradd.oldBackgroundColor = oldBackgroundColor;
vradd.oldColorSize = oldColorSize;
vradd.numTransformInputs = numTransformInputs;


