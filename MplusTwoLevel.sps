* Encoding: UTF-8.
* Use Mplus to run a two level model from within SPSS
* By Jamie DeCoster

* This program allows users to identify a path model that
* they want to test on an SPSS data set. The program then
* converts the active data set to Mplus format, writes a program
* that will perform the path analysis in Mplus, then loads the important
* parts of the Mplus output into the SPSS output window.

**** Usage: MplusTwoLevel(inpfile, modellabel, runModel, viewOutput, suppressSPSS,
withinLatent, withinLatentFixed, withinModel, withinMeans, withinVar, withinCovar, 
withinCovEndo, withinCovExo, withinIdentifiers, withinMeanIdentifiers, withinSlopes,
betweenLatent, betweenLatentFixed, betweenModel, betweenMeans, betweenVar, betweenCovar,
betweenCovEndo, betweenCovExo, 
betweenIdentifiers, betweenMeanIdentifiers,
estimator, useobservations, wald, constraint,
montecarlo, bootstrap, repse,
categorical, censored, count, nominal, groupmean, grandmean,
cluster, complex, weight, 
datasetName, datasetMeans, datasetIntercepts, datasetVariances, 
datasetResidualV, datasetLabels, waittime)
**** "inpfile" is a string identifying the directory and filename of
* Mplus input file to be created by the program. This filename must end with
* .inp . The data file will automatically be saved to the same directory. This
* argument is required.
**** "modellabel" is a string that indicates what label should be added to the output at the
* top of your model. If this is not specified, the label defaults to "MplusTwoLevel"
**** "runModel" is a boolean argument indicating whether or not you want
* the program to actually run the program it creates based on the model
* you define. You may choose to not run the model when you 
* want to use the program to load an existing output file into SPSS. 
* By default, the model is run.
**** "viewOutput" is a boolean argument indicating whether or not you want
* the program to read the created output into SPSS. You may choose not
* to read the output into SPSS when you know that it will take a very long
* time to run and you do not want to tie up SPSS while you are waiting 
* for Mplus to finish. If you choose not to view the output, then the program
* will also not create a dataset for the coefficients. 
* By default, the output is read into SPSS.
**** "suppressSPSS" is a boolean argument indicating whether or not you want
* the program to supress SPSS output while running the model. Typically this
* output is not useful and merely clogs up the output window. If your program 
* inconsistently causes SPSS to crash, suppressing the output can sometimes
* help. However, if your model is not running correctly, the SPSS output can 
* help you see where the errors are. Setting this argument to True will not 
* suppress the Mplus output. By default, the SPSS output is not suppressed.
**** "withinLatent" is a list of lists identifying the relations between observed and 
* latent variables for the within model. This argument is optional, and can be omitted 
* if your model does not have any latent variables at the within level. When 
* creating this argument, you first create a
* list of strings for each latent variable where the first element is the name of
* the latent variable and the remaining elements are the names of the observed
* variables that load on that latent variable. You then combine these individual
* latent variable lists into a larger list identifying the full measurement model.
**** "withinLatentFixed" is a list of lists identifying any values of latent variable links 
* that are fixed to constant values. Each entry in this list pairs a within latent 
* coefficient with its constant value. The coefficients part must 
* specifically match an element of
* the withinLatent statement. To do this, you may need to separate the 
* observed values for a single latent variable into different lists. This defaults to None, 
* which does not assign any fixed latent coefficients. 
**** "withinModel" is a list of lists identifying the equations in the within-cluster part
* of your model.  First, you create a set of lists that each have the outcome as
* the first element and then have the predictors as the following elements.
* Then you combine these individual equation lists into a larger list identifying 
* the entire within model. All variables included in the within model have to
* have variability within clusters.
**** "withinMeans" is a list of variables indicating which means you want 
* estimated in the within model. 
**** "withinVar" is a list of strings identifying variables that are to be treated
* as only having within-cluster variability. Note that you can include variables
* in the within model even if you do not include them in this command, in
* which case Mplus will assume that the variable has both within-cluster
* and within-cluster variability. This argument defaults to None, indicating
* that you are not identifying any variables as only having within-cluster
* variability.
**** "withinCovar" is a list of lists identifying within-cluster covariances among
* variables. First, you create a set of lists that identify pairs of variables that 
* are allowed to covary. 
* Then you combine these lists of pairs into a single, overall list. 
* This argument defaults to None, which would indicate that there are 
* not explicitly identifying within-cluster covariances among the variables. 
* However, your choices for the "withinCovEndo" and the "withinCovExo" 
* arguments may allow additional covariances.
**** "withinCovEndo" is a boolean variable that indicates whether you want
* to automatically covary all of the endogenous variables in the within-cluster
* part of the model.
* Endogenous variables are those that are used as an outcome at least
* once in your model. If this variable is set to True, then the program will
* automatically include covariances among all of the endogenous 
* variables. If this variable is set to False, then it will not, although
* you can still specify individual covariances between endogenous
* variables using the "withinCovar" argument described above. By default, 
* the value of covEndo is False.
**** "withinCovExo" is a boolean variable that indicates whether you want
* to automatically covary all of the exogenous variables in the within-cluster
* part of the model.
* Exogenous variables are those that are only used as predictors and
* never used as outcomes in your model. If this variable is set to True, 
* then the program will automatically include covariances among all 
* of the exogenous variables. If this variable is set to False, then it 
* will not, although you can still specify individual covariances between 
* exogenous variables using the "withinCovar" argument described above.
* By default, the value for corrExo is True.
**** "withinIdentifiers" is an optional argument that provides a list of lists pairing 
* within-cluster coefficients with identifiers that will be used as part of a 
* Wald Z test or a model constraint calculation. The coefficients part must 
* specifically match an element of
* the withinModel statement. To do this, you may need to separate the 
* predictors for a single outcome into different lists. This defaults to None, 
* which does not assign any identifiers. 
**** "withinMeanIdentifiers" is an optional argument that provides a list of lists
* pairing means from the within model with identifiers that will be used as 
* part of a Wald Z test,
* a Model Constraint calculation, or a model with parameters forced to be equal.
* This defaults to None, which does not assign any identifiers.
**** "withinSlopes" is an optional argument that provides a list of lists pairing
* within-cluster coefficients with identifiers that will be used to test cross-level
* interactions. The coefficients part must specifically match an element of 
* the withinModel statement. To do this, you may need to separate the
* predictors for a single outcome into different lists. This defaults to None, 
* which does not assign any identifiers. The identifiers created in this statement
* can be used in the betweenLatent, betweenModel, betweenCovar, and 
* betweenIdentifiers statements.
**** "betweenLatent" is a list of lists identifying the relations between observed and 
* latent variables for the between model. This argument is optional, and can be omitted 
* if your model does not have any latent variables at the between level. When 
* creating this argument, you first create a
* list of strings for each latent variable where the first element is the name of
* the latent variable and the remaining elements are the names of the observed
* variables that load on that latent variable. You then combine these individual
* latent variable lists into a larger list identifying the full measurement model.
**** "betweenLatentFixed" is a list of lists identifying any values of latent variable links 
* that are fixed to constant values. Each entry in this list pairs a within latent 
* coefficient with its constant value. The coefficients part must 
* specifically match an element of
* the betweenLatent statement. To do this, you may need to separate the 
* observed values for a single latent variable into different lists. This defaults to None, 
* which does not assign any fixed latent coefficients. 
**** "betweenModel" is a list of lists identifying the equations in the between-cluster 
* part of your model.  First, you create a set of lists that each have the outcome 
* as the first element and then have the predictors as the following elements.
* Then you combine these individual equation lists into a larger list identifying 
* the entire between model. You can include variables that vary within a 
* cluster as elements of the between model. In this case, the between-cluster
* test will specifically identify how between-cluster variability in the predictor
* relates to between-cluster variability in the outcome.
**** "betweenMeans" is a list of variables indicating which means you want 
* estimated in the between model. 
**** "betweenVar" is a list of strings identifying variables that are to be treated
* as only having between-cluster variability. Note that you can include variables
* in the between model even if you do not include them in this command, in
* which case Mplus will assume that the variable has both within-cluster
* and within-cluster variability. This argument defaults to None, indicating
* that you are not identifying any variables as only having between-cluster
* variability.
**** "betweenCovar" is a list of lists identifying between-cluster covariances among
* variables. First, you create a set of lists that identify pairs of variables that 
* are allowed to covary. 
* Then you combine these lists of pairs into a single, overall list. 
* This argument defaults to None, which would indicate that there are 
* not explicitly identifying between-cluster covariances among the variables. 
* However, your choices for the "betweenCovEndo" and the "betweenCovExo" 
* arguments may allow additional covariances.
**** "betweenCovEndo" is a boolean variable that indicates whether you want
* to automatically covary all of the endogenous variables in the between-cluster
* part of the model.
* Endogenous variables are those that are used as an outcome at least
* once in your model. If this variable is set to True, then the program will
* automatically include covariances among all of the endogenous 
* variables. If this variable is set to False, then it will not, although
* you can still specify individual covariances between endogenous
* variables using the "betweenCovar" argument described above. By default, 
* the value of covEndo is False.
**** "betweenCovExo" is a boolean variable that indicates whether you want
* to automatically covary all of the exogenous variables in the between-cluster
* part of the model.
* Exogenous variables are those that are only used as predictors and
* never used as outcomes in your model. If this variable is set to True, 
* then the program will automatically include covariances among all 
* of the exogenous variables. If this variable is set to False, then it 
* will not, although you can still specify individual covariances between 
* exogenous variables using the "betweenCovar" argument described above.
* By default, the value for corrExo is True.
**** "betweenIdentifiers" is an optional argument provides a list of lists pairing 
* between-cluster coefficients with identifiers that will be used as part of a 
* Wald Z test. The coefficients part must specifically match one list  
* in the betweenModel statement. To do this, you may need to separate the 
* predictors for a single outcome into different lists. This defaults to None, 
* which does not assign any identifiers. 
**** "betweenMeanIdentifiers" is an optional argument that provides a list of lists
* pairing means from the between model with identifiers that will be used as part of a Wald Z test,
* a Model Constraint calculation, or a model with parameters forced to be equal.
* This defaults to None, which does not assign any identifiers.
**** "estimator" is a string specifying the estimation method to be used. 
* Valid values are ML, MLM, MLMV, MLR, MLF, MUML, WLS, WLSM,
* WLSMV, ULS, ULSMV, GLS, and BAYES. If this argument is omitted,
* the Mplus default will be used, which depends on the data and model
* types you are using (most commonly MLR).
**** "useobservations" is a string specifying a selection
* criteriion that must be met for observations to be included in the 
* analysis. This is an optional argument that defaults to None, indicating
* that all observations are to be included in the analysis.
**** "wald" is an optional argument that identifies a list of constraints that
* will be tested using a Wald Z test. The constraints will be definted using the
* identifiers specified in the "identifiers" argument. This can be used 
* to create an omnibus test that several coefficients are equal to zero, or it 
* can be used to test the equivalence of different coefficients. This argument 
* defaults to None, which would indicate that you do not want to perform 
* a Wald Z test.
**** "constraint" is an optional argument that identifies a string
* to be included in the Model Constraint section, allowing you to estimate
* linear combinations of means and coefficients from your model. 
**** "montecarlo" is an optional argument that allows you to specify Monte
* Carlo integration. If you omit this argument, Mplus will not use Monte Carlo
* integration. If you want to use Monte Carlo integration, you set this argument
* to a number that is the number of integration points you want to use. The
* default used by Mplus is 2000.
**** "bootstrap" is an optional argument that allows you to request bootstrap
* confidence intervals. If you want to obtain bootstrap CIs, you set this
* argument equal to the number of bootstrap samples you want to use. This
* number should be at least 1000, but can go notably higher. Researchers
* typically use 5000, but it's not unheard of to use 20000 or more.
* NOTE: Bootstrapping is not currently implemented for two-level models.
* The authors have indicated that they will be implementing it soon, 
* but right now models with bootstrapping will not work.
**** "repse" is an optional argument that allows you to identify the resampling
* method used to create replicate weights. Valid options are bootstrap, 
* jackknife, jackknife1, jackknife2, brr, and fay(#)
**** "categorical" is an optional argument that identifies a list of variables
* that should be treated as categorical by Mplus. Note that what Mplus
* calls categorical is typically called "ordinal" in other places. Use the
* "nominal" command described below for true categorical variables.
**** "censored" is an optional argument that identifies a list of variables
* that should be treated as censored by Mplus.
**** "count" is an optional argument that identifies a list of variables
* that should be treated as count variables 
* (i.e., for Poisson regression) by Mplus.
**** "nominal" is an optional argument that identifies a list of variables
* that should be treated as nominal variables by Mplus.
**** "groupmean" is an optional argument that identifies a list of variables
* that should be group mean centered.
**** "grandmean" is an optional argument that identifies a list of variables
* that should be grand mean centered.
**** "cluster" is a string that identifies the primary cluster variable.
* This is required, because we cannot run a two-level model without
* a cluster variable.
**** "complex" is a string that identifies a second cluster variable that
* shoule be used to adjust the standard error of the coeffficients.
* This defaults to None, meaning that there is not a second cluster variable.
**** "weight" is an optional argument that identifies a sample weight.
* This defaults to None, which would indicate that there all observations
* are given equal weight. Note that not all estimators can make use of
* weights. MLR is typically a good option.
**** "datasetName" is an optional argument that identifies the name of
* an SPSS dataset that should be used to record the coefficients.
**** "datasetMeans" is an optional argument that determines whether
* the means are included in the coefficient dataset. This is False
* by default.
**** "datasetIntercepts" is an optional argument that determines whether
* the model intercepts are included in the coefficient dataset. This is False
* by default.
**** "datasetVariances" is an optional argument that determines whether
* the variances are included in the coefficient dataset. This is False
* by default.
**** "datasetResidualV" is an optional argument that determines whether
* the residual variances are included in the coefficient dataset. This is False
* by default.
**** "datasetLabels" is an optional argument that identifies a list of
* labels that would be applied to the datasets.  This can be useful if 
* you are appending the results from multiple analyses to the same dataset.
**** "miThreshold" is an optional argument that identifies the
* minimum chi-square change required for a modificiation index
* to be reported. Omitting this argument uses a default of 10.
**** "waittime" is an optional argument that specifies how many seconds
* the program should wait after running the Mplus program before it 
* tries to read the output file. This defaults to 5. You should be sure that
* you leave enough time for Mplus to finish the analyses before trying
* to import them into SPSS

* Example: 
MplusTwoLevel(inpfile = "C:/users/jamie/workspace/spssmplus/path.inp",
runModel = True,
viewOutput = True,
suppressSPSS = False,
withinLatent = [ ["CHSES", "chincome_mean", "chfrl_mean", "chmomed_mean"] ],
withinModel = [ ["CO", "CHSES", "att_ch", "yrs_tch"],
["ES", "CHSES", "att_ch", "yrs_tch"],
["IS", "CHSES", "att_ch", "yrs_tch"],
["CO", "satis"],
["ES", "satis"],
["IS", "satis"] ],
withinCovar = [ ["CO","ES"], ["CO", "IS"] ],
withinCovEndo = False,
withinCovExo = True,
withinIdentifiers = None,
withinSlopes = [ [ ["CO", "satis"], "StoCO"],
[ ["ES", "satis"], "StoES"],
[ ["IS", "satis"], "StoIS"] ],
betweenLatent = [ ["CHSES", "chincome_mean", "chfrl_mean", "chmomed_mean"] ],
betweenModel = [ ["CO", "CHSES", "att_ch", "yrs_tch", "schoolsize"],
["CO", "Tx"],
["ES", "CHSES", "att_ch", "yrs_tch", "schoolsize"],
["ES", "Tx"],
["IS", "CHSES", "att_ch", "yrs_tch", "schoolsize"] 
["IS", "Tx"],
["StoCO", "schoolsize"],
["StoES", "schoolsize"],
["StoIS", "schoolsize"] ],
betweenCovar = [ ["CO","ES"], ["CO", "IS"],
["StoCO", "StoES"], ["StoCO", "StoIS"], ["StoES", "StoIS"] ],
betweenCovEndo = False,
betweenCovExo = True,
betweenIdentifiers = [ [ ["CO", "Educ"], "b1"],
[ ["ES", "Educ"], "b2"],
[ ["IS", "Educ"], "b3"] ],
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
datasetLabels = ["2009 cohort"],
miThreshold = 4,
waittime = 10)
* This would test a model where three measures assessing classroom 
* interactions (CO, ES, and IS) are predicted by within-school (i.e., classroom)
* and between-school predictors (defined by the cluster variable school).
* The toggles are set so that the program will run the model in Mplus 
* and read the output into SPSS. The SPSS output is not suppressed.
* A single latent variable (CHSES) is created to represent child socio-
* economic status, based on observed variables assessing income 
* (chincome_mean), free/reduced lunch status (chfrl_mean), and
* mother education (chmomed_mean). Other within-school predictors 
* are teacher attitudes toward childen (att_ch), teacher satisfaction (satis), and
* teacher experience (yrs_tch). The exogenous variables (CHSES, att_ch, and 
* yrs_tch) are allowed to freely covary in the within model. The endogenous 
* variables  (CO, ES, and IS) are not automatically allowed to covary in the 
* within model, although two specific covariances are allowed (CO with ES 
* and CO with IS). The slopes of teacher satisfaction with the three outcomes 
* at the within level identified so that they can be used in the between model 
* to test cross-level interactions. Between-school predictors are the number of 
* students in the school (schoolsize) and treatment condition (Tx). School size is 
* also used to predict the relations of satisfaction with the three outcomes.
* The exogenous variables (CHSES, att_ch, and yrs_tch) are allowed 
* to freely covary in the between model. The endogenous variables  (CO, ES, 
* and IS) are not automatically allowed to covary in the between model, although 
* two specific covariances among the outcomes are allowed (CO with ES and 
CO with IS). The three slopes for satisfaction are all allowed to freely covary.
* Identifiers are created representing the treatment effects on the three 
* outcomes at A Wald test is created testing whether this collect of effects is 
* significant. The analysis will only include observations where the value of 
* pcond is 1. att_ch and trs_tch are treated as a categorical variables, whereas 
* Tx is treated as a nominal variable. The four within variables will be
* group mean centered, while schoolsize will be grand mean centered.
* The analysis weights the observations using the values in the variable 
* "demoweight." The regression coefficients will be recorded in the 
* SPSS dataset "CLASS". The dataset will additionally contain estimates 
* of the means, model intercepts, variances, and residual variances. 
* This dataset will have a label variable, which will 
* have the value of "2009 cohort" for all results from this analysis.
* All modification indices that are greater than 4 will be reported in 
* the output. The program will wait 10 seconds after starting to 
* run the Mplus program before it tries to read the results back into SPSS.

set printback = off.
begin program python.
import spss, spssaux, os, sys, time, re, tempfile, SpssClient
from subprocess import Popen, PIPE

def _titleToPane():
    """See titleToPane(). This function does the actual job"""
    outputDoc = SpssClient.GetDesignatedOutputDoc()
    outputItemList = outputDoc.GetOutputItems()
    textFormat = SpssClient.DocExportFormat.SpssFormatText
    filename = tempfile.mktemp() + ".txt"
    for index in range(outputItemList.Size()):
        outputItem = outputItemList.GetItemAt(index)
        if outputItem.GetDescription() == u"Page Title":
            outputItem.ExportToDocument(filename, textFormat)
            with open(filename) as f:
                outputItem.SetDescription(f.read().rstrip())
            os.remove(filename)
    return outputDoc

def titleToPane(spv=None):
    """Copy the contents of the TITLE command of the designated output document
    to the left output viewer pane"""
    try:
        outputDoc = None
        SpssClient.StartClient()
        if spv:
            SpssClient.OpenOutputDoc(spv)
        outputDoc = _titleToPane()
        if spv and outputDoc:
            outputDoc.SaveAs(spv)
    except:
        print "Error filling TITLE in Output Viewer [%s]" % sys.exc_info()[1]
    finally:
        SpssClient.StopClient()

def MplusSplit(splitstring, linelength):
    returnstring = ""
    curline = splitstring
    while (len(curline) > linelength):
        splitloc = linelength
        while (curline[splitloc] == " " or curline[splitloc-1] == " "):
            splitloc = splitloc -1
        returnstring = returnstring + curline[:splitloc] + "\n"
        curline = curline[splitloc:]
    returnstring += curline
    return returnstring

def SPSSspaceSplit(splitstring, linelength):
    stringwords = splitstring.split()
    returnstring = "'"
    curline = ""
    for word in stringwords:
        if (len(word) > linelength):
            break
        if (len(word) + len(curline) < linelength - 1):
            curline += word + " "
        else:
            returnstring += curline + "' +\n'"
            curline = word + " "
    returnstring += curline[:-1] + "'"
    return returnstring

def numericMissing(definition):
    for varnum in range(spss.GetVariableCount()):
        if (spss.GetVariableType(varnum) == 0):
      # for numeric variables
            submitstring = """
missing values %s (%s).""" %(spss.GetVariableName(varnum), definition)
            spss.Submit(submitstring)

def exportMplus(filepath):
######
# Get list of current variables in SPSS data set
######
 SPSSvarlist = []
 for varnum in range(spss.GetVariableCount()):
  SPSSvarlist.append(spss.GetVariableName(varnum))

##########
# Replace non-alphanumeric characters with _ in the variable names
##########
 nonalphanumeric = [".", "@", "#", "$"]
	for t in range(spss.GetVariableCount()):
		oldname = spss.GetVariableName(t)
		newname = ""
		for i in range(len(oldname)):
			if(oldname[i] in nonalphanumeric):
				newname = newname +"_"
			else:
				newname = newname+oldname[i]
		for i in range(t):
			compname = spss.GetVariableName(i)
			if (newname.lower() == compname.lower()):
				newname = "var" + "%05d" %(t+1)
		if (oldname != newname):
			submitstring = "rename variables (%s = %s)." %(oldname, newname)
			spss.Submit(submitstring)
#########
# Rename variables with names > 8 characters
#########
 for t in range(spss.GetVariableCount()):
		if (len(spss.GetVariableName(t)) > 8):
			name = spss.GetVariableName(t)[0:8]
			for i in range(spss.GetVariableCount()):
				compname = spss.GetVariableName(i)
				if (name.lower() == compname.lower()):
					name = "var" + "%05d" %(t+1)
			submitstring = "rename variables (%s = %s)." %(spss.GetVariableName(t), name)
			spss.Submit(submitstring)

# Obtain lists of variables in the dataset
	varlist = []
	numericlist = []
	stringlist = []
	for t in range(spss.GetVariableCount()):
		varlist.append(spss.GetVariableName(t))
		if (spss.GetVariableType(t) == 0):
			numericlist.append(spss.GetVariableName(t))
		else:
			stringlist.append(spss.GetVariableName(t))

###########
# Automatically recode string variables into numeric variables
###########
# First renaming string variables so the new numeric vars can take the 
# original variable names
	submitstring = "rename variables"
	for var in stringlist:
		submitstring = submitstring + "\n " + var + "=" + var + "_str"
	submitstring = submitstring + "."
	spss.Submit(submitstring)

# Recoding variables
 if (len(stringlist) > 0):
 	submitstring = "AUTORECODE VARIABLES="
	 for var in stringlist:
		 submitstring = submitstring + "\n " + var + "_str"
 	submitstring = submitstring + "\n /into"
	 for var in stringlist:
		 submitstring = submitstring + "\n " + var
 	submitstring = submitstring + """
   /BLANK=MISSING
   /PRINT."""
	 spss.Submit(submitstring)
	
# Dropping string variables
	submitstring = "delete variables"
	for var in stringlist:
		submitstring = submitstring + "\n " + var + "_str"
	submitstring = submitstring + "."
	spss.Submit(submitstring)

# Set all missing values to be -999
	submitstring = "RECODE "
	for var in varlist:
		submitstring = submitstring + " " + var + "\n"
	submitstring = submitstring + """ (MISSING=-999).
EXECUTE."""
	spss.Submit(submitstring)

 numericMissing("-999")

########
# Convert date and time variables to numeric
########
# SPSS actually stores dates as the number of seconds that have elapsed since October 14, 1582.
# This syntax takes variables with a date type and puts them in their natural numeric form

 submitstring = """numeric ddate7663804 (f11.0).
alter type ddate7663804 (date11).
ALTER TYPE ALL (DATE = F11.0).
alter type ddate7663804 (adate11).
ALTER TYPE ALL (ADATE = F11.0).
alter type ddate7663804 (time11).
ALTER TYPE ALL (TIME = F11.0).

delete variables ddate7663804."""
 spss.Submit(submitstring)

######
# Obtain list of transformed variables
######
 submitstring = """MATCH FILES /FILE=*
  /keep="""
 for var in varlist:
		submitstring = submitstring + "\n " + var
 submitstring = submitstring + """.
EXECUTE."""
 spss.Submit(submitstring)
 MplusVarlist = []
 for varnum in range(spss.GetVariableCount()):
  MplusVarlist.append(spss.GetVariableName(varnum))

############
# Create data file
############
# Break filename over multiple lines
 splitfilepath = SPSSspaceSplit(filepath, 60)

# Save data as a tab-delimited text file
	submitstring = """SAVE TRANSLATE OUTFILE=
	%s
  /TYPE=TAB
  /MAP
  /REPLACE
  /CELLS=VALUES
	/keep""" %(splitfilepath)
	for var in varlist:
		submitstring = submitstring + "\n " + var
	submitstring = submitstring + "."
	spss.Submit(submitstring)

##############
# Rename variables back to original values
##############
 submitstring = "rename variables"
 for s, m in zip(SPSSvarlist, MplusVarlist):
  submitstring += "\n(" + m + "=" + s + ")"
 submitstring += "."
 spss.Submit(submitstring)

 return MplusVarlist

class MplusPAprogram:
    def __init__(self):
        self.title = "TITLE:\n"
        self.data = "DATA:\n"
        self.variable = "VARIABLE:\n"
        self.define = "DEFINE:\n"
        self.analysis = "ANALYSIS:\n"
        self.model = "MODEL:\n"
        self.constraint = "MODEL CONSTRAINT:\n"        
        self.output = "OUTPUT:\n"
        self.savedata = "SAVEDATA:\n"
        self.plot = "PLOT:\n"
        self.montecarlo = "MONTECARLO:\n"

    def setTitle(self, titleText):
        self.title += titleText

    def setData(self, filename):
        self.data += "File is\n"
        splitName = MplusSplit(filename, 75)
        self.data += "'" + splitName + "';"

    def setVariable(self, fullList, withinLatent, withinModel, withinVar, 
slopeVars,
betweenLatent, betweenModel, betweenVar, useobservations, 
categorical, censored, count, nominal, cluster, complex, weight):
        self.variable += "Names are\n"
        for var in fullList:
            self.variable += var + "\n"
        self.variable += ";\n\n"

# Determine usevariables
        useList = []
        latentName = []
        if (withinLatent != None):
            for equation in withinLatent:
                latentName.append(equation[0])
                for var in equation[1:]:
                    if (var not in useList):
                        useList.append(var)
        if (betweenLatent != None):
            for equation in betweenLatent:
                latentName.append(equation[0])
                for var in equation[1:]:
                    if (var not in useList and var not in slopeVars):
                        useList.append(var)
        if (withinModel != None):
            for equation in withinModel:
                for var in equation:
                    if (var not in useList and var not in latentName):
                        useList.append(var)
        if (betweenModel != None):
            for equation in betweenModel:
                for var in equation:
                    if (var not in useList and var not in latentName and var not in slopeVars):
                        useList.append(var)
        self.variable += "Usevariables are\n"
        for var in useList:
            self.variable += var + "\n"

# Other variable additions
        if (useobservations != None):
            self.variable += ";\n\nuseobservations are " + useobservations
        self.variable += ";\n\ncluster is"
        if (complex != None):
            self.variable += " " + complex
        self.variable += " " + cluster
        if (weight != None):
            self.variable += ";\n\nweight is " + weight

        vartypeList = [categorical, censored, count, nominal, 
withinVar, betweenVar]
        varnameList = ["categorical", "censored", "count", "nominal", 
"within", "between"]
        for t in range(len(vartypeList)):
            if (vartypeList[t] != []):
                self.variable += ";\n\n{0} = ".format(varnameList[t])
                for var in vartypeList[t]:
                    self.variable += var + "\n"
        self.variable += ";\n\nMISSING ARE ALL (-999);"

    def setDefine(self, MplusGroupmean, MplusGrandmean):
        if (MplusGroupmean == [] and MplusGrandmean == []):
            self.define += ""
        else:
            self.define += "CENTER"
            if MplusGroupmean != []:
                for var in MplusGroupmean:
                    self.define += " " + var
                self.define += " (GROUPMEAN)"
            if MplusGrandmean != []:
                for var in MplusGrandmean:
                    self.define += " " + var
                self.define += " (GRANDMEAN)"
            self.define += ";"

    def setAnalysis(self, cluster, complex, MplusWithinSlopes, estimator, weight, mc, boot, repse):
        self.analysis += "type = twolevel"
        if (complex != None):
            self.analysis += " complex"
        if (MplusWithinSlopes != None):
            self.analysis += " random"
        self.analysis += ";"
        if (estimator != None):
            self.analysis += "\nestimator = {0};".format(estimator)
        if (mc != None):
            self.analysis += "\nintegration = montecarlo({0});".format(mc)
        if (boot != None):
            self.analysis += "\nbootstrap = {0};".format(boot)
        if (repse != None):
            self.analysis += "\nrepse = {0};".format(repse)

    def setModel(self, MplusWithinLatent, MplusWithinLatentFixed, MplusWithinModel, 
MplusWithinMeans, MplusWithinCovar, MplusWithinIdentifiers, MplusWithinMeanIdentifiers,
withinEndo, withinExo, MplusWithinSlopes, 
MplusBetweenLatent, MplusBetweenLatentFixed, MplusBetweenModel, MplusBetweenMeans,
MplusBetweenCovar, MplusBetweenIdentifiers, MplusBetweenMeanIdentifiers,
betweenEndo, betweenExo, wald):
        
        def modelCode(label, latent, latentFixed, model, means, covar, identifiers, meanIdentifiers,
cEndo, cExo, slopes, slopeList,):
            code = "%{0}%\n".format(label)
            # Latent variable definitions
            if (latent != None):
              for equation in latent:
                  curline = equation[0] + " by"
                  for var in equation[1:]:
                          if (len(curline) + len(var) < 75):
                              curline += " " + var
                          else:
                              code += curline + "\n"
                              curline = var
                  if (latentFixed != None):
                      for t in latentFixed:
                          if (equation == t[0]):
                              curline += "@" + str(t[1])
                  code += curline + ";\n\n"                              
            
            # Regression equations
            if (model != None):
              for equation in model:
                  curline = ""
                  if (slopes != None):
                      for s in slopes:
                          if (equation == s[0]):
                              curline += s[1] + " | " 
                  curline += equation[0] + " on"
                  for var in equation[1:]:
                          if (len(curline) + len(var) < 75):
                              curline += " " + var
                          else:
                              code += curline + "\n"
                              curline = var
                  if (identifiers != None):
                      for id in identifiers:
                          if (equation == id[0]):
                              curline += " (" + id[1] + ")"
                  code += curline + ";\n"
            
            # Means               
            if (means != None):
                for m in means:
                    curline = "[" + m + "]"
                    if (meanIdentifiers != None):
                        for id in meanIdentifiers:
                             if (m == id[0]):
                                curline += " (" + id[1] + ")"
                    code += curline + ";\n"                  
            
            # Getting lists of endogenous and exogenous variables
            endo = []
            for equation in model:
              if (equation[0] not in slopeList):
                  endo.append(equation[0])
            endo = list(set(endo))
            exo = []
            for equation in model:
              for var in equation:
                  if (var not in endo and var not in exo and var not in slopeList):
                      exo.append(var)
            
            # Add defined covariances
            if (covar != None):
              for t in range(len(covar)):
                  code += "\n" + covar[t][0] + " with "  
                  code += covar[t][1] + ";"
              code += "\n"
            
            # Covariances for all exogenous variables
            if (cExo == True and model != None):
            # Estimate variances for exogenous variables so that they
            # will be included in FIML
            # Cannot include predictors that are also included as random slopes 
              if (len(exo) > 0):
                  for var in exo:
                      code += "\n" + var + ";"
                  code += "\n"
                  for t in range(len(exo)-1):
                      code += "\n" 
                      curline = exo[t] + " with"
                      for var in exo[t+1:]:
                          if (len(curline) + len(var) < 75):
                              curline = curline + " " + var
                          else:
                              code += curline + "\n"
                              curline = var
                      code += curline + ";"
            
            # Covariances for all endgenous variables
            if (cEndo == True and model != None):
              if (len(endo) > 0):
                  code += "\n"
                  for t in range(len(endo)-1):
                      code += "\n" 
                      curline = endo[t] + " with"
                      for var in endo[t+1:]:
                          if (len(curline) + len(var) < 75):
                              curline = curline + " " + var
                          else:
                              code += curline + "\n"
                              curline = var
                      code += curline + ";"
            code += "\n\n"
            return(code)

# List of variables involved in random slopes
        slopeList = []
        if (MplusWithinSlopes != None):
            for slope in MplusWithinSlopes:
                for var in slope[0]:
                    slopeList.append(var)
# Within Model
        withinCode = modelCode("WITHIN", MplusWithinLatent, MplusWithinLatentFixed, 
MplusWithinModel, MplusWithinMeans, MplusWithinCovar, MplusWithinIdentifiers, 
MplusWithinMeanIdentifiers, withinEndo, withinExo, MplusWithinSlopes, slopeList)
        self.model += withinCode
# Between Model
        betweenCode = modelCode("BETWEEN", MplusBetweenLatent, MplusBetweenLatentFixed,
MplusBetweenModel, MplusBetweenMeans, MplusBetweenCovar, MplusBetweenIdentifiers, 
MplusBetweenMeanIdentifiers, betweenEndo, betweenExo, None, slopeList)
        self.model += betweenCode

# Wald test
        if (wald != None):
            self.model += "\n\nMODEL TEST:"
            for line in wald:
                self.model += "\n" + line + ";"

    def setConstraint(self, constraintText):
        if (constraintText != None):
            self.constraint +="\n" + constraintText

    def setOutput(self, MplusComplex, miThreshold, boot):
        if (MplusComplex == None):
            self.output += "stdyx;"
        if (boot != None):
            self.output += "\ncinterval(bcbootstrap);"
        self.output += "\nmodindices({0});".format(miThreshold)

    def write(self, filename):
# Write input file
        sectionList = [self.title, self.data, self.variable, self.define,
self.analysis, self.model, self.constraint, self.output, self.savedata, 
self.plot, self.montecarlo]
        outfile = open(filename, "w")
        for sec in sectionList:
            if (sec[-2:] != ":\n"):
                outfile.write(sec)
                outfile.write("\n\n")
        outfile.close()

def batchfile(directory, filestem):
# Write batch file
    batchFile = open(directory + "/" + filestem + ".bat", "w")
    batchFile.write("cd " + directory + "\n")
    batchFile.write("call mplus \"" + filestem + ".inp" + "\"\n")
    batchFile.close()

# Run batch file
    p = Popen(directory + "/" + filestem + ".bat", cwd=directory)

def removeBlanks(processString):
    if (processString == None):
        return (None)
    else:
        for t in range(len(processString), 0, -1):
                if (processString[t-1] != "\n"):
                    return (processString[0:t])

def getCoefficients(outputBlock):
    coefficients = []
    if (outputBlock != None):
        outputBlock2 = outputBlock.replace("\r", "")
        blockList = outputBlock2.split("\n")
        for t in range(len(blockList)):
            values1 = blockList[t].split(" ")
            values2 = []
            for i in values1:
                if (i != ""):
                    values2.append(i)

            if (len(values2) > 1):
                if (values2[1] == "ON"):
                    outcome = values2[0]
                if (len(values2) > 2 and values2[0] != "Estimate"):
                    line = [outcome]
                    line.extend(values2[0:1])
                    for j in values2[1:]:
                        if (j != "*"):
                            line.append(float(j))
                    coefficients.append(line)
    return coefficients

def getStats(outputBlock, startList, stopList):
    stats = []
    startRead = 0
    if (outputBlock != None):
        outputBlock2 = outputBlock.replace("\r", "")
        blockList = outputBlock2.split("\n")
        for t in range(len(blockList)):
            values1 = blockList[t].split(" ")
            values2 = []
            for i in values1:
                if (i != ""):
                    values2.append(i)

            if (len(values2) > 0):
                if (values2[0] in stopList):
                    break
                if (startRead == 1):
                    line = [values2[0]]
                    for j in values2[1:]:
                        line.append(float(j))
                    stats.append(line)
                if (values2[0] in startList):
                    startRead = 1

    return stats

class MplusTLoutput:
    def __init__(self, modellabel, filename, Mplus, SPSS, slopes, complex, estimator):
        self.label = modellabel
        infile = open(filename, "rb")
        fileText = infile.read()
        infile.close()
        outputList = fileText.split("\n")

        if (estimator == "BAYES"):
            self.header = """                                               Posterior  One-Tailed         95% C.I.
                                   Estimate       S.D.      P-Value   Lower 2.5%  Upper 2.5%  Sig"""
        else:
            self.header = """                                                                   Two-Tailed 
                                   Estimate       S.E.  Est./S.E.    P-Value"""
        self.summary = None
        self.warnings = None
        self.fit = None
        self.wmeasurement = None
        self.wcoefficients = None
        self.wcovariances = None
        self.wdescriptives = None
        self.bmeasurement = None
        self.bcoefficients = None
        self.bcovariances = None
        self.bdescriptives = None
        self.newParam = None
        self.Zwmeasurement = None
        self.Zwcoefficients = None
        self.Zwcovariances = None
        self.Zwdescriptives = None
        self.Zbmeasurement = None
        self.Zbcoefficients = None
        self.Zbcovariances = None
        self.Zbdescriptives = None
        self.wr2 = None
        self.br2 = None
        self.wmi = None
        self.bmi = None

# Summary
        for t in range(len(outputList)):
            if ("SUMMARY OF ANALYSIS" in outputList[t]):
                start = t
            if ("Number of continuous latent variables" in outputList[t]):
                end = t
        self.summary = "\n".join(outputList[start:end+1])
# Warnings
        for t in range(len(outputList)):
            if ("Covariance Coverage" in outputList[t]):
                covcov = t
        blank = 0
        for t in range(covcov, len(outputList)):
            if (len(outputList[t]) < 2):
                blank = 1
            if (blank == 1 and len(outputList[t]) > 1):
                start = t
                break
        for t in range(start, len(outputList)):
            if ("MODEL FIT INFORMATION" in outputList[t] or
"MODEL RESULTS" in outputList[t]):
                end = t
                break
        self.warnings = "\n".join(outputList[start:end])
        self.warnings = removeBlanks(self.warnings)

        if ("MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings):
# Fit statistics
            start = end
            for t in range(start, len(outputList)):
                if ("MODEL RESULTS" in outputList[t]):
                    end = t
                    break
            self.fit = "\n".join(outputList[start:end])
            self.fit = removeBlanks(self.fit)

# Within Unstandardized measurement model
        start = end
        secexists = 0
        for t in range(start, len(outputList)):
            if (re.search(r"\bBY\b", outputList[t])):
                start = t
                secexists = 1
                break
            if (re.search(r"\bBetween Level\b", outputList[t])):
                break
        if (secexists == 1):
            for t in range(start, len(outputList)):
                if (re.search(r"\bON\b", outputList[t]) or
    re.search(r"\bWITH\b", outputList[t]) or
    re.search(r"\bMeans\b", outputList[t]) or 
    re.search(r"\bVariances\b", outputList[t]) ):
                    end = t
                    break
            self.wmeasurement = "\n".join(outputList[start:end])
            self.wmeasurement = removeBlanks(self.wmeasurement)

# Within Unstandardized coefficients
        start = end
        secexists = 0
        for t in range(start, len(outputList)):
            if (re.search(r"\bON\b", outputList[t])):
                start = t
                secexists = 1
                break
            if (re.search(r"\bBetween Level\b", outputList[t])):
                break
            if (re.search(r"\bSTANDARDIZED\b", outputList[t])):
                break
        if (secexists == 1):
            for t in range(start, len(outputList)):
                if (re.search(r"\bWITH\b", outputList[t]) or
    re.search(r"\bMeans\b", outputList[t]) or 
    re.search(r"\bVariances\b", outputList[t])):
                    end = t
                    break
            self.wcoefficients = "\n".join(outputList[start:end])
            self.wcoefficients = removeBlanks(self.wcoefficients)

# Within Unstandardized covariances
        start = end
        secexists = 0
        for t in range(start, len(outputList)):
            if (re.search(r"\bWITH\b", outputList[t])):
                start = t
                secexists = 1
                break
            if (re.search(r"\bBetween Level\b", outputList[t])):
                break
            if (re.search(r"\bSTANDARDIZED\b", outputList[t])):
                break                
        if (secexists == 1):
            for t in range(start, len(outputList)):
                if (re.search(r"\bMeans\b", outputList[t]) or 
    re.search(r"\bVariances\b", outputList[t])):
                    end = t
                    break
            self.wcovariances = "\n".join(outputList[start:end])
            self.wcovariances = removeBlanks(self.wcovariances)

# Within Unstandardized Descriptives
        start = end
        for t in range(start, len(outputList)):
            if ("STANDARDIZED MODEL RESULTS" in outputList[t] or
"MODEL COMMAND" in outputList[t] or
    "New/Additional Parameters" in outputList[t] or 
"Between Level" in outputList[t]):
                end = t
                break
        self.wdescriptives = "\n".join(outputList[start:end])
        self.wdescriptives = removeBlanks(self.wdescriptives)

# Between Unstandardized measurement model
        start = end
        secexists = 0
        for t in range(start, len(outputList)):
            if ("QUALITY OF NUMERICAL RESULTS" in outputList[t]):
                break
            if (re.search(r"\bBY\b", outputList[t])):
                start = t
                secexists = 1
                break
        if (secexists == 1):
            for t in range(start, len(outputList)):
                if (re.search(r"\bON\b", outputList[t]) or
    re.search(r"\bWITH\b", outputList[t]) or
    re.search(r"\bMeans\b", outputList[t]) or 
    re.search(r"\bVariances\b", outputList[t]) ):
                    end = t
                    break
            self.bmeasurement = "\n".join(outputList[start:end])
            self.bmeasurement = removeBlanks(self.bmeasurement)

# Between Unstandardized coefficients
        start = end
        secexists = 0
        for t in range(start, len(outputList)):
            if (re.search(r"\bON\b", outputList[t])):
                start = t
                secexists = 1
                break
            if (re.search(r"\bSTANDARDIZED\b", outputList[t])):
                break                
        if (secexists == 1):
            for t in range(start, len(outputList)):
                if (re.search(r"\bWITH\b", outputList[t]) or
    re.search(r"\bMeans\b", outputList[t]) or 
    re.search(r"\bVariances\b", outputList[t])):
                    end = t
                    break
            self.bcoefficients = "\n".join(outputList[start:end])
            self.bcoefficients = removeBlanks(self.bcoefficients)

# Between Unstandardized covariances
        start = end
        secexists = 0
        for t in range(start, len(outputList)):
            if (re.search(r"\bWITH\b", outputList[t]) or 
re.search(r"\bMeans\b", outputList[t]) or
re.search(r"\bVariances\b", outputList[t])):
                start = t
                secexists = 1
                break
            if (re.search(r"\bSTANDARDIZED\b", outputList[t])):
                break                
        if (secexists == 1):
            for t in range(start, len(outputList)):
                if (re.search(r"\bMeans\b", outputList[t]) or 
    re.search(r"\bVariances\b", outputList[t])):
                    end = t
                    break
            self.bcovariances = "\n".join(outputList[start:end])
            self.bcovariances = removeBlanks(self.bcovariances)

# Between Unstandardized Descriptives
        start = end
        for t in range(start, len(outputList)):
            if ("STANDARDIZED MODEL RESULTS" in outputList[t] or
"MODEL COMMAND" in outputList[t] or
"STANDARDIZED" in outputList[t] or
    "New/Additional Parameters" in outputList[t] or
"QUALITY OF NUMERICAL RESULTS" in outputList[t]):
                end = t
                break
        self.bdescriptives = "\n".join(outputList[start:end])
        self.bdescriptives = removeBlanks(self.bdescriptives)

# New/additional parameters
        start = end
        if ("New/Additional Parameters" in outputList[start]):
            for t in range(start, len(outputList)):
                if ("STANDARDIZED MODEL RESULTS" in outputList[t] or
"STANDARDIZED" in outputList[t] or
    "MODEL COMMAND" in outputList[t] or
"QUALITY OF NUMERICAL RESULTS" in outputList[t]):
                    end = t
                    break
            self.newParam = "\n".join(outputList[start:end])
            self.newParam = removeBlanks(self.newParam)        

        noStand = 0
        for t in range(len(outputList)):
            if ("STANDARDIZED (STD, STDY, STDYX) options are not available" in outputList[t]
or "Request for STANDARDIZED (STD, STDY, STDYX) is ignored" in outputList[t]):
                noStand = 1
                break
            if ("SUMMARY OF ANALYSIS" in outputList[t]):
                break
        if (complex != None):
            noStand = 1
        
        if (noStand == 0):
# Within standardized measurement model
            if ("MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings):
                start = end
                secexists = 0
                for t in range(start, len(outputList)):
                    if (re.search(r"\bBY\b", outputList[t])):
                        start = t
                        secexists = 1
                        break
                    if (re.search(r"\bBetween Level\b", outputList[t])):
                        break
                if (secexists == 1):
                    for t in range(start, len(outputList)):
                        if (re.search(r"\bON\b", outputList[t]) or
            re.search(r"\bWITH\b", outputList[t]) or
            re.search(r"\bMeans\b", outputList[t]) or 
            re.search(r"\bVariances\b", outputList[t]) ):
                            end = t
                            break
                    self.Zwmeasurement = "\n".join(outputList[start:end])
                    self.Zwmeasurement = removeBlanks(self.Zwmeasurement)

        # Within standardized coefficients
                start = end
                secexists = 0
                for t in range(start, len(outputList)):
                    if (re.search(r"\bON\b", outputList[t])):
                        start = t
                        secexists = 1
                        break
                    if (re.search(r"\bBetween Level\b", outputList[t])):
                        break
                if (secexists == 1):
                    for t in range(start, len(outputList)):
                        if (re.search(r"\bWITH\b", outputList[t]) or
            re.search(r"\bMeans\b", outputList[t]) or 
            re.search(r"\bVariances\b", outputList[t])):
                            end = t
                            break
                    self.Zwcoefficients = "\n".join(outputList[start:end])
                    self.Zwcoefficients = removeBlanks(self.Zwcoefficients)

        # Within standardized covariances
                start = end
                secexists = 0
                for t in range(start, len(outputList)):
                    if (re.search(r"\bWITH\b", outputList[t])):
                        start = t
                        secexists = 1
                        break
                    if (re.search(r"\bBetween Level\b", outputList[t])):
                        break
                if (secexists == 1):
                    for t in range(start, len(outputList)):
                        if (re.search(r"\bMeans\b", outputList[t]) or 
            re.search(r"\bVariances\b", outputList[t])):
                            end = t
                            break
                    self.Zwcovariances = "\n".join(outputList[start:end])
                    self.Zwcovariances = removeBlanks(self.Zwcovariances)

        # Within Unstandardized Descriptives
                start = end
                for t in range(start, len(outputList)):
                    if ("STANDARDIZED MODEL RESULTS" in outputList[t] or
        "MODEL COMMAND" in outputList[t] or
        "Between Level" in outputList[t]):
                        end = t
                        break
                self.Zwdescriptives = "\n".join(outputList[start:end])
                self.Zwdescriptives = removeBlanks(self.Zwdescriptives)

        # Between standardized measurement model
                start = end
                secexists = 0
                for t in range(start, len(outputList)):
                    if (re.search(r"\bBY\b", outputList[t])):
                        start = t
                        secexists = 1
                        break
                if (secexists == 1):
                    for t in range(start, len(outputList)):
                        if (re.search(r"\bON\b", outputList[t]) or
            re.search(r"\bWITH\b", outputList[t]) or
            re.search(r"\bMeans\b", outputList[t]) or 
            re.search(r"\bVariances\b", outputList[t]) ):
                            end = t
                            break
                    self.Zbmeasurement = "\n".join(outputList[start:end])
                    self.Zbmeasurement = removeBlanks(self.Zbmeasurement)

        # Between standardized coefficients
                start = end
                secexists = 0
                for t in range(start, len(outputList)):
                    if (re.search(r"\bON\b", outputList[t])):
                        start = t
                        secexists = 1
                        break
                if (secexists == 1):
                    for t in range(start, len(outputList)):
                        if (re.search(r"\bWITH\b", outputList[t]) or
            re.search(r"\bMeans\b", outputList[t]) or 
            re.search(r"\bVariances\b", outputList[t])):
                            end = t
                            break
                    self.Zbcoefficients = "\n".join(outputList[start:end])
                    self.Zbcoefficients = removeBlanks(self.Zbcoefficients)

        # Between standardized covariances
                start = end
                secexists = 0
                for t in range(start, len(outputList)):
                    if (re.search(r"\bWITH\b", outputList[t])):
                        start = t
                        secexists = 1
                        break
                    if (re.search(r"\bR-SQUARE\b", outputList[t])):
                        break
                if (secexists == 1):
                    for t in range(start, len(outputList)):
                        if (re.search(r"\bMeans\b", outputList[t]) or 
            re.search(r"\bVariances\b", outputList[t])):
                            end = t
                            break
                    self.Zbcovariances = "\n".join(outputList[start:end])
                    self.Zbcovariances = removeBlanks(self.Zbcovariances)

        # Between standardized Descriptives
                start = end
                for t in range(start, len(outputList)):
                    if ("STANDARDIZED MODEL RESULTS" in outputList[t] or
        "MODEL COMMAND" in outputList[t] or
        "R-SQUARE" in outputList[t]):
                        end = t
                        break
                self.Zbdescriptives = "\n".join(outputList[start:end])
                self.Zbdescriptives = removeBlanks(self.Zbdescriptives)

    # Within R squares
                start = end
                for t in range(start, len(outputList)):
                    if ("Between Level" in outputList[t]):
                        end = t
                        break
                self.wr2 = "\n".join(outputList[start:end])
                self.wr2 = removeBlanks(self.wr2)

    # Between R squares
                start = end
                for t in range(start, len(outputList)):
                    if ("QUALITY OF NUMERICAL RESULTS" in outputList[t]):
                        end = t
                        break
                self.br2 = "\n".join(outputList[start:end])
                self.br2 = removeBlanks(self.br2)

# Within Modification indices
            for t in range(end, len(outputList)):
                stest = 0
                if ("MODEL MODIFICATION INDICES" in outputList[t]):
                    start = t
                    stest = 1
                    break
            if (stest == 1):
                for t in range(start, len(outputList)):
                    if ("Between Level" in outputList[t]):
                        end = t-1
                        break
                self.wmi = "\n".join(outputList[start:end])
                self.wmi = removeBlanks(self.wmi)

# Between level modification indices
            start = end
            if (stest == 1):
                for t in range(start, len(outputList)):
                    if ("Beginning Time" in outputList[t] or "TECHNICAL" in outputList[t]):
                        end = t-1
                        break
                self.bmi = "\n".join(outputList[start:end])
                self.bmi = removeBlanks(self.bmi)

# Replacing variable names
# In the Coefficients section, initially room for 17
#    A) Increasing overall width from 61 to 75 = gain of 14
# In the Modification indices section, 
# there is initially room for 2 vars X 10 characters
#    A) Increasing overall width from 67 to 77 = gain of 5 for each var
#    B) Drop STD EPC = gain of 6 for each var
#    C) Change "StdYX E.P.C." to "StdYX EPC" = gain of 2 for each var
# Making all variables length of 23

# Variables
        Mplus.extend(slopes)
        SPSS.extend(slopes)
        for var1, var2 in zip(Mplus, SPSS):
            var1 += " "*(8-len(var1))
            var1 = " " + var1 + " "
            if (len(var2) < 23):
                var2 += " "*(23-len(var2))
            else:
                var2 = var2[:23]
            var2 = " " + var2 + " "

            if (self.wmeasurement != None):
                self.wmeasurement = self.wmeasurement.replace(var1.upper(), var2)
            if (self.wcoefficients != None):
                self.wcoefficients = self.wcoefficients.replace(var1.upper(), var2)
            if (self.wcovariances != None):
                self.wcovariances = self.wcovariances.replace(var1.upper(), var2)
            if (self.wdescriptives != None):
                self.wdescriptives = self.wdescriptives.replace(var1.upper(), var2)
            if (self.Zwmeasurement != None):
                self.Zwmeasurement = self.Zwmeasurement.replace(var1.upper(), var2)
            if (self.Zwcoefficients != None):
                self.Zwcoefficients = self.Zwcoefficients.replace(var1.upper(), var2)
            if (self.Zwcovariances != None):
                self.Zwcovariances = self.Zwcovariances.replace(var1.upper(), var2)
            if (self.Zwdescriptives != None):
                self.Zwdescriptives = self.Zwdescriptives.replace(var1.upper(), var2)

            if (self.bmeasurement != None):
                self.bmeasurement = self.bmeasurement.replace(var1.upper(), var2)
            if (self.bcoefficients != None):
                self.bcoefficients = self.bcoefficients.replace(var1.upper(), var2)
            if (self.bcovariances != None):
                self.bcovariances = self.bcovariances.replace(var1.upper(), var2)
            if (self.bdescriptives != None):
                self.bdescriptives = self.bdescriptives.replace(var1.upper(), var2)
            if (self.Zbmeasurement != None):
                self.Zbmeasurement = self.Zbmeasurement.replace(var1.upper(), var2)
            if (self.Zbcoefficients != None):
                self.Zbcoefficients = self.Zbcoefficients.replace(var1.upper(), var2)
            if (self.Zbcovariances != None):
                self.Zbcovariances = self.Zbcovariances.replace(var1.upper(), var2)
            if (self.Zbdescriptives != None):
                self.Zbdescriptives = self.Zbdescriptives.replace(var1.upper(), var2)

# Within MI section
        if (self.wmi != None and
not ("THE STANDARD ERRORS OF THE MODEL PARAMETER ESTIMATES COULD NOT" 
in self.warnings)):
            for var1, var2 in zip(Mplus, SPSS):
                if (len(var2) > 23):
                    var2 = var2[:23]
                else:
                    var1 = var1 + " "
                    var2 = var2 + " "
                self.wmi = self.wmi.replace(var1.upper(), var2)
            self.wmi = self.wmi.replace("""M.I.     E.P.C.  Std E.P.C.  StdYX E.P.C.""",
"""                          MI         EPC   StdYX EPC""")
            newMI = []
            miLines = self.wmi.split("\n")
            for line in miLines:
                if (" ON " in line or " BY " in line or " WITH " in line):
                    miWords = line.split()
                    newLine = miWords[0] + " "*(23-len(miWords[0]))
                    newLine += " " + miWords[1] + " "*(5-len(miWords[1]))
                    newLine += miWords[2] + " "*(23-len(miWords[2]))
                    newLine += " "*(8-len(miWords[3])) + miWords[3] + "  "
                    newLine += " "*(8-len(miWords[4])) + miWords[4] + "  "
                    newLine += " "*(8-len(miWords[6])) + miWords[6] + "  "
                    newMI.append(newLine)
                else:
                    newMI.append(line)
            self.wmi = "\n".join(newMI)

# Between MI section
        if (self.bmi != None and
not ("THE STANDARD ERRORS OF THE MODEL PARAMETER ESTIMATES COULD NOT" 
in self.warnings)):
            for var1, var2 in zip(Mplus, SPSS):
                if (len(var2) > 23):
                    var2 = var2[:23]
                else:
                    var1 = var1 + " "
                    var2 = var2 + " "
                self.bmi = self.bmi.replace(var1.upper(), var2)
            self.bmi = self.bmi.replace("""M.I.     E.P.C.  Std E.P.C.  StdYX E.P.C.""",
"""                          MI         EPC   StdYX EPC""")
            newMI = []
            miLines = self.bmi.split("\n")
            for line in miLines:
                if ( (" ON " in line or " BY " in line or " WITH " in line) and 
("/" not in line)):
                    miWords = line.split()
                    newLine = miWords[0] + " "*(23-len(miWords[0]))
                    newLine += " " + miWords[1] + " "*(5-len(miWords[1]))
                    newLine += miWords[2] + " "*(23-len(miWords[2]))
                    newLine += " "*(8-len(miWords[3])) + miWords[3] + "  "
                    newLine += " "*(8-len(miWords[4])) + miWords[4] + "  "
                    newLine += " "*(8-len(miWords[6])) + miWords[6] + "  "
                    newMI.append(newLine)
                else:
                    newMI.append(line)
            self.bmi = "\n".join(newMI)

        if (self.newParam != None):
            newNP = ["New/Additional Parameters"]
            npLines = self.newParam.split("\n")
            for line in npLines[1:]:
                if (len(line) > 1):
                    firstWord = line.split()[0]
                    line = line.replace(firstWord, firstWord + " "*15)
                    newNP.append(line)
            self.newParam = "\n".join(newNP)                     

# Print function
    def toSPSSoutput(self):
        spss.Submit("title '" + self.label + "'.")
        spss.Submit("title 'SUMMARY'.")
        print self.summary
        spss.Submit("title 'WARNINGS'.")
        print self.warnings
        if ("MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings):
            spss.Submit("title 'FIT STATISTICS'.")
            print self.fit
# Unstandardized Within
        if (self.wmeasurement != None):
            spss.Submit("title 'UNSTANDARDIZED WITHIN MEASUREMENT MODEL'.")
            print "Unstandardized Within"
            print self.header
            print self.wmeasurement
        if (self.wcoefficients != None):
            spss.Submit("title 'UNSTANDARDIZED WITHIN COEFFICIENTS'.")
            print "Unstandardized Within"
            print self.header
            print self.wcoefficients
        if (self.wcovariances != None):
            spss.Submit("title 'UNSTANDARDIZED WITHIN COVARIANCES'.")
            print "Unstandardized Within"
            print self.header
            print self.wcovariances
        spss.Submit("title 'UNSTANDARDIZED WITHIN DESCRIPTIVES'.")
        print "Unstandardized Within"
        print self.header
        print self.wdescriptives
# Unstandardized Between
        if (self.bmeasurement != None):
            spss.Submit("title 'UNSTANDARDIZED BETWEEN MEASUREMENT MODEL'.")
            print "Unstandardized Between"
            print self.header
            print self.bmeasurement
        if (self.bcoefficients != None):
            spss.Submit("title 'UNSTANDARDIZED BETWEEN COEFFICIENTS'.")
            print "Unstandardized Between"
            print self.header
            print self.bcoefficients
        if (self.bcovariances != None):
            spss.Submit("title 'UNSTANDARDIZED BETWEEN COVARIANCES'.")
            print "Unstandardized Between"
            print self.header
            print self.bcovariances
        spss.Submit("title 'UNSTANDARDIZED BETWEEN DESCRIPTIVES'.")
        print "Unstandardized Between"
        print self.header
        print self.bdescriptives
        if (self.newParam != None):
            spss.Submit("title 'NEW/ADDITIONAL PARAMETERS'.")
            print self.header
            print self.newParam
            
# Standardized Within
        if (self.Zwmeasurement != None):
            spss.Submit("title 'STANDARDIZED WITHIN MEASUREMENT MODEL'.")
            print "Standardized Within"
            print self.header
            print self.Zwmeasurement
        if (self.Zwcoefficients != None):
            spss.Submit("title 'STANDARDIZED WITHIN COEFFICIENTS'.")
            print "Standardized Within"
            print self.header
            print self.Zwcoefficients
        if (self.Zwcovariances != None):
            spss.Submit("title 'STANDARDIZED WITHIN COVARIANCES'.")
            print "Standardized Within"
            print self.header
            print self.Zwcovariances
        if (self.Zwdescriptives != None):
            spss.Submit("title 'STANDARDIZED WITHIN DESCRIPTIVES'.")
            print "Standardized Within"
            print self.header
            print self.Zwdescriptives

# Standardized Between
        if (self.Zbmeasurement != None):
            spss.Submit("title 'STANDARDIZED BETWEEN MEASUREMENT MODEL'.")
            print "Standardized Between"
            print self.header
            print self.Zbmeasurement
        if (self.Zbcoefficients != None):
            spss.Submit("title 'STANDARDIZED BETWEEN COEFFICIENTS'.")
            print "Standardized Between"
            print self.header
            print self.Zbcoefficients
        if (self.Zbcovariances != None):
            spss.Submit("title 'STANDARDIZED BETWEEN COVARIANCES'.")
            print "Standardized Between"
            print self.header
            print self.Zbcovariances
        if (self.Zbdescriptives != None):
            spss.Submit("title 'STANDARDIZED BETWEEN DESCRIPTIVES'.")
            print "Standardized Between"
            print self.header
            print self.Zbdescriptives

        if (self.wr2 != None):
            spss.Submit("title 'WITHIN R-SQUARES'.")
            print self.wr2
        if (self.br2 != None):
            spss.Submit("title 'BETWEEN R-SQUARES'.")
            print self.br2
        if (self.wmi != None):
            spss.Submit("title 'WITHIN MODIFICATION INDICES'.")
            print self.wmi     
        if (self.bmi != None):
            spss.Submit("title 'BETWEEN MODIFICATION INDICES'.")
            print self.bmi     

# Save coefficients to dataset
    def toSPSSdata(self, datasetName, datasetMeans, datasetIntercepts, 
datasetVariances, datasetResidualV, estimator, labelList = []):
# Determine active data set so we can return to it when finished
        activeName = spss.ActiveDataset()
# Set up data set if it doesn't already exist
        tag,err = spssaux.createXmlOutput('Dataset Display',
omsid='Dataset Display', subtype='Datasets')
        datasetList = spssaux.getValuesFromXmlWorkspace(tag, 'Datasets')

        if (datasetName not in datasetList):
            spss.StartDataStep()
            datasetObj = spss.Dataset(name=None)
            dsetname = datasetObj.name
            datasetObj.varlist.append("wbLevel", 50)
            datasetObj.varlist.append("Outcome", 50)
            datasetObj.varlist.append("Predictor", 50)
            if (estimator == "BAYES"):
                datasetObj.varlist.append("b_Coefficient", 0)
                datasetObj.varlist.append("b_PostSD", 0)
                datasetObj.varlist.append("b_p", 0)
                datasetObj.varlist.append("b_lower", 0)
                datasetObj.varlist.append("b_upper", 0)
                datasetObj.varlist.append("beta_Coefficient", 0)
                datasetObj.varlist.append("beta_PostSD", 0)
                datasetObj.varlist.append("beta_p", 0)
                datasetObj.varlist.append("beta_lower", 0)
                datasetObj.varlist.append("beta_upper", 0)                
            else:
                datasetObj.varlist.append("b_Coefficient", 0)
                datasetObj.varlist.append("b_SE", 0)
                datasetObj.varlist.append("b_Ratio", 0)
                datasetObj.varlist.append("b_p", 0)
                datasetObj.varlist.append("beta_Coefficient", 0)
                datasetObj.varlist.append("beta_SE", 0)
                datasetObj.varlist.append("beta_Ratio", 0)
                datasetObj.varlist.append("beta_p", 0)
            spss.EndDataStep()
            submitstring = """dataset activate {0}.
dataset name {1}.""".format(dsetname, datasetName)
            spss.Submit(submitstring)

        spss.StartDataStep()
        datasetObj = spss.Dataset(name = datasetName)
        spss.SetActive(datasetObj)

# Label variables
        variableList =[]
        for t in range(spss.GetVariableCount()):
            variableList.append(spss.GetVariableName(t))
        for t in range(len(labelList)):
            if ("label{0}".format(str(t)) not in variableList):
                datasetObj.varlist.append("label{0}".format(str(t)), 50)
        spss.EndDataStep()

# Set variables to f8.3
        if (estimator == "BAYES"):
            submitstring = "alter type b_Coefficient to beta_upper (f8.3)."
        else:
            submitstring = "alter type b_Coefficient to beta_p (f8.3)."
        spss.Submit(submitstring)

# Get coefficients
        lList = ["WITHIN", "BETWEEN"]
        cList = [getCoefficients(self.wcoefficients), 
getCoefficients(self.bcoefficients)]
        if (self.Zwcoefficients != None and self.Zbcoefficients != None):
            zList = [getCoefficients(self.Zwcoefficients),
getCoefficients(self.Zbcoefficients)]
        else:
            zList = [None, None]
# Determine values for dataset
        dataValues = []
        for l, c, z in zip(lList, cList, zList):
            for t in range(len(c)):
                rowList = [l]
                rowList.extend(c[t])
                if (z == None):
                    rowList.extend([None]*4)
                else:
                    rowList.extend(z[t][2:])
                rowList.extend(labelList)
                dataValues.append(rowList)    

# Dataset Means
        if (datasetMeans == True):
            lList = ["WITHIN", "BETWEEN"]
            start = ["Means"]
            stop = ["Intercepts", "Variances", "Residual"]
            cList = [getStats(self.wdescriptives, start, stop), 
getStats(self.bdescriptives, start, stop)]

            for l, c in zip (lList, cList):
                for t in range(len(c)):
                    rowList = c[t]
                    rowList.insert(0, l)
                    rowList.insert(2, "Mean")
                    rowList.extend([None]*4)
                    rowList.extend(labelList)
                    dataValues.append(rowList) 

# Dataset Intercepts
        if (datasetIntercepts == True):
            lList = ["WITHIN", "BETWEEN"]
            start = ["Intercepts"]
            stop = ["Variances", "Residual"]
            cList = [getStats(self.wdescriptives, start, stop), 
getStats(self.bdescriptives, start, stop)]

            for l, c in zip (lList, cList):
                for t in range(len(c)):
                    rowList = c[t]
                    rowList.insert(0, l)
                    rowList.insert(2, "Intercept")
                    rowList.extend([None]*4)
                    rowList.extend(labelList)
                    dataValues.append(rowList) 

# Dataset Variances
        if (datasetVariances == True):
            lList = ["WITHIN", "BETWEEN"]
            start = ["Variances"]
            stop = ["Residual"]
            cList = [getStats(self.wdescriptives, start, stop), 
getStats(self.bdescriptives, start, stop)]

            for l, c in zip (lList, cList):
                for t in range(len(c)):
                    rowList = c[t]
                    rowList.insert(0, l)
                    rowList.insert(2, "Variance")
                    rowList.extend([None]*4)
                    rowList.extend(labelList)
                    dataValues.append(rowList) 

# Dataset Residual Variances
        if (datasetResidualV == True):
            lList = ["WITHIN", "BETWEEN"]
            start = ["Residual"]
            stop = ["XXX"]
            cList = [getStats(self.wdescriptives, start, stop), 
getStats(self.bdescriptives, start, stop)]

            for l, c in zip (lList, cList):
                for t in range(len(c)):
                    rowList = c[t]
                    rowList.insert(0, l)
                    rowList.insert(2, "ResidualVariance")
                    rowList.extend([None]*4)
                    rowList.extend(labelList)
                    dataValues.append(rowList)

# Put values in dataset
        spss.StartDataStep()
        datasetObj = spss.Dataset(name = datasetName)
        for t in dataValues:
            datasetObj.cases.append(t)
        spss.EndDataStep()

# Return to original data set
        spss.StartDataStep()
        datasetObj = spss.Dataset(name = activeName)
        spss.SetActive(datasetObj)
        spss.EndDataStep()

def MplusTwoLevel(inpfile, modellabel = "MplusTwoLevel", 
runModel = True, viewOutput = True, suppressSPSS = False,
withinLatent = None, withinLatentFixed = None, withinModel = None, withinMeans = None, 
withinVar = None, withinCovar = None, withinCovEndo = False, withinCovExo = True, 
withinIdentifiers = None, withinMeanIdentifiers = None, withinSlopes = None,
betweenLatent = None, betweenLatentFixed = None, betweenModel = None, 
betweenMeans = None, betweenVar = None, betweenCovar = None, 
betweenCovEndo = False, betweenCovExo = True, 
betweenIdentifiers = None, betweenMeanIdentifiers = None,
estimator = None, useobservations = None, 
wald = None, constraint = None, 
montecarlo = None, bootstrap = None, repse = None,
categorical = None, censored = None, count = None, nominal = None,
groupmean = None, grandmean = None,
cluster = None, complex = None, weight = None, 
datasetName = None, datasetMeans = False, datasetIntercepts = False, 
datasetVariances = False, datasetResidualV = False, 
datasetLabels = [], miThreshold = 10, waittime = 5):

    spss.Submit("display scratch.")

# Redirect output
    if (suppressSPSS == True):
        submitstring = """OMS /SELECT ALL EXCEPT = [WARNINGS] 
        /DESTINATION VIEWER = NO 
        /TAG = 'NoJunk'."""
        spss.Submit(submitstring)

# Find directory and filename
    for t in range(len(inpfile)):
        if (inpfile[-t] == "/"):
            break
    outdir = inpfile[:-t+1]
    fname, fext = os.path.splitext(inpfile[-(t-1):])

# Obtain list of variables in data set
    SPSSvariables = []
    SPSSvariablesCaps = []
    for varnum in range(spss.GetVariableCount()):
        SPSSvariables.append(spss.GetVariableName(varnum))
        SPSSvariablesCaps.append(spss.GetVariableName(varnum).upper())

# Obtain lists of latent variables
    withinLatentVars = []
    if (withinLatent != None):
        for t in withinLatent:
            withinLatentVars.append(t[0].upper())
    betweenLatentVars = []
    if (betweenLatent != None):
        for t in betweenLatent:
            betweenLatentVars.append(t[0].upper())

# Obtain list of slope identifiers
    slopeVars = []
    if (withinSlopes != None):
        for t in withinSlopes:
            slopeVars.append(t[1].upper())

# Restore output
    if (suppressSPSS == True):
        submitstring = """OMSEND TAG = 'NoJunk'."""
        spss.Submit(submitstring)

# Check for errors
    error = 0
    if (fext.upper() != ".INP"):
        print ("Error: Input file specification does not end with .inp")
        error = 1
    if (not os.path.exists(outdir)):
        print("Error: Output directory does not exist")
        error = 1
    if (cluster == None):
        print ("Error: No cluster variable identified")
        error = 1
    if (estimator != None):
        estimator = estimator.upper()
        if (estimator not in ["ML",
"MLM",
"MLMV",
"MLR",
"MLF",
"MUML",
"WLS",
"WLSM",
"WLSMV",
"ULS",
"ULSMV",
"GLS",
"BAYES"]):
            print("Error: Estimator not valid")
            error = 1
        
    variableError = 0
    for var in withinLatentVars:
        if (var in SPSSvariablesCaps):
            variableError = 1
            break
    if (variableError == 1):
            print "Error: Within latent variable name overlaps with existing variable name"
            error = 1
    variableError = 0
    for var in betweenLatentVars:
        if (var in SPSSvariablesCaps):
            variableError = 1
            break
    if (variableError == 1):
            print "Error: Between latent variable name overlaps with existing variable name"
            error = 1
    if (withinLatent != None):
        variableError = 0
        for equation in withinLatent:
            for var in equation[1:]:
                if (var.upper() not in SPSSvariablesCaps):
                    variableError = 1
                    break
        if (variableError == 1):
            print("Error: Variable listed in within latent variable definition not in current data set")
            error = 1
    if (betweenLatent != None):
        variableError = 0
        for equation in betweenLatent:
            for var in equation[1:]:
                if (var.upper() not in SPSSvariablesCaps and var.upper() not in slopeVars):
                    variableError = 1
        if (variableError == 1):
            print("Error: Variable listed in between latent variable definition not in current data set")
            error = 1
    if (withinLatent != None and betweenLatent != None):
        variableError = 0
        for w in withinLatentVars:
            for b in betweenLatentVars:
                if (w == b):
                    variableError = 1
        if (variableError == 1):
            print ("Error: Same name used for within and between latent variable definitions")
    variableError = 0
    if (withinModel != None):
        for equation in withinModel:
            for var in equation:
                if (var.upper() not in SPSSvariablesCaps 
and var.upper() not in withinLatentVars):
                    variableError = 1
                    print "Missing " + var
        if (variableError == 1):
            print("Error: Variable listed in within model not in current data set")
            error = 1
    if (betweenModel != None):
        variableError = 0
        for equation in betweenModel:
            for var in equation:
                if (var.upper() not in SPSSvariablesCaps 
and var.upper() not in slopeVars
and var.upper() not in betweenLatentVars
and var.upper() not in withinLatentVars):
                    variableError = 1
                    print "Missing " + var
        if (variableError == 1):
            print("Error: Variable listed in between model not in current data set")
            error = 1

    if (error == 0):

# Redirect output
        if (suppressSPSS == True):
            submitstring = """OMS /SELECT ALL EXCEPT = [WARNINGS] 
        /DESTINATION VIEWER = NO 
        /TAG = 'NoJunk'."""
            spss.Submit(submitstring)

# Export data
        dataname = outdir + fname + ".dat"
        MplusVariables = exportMplus(dataname)
 
# Define within latent variables using Mplus variables
        if (withinLatent == None):
            MplusWithinLatent = None
        else:
            MplusWithinLatent = []
            for t in withinLatent:
                MplusWithinLatent.append([i.upper() for i in t])
            for t in range(len(MplusWithinLatent)):
                for i in range(len(MplusWithinLatent[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (MplusWithinLatent[t][i] == s):
                            MplusWithinLatent[t][i] = m
                            
# Convert withinLatentFixed to Mplus
        if (withinLatentFixed == None):
            MplusWithinLatentFixed = None
        else:
            MplusWithinLatentFixed = []
            fixedEquations = []
            for t in withinLatentFixed:
                j = []
                for i in t[0]:  # t[0] is the equation, t[1] is the fixed value
                    j.append(i.upper())
                fixedEquations.append(j) # appending the upper-case version of the equation
            for t in range(len(fixedEquations)):
                for i in range (len(fixedEquations[t])):
                    for s,m in zip(SPSSvariablesCaps, MplusVariables):
                        if (fixedEquations[t] [i] == s ):
                            fixedEquations[t] [i] = m
                MplusWithinLatentFixed.append([fixedEquations[t], withinLatentFixed[t] [1] ])
                            
# Define between latent variables using Mplus variables
        if (betweenLatent == None):
            MplusBetweenLatent = None
        else:
            MplusBetweenLatent = []
            for t in betweenLatent:
                MplusBetweenLatent.append([i.upper() for i in t])
            for t in range(len(MplusBetweenLatent)):
                for i in range(len(MplusBetweenLatent[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (MplusBetweenLatent[t][i] == s):
                            MplusBetweenLatent[t][i] = m

# Convert betweenLatentFixed to Mplus
        if (betweenLatentFixed == None):
            MplusBetweenLatentFixed = None
        else:
            MplusBetweenLatentFixed = []
            fixedEquations = []
            for t in betweenLatentFixed:
                j = []
                for i in t[0]:  # t[0] is the equation, t[1] is the fixed value
                    j.append(i.upper())
                fixedEquations.append(j) # appending the upper-case version of the equation
            for t in range(len(fixedEquations)):
                for i in range (len(fixedEquations[t])):
                    for s,m in zip(SPSSvariablesCaps, MplusVariables):
                        if (fixedEquations[t] [i] == s ):
                            fixedEquations[t] [i] = m
                MplusBetweenLatentFixed.append([fixedEquations[t], betweenLatentFixed[t] [1] ])

# Define withinModel using Mplus variables
        if (withinModel == None):
            MplusWithinModel = None
        else:
            MplusWithinModel = []
            for t in withinModel:
                MplusWithinModel.append([i.upper() for i in t])
            for t in range(len(MplusWithinModel)):
                for i in range(len(MplusWithinModel[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (MplusWithinModel[t][i] == s):
                            MplusWithinModel[t][i] = m

# Convert variables in betweenCovariance list to Mplus
        if (withinCovar == None):
            MplusWithinCovar = None
        else:
            MplusWithinCovar = []
            for t in withinCovar:
                MplusWithinCovar.append([i.upper() for i in t])
            for t in range(len(MplusWithinCovar)):
                for i in range(2):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (MplusWithinCovar[t][i] == s):
                            MplusWithinCovar[t][i] = m

# Convert withinIdentifiers to Mplus
        if (withinIdentifiers == None):
            MplusWithinIdentifiers = None
        else:
            MplusWithinIdentifiers = []
            idEquations = []
            for t in withinIdentifiers:
                j = []
                for i in t[0]:
                    j.append(i.upper())
                idEquations.append(j)
            for t in range(len(idEquations)):
                for i in range(len(idEquations[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (idEquations[t][i] == s):
                            idEquations[t][i] = m
                MplusWithinIdentifiers.append([idEquations[t], withinIdentifiers[t][1]])

# Convert within mean identifiers to Mplus
        if (withinMeanIdentifiers == None):
            MplusWithinMeanIdentifiers = None
        else:
            MplusWithinMeanIdentifiers = []
            idMeans = []
            for t in withinMeanIdentifiers:
                idMeans.append(t[0].upper())
            for t in range(len(idMeans)):
                for s, m in zip(SPSSvariablesCaps, MplusVariables):
                    if (idMeans[t] == s):
                        idMeans[t] = m
                MplusWithinMeanIdentifiers.append([idMeans[t], withinMeanIdentifiers[t][1]])                

# Convert withinSlopes to Mplus
        if (withinSlopes == None):
            MplusWithinSlopes = None
        else:
            MplusWithinSlopes = []
            idEquations = []
            for t in withinSlopes:
                j = []
                for i in t[0]:
                    j.append(i.upper())
                idEquations.append(j)
            for t in range(len(idEquations)):
                for i in range(len(idEquations[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (idEquations[t][i] == s):
                            idEquations[t][i] = m
                MplusWithinSlopes.append([idEquations[t], withinSlopes[t][1]])

# Define betweenModel using Mplus variables
        if (betweenModel == None):
            MplusBetweenModel = None
        else:
            MplusBetweenModel = []
            for t in betweenModel:
                MplusBetweenModel.append([i.upper() for i in t])
            for t in range(len(MplusBetweenModel)):
                for i in range(len(MplusBetweenModel[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (MplusBetweenModel[t][i] == s):
                            MplusBetweenModel[t][i] = m

# Convert variables in betweenCovariance list to Mplus
        if (betweenCovar == None):
            MplusBetweenCovar = None
        else:
            MplusBetweenCovar = []
            for t in betweenCovar:
                MplusBetweenCovar.append([i.upper() for i in t])
            for t in range(len(MplusBetweenCovar)):
                for i in range(2):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (MplusBetweenCovar[t][i] == s):
                            MplusBetweenCovar[t][i] = m

# Convert betweenIdentifiers to Mplus
        if (betweenIdentifiers == None):
            MplusBetweenIdentifiers = None
        else:
            MplusBetweenIdentifiers = []
            idEquations = []
            for t in betweenIdentifiers:
                j = []
                for i in t[0]:
                    j.append(i.upper())
                idEquations.append(j)
            for t in range(len(idEquations)):
                for i in range(len(idEquations[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (idEquations[t][i] == s):
                            idEquations[t][i] = m
                MplusBetweenIdentifiers.append([idEquations[t], betweenIdentifiers[t][1]])

# Convert between mean identifiers to Mplus
        if (betweenMeanIdentifiers == None):
            MplusBetweenMeanIdentifiers = None
        else:
            MplusBetweenMeanIdentifiers = []
            idMeans = []
            for t in betweenMeanIdentifiers:
                idMeans.append(t[0].upper())
            for t in range(len(idMeans)):
                for s, m in zip(SPSSvariablesCaps, MplusVariables):
                    if (idMeans[t] == s):
                        idMeans[t] = m
                MplusBetweenMeanIdentifiers.append([idMeans[t], betweenMeanIdentifiers[t][1]])  

# Convert useobservations to Mplus
        if (useobservations == None):
            MplusUseobservations = None
        else:
            MplusUseobservations = useobservations
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                z = re.compile(s, re.IGNORECASE)
                MplusUseobservations = z.sub(m, MplusUseobservations)

# Convert cluster variable to Mplus
        if (cluster == None):
            MplusCluster = None
        else:
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                if (cluster.upper() == s):
                    MplusCluster = m

# Convert complex variable to Mplus
        if (complex == None):
            MplusComplex = None
        else:
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                if (complex.upper() == s):
                    MplusComplex = m

# Convert variable list arguments to Mplus
        lvarList = [categorical, censored, count, nominal, 
groupmean, grandmean, withinVar, withinMeans, betweenVar, betweenMeans]
        MplusCategorical = []
        MplusCensored = []
        MplusCount = []
        MplusNominal = []
        MplusGroupmean = []
        MplusGrandmean = []
        MplusWithinVar = []
        MplusWithinMeans = []
        MplusBetweenVar = []
        MplusBetweenMeans = []
        lvarMplusList = [MplusCategorical, MplusCensored,
MplusCount, MplusNominal, MplusGroupmean, MplusGrandmean,
MplusWithinVar, MplusWithinMeans, MplusBetweenVar, MplusBetweenMeans]
        for t in range(len(lvarList)):
            if (lvarList[t] == None):
                lvarMplusList[t] = None
            else:
                for i in lvarList[t]:
                    lvarMplusList[t].append(i.upper())
                for i in range(len(lvarMplusList[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (lvarMplusList[t][i] == s):
                            lvarMplusList[t][i] = m

# Convert weight variable to Mplus
        if (weight == None):
            MplusWeight = None
        else:
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                if (weight.upper() == s):
                    MplusWeight = m

# Create input program
        pathProgram = MplusPAprogram()
        pathProgram.setTitle("Created by MplusPathAnalysis")
        pathProgram.setData(dataname)
        pathProgram.setVariable(MplusVariables, MplusWithinLatent, 
MplusWithinModel, MplusWithinVar, slopeVars,
MplusBetweenLatent, MplusBetweenModel, 
MplusBetweenVar, MplusUseobservations, MplusCategorical, MplusCensored, 
MplusCount, MplusNominal, MplusCluster, MplusComplex, MplusWeight)
        pathProgram.setDefine(MplusGroupmean, MplusGrandmean)
        pathProgram.setAnalysis(MplusCluster, MplusComplex, MplusWithinSlopes, estimator,
MplusWeight, montecarlo, bootstrap, repse)
        pathProgram.setModel(MplusWithinLatent, MplusWithinLatentFixed, MplusWithinModel, 
MplusWithinMeans, MplusWithinCovar, MplusWithinIdentifiers, MplusWithinMeanIdentifiers,
withinCovEndo, withinCovExo, MplusWithinSlopes, 
MplusBetweenLatent, MplusBetweenLatentFixed, MplusBetweenModel, MplusBetweenMeans,
MplusBetweenCovar, MplusBetweenIdentifiers, MplusBetweenMeanIdentifiers,
betweenCovEndo, betweenCovExo,wald)
        pathProgram.setConstraint(constraint)    
        pathProgram.setOutput(MplusComplex, miThreshold, bootstrap)
        pathProgram.write(outdir + fname + ".inp")

# Add latent variables to SPSSvariables lists
        if (withinLatent != None):
            for equation in withinLatent:
                if (equation[0].upper() not in SPSSvariablesCaps):
                    SPSSvariables.append(equation[0])
                    SPSSvariablesCaps.append(equation[0].upper())
        if (betweenLatent != None):
            for equation in betweenLatent:
                if (equation[0].upper() not in SPSSvariablesCaps):            
                    SPSSvariables.append(equation[0])
                    SPSSvariablesCaps.append(equation[0].upper())

# Add latent variables to MplusVariable list
        if (withinLatent != None):
            for equation in withinLatent:
                if (equation[0].upper() not in MplusVariables):            
                    MplusVariables.append(equation[0].upper())
        if (betweenLatent != None):
            for equation in betweenLatent:
                if (equation[0].upper() not in MplusVariables):            
                    MplusVariables.append(equation[0].upper())

# Run input program
        if (runModel == True):
            batchfile(outdir, fname)
            time.sleep(waittime)

# Restore output
        if (suppressSPSS == True):
            submitstring = """OMSEND TAG = 'NoJunk'."""
            spss.Submit(submitstring)

# Parse output
        if (viewOutput == True):
            pathOutput = MplusTLoutput(modellabel, outdir + fname + ".out", 
    MplusVariables, SPSSvariables, slopeVars, complex, estimator)
            pathOutput.toSPSSoutput()

# Redirect output
            if (suppressSPSS == True):
                submitstring = """OMS /SELECT ALL EXCEPT = [WARNINGS] 
        /DESTINATION VIEWER = NO 
        /TAG = 'NoJunk'."""
                spss.Submit(submitstring)

    # Create coefficient dataset
            if (datasetName != None):
                pathOutput.toSPSSdata(datasetName, datasetMeans, 
datasetIntercepts, datasetVariances, datasetResidualV, estimator,
datasetLabels)

# Restore output
            if (suppressSPSS == True):
                submitstring = """OMSEND TAG = 'NoJunk'."""
                spss.Submit(submitstring)

# Replace titles
    titleToPane()
end program python.
set printback = on.

************
* Version History
************
* 2014-08-19 Created based on MplusPathAnalysis 2014-08-19.sps
* 2014-08-21 Created .inp file
* 2014-08-24 Separated between and within latent definitions
* 2014-08-25 Read output file
* 2014-08-26 Fixed latent names
    Added level variable to dataset
* 2014-08-28 Removed problematic reference to auxiliary variables
* 2014-09-02 Renamed function
    Fixed error when no latent variables
* 2014-09-05 Added runModel and viewOutput arguments
* 2015-01-19 Suppressed output
* 2015-05-02 Added the ability to examine random slopes
    Added toggle to suppress output
* 2015-05-18 Corrected extraction of output file
* 2018-03-04 When a variable is missing from the data set, that variable is printed
    Replaced nonalphanumerics before checking for duplicate variable names
* 2018-03-05 Added complex option
    Required the identification of a cluster variable
* 2018-04-12 Added groupmean and grandmean arguments
* 2018-04-18 Fixed error when replacing variable names
* 2018-04-18a Added titleToPane
* 2018-04-18b Added miThreshold
    Fixed coefficient dataset generation when no standardized output
* 2018-04-19 Added datasetIntercepts
* 2018-04-19a Added datasetResidualV
* 2018-04-26 Skip standardized results if complex != None
* 2018-04-28 Added datasetVariances
* 2018-04-28a Consolidated getIntercepts, getVariances, and
    getResidualV into getStats
* 2018-04-28b Added datasetMeans
* 2018-04-28c Corrected error where means are reported with 
    intercepts
* 2018-10-02 Still writes .inp file when runModel = False
* 2021-04-05 Added MLR command
* 2021-04-05a Added constraint option
* 2021-04-05b Added mean and meanidentifier commands
* 2021-04-08 Added withinLatentFixed and betweenLatentFixed
* 2021-04-08a Made sure each latent variable is only added to variable lists once
* 2021-04-09 Allowed within latent variables to be used at the between level
* 2021-04-09a Added label to output.
* 2021-05-07 Added estimator command/dropped MLR
* 2021-05-08 Added montecarlo, bootstrap, repse
* 2021-05-09 Corrected section breaks when there are no regression coefs
* 2021-05-09a Changed dataset values for Bayes estimation
* 2021-05-10 Revised title for new/additional parameters
COMMENT BOOKMARK;LINE_NUM=938;ID=2.
COMMENT BOOKMARK;LINE_NUM=1034;ID=3.
COMMENT BOOKMARK;LINE_NUM=1496;ID=5.
COMMENT BOOKMARK;LINE_NUM=2202;ID=1.
