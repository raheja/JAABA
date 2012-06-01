%% script for making plots used to demonstrate accuracy of detectors

%% set up path

addpath ../perframe;
addpath ../perframe/compute_perframe_features;
addpath ../misc;
addpath ../filehandling;
outfigdir = '../figures/AccuracyOut';
if ispc,
  addpath C:\Code\Ctrax\trunk\matlab\netlab;
else
  addpath /groups/branson/home/bransonk/tracking/code/Ctrax/matlab/netlab;
end
if ~exist(outfigdir,'dir'),
  mkdir(outfigdir);
end


%% global parameters

% sample frames
annfilestr = 'movie.ufmf.ann';
colorpos = [.7,0,0];
colorneg = [0,0,.7];
border = 16;
border_mouse = border*2;
bg_thresh = 10/255;
fg_thresh_mouse = .7;
wmah = .5;
frac_a_back = 1;
dist_epsilon = .1;
figpos_example = [100 400 1800 650];
nframes_sample_bkgd = 30;

fg_thresh_larvae = 60/255;
bg_thresh_larvae = .11;
fg_thresh_larvae2 = .35;
bg_thresh_larvae2 = .15;

TOUCH = 1;
CRABWALK = 2;
BACKUP = 3;
CHASE = 4;
WINGGROOMING = 5;
JUMP = 6;
STOP = 7;
RIGHTING = 8;
TAILPIVOTTURN = 9;
WALK = 10;

MOUSE_WALK = 11;
MOUSE_MALEFOLLOW = 12;

LARVA_HEADCAST = 13;
LARVA_CRAWL = 14;

ncolors_reference = 256;
reference_jet = jet(ncolors_reference);


%% TOUCH parameters

behavior = 'Touch';
scoresfilestr = 'scoresTouch.mat';
rootdatadir = 'C:/Data/JAABA/groundtruth_pBDPGAL4U_data';
experiment_name = 'pBDPGAL4U_TrpA_Rig2Plate17BowlC_20110811T133805';
mainfly = 3;
otherflies = 18;
ts = [13879,13882,13888,13892,13894,13899];
ts_overlay = [13875,13882,13888,13899];

%% TOUCH draw example frames

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'ncolors_reference',ncolors_reference,...
  'hfig_base',TOUCH*100);

%% CRABWALK

behavior = 'Crabwalk';
scoresfilestr = 'scoresCrabwalk.mat';
rootdatadir = 'C:/Data/JAABA/groundtruth_pBDPGAL4U_data';
experiment_name = 'pBDPGAL4U_TrpA_Rig1Plate10BowlB_20110609T091905';
mainfly = 19;
otherflies = [];
ts = 15383:4:15403;
ts_overlay = 15383:4:15423;
%ts = round(linspace(15370,15407,6));

%% CRABWALK draw example frames

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'ncolors_reference',ncolors_reference,...
  'hfig_base',CRABWALK*100);

%% BACKUP

behavior = 'Backup';
scoresfilestr = 'scoresBackup.mat';
rootdatadir = 'C:/Data/JAABA/FlyBowl';
experiment_name = 'pBDPGAL4U_TrpA_Rig1Plate15BowlB_20110922T145928';
mainfly = 1;
otherflies = [];
ts = 12390:4:12406;
ts_overlay = [12390,12398,12406];

%% BACKUP draw example frames

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'ncolors_reference',ncolors_reference,...
  'hfig_base',BACKUP*100);


%% CHASE

behavior = 'Chase';
scoresfilestr = 'scores_Chasev7.mat';
rootdatadir = 'C:/Data/JAABA/FlyBowl';
experiment_name = 'pBDPGAL4U_TrpA_Rig1Plate15BowlB_20110922T145928';
mainfly = 20;
otherflies = [12];
ts_overlay = [6440,6461,6470,6480,6490];
ts = ts_overlay;

%% CHASE plot example frames

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'ncolors_reference',ncolors_reference,...
  'hfig_base',CHASE*100);

%% different CHASE

