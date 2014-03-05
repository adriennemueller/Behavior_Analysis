function rslt = make_LP_struct()

% File Directory Information
    directory = '/Volumes/data/RigD/Garf/Lever_Training/';

    files_list = {  'Experiment-garf-02-21-2014.bhv', ...
                    'Experiment-garf-02-24-2014(01).bhv', ...
                    'Experiment-garf-02-25-2014.bhv', ...
                    'Experiment-garf-02-26-2014(06).bhv', ...
                    'Experiment-garf-02-27-2014.bhv', ...
                    'Experiment-garf-03-03-2014.bhv'
                 };

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
