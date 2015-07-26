function rslt = percCorrect_blanktime( LP )


    % Extract trialerror info for new te struct
    TrialErrors = LP.TrialError;
    BlankTimes  = [LP.UserVars.blank_time]';
    
    
    % Calculate Values for Plotting
    % Corrects = TrialErrors == 0
    % Fails = TrialErrors == 1 %Failed to Initiate Trial by Fixating
    % Fails2 = TrialErrors == 2 % Didn't press in time or broke Fixation
    % Fails3 = TrialErrors == 3 %Released too early or broke fix
    % FPs = TrialErrors == 4 % Released when shouldn't have
    % FNs = TrialErrors == 5 %Did not release when should have
    
    tes_50_corrs  = find( (TrialErrors == 0) & (BlankTimes == 50) );
    tes_50_FPs = find( (TrialErrors == 4) & (BlankTimes == 50) );
    tes_50_FNs = find( (TrialErrors == 5) & (BlankTimes == 50) );
    n_50 = sum( [length(tes_50_corrs), length(tes_50_FPs), length(tes_50_FNs)]);
    
    
    tes_100_corrs  = find( (TrialErrors == 0) & (BlankTimes == 100) );
    tes_100_FPs = find( (TrialErrors == 4) & (BlankTimes == 100) );
    tes_100_FNs = find( (TrialErrors == 5) & (BlankTimes == 100) );
    n_100 = sum( [length(tes_100_corrs), length(tes_100_FPs), length(tes_100_FNs)]);
    
    tes_200_corrs  = find( (TrialErrors == 0) & (BlankTimes == 200) );
    tes_200_FPs = find( (TrialErrors == 4) & (BlankTimes == 200) );
    tes_200_FNs = find( (TrialErrors == 5) & (BlankTimes == 200) );
    n_200 = sum( [length(tes_200_corrs), length(tes_200_FPs), length(tes_200_FNs)]);
    
 
    perc50 = length(tes_50_corrs) / n_50;
    perc100 = length(tes_100_corrs) / n_100; 
    perc200 = length(tes_200_corrs) / n_200;


    rslt = [perc50 perc100 perc200];



end
