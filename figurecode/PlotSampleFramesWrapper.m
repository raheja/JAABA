function PlotSampleFramesWrapper(behavior,rootdatadir,experiment_name,scoresfilestr,mainfly,otherflies,ts,ts_overlay,varargin)

annfilestr = 'movie.ufmf.ann';
colorpos = [.7,0,0];
colorneg = [0,0,.7];
border = 16;
bg_thresh = 10/255;
wmah = .5;
frac_a_back = 1;
dist_epsilon = .1;
figpos_example = [97 886 1800 650];
targettype = 'fly';
nframes_sample_bkgd = 20;

[annfilestr,colorpos,colorneg,border,...
  bg_thresh,wmah,frac_a_back,dist_epsilon,...
  figpos,hfig_base,outfigdir,doplotellipseoverlay,predictions,...
  targettype,nframes_sample_bkgd,...
  fg_thresh,ncolors_reference,intensityoff] = ...
  myparse(varargin,...
  'annfilestr',annfilestr,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'border',border,...
  'bg_thresh',bg_thresh,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'figpos',figpos_example,...
  'hfig_base',0,...
  'outfigdir','.',...
  'doplotellipseoverlay',false,...
  'predictions',[],...
  'targettype',targettype,...
  'nframes_sample_bkgd',nframes_sample_bkgd,...
  'fg_thresh',.7,...
  'ncolors_reference',256,...
  'intensityoff',0);

flipim = false;
switch targettype,
  case 'fly',
    moviefilestr = 'movie.ufmf';
    trxfilestr = 'registered_trx.mat';
    trx = Trx('trxfilestr',trxfilestr,'moviefilestr',moviefilestr,'perframedir','perframe');
  case 'mouse'
    moviefilestr = 'movie.seq';
    trxfilestr = 'trx.mat';
    trx = Trx('trxfilestr',trxfilestr,'moviefilestr',moviefilestr,'perframedir','perframe');
  case 'larva'
    moviefilestr = 'movie.mov';
    trxfilestr = 'trx.mat';
    trx = Trx('trxfilestr',trxfilestr,'moviefilestr',moviefilestr,'perframedir','perframe');
    flipim = true;
end
expdir = fullfile(rootdatadir,experiment_name);
trx.AddExpDir(expdir,'openmovie',false);
moviename = fullfile(expdir,moviefilestr);
global STOREDREADFRAME
global STOREDHEADERINFO
% readframe = STOREDREADFRAME;
% headerinfo = STOREDHEADERINFO;
[readframe,nframes,fid,headerinfo] = get_readframe_fcn(moviename);
STOREDREADFRAME = readframe;
STOREDHEADERINFO = headerinfo;

if isempty(predictions),
  if ~exist(fullfile(expdir,scoresfilestr),'file'),
    fprintf('PREDICTIONS NOT LOADED FOR REAL FOR %s! FIX THIS\n',behavior);
    predictions = cell(1,trx.nflies);
    for i = 1:trx.nflies,
      predictions{i} = true(trx(i).nframes);
    end
  else
    scoresdata = load(fullfile(expdir,scoresfilestr));
    predictions = cellfun(@(x) x > 0,scoresdata.allScores.scores,'UniformOutput',false);
  end
end

if ~isempty(annfilestr),
  annfilename = fullfile(rootdatadir,experiment_name,annfilestr);
  [bkgdim,fg_thresh] = read_ann(annfilename,'background_center','n_bg_std_thresh');
  bkgdim = reshape(bkgdim,[headerinfo.nc,headerinfo.nr])'/255;
  fg_thresh = fg_thresh / 255;
else
  sampleims = nan(headerinfo.nr,headerinfo.nc,1,nframes_sample_bkgd);
  samplets_bkgd = round(linspace(1,headerinfo.nframes,nframes_sample_bkgd+2));
  samplets_bkgd = samplets_bkgd(2:end-1);
  for i = 1:nframes_sample_bkgd,
    imcurr = im2double(readframe(samplets_bkgd(i)));
    if i == 1 && size(imcurr,3) > 1,
      sampleims = repmat(sampleims,[1,1,3,1]);
    end
    sampleims(:,:,:,i) = imcurr;
  end
  bkgdim = median(sampleims,4);
end

sigma_bkgd = (fg_thresh-bg_thresh);

hfig = hfig_base+1;