behavior = 'Chase';
scoresfilestr = 'scores_Chasev7.mat';
rootdatadir = 'C:/Data/JAABA/groundtruth_pBDPGAL4U_data';
experiment_name = 'pBDPGAL4U_TrpA_Rig2Plate17BowlD_20111130T094443';
mainfly = 16;
otherflies = [9];
ts_overlay = 22464+(0:10:50);
ts = ts_overlay;

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'ncolors_reference',ncolors_reference,...
  'hfig_base',(CHASE+.5)*100);

%% WINGGROOMING

behavior = 'WingGrooming';
scoresfilestr = 'scoresWingGrooming.mat';
rootdatadir = 'C:/Data/JAABA/FlyBowl';
experiment_name = 'pBDPGAL4U_TrpA_Rig2Plate14BowlD_20110615T164545';
mainfly = 17;
otherflies = [];
%ts = [9962,9963,9964,9965,9966,9967,9968];
%ts = [10179,10185,10186,10187,10188,10189];
ts = 10291:10296;
ts_overlay = ts;
%ts = round(linspace(15370,15407,6));

%% WINGGROOMING plot example frames

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'hfig_base',WINGGROOMING*100,...
  'ncolors_reference',ncolors_reference,...
  'doplotellipseoverlay',true);

%% JUMP

behavior = 'Jump';
scoresfilestr = 'scores_Jump.mat';
rootdatadir = 'C:/Data/JAABA/groundtruth_pBDPGAL4U_data';
experiment_name = 'pBDPGAL4U_TrpA_Rig2Plate17BowlD_20111130T094443';
mainfly = 8;
otherflies = [];
ts = [18598 18599 18600 18601 18602];
ts_overlay = ts;

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'ncolors_reference',ncolors_reference,...
  'hfig_base',JUMP*100);

%% STOP

behavior = 'Stop';
scoresfilestr = 'scores_Stops.mat';
rootdatadir = 'C:/Data/JAABA/groundtruth_pBDPGAL4U_data';
experiment_name = 'pBDPGAL4U_TrpA_Rig2Plate17BowlD_20111130T094443';
mainfly = 1;
otherflies = [];
ts = [12060 12065 12070 12075];
ts_overlay = ts;

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'ncolors_reference',ncolors_reference,...
  'hfig_base',STOP*100);

%% RIGHTING

behavior = 'Righting';
scoresfilestr = 'scores_Righting.mat';
rootdatadir = 'C:/Data/JAABA/groundtruth_pBDPGAL4U_data';
experiment_name = 'pBDPGAL4U_TrpA_Rig2Plate17BowlD_20111130T094443';
mainfly = 18;
otherflies = [];
ts = [12067 12070 12074 12078 12088 12092];
ts_overlay = ts;

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'ncolors_reference',ncolors_reference,...
  'hfig_base',RIGHTING*100);

%% TAILPIVOTTURN

behavior = 'TailPivotTurn';
scoresfilestr = 'scores_pivot_tail.mat';
rootdatadir = 'C:/Data/JAABA/groundtruth_pBDPGAL4U_data';
experiment_name = 'pBDPGAL4U_TrpA_Rig2Plate17BowlD_20111130T094443';
mainfly = 1;
otherflies = [];
ts = [6741 6742 6743 6744 6745];
ts_overlay = ts;

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'hfig_base',TAILPIVOTTURN*100,...
  'ncolors_reference',ncolors_reference,...
  'doplotellipseoverlay',true);

%% WALK

behavior = 'Walk';
scoresfilestr = 'scores_Walk.mat';
rootdatadir = 'C:/Data/JAABA/groundtruth_pBDPGAL4U_data';
experiment_name = 'pBDPGAL4U_TrpA_Rig2Plate17BowlD_20111130T094443';
mainfly = 1;
otherflies = [];
ts = [12344 12349 12353 12358 12362 12367];
ts_overlay = ts;

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'ncolors_reference',ncolors_reference,...
  'hfig_base',WALK*100);

%% MOUSEWALK

