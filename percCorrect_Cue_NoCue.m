function rslt = percCorrect_Cue_NoCue( Bhv_struct )
    
    TrialErrors = [];
    nocue = [];
    %blank_time = [];

    for i = 1:length(Bhv_struct)
        TrialErrors = vertcat(TrialErrors, [Bhv_struct(i).TrialError]);
        nocue = horzcat(nocue, [Bhv_struct(i).UserVars.nocue]);
        %blank_time = vertcat(blank_time, [Bhv_struct(i).UserVars.blank_time]);
    end

    TrialErrors = TrialErrors';

    tes_cue_corrs  = find( (TrialErrors == 0) & (nocue == 0) );
    tes_cue_FPs = find( (TrialErrors == 4) & (nocue == 0) );
    tes_cue_FNs = find( (TrialErrors == 5) & (nocue == 0) );
    n_cue = sum( [length(tes_cue_corrs), length(tes_cue_FPs), length(tes_cue_FNs)]);

    tes_nocue_corrs  = find( (TrialErrors == 0) & (nocue == 1) );
    tes_nocue_FPs = find( (TrialErrors == 4) & (nocue == 1) );
    tes_nocue_FNs = find( (TrialErrors == 5) & (nocue == 1) );
    n_nocue = sum( [length(tes_nocue_corrs), length(tes_nocue_FPs), length(tes_nocue_FNs)]);
    
 
    perc_Cue = length(tes_cue_corrs) / n_cue;
    perc_NoCue = length(tes_nocue_corrs) / n_nocue; 
    
    pval = chisqcue(length(tes_cue_corrs), (length(tes_cue_FPs) + length(tes_cue_FNs)), length(tes_nocue_corrs), (length(tes_nocue_FPs) + length(tes_nocue_FNs)) )
    
    
    rslt = [perc_Cue perc_NoCue];
    rslt = rslt .* 100;
    rslt = round(rslt, 2);

    figure();
    bar(rslt);
    ylabel( 'Percent Correct' );
    ylim([0 100]);
    set(gca, 'YTick', [25 50 75 100]);
    set(gca,'XTick',[1 2]);
    set(gca,'XTickLabel', {'Cued', 'Uncued'});
    set(gca, 'FontSize', 18);
    text(1, rslt(1), [num2str(rslt(1)) ' %'], 'FontSize', 16, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    text(2, rslt(2), [num2str(rslt(2)) ' %'], 'FontSize', 16, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    text(2.2, 90, ['p = ' num2str(round(pval,4))],  'FontSize', 16, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');


end