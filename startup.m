run('/usr/local/MATLAB/R2015b/toolbox/sundialsTB/startup_STB');
addpath('/home/amahmutoglu/pbd/cirsium/dev');
addpath('/home/amahmutoglu/pbd/cirsium/dev/freq-dom');
addpath('/home/amahmutoglu/matlab/matlab2tikz/src');

% start mapp
addpath('/home/amahmutoglu/pbd/mapp/');
% run('/home/amahmutoglu/prj/mapp/start_MAPP');

% set grid on
set(0,'DefaultAxesXGrid','on','DefaultAxesYGrid','on');

% Set plot position and font
%figW = 560;
%figH = 420;
%scrnSize = get(0,'ScreenSize');
%set(0, 'DefaultFigurePosition', [scrnSize(3)/2-4*figW/5,...
%                                        scrnSize(4)-figH-250 figW, figH]);
%clear figW figH scrnSize
% set(0, 'DefaultAxesFontSize', 12);
% set(0, 'DefaultAxesFontName', 'Helvetica');
% set(0, 'DefaultAxesFontWeight', 'bold');

% Disable toostrip mnemonics
com.mathworks.desktop.mnemonics.MnemonicsManagers.get.disable

% disable the new JxBrowser used in the doc pages -> this has a bug causing
% 100% cpu usage when idle, see 
% http://www.mathworks.com/matlabcentral/answers/114915-why-does-matlab-cause-my-cpu-to-spike-even-when-matlab-is-idle-in-matlab-8-0-r2012b
com.mathworks.mlwidgets.html.HtmlComponentFactory.setDefaultType('HTMLRENDERER');
