function rslt =  make_ErrorsByContrast( LP )

    % Extract trialerror info for new te struct
    TrialErrors = LP.TrialError;
    ConditionNumbers = LP.ConditionNumber;
    
    trials = length(TrialErrors);
    bhvContrast = [];
    
    for i = 1:trials
        Condition = ConditionNumbers(i);
        bhvContrastString = LP.TaskObject(Condition,2);
        bhvContrast(i) = get_contrast( bhvContrastString );
    end
    
    %Calculate Values for Plotting
    C10 = perc_correct( TrialErrors, bhvContrast, 10 );
    C15 = perc_correct( TrialErrors, bhvContrast, 15 );
    C20 = perc_correct( TrialErrors, bhvContrast, 20 );
    C25 = perc_correct( TrialErrors, bhvContrast, 25 );
    
    figure();
    bar( [C10 C15 C20 C25] );


end

function rslt = get_contrast( contrastString )
    contrastString = contrastString{1};
    startIndex = regexp(contrastString, 'C');
    vals = contrastString(startIndex+1:startIndex+2);
    rslt = str2double( vals );
end

function rslt = perc_correct( tes, bhvContrasts, contrast )

    te_idxes = find(bhvContrasts == contrast);
    sub_tes = tes(te_idxes);
    corr_idxes = find( sub_tes == 0 );
    incorr_idxesOn = find( sub_tes == 4); % check
    incorr_idxesOff = find( sub_tes == 5); % check
    
    num_corr = length(corr_idxes);
    num_incorr = length(incorr_idxesOn) + length(incorr_idxesOff);
    total = num_corr + num_incorr;
    
    rslt = num_corr / total;

end