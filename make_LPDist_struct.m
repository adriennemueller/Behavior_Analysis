function rslt = make_LPDist_struct()

    % File Directory Information

    path(path,'../monkeylogic');
    directory = '/Users/eddi/Documents/MATLAB/monkeylogic/lp/';

    files_list = {  'Experiment-garf-03-12-2014.bhv'
                 };

    % Load Bhv File
    filename = strcat( directory, files_list(1));
    BHV = bhv_read(filename{1});

    % Make Empty LeverPress Struct
    LPD(2) = BHV;
    LPD = LPD(1);

    % Append Bhv Data for Successive days into LP Struct
    for i = 1:length(files_list)
        filename = strcat( directory, files_list(i));
        BHV = bhv_read(filename{1});

        LPD(i) = BHV;
    end

    rslt = LPD;
end
