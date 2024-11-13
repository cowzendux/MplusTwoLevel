# MplusTwoLevel

SPSS Python Extension function that will use Mplus to run a two-level model from within SPSS

This function allows users to identify a path model that they want to test on an SPSS data set. The program then converts the active data set to Mplus format, writes a program that will perform the path analysis in Mplus, then loads the important parts of the Mplus output into the SPSS output window.

This and other SPSS Python Extension functions can be found at http://www.stat-help.com/python.html

## Usage
**MplusTwoLevel(inpfile, modellabel, runModel, viewOutput, suppressSPSS, withinLatent, withinLatentFixed, withinLatentIdentifiers, withinModel, withinMeans, withinVar, withinCovar, withinCovEndo, withinCovExo, withinIdentifiers, withinMeanIdentifiers, withinSlopes, betweenLatent, betweenLatentFixed, betweenLatentIdentifiers, betweenModel, betweenVar, betweenCovar, betweenCovEndo, betweenCovExo, betweenIdentifiers, betweenMeanIdentifiers, estimator, starts, useobservations, wald, categorical, censored, count, nominal, groupmean, grandmean, cluster, complex, weight, datasetName, datasetMeans, datasetIntercepts, datasetVariances, datasetResidualV, newDatasetName, datasetLabels, processors, waittime)**
* "inpfile" is a string identifying the directory and filename of Mplus input file to be created by the program. This filename must end with .inp . The data file will automatically be saved to the same directory. This argument is required.
* "modellabel" is a string that indicates what label should be added to the output at the top of your model. If this is not specified, the label defaults to "MplusTwoLevel".
* "runModel" is a boolean argument indicating whether or not you want the program to actually run the program it creates based on the model you define. You may choose to not run the model when you want to use the program to load an existing output file into SPSS. However, when doing this, you should first load the corresponding data set so that the function can determine the appropriate translation between the Mplus variable names and SPSS variable names. By default, the model is run.
* "viewOutput" is a boolean argument indicating whether or not you want the program to read the created output into SPSS. You may choose not to read the output into SPSS when you know that it will take a very long time to run and you do not want to tie up SPSS while you are waiting for Mplus to finish. If you choose not to view the output, then the program will also not create a dataset for the coefficients. By default, the output is read into SPSS.
* "suppressSPSS" is a boolean argument indicating whether or not you want the program to supress SPSS output while running the model. Typically this output is not useful and merely clogs up the output window. If your program inconsistently causes SPSS to crash, suppressing the output can sometimes help. However, if your model is not running correctly, the SPSS output can help you see where the errors are. Setting this argument to True will not suppress the Mplus output. By default, the SPSS output is not suppressed.
* "withinLatent" is a list of lists identifying the relations between observed and latent variables for the within model. This argument is optional, and can be omitted if your model does not have any latent variables at the within level. When creating this argument, you first create a list of strings for each latent variable where the first element is the name of the latent variable and the remaining elements are the names of the observed variables that load on that latent variable. You then combine these individual latent variable lists into a larger list identifying the full measurement model.
* "withinLatentFixed" is a list of lists identifying any values of latent variable links that are fixed to constant values. Each entry in this list pairs a within latent coefficient with its constant value. The coefficients part must specifically match an element of the withinLatent statement. To do this, you may need to separate the observed values for a single latent variable into different lists. This defaults to None, which does not assign any fixed latent coefficients.
* "withinLatentIdentifiers" is an optional argument provides a list of lists pairing within latent coefficients with identifiers that can be used as part of a Wald Z test or a Model Constraint calculation, or a model with parameters forced to be equal. The coefficients part must specifically match a list in the "withinLatent" statement. To do this, you may need to separate the predictors for a single latent variable into different lists. This defaults to None, which does not assign any identifiers. 
* "withinModel" is a list of lists identifying the equations in the within-cluster part of your model.  First, you create a set of lists that each have the outcome as the first element and then have the predictors as the following elements. Then you combine these individual equation lists into a larger list identifying  the entire within model. All variables included in the within model have to have variability within clusters.
* "withinMeans" is a list of variables indicating which means you want estimated in the within model. 
* "withinVar" is a list of strings identifying variables that are to be treated as only having within-cluster variability. Note that you can include variables in the within model even if you do not include them in this command, in which case Mplus will assume that the variable has both within-cluster and within-cluster variability. This argument defaults to None, indicating that you are not identifying any variables as only having within-cluster variability.
* "withinCovar" is a list of lists identifying within-cluster covariances among variables. First, you create a set of lists that identify pairs of variables that  are allowed to covary. Then you combine these lists of pairs into a single, overall list. This argument defaults to None, which would indicate that there are not explicitly identifying within-cluster covariances among the variables. However, your choices for the "withinCovEndo" and the "withinCovExo" arguments may allow additional covariances.
*  "withinCovEndo" is a boolean variable that indicates whether you want to automatically covary all of the endogenous variables in the within-cluster part of the model. Endogenous variables are those that are used as an outcome at least once in your model. If this variable is set to True, then the program will automatically include covariances among all of the endogenous variables. If this variable is set to False, then it will not, although you can still specify individual covariances between endogenous variables using the "withinCovar" argument described above. By default, the value of withinCovEndo is False.
* "withinCovExo" is a boolean variable that indicates whether you want to automatically covary all of the exogenous variables in the within-cluster part of the model. Exogenous variables are those that are only used as predictors and never used as outcomes in your model. If this variable is set to True, then the program will automatically include covariances among all of the exogenous variables. If this variable is set to False, then it will not, although you can still specify individual covariances between exogenous variables using the "withinCovar" argument described above. By default, the value for withinCovExo is True.
* "withinIdentifiers" is an optional argument provides a list of lists pairing within-cluster coefficients with identifiers that will be used as part of a Wald Z test. The coefficients part must specifically match a list within the withinModel statement. To do this, you may need to separate the predictors for a single outcome into different lists. This defaults to None, which does not assign any identifiers.
* "withinMeanIdentifiers" is an optional argument that provides a list of lists pairing means from the within model with identifiers that will be used as part of a Wald Z test, a Model Constraint calculation, or a model with parameters forced to be equal. This defaults to None, which does not assign any identifiers. 
* "withinSlopes" is an optional argument that provides a list of lists pairing within-cluster coefficients with identifiers that will be used to test cross-level interactions. The coefficients part must specifically match an element of the withinModel statement. To do this, you may need to separate the predictors for a single outcome into different lists. This defaults to None, which does not assign any identifiers. The identifiers created in this statement can be used in the betweenLatent, betweenModel, betweenCovar, and betweenIdentifiers statements.
* "betweenLatent" is a list of lists identifying the relations between observed and latent variables for the between model. This argument is optional, and can be omitted if your model does not have any latent variables at the between level. When creating this argument, you first create a list of strings for each latent variable where the first element is the name of the latent variable and the remaining elements are the names of the observed variables that load on that latent variable. You then combine these individual latent variable lists into a larger list identifying the full measurement model.
* "betweenLatentFixed" is a list of lists identifying any values of latent variable links that are fixed to constant values. Each entry in this list pairs a within latent coefficient with its constant value. The coefficients part must specifically match an element of the betweenLatent statement. To do this, you may need to separate the observed values for a single latent variable into different lists. This defaults to None, which does not assign any fixed latent coefficients.
* "betweenLatentIdentifiers" is an optional argument provides a list of lists pairing between latent coefficients with identifiers that can be used as part of a Wald Z test or a Model Constraint calculation, or a model with parameters forced to be equal. The coefficients part must specifically match a list in the "betweenLatent" statement. To do this, you may need to separate the predictors for a single latent variable into different lists. This defaults to None, which does not assign any identifiers. 
* "betweenModel" is a list of lists identifying the equations in the between-cluster part of your model.  First, you create a set of lists that each have the outcome as the first element and then have the predictors as the following elements. Then you combine these individual equation lists into a larger list identifying the entire between model. You can include variables that vary within a cluster as elements of the between model. In this case, the between-cluster test will specifically identify how between-cluster variability in the predictor relates to between-cluster variability in the outcome.
* "betweenMeans" is a list of variables indicating which means you want estimated in the between model.
* "betweenVar" is a list of strings identifying variables that are to be treated as only having between-cluster variability. Note that you can include variables in the between model even if you do not include them in this command, in which case Mplus will assume that the variable has both within-cluster and within-cluster variability. This argument defaults to None, indicating that you are not identifying any variables as only having between-cluster variability.
* "betweenCovar" is a list of lists identifying between-cluster covariances among variables. First, you create a set of lists that identify pairs of variables that are allowed to covary. Then you combine these lists of pairs into a single, overall list. This argument defaults to None, which would indicate that there are not explicitly identifying between-cluster covariances among the variables. However, your choices for the "betweenCovEndo" and the "betweenCovExo" arguments may allow additional covariances.
* "betweenCovEndo" is a boolean variable that indicates whether you want to automatically covary all of the endogenous variables in the between-cluster part of the model. Endogenous variables are those that are used as an outcome at least once in your model. If this variable is set to True, then the program will automatically include covariances among all of the endogenous variables. If this variable is set to False, then it will not, although you can still specify individual covariances between endogenous variables using the "betweenCovar" argument described above. By default, the value of betweenCovEndo is False.
* "betweenCovExo" is a boolean variable that indicates whether you want to automatically covary all of the exogenous variables in the between-cluster part of the model. Exogenous variables are those that are only used as predictors and never used as outcomes in your model. If this variable is set to True, then the program will automatically include covariances among all of the exogenous variables. If this variable is set to False, then it will not, although you can still specify individual covariances between exogenous variables using the "betweenCovar" argument described above. By default, the value for betweenCovExo is True.
* "betweenIdentifiers" is an optional argument provides a list of lists pairing between-cluster coefficients with identifiers that will be used as part of a Wald Z test. The coefficients part must specifically match one listed in the betweenModel statement. To do this, you may need to separate the predictors for a single outcome into different lists. This defaults to None, which does not assign any identifiers. 
* "betweenMeanIdentifiers" is an optional argument that provides a list of lists pairing means from the between model with identifiers that will be used as part of a Wald Z test, a Model Constraint calculation, or a model with parameters forced to be equal. This defaults to None, which does not assign any identifiers.
* "estimator" is a string specifying the estimation method to be used. Valid values are ML, MLM, MLMV, MLR, MLF, MUML, WLS, WLSM, WLSMV, ULS, ULSMV, GLS, and BAYES. If this argument is omitted, the Mplus default will be used, which depends on the data and model types you are using (most commonly MLR).
* "starts" is number specifying the number of random starts to be used. Omitting this value has Mplus use the default number of random starts, which depends on the exact analysis you are doing.
* "useobservations" is a string specifying a selection criteriion that must be met for observations to be included in the analysis. This is an optional argument that defaults to None, indicating that all observations are to be included in the analysis.
* "wald" is an optional argument that identifies a list of constraints that will be tested using a Wald Z test. The constraints will be definted using the identifiers specified in the "identifiers" argument. This can be used to create an omnibus test that several coefficients are equal to zero, or it can be used to test the equivalence of different coefficients. This argument defaults to None, which would indicate that you do not want to perform a Wald Z test.
* "constraint" is an optional argument that identifies a string to be included in the Model Constraint section, allowing you to estimate linear combinations of means and coefficients from your model.
* "montecarlo" is an optional argument that allows you to specify Monte Carlo integration. If you omit this argument, Mplus will not use Monte Carlo integration. If you want to use Monte Carlo integration, you set this argument to a number that is the number of integration points you want to use. The default used by Mplus is 2000.
* "bootstrap" is an optional argument that allows you to request bootstrap confidence intervals. If you want to obtain bootstrap CIs, you set this argument equal to the number of bootstrap samples you want to use. This number should be at least 1000, but can go notably higher. Researchers typically use 5000, but it's not unheard of to use 20000 or more.  NOTE: Bootstrapping is not currently implemented for two-level models. The authors have indicated that they will be implementing it soon, but right now models with bootstrapping will not work.
* "repse" is an optional argument that allows you to identify the resampling method used to create replicate weights. Valid options are bootstrap, jackknife, jackknife1, jackknife2, brr, and fay(#)
* "categorical" is an optional argument that identifies a list of variables that should be treated as categorical by Mplus. Note that what Mplus calls categorical is typically called "ordinal" in other places. Use the "nominal" command described below for true categorical variables.
* "censored" is an optional argument that identifies a list of variables that should be treated as censored by Mplus.
* "count" is an optional argument that identifies a list of variables that should be treated as count variables (i.e., for Poisson regression) by Mplus.
* "nominal" is an optional argument that identifies a list of variables that should be treated as nominal variables by Mplus.
* "cluster" is an optional argument that identifies a cluster variable. This defaults to None, which would indicate that there is no clustering.
* "complex" is a string that identifies a second cluster variable that shoule be used to adjust the standard error of the coeffficients. This defaults to None, meaning that there is not a second cluster variable.
* "groupmean" is an optional argument that identifies a list of variables that should be group mean centered.
* "grandmean" is an optional argument that identifies a list of variables that should be grand mean centered.
* "weight" is an optional argument that identifies a sample weight. This defaults to None, which would indicate that there all observations are given equal weight.
* "datasetName" is an optional argument that identifies the name of an SPSS dataset that should be used to record the coefficients.
* "datasetMeans" is an optional argument that determines whether the means are included in the coefficient dataset. This is False by default.
* "datasetIntercepts" is an optional argument that determines whether the model intercepts are included in the coefficient dataset. This is False by default.
* "datasetVariances" is an optional argument that determines whether the variances are included in the coefficient dataset. This is False by default.
* "datasetResidualV" is an optional argument that determines whether the residual variances are included in the coefficient dataset. This is False by default.
* "newDatasetName" is an optional argument that identifiers the name of an SPSS dataset that should be used to record the tests of new/additional parameters created using the "model contrast" command.
* "datasetLabels" is an optional argument that identifies a list of labels that would be applied to the datasets.  This can be useful if you are appending the results from multiple analyses to the same dataset.
* "miThreshold" is an optional argument that identifies the minimum chi-square change required for a modificiation index to be reported. Omitting this argument uses a default of 10. "processors" is an optional argument that specifies how many logical processors Mplus should use when running the analysis. You should not specify more processors than are available in your machine. If this argument is omitted, Mplus will use 1 processor.
* "waittime" is an optional argument that specifies how many seconds the program should wait after running the Mplus program before it tries to read the output file. This defaults to 5. You should be sure that you leave enough time for Mplus to finish the analyses before trying to import them into SPSS.

## Example 1 - Simple specification
**MplusTwoLevel(inpfile = "C:/users/jamie/workspace/spssmplus/path.inp",  
withinModel = [ ["CO", "att_ch", "yrs_tch"] ],  
withinCovExo = True,  
betweenModel = [ ["CO", "att_ch", "yrs_tch", "schoolsize", "Tx"] ]  
betweenCovExo = True,  
cluster = "school" )**
* This would test a model where Classroom Organinzation (CO) is predicted by within-school (i.e., classroom) and between-school predictors (defined by the cluster variable school).
* Within-school predictors are teacher attitudes toward childen (att_ch) and teacher experience (yrs_tch). 
* The exogenous variables (att_ch, and yrs_tch) are allowed to freely covary in the within model.
* Between-school predictors are the number of students in the school (schoolsize) and treatment condition (Tx). 
* The exogenous variables (Tx, att_ch, yrs_tch, and schoolsize) are allowed to freely covary in the between model. 

## Example 2 - Full specification
**MplusTwoLevel(inpfile = "C:/users/jamie/workspace/spssmplus/path.inp",  
runModel = True,  
viewOutput = True,  
withinLatent = [ ["CHSES", "chincome_mean", "chfrl_mean", "chmomed_mean"] ],  
withinModel = [ ["CO", "CHSES", "att_ch", "yrs_tch"],  
$~~~~$["ES", "CHSES", "att_ch", "yrs_tch"],  
$~~~~$["IS", "CHSES", "att_ch", "yrs_tch"],  
$~~~~$["CO", "satis"],   
$~~~~$["ES", "satis"],  
$~~~~$["IS", "satis"] ],  
withinCovar = [ ["CO","ES"], ["CO", "IS"] ],  
withinCovEndo = False,  
withinCovExo = True,  
withinIdentifiers = None,  
withinSlopes = [ [ ["CO", "satis"], "bCO"],  
$~~~~$[ ["ES", "satis"], "bES"],  
$~~~~$[ ["IS", "satis"], "bIS"] ],  
betweenLatent = [ ["CHSES", "chincome_mean", "chfrl_mean", "chmomed_mean"] ],  
betweenModel = [ ["CO", "CHSES", "att_ch", "yrs_tch", "schoolsize", "satis"],  
$~~~~$["CO", "Tx"],  
$~~~~$["ES", "CHSES", "att_ch", "yrs_tch", "schoolsize"],  
$~~~~$["ES", "Tx"],  
$~~~~$["IS", "CHSES", "att_ch", "yrs_tch", "schoolsize"]  
$~~~~$["IS", "Tx"],  
$~~~~$["bCO", "Tx"],  
$~~~~$["bES", "Tx"],  
$~~~~$["bIS", "Tx] ],  
betweenCovar = [ ["CO","ES"], ["CO", "IS"] ],  
betweenCovEndo = False,  
betweenCovExo = True,  
betweenIdentifiers = [ [ ["CO", "Educ"], "b1"],  
$~~~~$[ ["ES", "Educ"], "b2"],  
$~~~~$[ ["IS", "Educ"], "b3"] ],  
wald = [ "b1 = 0", "b2 = 0", "b3 = 0" ],  
useobservations = "p2cond==1",  
categorical = ["att_ch", "yrs_tch"],  
censored = None,  
count = None,  
nominal = ["Tx"],  
groupmean = ["CO", "CHSES", "att_ch", "yrs_tch"],  
grandmean = ["schoolsize"],  
cluster = "school",  
weight = "demoweight",  
datasetName = "CLASS",  
datasetMeans = True,  
datasetIntercepts = True,  
datasetVariances = True,  
datasetResidualV = True,  
datasetLabels = ["2009 cohort"]  
waittime = 10)**
* This would test a model where three measures assessing classroom interactions (CO, ES, and IS) are predicted by within-school (i.e., classroom) and between-school predictors (defined by the cluster variable school).
* The program will both run the model and load the program into SPSS.
* A single latent variable (CHSES) is created to represent child socio-economic status, based on observed variables assessing income (chincome_mean), free/reduced lunch status (chfrl_mean), and mother education (chmomed_mean). This is implemented at both the within level and the between level. 
* Other within-school predictors are teacher attitudes toward childen (att_ch) and teacher experience (yrs_tch). 
* The exogenous variables (CHSES, att_ch, and yrs_tch) are allowed to freely covary in the within model. 
* The endogenous variables  (CO, ES, and IS) are not automatically allowed to covary in the within model, although two specific covariances are allowed (CO with ES and CO with IS). 
* The relations of teacher satisfaction with the outcomes in the within model are identified as bCO, bES, and bIS.
* Between-school predictors are the number of students in the school (schoolsize) and treatment condition (Tx). 
* The random slopes bCO, bES, and bIS are used to test cross-level interactions between treatment and satisfaction on the outcomes (CO, ES, and IS).
* The exogenous variables (Tx, CHSES, att_ch, yrs_tch, and schoolsize) are allowed to freely covary in the between model. 
* The endogenous variables  (CO, ES, and IS) are not automatically allowed to covary in the between model, although two specific covariances are allowed (CO with ES and CO with IS). 
* Identifiers are created representing the treatment effects on the three outcomes at the between level. A Wald test is created testing whether this collect of effects is significant.
* The analysis will only include observations where the value of pcond is 1.
* att_ch and trs_tch are treated as a categorical variables, whereas Tx is treated as a nominal variable. 
* The four within variables will be group mean centered, while schoolsize will be grand mean centered. 
* The analysis weights the observations using the values in the variable "demoweight." 
* The regression coefficients will be recorded in the SPSS dataset "CLASS". This dataset will have a label variable, which will have the value of "2009 cohort" for all results from this analysis. The dataset will additionally contain estimates of the means, model intercepts, variances, and residual variances.
* The program will wait 10 seconds after starting to run the Mplus program before it tries to read the results back into SPSS.

## Example 3 - Only reading output
**MplusTwoLevel(inpfile = "C:/users/jamie/workspace/spssmplus/path.inp",  
runModel = False,  
withinModel = [ ["CO", "att_ch", "yrs_tch"] ],  
withinCovExo = True,  
betweenModel = [ ["CO", "att_ch", "yrs_tch", "schoolsize", "Tx"] ]  
betweenCovExo = True,  
cluster = "school" )**
* This is the model listed in the simple specification, except that now choose to not run the model but only read its output into SPSS.
* It is not necessary to actually report the model with the withinModel, betweenModel, etc. statements. However, you can leave them in without any problems.
* Before running this command you should have loaded the appropriate data set so that the function can determine the appropriate translation between the Mplus and SPSS variables.
