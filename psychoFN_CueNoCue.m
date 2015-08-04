function rslt = psychoFN_CueNoCue( bhv )

    % Make a matrix pooling across sessions
    bhv_mat = extract_trialinfo( bhv );
    
    % Eliminate all mistrials
    TrialErrors = bhv_mat(:,1);
    rows_to_remove = find(TrialErrors ~= 0 & TrialErrors ~= 4 & TrialErrors ~= 5);
    bhv_mat(rows_to_remove,:) = [];
    
    % Separate into Cue and NoCue
    nocue = bhv_mat(:,2);
    cue_rows = find(nocue == 0);
    nocue_rows = find(nocue == 1);
    nocue_trials = bhv_mat; cue_trials = bhv_mat;
    nocue_trials(cue_rows,:) = [];
    cue_trials(nocue_rows,:) = [];
    
    % Get Perc Correct for each Difficulty (of orientation shift)
    percmat = get_perc_corr( cue_trials, nocue_trials);
    cue_percs = percmat(1,:) ./ (percmat(1,:) + percmat(2,:))
    nocue_percs = percmat(3,:) ./ (percmat(3,:) + percmat(4,:))
    
    chsq = zeros(1,3);
    chsq(1,1) = chisqcue( percmat(1,1), percmat(2,1), percmat(3,1),percmat(4,1) );
    chsq(1,2) = chisqcue( percmat(1,2), percmat(2,2), percmat(3,2),percmat(4,2) );
    chsq(1,3) = chisqcue( percmat(1,3), percmat(2,3), percmat(3,3),percmat(4,3) );
    
    chsq
    
    rslt = percmat;
    
    a = vertcat(cue_percs, nocue_percs);
    a = a';
    
    % Plot Perc Correct against Difficult for Cue/No Cue
    figure();
    bar(a);
    
end

function rslt = get_perc_corr( cue_trials, nocue_trials )
    
    rslt = zeros(4,3);

    cue_difficulties = cue_trials(:,3);
    nocue_difficulties = nocue_trials(:,3);
    cue_tes = cue_trials(:,1);
    nocue_tes = nocue_trials(:,1);
    
    rslt(1,1) = length(find( (cue_tes == 0) & (cue_difficulties <= 30) ));
    rslt(2,1) = length(find( (cue_tes == 4) & (cue_difficulties <= 30) )) +  length(find( (cue_tes == 5) & (cue_difficulties <= 30) ));
    rslt(3,1) = length(find( (nocue_tes == 0) & (nocue_difficulties <= 30) ));
    rslt(4,1) = length(find( (nocue_tes == 4) & (nocue_difficulties <= 30) )) +  length(find( (nocue_tes == 5) & (nocue_difficulties <= 30) ));
    
    rslt(1,2) = length(find( (cue_tes == 0) & (cue_difficulties > 30) & (cue_difficulties <= 60)));
    rslt(2,2) = length(find( (cue_tes == 4) & (cue_difficulties > 30) & (cue_difficulties <= 60))) + length(find( (cue_tes == 5) & (cue_difficulties > 30) & (cue_difficulties <= 60)));
    rslt(3,2) = length(find( (nocue_tes == 0) & (nocue_difficulties > 30) & (nocue_difficulties <= 60)));
    rslt(4,2) = length(find( (nocue_tes == 4) & (nocue_difficulties > 30) & (nocue_difficulties <= 60))) + length(find( (nocue_tes == 5) & (nocue_difficulties > 30) & (nocue_difficulties <= 60)));
    
    rslt(1,3) = length(find( (cue_tes == 0) & (cue_difficulties > 60) & (cue_difficulties <= 90)));
    rslt(2,3) = length(find( (cue_tes == 4) & (cue_difficulties > 60) & (cue_difficulties <= 90))) + length(find( (cue_tes == 5) & (cue_difficulties > 60) & (cue_difficulties <= 90)));
    rslt(3,3) = length(find( (nocue_tes == 0) & (nocue_difficulties > 60) & (nocue_difficulties <= 90)));
    rslt(4,3) = length(find( (nocue_tes == 4) & (nocue_difficulties > 60) & (nocue_difficulties <= 90))) + length(find( (nocue_tes == 5) & (nocue_difficulties > 60) & (nocue_difficulties <= 90)));


end


% Extract a vector of TrialResults (0 = Correct, etc)
% Extract a vector of the orientation shifts
% Extract info about whether it was a Cue or a No Cue trial
function rslt = extract_trialinfo( bhv )

    TrialErrors = [];
    nocue = [];
    difficulties = [];

    for i = 1:length(bhv)
        TrialErrors = vertcat(TrialErrors, [bhv(i).TrialError]);
        nocue = horzcat(nocue, [bhv(i).UserVars.nocue]);
        difficulties = vertcat( difficulties, get_filegenned_difficulties( bhv(i) ) );
        
    end
    
    TrialErrors = TrialErrors';
    difficulties = difficulties';
    
    rslt = vertcat( TrialErrors, nocue, difficulties );
    rslt = rslt';
end