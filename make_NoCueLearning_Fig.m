function histfig = make_NoCueLearning_Fig( LP )

    bhv = struct([]);
    bhvHorz = struct([]); bhvVert = struct([]);
        
    % Generate Behavior Lists
    for i = 1:length(LP)
        bhv(i).responsetype = calc_response_type( LP(i).CodeNumbers, LP(i).ConditionNumber );
    end

    % Make 'substructs' with Horizontal/Vertical or Both
    % Horizontal Only
    for i = 1:length(LP)
        bhvHorz(i).responsetype = bhv(i).responsetype(bhv(i).responsetype < 9 | bhv(i).responsetype > 16);
        
        % Change values of response types to match expected
        for j = 1:length(bhvHorz(i).responsetype) 
            if bhvHorz(i).responsetype(j) > 8, bhvHorz(i).responsetype(j) = bhvHorz(i).responsetype(j) -8; end 
        end
        
        bhvHorz(i).rspcount = calc_num_response_types( bhvHorz(i).responsetype); 
    end

    
    % Vertical Only
    for i = 1:length(LP)
        bhvVert(i).responsetype = bhv(i).responsetype(bhv(i).responsetype > 8);
        
        % Change values of response types to match expected
        for j = 1:length(bhvVert(i).responsetype) 
            if bhvVert(i).responsetype(j) > 8, bhvVert(i).responsetype(j) = bhvVert(i).responsetype(j) -8; end 
        end
        
        bhvVert(i).rspcount = calc_num_response_types( bhvVert(i).responsetype); 
    end
    
    % Plot Stacked Histo
    figure(); Horzhistfig = make_multidayhist( bhvHorz );
    figure(); Verthistfig = make_multidayhist( bhvVert );
    
end