[hfig,~,pfore] = PlotSampleFramesColor(trx,readframe,bkgdim,predictions,mainfly,otherflies,ts,...
  'colorpos',colorpos,...
  'colorneg',colorneg,...
  'hfig',hfig,'figpos',figpos,...
  'colormap',{@jet,@jet},...
  'fg_thresh',fg_thresh,...
  'bg_thresh',bg_thresh,...
  'sigma_bkgd',sigma_bkgd,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'border',border,...
  'ncolors_reference',ncolors_reference,...
  'flipim',flipim,...
  'intensityoff',intensityoff);

outfigdir1 = fullfile(outfigdir,sprintf('Example%s_%s_fly%02d_Frames%05dto%05d',behavior,experiment_name,mainfly,ts_overlay(1),ts_overlay(end)));
if ~exist(outfigdir1,'dir'),
  mkdir(outfigdir1);
end

SaveFigLotsOfWays(hfig,fullfile(outfigdir1,sprintf('Example%s_%s_fly%02d_frame%02d',behavior,experiment_name,mainfly,ts(1))));
for i = 1:size(pfore,3),
  imwrite(pfore(:,:,i),fullfile(outfigdir1,sprintf('Example%s_pfore_%s_fly%02d_frame%02d.png',behavior,experiment_name,mainfly,ts(i))));
end

hfig = hfig_base+2;
[hfig,~,pfore] = OverlayFrames(trx,readframe,bkgdim,predictions,mainfly,otherflies,ts_overlay,...
  'colorpos',colorpos,'colorneg',colorneg,'border',border,...
  'hfig',hfig,'figpos',figpos,...
  'colormap',{@jet,@jet},...
  'fg_thresh',fg_thresh,...
  'bg_thresh',bg_thresh,...
  'sigma_bkgd',sigma_bkgd,...
  'wmah',wmah,...
  'frac_a_back',frac_a_back,...
  'dist_epsilon',dist_epsilon,...
  'ncolors_reference',ncolors_reference,...
  'flipim',flipim,...
  'intensityoff',intensityoff);

SaveFigLotsOfWays(hfig,fullfile(outfigdir1,sprintf('Example%s_Overlay_%s_fly%02d_Frames%05dto%05d',behavior,experiment_name,mainfly,ts_overlay(1),ts_overlay(end))));
imwrite(pfore,fullfile(outfigdir1,sprintf('Example%s_Overlay_pfore_%s_fly%02d_frame%02d.png',behavior,experiment_name,mainfly,ts(i))));

if doplotellipseoverlay,
  hfig = hfig_base+3;
  if strcmp(targettype,'larva'),
    tmp = load(fullfile(expdir,trxfilestr),'trx');
    trx1 = tmp.trx;
    [hfig] = OverlayFrames_Skeletons(trx,trx1,readframe,bkgdim,predictions,mainfly,otherflies,ts,...
      'colorpos',colorpos,'colorneg',colorneg,'border',border,...
      'hfig',hfig,'figpos',figpos,...
      'colormap',{@jet,@jet},...
      'fg_thresh',fg_thresh,...
      'bg_thresh',bg_thresh,...
      'sigma_bkgd',sigma_bkgd,...
      'wmah',wmah,...
      'frac_a_back',frac_a_back,...
      'dist_epsilon',dist_epsilon,...
      'border',border,...
      'ncolors_reference',ncolors_reference,...
      'flipim',flipim);
  else
    [hfig] = OverlayFrames_Ellipses(trx,readframe,bkgdim,predictions,mainfly,otherflies,ts,...
      'colorpos',colorpos,'colorneg',colorneg,'border',border,...
      'hfig',hfig,'figpos',figpos,...
      'colormap',{@jet,@jet},...
      'fg_thresh',fg_thresh,...
      'bg_thresh',bg_thresh,...
      'sigma_bkgd',sigma_bkgd,...
      'wmah',wmah,...
      'frac_a_back',frac_a_back,...
      'dist_epsilon',dist_epsilon,...
      'border',border,...
      'ncolors_reference',ncolors_reference);
  end
  SaveFigLotsOfWays(hfig,fullfile(outfigdir1,sprintf('Example%s_OverlayEllipses_%s_fly%02d_Frames%05dto%05d',behavior,experiment_name,mainfly,ts_overlay(1),ts_overlay(end))));
end