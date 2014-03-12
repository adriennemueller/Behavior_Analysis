function fig = make_DistractorLearning_Fig( LP )

    bhv = struct([]);

    % Generate Behavior Lists
    for i = 1:length(LP)
        bhv(i).responsetype = calc_response_type( LP(i).CodeNumbers );
        bhv(i).rspcount = calc_num_response_types( bhv(i).responsetype, LP(i).BlockNumber );
    end
    
    % Plot Smoothed Behavior over Time in multi-plot
    
    
    % Plot Stacked Histo
    histfig = make_multidayhist( bhv );
    
end

function rslt = calc_response_type( codes )
    % Codes: 126 = released too soon. 
    % 122 = Targ Same;  123 = Targ Change
    % 129 = Dist Same;  130 = Dist Change
    % 127 = Released When Should Not have
    % 128 = Did Not Release When Should have
    % 124 = Performed Correctly
    
    vals = [];
    
    % Sort
    for i = 1:length( codes )
        currcodes = cell2mat(codes(i)); 
        if contains_all(currcodes', [124 122 129])     % 1: Correctly Held, Distractor Same
            vals = [vals 1];
        elseif contains_all(currcodes', [124 123 129]) % 2: Correctly Released, Distractor Same
            vals = [vals 2];
        elseif contains_all(currcodes', [124 122 130]) % 3: Correctly Held, Distractor Different
            vals = [vals 3];
        elseif contains_all(currcodes', [124 123 130]) % 4: Correctly Release, Distractor Different
            vals = [vals 4];
        elseif contains_all(currcodes', [128 123 129])  % 5: Incorrectly Held, Distractor Same
            vals = [vals 5];
        elseif contains_all(currcodes', [127 122 129])  % 6: Incorrectly Released, Distractor Same
            vals = [vals 6];
        elseif contains_all(currcodes', [128 123 130])  % 7: Incorrectly Held, Distractor Different
            vals = [vals 7];
        elseif contains_all(currcodes', [127 122 130])  % 8: Incorrectly Release, Distractor Different
            vals = [vals 8];
        elseif contains_all(currcodes', 126)            % 9: Released too soon.
            vals = [vals 9];
        elseif contains_all(currcodes', 125)
            vals = [vals 10];                           % 10: Didn't push lever down during fixation cue.
        else
            vals = [vals 11];                           % 11: Unknown?!
            disp( 'No compatiable Code Combinations found.');
        end
    end
    
    rslt = vals;
    
    % Rslt Code will be:
    % 1: Correctly Held, Distractor Same
    % 2: Correctly Released, Distractor Same
    % 3: Correctly Held, Distractor Different
    % 4: Correctly Release, Distractor Different
    % 5: Incorrectly Held, Distractor Same
    % 6: Incorrectly Released, Distractor Same
    % 7: Incorrectly Held, Distractor Different
    % 8: Incorrectly Release, Distractor Different
    % 9: Released too soon.
    %10: Unknown
   
end

% Helper function: identifies whether all items appear in a list;
function rslt = contains_all( list, itms )
    tf = [];
    for i = 1:length( itms )
        tf = [tf sum( itms(i) == list )];
    end
    
    if find( tf == 0 )
        rslt = 0;
    else
        rslt = 1;
    end
    
end


function fig = make_multidayhist( bhv )
    % Make Matrix out of bhv.rspcount
    histmat = [];
    
    [m n] = size( bhv(1).rspcount );
    
    
    for i = 1:length(bhv)
       histmat = vertcat( histmat, bhv(i).rspcount);
       histmat = vertcat( histmat, zeros(1,n));
    end
    
    [newm newn] = size( histmat );
    
    xtickpos = get_xtick_positions( newm, m );
    H = bar(histmat, 'stack');
         
    C=[0 0 0.55; 0 0 0.8; 0 0 0.93; 0 0 1; 0.55 0 0; 0.8 0 0 ; 0.93 0 0 ; 1 0 0; 0.55 0.55 0.55; 0.7 0.7 0.7 ]; % make a colors list
    for n=1:length(H)
        set(H(n),'facecolor',C(n,:));
    end
    
    legend( H, {'Correct SS', 'Correct DS', 'Correct SD', 'Correct DD', 'FN DS', 'FP SS', 'FN DD', 'FP SD', 'False Start', 'No Start'}, 'Location', 'Best');
    xlabel( 'Day', 'FontSize', 18, 'FontWeight', 'bold' );
    ylabel( 'Fraction of Total', 'FontSize', 18, 'FontWeight', 'bold' );
    set( gca, 'YTick', [0.25, 0.5, 0.75], 'FontSize', 16, 'FontWeight', 'bold');
    set(gca, 'XLim', [0 (newm+1)], 'XTick', xtickpos, 'XTickLabel', 1:length(bhv));
    ylim([0 1]);

    fig = H;
    
end

function rslt = get_xtick_positions( num_bars, num_blocks )
    center = (1 + num_blocks)/2;

    finish = num_bars - center;
    sep = num_blocks + 1;

    rslt = [center: sep : finish];
end

function rslt = calc_num_response_types( responsetype, block )
    n_conds = 10;
    
    b1_vals = (responsetype(find(block == 1)));
    b2_vals = (responsetype(find(block == 2)));
    
    b1_counts = zeros(1,n_conds);
    b2_counts = zeros(1,n_conds);
  
    for j = 1:n_conds
            b1_counts(j) = sum(j == b1_vals);
            b2_counts(j) = sum(j == b2_vals);
    end
   
    rslt_b1 = b1_counts'; %Block 1 counts
    rslt_b2 = b2_counts'; %Block 2 counts
    
    % Calculate fraction
    rslt_b1 = rslt_b1 ./ length(b1_vals);
    rslt_b2 = rslt_b2 ./ length(b2_vals);
    
    
    rslt = [rslt_b1'; rslt_b2'];
end
    
    