behavior = 'Mouse_Walk';
scoresfilestr = 'scores_Walk.mat';
rootdatadir = 'C:/Data/roian';
experiment_name = 'b6_popcage_16_110405_09.58.30.268';
mainfly = 1;
otherflies = [];
%ts = [20342 20351 20359 20368 20376 20385];
ts = [20188 20195 20202  20218 20234 20250];

ts_overlay = ts;

predictions = cell(1,4);
predictions{mainfly} = sparse(1,ts(1):ts(end),[false,true(1,ts(end)-ts(1))],1,ts(end));
% predictions = handles.guidata.data.predictedidx(ts(1):ts(end)) == 1;

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border_mouse,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'hfig_base',MOUSE_WALK*100,...
  'fg_thresh',fg_thresh_mouse,...
  'nframes_sample_bkgd',nframes_sample_bkgd,...
  'targettype','mouse',...
  'ncolors_reference',ncolors_reference,...
  'predictions',predictions,...
  'annfilestr','');

%% MOUSEMALEFOLLOW

behavior = 'Mouse_MaleFollow';
scoresfilestr = 'scores_MaleFollowing.mat';
rootdatadir = 'C:/Data/roian';
experiment_name = 'b6_popcage_16_110405_09.58.30.268';
mainfly = 2;
otherflies = 4;
%ts = [20342 20351 20359 20368 20376 20385];
ts = [9692,9700,9706,9715,9730,9745];

ts_overlay = ts;

predictions = cell(1,4);
%v = handles.guidata.data.predictedidx(ts(1):ts(end)) == 1;
v = [false,false,true(1,3),false(1,2),true(1,47)];
predictions{mainfly} = sparse(1,ts(1):ts(end),v,1,ts(end));

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border_mouse,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'hfig_base',MOUSE_MALEFOLLOW*100,...
  'fg_thresh',fg_thresh_mouse,...
  'nframes_sample_bkgd',nframes_sample_bkgd,...
  'targettype','mouse',...
  'ncolors_reference',ncolors_reference,...
  'predictions',predictions,...
  'annfilestr','');

%% LARVAHEADCAST

behavior = 'Larva_HeadCast';
scoresfilestr = 'scores_Head_casting.mat';
rootdatadir = '/groups/branson/bransonlab/projects/JAABA/data/larva';
experiment_name = 'virilis';
mainfly = 35;
otherflies = [];
ts = [620,642,662,678,698];
ts_overlay = ts;

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh_larvae,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'hfig_base',LARVA_HEADCAST*100,...
  'fg_thresh',fg_thresh_larvae,...
  'nframes_sample_bkgd',nframes_sample_bkgd,...
  'targettype','larva',...
  'ncolors_reference',ncolors_reference,...
  'annfilestr','',...
  'doplotellipseoverlay',true);

%% LARVA CRAWL

behavior = 'Larva_Crawling';
scoresfilestr = 'scores_Crawling.mat';
rootdatadir = '/groups/branson/bransonlab/projects/JAABA/data/larva';
experiment_name = 'OregonRA';
mainfly = 6;
otherflies = [];
ts = [82,117,152,187,222,257];
ts_overlay = ts;
dist_epsilon_larva_crawling = .01;

PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,...
  scoresfilestr,mainfly,otherflies,ts,ts_overlay,...
  'outfigdir',outfigdir,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh_larvae2,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon_larva_crawling,...
  'figpos',figpos_example,...
  'hfig_base',LARVA_CRAWL*100,...
  'fg_thresh',fg_thresh_larvae2,...
  'nframes_sample_bkgd',nframes_sample_bkgd,...
  'targettype','larva',...
  'ncolors_reference',ncolors_reference,...
  'annfilestr','',...
  'doplotellipseoverlay',false,...
  'intensityoff',.25);

%% figure out colorbar correspondences

nt = ts(end)-ts(1)+1;
jetcurr = jet(nt);
[~,closeststart] = min(sum(abs(bsxfun(@minus,reference_jet,jetcurr(1,:))),2));
[~,closestend] = min(sum(abs(bsxfun(@minus,reference_jet,jetcurr(end,:))),2));
fprintf('%s: %f to %f\n',behavior,(closeststart-1)/255,(closestend-1)/255);
