function plot_psychoFNs( bhv )

    for i = 1:length(bhv)
        if strcmp(bhv(i).TimingFileByCond(1), 'lp_dstrctr_nocue_mobile.m')
            difficulties = [bhv(i).ConditionNumber];
        else
            difficulties = get_filegenned_difficulties( bhv(i) );
        end
        errors = [bhv(i).TrialError];
        errorstruct = get_error_struct( difficulties, errors );
        bhv(i).perc_corrs = get_perc_corrs( errorstruct );
    end
    assignin( 'base', 'bhv', bhv );

    if strcmp(bhv(i).TimingFileByCond(1), 'lp_dstrctr_nocue_mobile.m')
        xvals = [90 80 70 60 50 40 30 20 10 5];
    else
        xvals = 5:5:90;
    end
    
    C=[1 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.1];
    
    figure();
    hold on;
    for i = 1:length(bhv)
        plot( xvals, bhv(i).perc_corrs, 'LineWidth', 2, 'Color', [C(i) 0 0] );
    end
    
    
    xlabel('Orientation Change (deg)', 'FontSize', 20, 'FontWeight', 'bold')
    ylabel('Percentage Correct', 'FontSize', 20, 'FontWeight', 'bold')
    set(gca,'FontSize',18);
    set(gca,'YTick',[40:10:100]);
    
    
end


function rslt = get_error_struct (difficulties, errors)
    err_struct = {};
    
    for j = 1:max(difficulties)
        err_struct(j).FP = 0;
        err_struct(j).FN = 0;
        err_struct(j).CR = 0;
    end

    for i = 1:length(difficulties)
        curr_diff = difficulties(i);
        if curr_diff == 0
            curr_diff = 1;
        end
        if errors(i) == 3
            err_struct(curr_diff).FP = err_struct(curr_diff).FP + 1;
        elseif errors(i) == 4;
            err_struct(curr_diff).FN = err_struct(curr_diff).FN + 1;
        elseif errors(i) == 0;
            err_struct(curr_diff).CR = err_struct(curr_diff).CR + 1;
        end
    end
    
    %If not the no_cue, but instead the pregenned cue paradigm
    if j>15
        err_struct = err_struct(5:5:90);
    end
    
    assignin( 'base', 'err_struct', err_struct );

    
    rslt = err_struct;
end

function rslt = get_perc_corrs( err_struct )

    perc_corrs = [];
    
    for i = 1:length(err_struct)
        perc_corr = err_struct(i).CR / (err_struct(i).CR + err_struct(i).FN);
        perc_corrs = [perc_corrs perc_corr];
    end
    
    rslt = perc_corrs * 100;
end

