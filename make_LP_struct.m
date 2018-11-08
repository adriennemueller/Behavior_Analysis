function rslt = make_LP_struct()

% File Directory Information

    path(path,'../monkeylogic');

    directory = '/Volumes/Hnoss/Data/Behavior/Lever_Training/Garf/';
% Jose LeverPress
%     files_list = {  'Experiment-jose-04-14-2014.bhv', ...
%                     'Experiment-jose-04-15-2014.bhv', ...
%                     'Experiment-jose-04-16-2014.bhv', ...
%                     'Experiment-jose-04-17-2014.bhv'
%                  };

% Garf LeverPress
%     files_list = {  'Experiment-garf-03-04-2014(01).bhv', ...
%                     'Experiment-garf-03-05-2014.bhv', ...
%                     'Experiment-garf-03-06-2014.bhv'
%                  };


% Garf Distractor Choice 
%     files_list = {  'Experiment-garf-03-11-2014_01.bhv', ...
%                     'Experiment-garf-03-12-2014.bhv', ...
%                     'Experiment-garf-03-13-2014.bhv', ...
%                     'Experiment-garf-03-14-2014_01.bhv', ...
%                     'Experiment-garf-03-18-2014(01).bhv'
%                  };

% Garf Cue / NoCue Choice 
%    files_list = { % 'LP_Cue_NoCue_Blank_Fix-garf-07-02-2015.bhv', ...
%                     'LP_Cue_NoCue_Blank_Fix-garf-07-06-2015.bhv',...
%                     'LP_Cue_NoCue_Blank_Fix-garf-07-07-2015.bhv', ...
%                     'LP_Cue_NoCue_Blank_Fix-garf-07-08-2015.bhv', ...
%                     'LP_Cue_NoCue_Blank_Fix-garf-07-09-2015.bhv', ...
%                     'LP_Cue_NoCue_Blank_Fix-garf-07-13-2015.bhv', ...
%                     'LP_Cue_NoCue_Blank_Fix-garf-07-14-2015.bhv', ...
%                     'LP_Cue_NoCue_Blank_Fix-garf-07-15-2015.bhv', ...
%                     'LP_Cue_NoCue_Blank_Fix-garf-07-16-2015.bhv'
                      %'LP_Cue_NoCue_Blank_Fix-garf-07-22-2015(01).bhv', ...
                      %'LP_Cue_NoCue_Blank_Fix-garf-07-23-2015.bhv', ...
                      %'LP_Cue_NoCue_Blank_Fix-garf-07-24-2015.bhv', ...
                      %'LP_Cue_NoCue_Blank_Fix-garf-07-27-2015.bhv', ...
                      %'LP_Cue_NoCue_Blank_Fix-garf-07-28-2015.bhv', ...
                      %'LP_Cue_NoCue_Blank_Fix-garf-07-29-2015.bhv', ...
%                     'LP_Cue_NoCue_Blank_Fix-garf-07-30-2015.bhv', ...
%                     'LP_Cue_NoCue_Blank_Fix_Setable-garf-07-31-2015.bhv'
%                 };           

             
% Garf Cue/NoCue Distractor with Contrasts
    files_list = { 
        %'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-03-17-2017.bhv' % Not Great

        
        'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-03-21-2017.bhv' % Okay
        'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-04-19-2017.bhv' % Nice
        %'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-04-20-2017.bhv' % Bad
        
        'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-04-24-2017.bhv' % Not Great
        'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-04-25-2017.bhv' % Not Great
        'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-04-27-2017.bhv' % Not Great
        'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-04-28-2017.bhv' % Shows High 15%
        
        'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-06-15-2017_01.bhv' % Not Great
        %'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-06-16-2017_01.bhv' % Shows low 20%
        'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-06-18-2017.bhv' % Shows low 20%
        
        'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-06-19-2017.bhv' % Looks Okay, Low 20%
        'LP_Cue_NoCue_Blank_Fix_8Dir_MGS_Contrasts-Garf-06-20-2017.bhv' % High 15%
        
    };           

             

% Garf Distractor Choice - Down Training
%     files_list = {  'Experiment-garf-03-18-2014(02).bhv', ...
%                     'Experiment-garf-03-19-2014(01).bhv', ...
%                     'Experiment-garf-03-20-2014(03).bhv', ...
%                     'Experiment-garf-03-21-2014.bhv', ...
%                     'Experiment-garf-03-24-2014.bhv', ...
%                     'Experiment-garf-03-25-2014.bhv'
%                  };


% Garf Distractor Choice - After Down Training
%     files_list = {  'Experiment-garf-03-26-2014.bhv', ...
%                     'Experiment-garf-03-27-2014.bhv', ...
%                     'Experiment-garf-03-28-2014.bhv'
%                  };



% Garf Cued LeverPress (Both Green) w Distractor
%     files_list = {  'Experiment-garf-04-02-2014.bhv', ...
%                     'Experiment-garf-04-03-2014.bhv', ...
%                     'Experiment-garf-04-04-2014.bhv', ...
%                     'Experiment-garf-04-07-2014.bhv', ...
%                     'Experiment-garf-04-08-2014(01).bhv'
%                  };
%              

% Garf Shifted-Cued LeverPress w/o Distractor (Training)
%     files_list = {  'Experiment-garf-04-15-2014(02).bhv', ...
%                     'Experiment-garf-04-16-2014.bhv', ...
%                  };

% Garf Shifted-Cued LeverPress w Distractor
%     files_list = {  'Experiment-garf-04-15-2014(03).bhv', ...
%                     'Experiment-garf-04-16-2014(01).bhv', ...
%                     'Experiment-garf-04-17-2014.bhv'
%                  };


    % Load Bhv File
    filename = strcat( directory, files_list(1));
    BHV = bhv_read(filename{1});

    % Make Empty LeverPress Struct
    LP(2) = BHV;
    LP = LP(1);


    % Append Bhv Data for Successive days into LP Struct
    for i = 1:length(files_list)
        filename = strcat( directory, files_list(i));
        BHV = bhv_read(filename{1});

        LP(i) = BHV;

    end

    rslt = LP;
end