function rslt = calc_response_type( codes, conds )
 
    % Situations and Codes (b/c >1 version of perceptually identical task)
    % No flip R or L
        % Cond 1 and code 122 129
        % Cond 3 and code 122 129
        % Cond 1 and code 132
    
    % Flip R (assumming Cond 1 is Right, Cond 3 is Left)
        % Cond 1 and code 123 129
        % Cond 3 and code 122 130
        % Cond 1 and code 133
    
    % Flip L 
        % Cond 1 and code 122 130
        % Cond 3 and code 123 129
        % Cond 1 and code 134
    
    % Flip R and L
        % Cond 1 and code 123 130
        % Cond 3 and code 123 130
        % Cond 1 and code 135
        
    % No flip U or D
        % Cond 2 and code 122 129
        % Cond 4 and code 122 129
        % Cond 2 and code 132
        
    % Flip U 
        % Cond 2 and code 123 129
        % Cond 4 and code 122 130
        % Cond 2 and code 133
            
    % Flip D
        % Cond 2 and code 122 130
        % Cond 4 and code 123 129
        % Cond 2 and code 134
        
    % Flip U and D
        % Cond 2 and code 123 130
        % Cond 4 and code 123 130
        % Cond 2 and code 135
        
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
        currcond = conds(i);
        if (contains_all(currcodes', [124 122 129]) && currcond == 1) || (contains_all(currcodes', [124 122 129]) && currcond == 3) || (contains_all(currcodes', [124 132]) && currcond == 1)
            vals = [vals 1]; % 1: Correctly Held R/L
        elseif (contains_all(currcodes', [124 123 129]) && currcond == 1) || (contains_all(currcodes', [124 122 130]) && currcond == 3) || (contains_all(currcodes', [124 133]) && currcond == 1)
            vals = [vals 2]; % 2: Correctly Released R
        elseif (contains_all(currcodes', [124 122 130]) && currcond == 1) || (contains_all(currcodes', [124 123 129]) && currcond == 3) || (contains_all(currcodes', [124 134]) && currcond == 1)
            vals = [vals 3]; % 3: Correctly Released L
        elseif (contains_all(currcodes', [124 123 130]) && currcond == 1) || (contains_all(currcodes', [124 123 130]) && currcond == 3) || (contains_all(currcodes', [124 135]) && currcond == 1)
            vals = [vals 4]; % 4: Correctly Released R/L
        elseif (contains_all(currcodes', [127 122 129]) && currcond == 1) || (contains_all(currcodes', [127 122 129]) && currcond == 3) || (contains_all(currcodes', [127 132]) && currcond == 1)
            vals = [vals 5]; % 5: Incorrectly Released R/L
        elseif (contains_all(currcodes', [128 123 129]) && currcond == 1) || (contains_all(currcodes', [128 122 130]) && currcond == 3) || (contains_all(currcodes', [128 133]) && currcond == 1)
            vals = [vals 6]; % 6: Incorrectly Held R
        elseif (contains_all(currcodes', [128 122 130]) && currcond == 1) || (contains_all(currcodes', [128 123 129]) && currcond == 3) || (contains_all(currcodes', [128 134]) && currcond == 1)
            vals = [vals 7]; % 7: Incorrectly Held L        
        elseif (contains_all(currcodes', [128 123 130]) && currcond == 1) || (contains_all(currcodes', [128 123 130]) && currcond == 3) || (contains_all(currcodes', [128 135]) && currcond == 1)
            vals = [vals 8]; % 8: Incorrectly Held R/L                             
        elseif (contains_all(currcodes', [124 122 129]) && currcond == 2) || (contains_all(currcodes', [124 122 129]) && currcond == 4) || (contains_all(currcodes', [124 132]) && currcond == 2)
            vals = [vals 9]; % 9: Correctly Held U/D
        elseif (contains_all(currcodes', [124 123 129]) && currcond == 2) || (contains_all(currcodes', [124 122 130]) && currcond == 4) || (contains_all(currcodes', [124 133]) && currcond == 2)
            vals = [vals 10]; % 10: Correctly Released U
        elseif (contains_all(currcodes', [124 122 130]) && currcond == 2) || (contains_all(currcodes', [124 123 129]) && currcond == 4) || (contains_all(currcodes', [124 134]) && currcond == 2)
            vals = [vals 11]; % 11: Correctly Released D
        elseif (contains_all(currcodes', [124 123 130]) && currcond == 2) || (contains_all(currcodes', [124 123 130]) && currcond == 4) || (contains_all(currcodes', [124 135]) && currcond == 2)
            vals = [vals 12]; % 12: Correctly Released U/D
        elseif (contains_all(currcodes', [127 122 129]) && currcond == 2) || (contains_all(currcodes', [127 122 129]) && currcond == 4) || (contains_all(currcodes', [127 132]) && currcond == 2)
            vals = [vals 13]; % 13: Incorrectly Released U/D
        elseif (contains_all(currcodes', [128 123 129]) && currcond == 2) || (contains_all(currcodes', [128 122 130]) && currcond == 4) || (contains_all(currcodes', [128 133]) && currcond == 2)
            vals = [vals 14]; % 14: Incorrectly Held U
        elseif (contains_all(currcodes', [128 122 130]) && currcond == 2) || (contains_all(currcodes', [128 123 129]) && currcond == 4) || (contains_all(currcodes', [128 134]) && currcond == 2)
            vals = [vals 15]; % 15: Incorrectly Held D        
        elseif (contains_all(currcodes', [128 123 130]) && currcond == 2) || (contains_all(currcodes', [128 123 130]) && currcond == 4) || (contains_all(currcodes', [128 135]) && currcond == 2)
            vals = [vals 16]; % 16: Incorrectly Held U/D          
        elseif contains_all(currcodes', 126)
            vals = [vals 17]; % 17: Released too soon.
        elseif contains_all(currcodes', 125)
            vals = [vals 18]; % 18: Didn't push lever down during fixation cue.            
        else
            vals = [vals 19]; % 19: Unknown?!
            disp( 'No compatiable Code Combinations found.');
        end
    end
    
    rslt = vals;
    
    % Rslt Code will be:
    % 1: Correctly Held R/L
    % 2: Correctly Released R
    % 3: Correctly Released L
    % 4: Correctly Released R/L
    % 5: Incorrectly Released R/L
    % 6: Incorrectly Held R
    % 7: Incorrectly Held L 
    % 8: Incorrectly Held R/L
    % 9: Correctly Held U/D
    % 10: Correctly Released U
    % 11: Correctly Released D
    % 12: Correctly Released U/D
    % 13: Incorrectly Released U/D
    % 14: Incorrectly Held U
    % 15: Incorrectly Held D 
    % 16: Incorrectly Held U/D
    % 17: Released too soon.
    % 18: Didn't push lever down during fixation cue.
    % 19: Unknown?!
    
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
    ns = {};
    
    for i = 1:length(bhv)
       histmat = vertcat( histmat, bhv(i).rspcount);
       ns{end+1} = length(bhv(i).responsetype);
    end
    
    
    H = bar(histmat, 'stack');
         
    C=[0 0 0.55; 0 0 0.8; 0 0 0.93; 0 0 1; 0.55 0 0; 0.8 0 0 ; 0.93 0 0 ; 1 0 0; 0.55 0.55 0.55; 0.7 0.7 0.7 ]; % make a colors list
    for n=1:length(H)
        set(H(n),'facecolor',C(n,:));
    end
    
    legend( H, {'Correct Held', 'Correct Rel1', 'Correct Rel2', 'Correct RelB', 'False Rel', 'False Hold1', 'False Hold2', 'False HoldB', 'Early Release', 'No Start'}, 'Location', 'Best');
    xlabel( 'Day', 'FontSize', 18, 'FontWeight', 'bold' );
    ylabel( 'Fraction of Total', 'FontSize', 18, 'FontWeight', 'bold' );
    set( gca, 'YTick', [0.25, 0.5, 0.75], 'FontSize', 16, 'FontWeight', 'bold');
    set( gca, 'XTickLabel', 1:length(bhv));
    ylim([0 1]);
    
    text( 1:length(bhv), repmat(0, 1, length(bhv)), ns, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'white'); 
    
    fig = H;
    
end

function rslt = calc_num_response_types( responsetype )
    n_conds = 10;
    
    counts = zeros(1,n_conds);

    for j = 1:n_conds
        counts(j) = sum(j == responsetype);
    end
   
    counts = counts';
       
    % Calculate fraction
    rslt = counts ./ length(responsetype);
    rslt = rslt';
       
end
    
    