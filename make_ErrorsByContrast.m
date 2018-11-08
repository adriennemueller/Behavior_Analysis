function rslt =  make_ErrorsByContrast( LP )

    C10 = [];
    C15 = [];
    C20 = [];
    C25 = [];
    
    for i = 1:length(LP)

        % Extract trialerror info for new te struct
        TrialErrors = LP(i).TrialError;
        ConditionNumbers = LP(i).ConditionNumber;

        trials = length(TrialErrors);
        bhvContrast = [];

        for j = 1:trials
            Condition = ConditionNumbers(j);
            bhvContrastString = LP(i).TaskObject(Condition,2);
            bhvContrast(j) = get_contrast( bhvContrastString );
        end

        %Calculate Values for Plotting
        C10 = [C10 perc_correct( TrialErrors, bhvContrast, 10 )];
        C15 = [C15 perc_correct( TrialErrors, bhvContrast, 15 )];
        C20 = [C20 perc_correct( TrialErrors, bhvContrast, 20 )];
        C25 = [C25 perc_correct( TrialErrors, bhvContrast, 25 )];
        
    end    
    
    meanC10 = mean(C10); steC10 = std( C10 ) ./ sqrt(length(C10));
    meanC15 = mean(C15); steC15 = std( C15 ) ./ sqrt(length(C15));
    meanC20 = mean(C20); steC20 = std( C20 ) ./ sqrt(length(C20));
    meanC25 = mean(C25); steC25 = std( C25 ) ./ sqrt(length(C25));
    
    figure();
    b = bar( [meanC10 meanC15 meanC20 meanC25] * 100);
    hold on;
    errorbar( [1 2 3 4], [meanC10 meanC15 meanC20 meanC25]*100, [steC10 steC15 steC20 steC25]*100, '.k');

    
    
    AxisLabel_FontSize = 14; TickLabel_FontSize = 12;
    set( gca, 'XTick', [1, 2, 3, 4], 'XTickLabel', {'10%', '15%', '20%', '25%' }, 'FontSize', TickLabel_FontSize,  ...
         'FontWeight', 'Bold', 'YTick', [50 60 70 80 90]);
    ylim( [50 90] );
    %xlim([0.5 4.5]);  
    xlabel( 'Contrast', 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
    ylabel( {'Percent Correct'}, 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
    box( gca, 'off');     
    hold off;
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