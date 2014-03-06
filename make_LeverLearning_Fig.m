function fig = make_LeverLearning_Fig( LP )

    te = struct([]);


    % Extract trialerror info for new te struct
    for i = 1:length(LP)
        te(i).TrialErrors = LP(i).TrialError;
        te(i).CodeNumbers = LP(i).CodeNumbers;
    end
    
    %Calculate Values for Plotting
    
    for i = 1:length(te)
        te(i).FPs = sum(te(i).TrialErrors == 3); %Released when shouldn't have
        te(i).FNs = sum(te(i).TrialErrors == 4); %Did not release when should have
        te(i).Corrects = sum(te(i).TrialErrors == 0);
        te(i).Fails = sum(te(i).TrialErrors == 1); %Failed to Initiate Trial by Pressing Lever
        te(i).N = length(te(i).TrialErrors);
    
    
        te(i).LongestRun = findLongestRun( te(i).TrialErrors );
        te(i).CorrectSwitches = findCorrectSwitches( te(i).TrialErrors, te(i).CodeNumbers );
    end


    assignin( 'base', 'tes', te );
    
    % Make plots
    
    
    subplot(1,3,1)
    panel1 = makeFractionPlot( te );
    
    subplot(1,3,2)
    panel2 = makeLongestRunPlot([te.LongestRun] );
    
    subplot(1,3,3)
    panel3 = makeCorrectSwitchesPlot([te.CorrectSwitches] );
    
    
    set(gcf, 'Position', [0 0 1200 600]);
    
        % Relative frequency of correct / false positives / false negatives
        % Longest run of correct
        % Fraction of at least 2+ and correct switch out of total available
    
    
end





% indexes = [3 4 5 6 9]
% dIndex  = [0 1 1 1 3]
% [1 5]
function rslt = findLongestRun( tes )
    tes = tes';

    % Find all runs in the input
    dTes = [1 diff(tes) 1];
    startIndexes = find(dTes ~= 0);

    runDurations = diff(startIndexes); % All run durations
    runValues = tes(startIndexes(1:end-1)); % Repeated value
    durationsOfZeroRuns = runDurations(runValues == 0); % Durations of runs with a value of 0

    maxDuration = max(durationsOfZeroRuns);
    rslt = maxDuration;
end


function rslt = findCorrectSwitches( tes, ems )
    
    numSwitches = 0;

    %find sequences of 3 correct in a row
    CorrIdxs = strfind( tes', [0 0 0] );

    for i = 1:length( CorrIdxs )
        
        %Look at eventmarkers for each of those three trials
        trial1ems = cell2mat(ems(CorrIdxs(i)));
        trial2ems = cell2mat(ems(CorrIdxs(i)+1));
        trial3ems = cell2mat(ems(CorrIdxs(i)+2));
        
        
        if ~isempty(strfind(trial1ems', [121 124])) && ~isempty(strfind(trial2ems', [121 124])) && sum((123 == trial3ems))
            numSwitches = numSwitches+1;
        end
        
        if sum((123 == trial1ems)) && sum((123 == trial2ems)) && ~isempty(strfind(trial3ems', [121 124]))
            numSwitches = numSwitches+1;
        end
            
    end

    targs = [];
    %Look at every trial and determine whether targ 1 or targ 2 was shown
    for i = 1:length(tes)
        trialems = cell2mat(ems(i));
        if ~isempty(strfind(trialems', [121 124]))
            targs = [targs 2];
        elseif sum((123 == trialems))
            targs = [targs 1];
        end
    end
    
    switches1 = strfind( targs, [1 1 2]);
    switches2 = strfind( targs, [2 2 1]);
    
    totalswitches = length(switches1) + length(switches2);
    
    rslt = numSwitches / totalswitches;
    
end


function fig = makeFractionPlot( te )

    C=[0 0 1; 0 0 0; 1 0 0]; % make a colors list
        
    Corrs = [te.Corrects] ./ [te.N];
    FPs = [te.FPs] ./ [te.N];
    FNs = [te.FNs] ./ [te.N];
    
    total = vertcat( Corrs, FPs, FNs );
    H = bar(total', 'stack');

    for n=1:length(H)
        set(H(n),'facecolor',C(n,:));
    end
       
    legend( H, {'Correct', 'FPs', 'FNs'}, 'Location', 'Best');
    xlabel( 'Day', 'FontSize', 18, 'FontWeight', 'bold' );
    ylabel( 'Fraction of Total', 'FontSize', 18, 'FontWeight', 'bold' );
    set( gca, 'YTick', [0.25, 0.5, 0.75], 'FontSize', 16, 'FontWeight', 'bold');
    ylim([0 1]);
    
    
    fig = H;
end


function fig = makeLongestRunPlot( lRuns )

    P = plot(lRuns, 'k-', 'LineWidth', 2 );

    xlabel( 'Day', 'FontSize', 18, 'FontWeight', 'bold' );
    ylabel( 'Longest Run of Corrects', 'FontSize', 18, 'FontWeight', 'bold' );
    set( gca, 'YTick', [5, 10, 15, 20, 25, 30], 'FontSize', 16, 'FontWeight', 'bold');
    ylim([0 30]);
    
    fig = P;
end


function fig = makeCorrectSwitchesPlot( corrSwchs )

    P = plot(corrSwchs, 'k-', 'LineWidth', 2 );

    xlabel( 'Day', 'FontSize', 18, 'FontWeight', 'bold' );
    ylabel( 'Fraction of Correct Switches', 'FontSize', 18, 'FontWeight', 'bold' );
    set( gca, 'YTick', [0.25 0.5 1.0], 'FontSize', 16, 'FontWeight', 'bold');
    ylim([0 1]);
    
    fig = P;  
end

