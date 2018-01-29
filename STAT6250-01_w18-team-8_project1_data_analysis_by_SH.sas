*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address three research
questions regarding civil aviation accidents from 1962 to 2017.

Dataset Name: AviationData_analytic_file created in external file
STAT6250-01_w18-team-8_project1_data_preparation.sas, which is assumed to be
in the same directory as this file.

See included file for dataset properties.
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset AviationData_analytic_file;
%include '.\STAT6250-01_w18-team-8_project1_data_preparation.sas';

title1
'Research Question: What are the top 5 makes of planes that had the most accidents?'
;

title2
'Rationale: This will help to identify if there is a certain make of plane that is more prone to accidents.'
;

footnote1
'Based on the above output, the top 5 makes of planes that had the most accidents are Cessna, Piper, Beech, Boeing, and Bell'
;

*
Methodology: Use PROQ FREQ to generate a dataset that counts the accidents by 
Make,and then use PROC SORT to sort the data by descending count. Use PROC PRINT
of the first 9 observations, due to the inconsistency in the lettering of Make 
the value of the all capital letters need to be combined with the the 
non-capital letters.

Limitations: This methodology does not account for accidents with missing data. 
It also does not attempt to validate the data in any way. Also, there is a 
inconsistency in the labeling of the Make, some are in all capital letters while
other are not.

Possible Follow-up Steps: More carefully clean the values of the variable Make, 
and better handle missing data.
;

proc freq
	data = AviationData_analytic_file
     ;
     table
	Make / out=FreqCount list
     ;
run;

proc sort
    	data=FreqCount
	out=FreqCount_Desc
     ;
     by
	descending count
     ;
run;

proc print
	data=FreqCount_Desc(obs=9)
     ;
run;
title;
footnote;



title1
'Research Question: What is the distribution of accidents during each phase of flight?'
;

title2
'Rationale: This will help determine if there is a phase a flight that may be more prone to error or danger resulting in an accident.'
;

footnote1
'Based on the above output, the distribution fo accidents are as follows: 26.73% during landing, 20.95% during takeoff, 13.91% during cruise, 13.5% during manuvering, 10.5% during approach'
;

footnote2
'The rest of the phases have such a small distribution that it is not significant enough.'
;

*
Methodology: Use PROQ FREQ to generate a dataset that counts the accidents by 
Broad Phase of Flight, and then use PROC SORT to sort the data by descending 
count. 

Limitations: This methodology does not account for accidents with missing data. 
It also does not attempt to validate the data in any way. 

Possible Follow-up Steps: More carefully clean the values of the variable Broad
Phase of Flight, and better handle missing data.
;

proc freq
	data = AviationData_analytic_file
     ;
     table
	Broad_Phase_of_Flight / out=FreqCount list
     ;
run;

proc sort
	data=FreqCount
	out=FreqCount_Desc
     ;
     by
	descending percent
     ;
run;

proc print
	data=FreqCount_Desc 
     ;
run;
title;
footnote;



title1
'Research Question: What are the percentage of accidents that occur in each state according to year?'
;

title2
'Rationale: This will help determine if there is a pattern of accidents by year and by state.'
;

*
Methodology: Use PROQ FREQ to generate a dataset that counts the accidents by 
year,and then use PROC SORT to sort the data by descending count. 

Limitations: This methodology does not attempt to validate the data in any way. 
Possible Follow-up Steps: More carefully clean the values of the variable 
Event_Date.
;

proc freq
	data = AviationData_analytic_file
     ;
     table
	Event_Date / out=FreqCount list
     ;
run;

proc sort
	data=FreqCount
	out=FreqCount_Desc
     ;
     by
	descending percent
     ;
run;

proc print
	data=FreqCount_Desc 
     ;
run;
title;
footnote;
