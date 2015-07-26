function rslt = chisqcue( Cue_Corrs, Cue_Fails, NoCue_Corrs, NoCue_Fails )
    
    Total_Cue = Cue_Corrs + Cue_Fails;
    Total_NoCue = NoCue_Corrs + NoCue_Fails;
    Total_Corrs = Cue_Corrs + NoCue_Corrs;
    Total_Trials = Total_Cue + Total_NoCue;
       
    % Pooled Estimate of Proportion
    p0 = Total_Corrs / Total_Trials;
    %p0 = Cue_Corrs / Total_Cue; 
    
    % Expected counts under H0 (null hypothesis)
   
    Expected_Cue_Corrs = Total_Cue * p0;
    Expected_NoCue_Corrs = Total_NoCue * p0;
    
    % Chi-square test, by hand
    observed = [Cue_Corrs Cue_Fails NoCue_Corrs NoCue_Fails];
    expected = [Expected_Cue_Corrs (Total_Cue - Expected_Cue_Corrs) Expected_NoCue_Corrs (Total_NoCue - Expected_NoCue_Corrs)];
    chi2stat = sum((observed-expected).^2 ./ expected);
    rslt = 1 - chi2cdf(chi2stat,1);
    
    
    
end