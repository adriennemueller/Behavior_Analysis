function rslt = make_ErrorsByDirection( LP )


   te = struct([]);


    % Extract trialerror info for new te struct
    for i = 1:length(LP)
        te(i).TrialErrors = LP(i).TrialError;
        te(i).ConditionNumbers = LP(i).ConditionNumber;
    end
    
    %Calculate Values for Plotting
    for i = 1:length(te)
        te(i).DirErrors = findFailsByDirection (te(i).TrialErrors, te(i).ConditionNumbers);
    end

    assignin( 'base', 'dirErrors', te );
    
    figure();
    makeDirErrorPlot( te );
    
end


function fig = makeDirErrorPlot( te )

    C=[0 0 1; 0 0 0; 1 0 0; 0 1 0]; % make a colors list
    te_destruct = [];    
    
    for i = 1:length(te)
       te_destruct = vertcat(te_destruct, te(i).DirErrors);        
    end
    
    te_destruct
    
    H = bar(te_destruct, 'stack');

    for n=1:length(H)
        set(H(n),'facecolor',C(n,:));
    end
       
    legend( H, {'Left', 'Up', 'Right', 'Down' }, 'Location', 'Best');
    xlabel( 'Day', 'FontSize', 18, 'FontWeight', 'bold' );
    ylabel( 'Fraction of Errors', 'FontSize', 18, 'FontWeight', 'bold' );
    set( gca, 'YTick', [0.25, 0.5, 0.75], 'FontSize', 16, 'FontWeight', 'bold');
    ylim([0 1]);
    
    
    fig = H;
end


function rslt = findFailsByDirection( tes, conditions )

RCount = 0;
UCount = 0;
LCount = 0;
DCount = 0;

for i = 1:length(tes)
    if tes(i) ~= 0;
        if (conditions(i) == 1)      || (conditions(i) == 5)
            RCount = RCount + 1;
        elseif (conditions(i) == 2)  || (conditions(i) == 6)      
            UCount = UCount + 1;
        elseif (conditions(i) == 3)  || (conditions(i) == 7)
            LCount = LCount + 1;
        elseif (conditions(i) == 4)  || (conditions(i) == 8)
            DCount = DCount + 1;
        end
        
    end
end

total = sum( tes ~= 0 );

rslt = [RCount UCount LCount DCount]./total;

end

