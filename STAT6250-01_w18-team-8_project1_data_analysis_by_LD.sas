*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address three research questions
regarding the aviation accidents happened within the U.S. territories from 1962
to 2017. And we are only intrested in the accidents when the aircraft catergory
is airplane here. 

Dataset Name: AviationData-edited.xlsx created in external file
STAT6250-01_w18-team-8_project1_data_preparation.sas, which is assumed to be in
the same directory as this file.

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset AviationData-edited.xlsx;
%include '.\STAT6250-01_w18-team-8_project1_data_preparation.sas';
  
title1
'Research Question: What is the distribution of level of injury as the result of the accidents, when the aircraft category is airplane, and the purpose of the flights are for personal or business use?' 
;

title2
'Rationale: This would help to quickly identify how bad was the accident? How many accidents caused death?'
;

footnote1
'Based on the output, we could see that there were 8962 Non-Fatal accidents, 108 incidents, and 2004 Fatal accidents.'
;

footnote2
'Moreover, we could see that among the fatal accidents, 1058 caused 1 death, 590 caused 2 death, 173 caused 3 death, 114 caused 4 death, 40 caused 5 death etc. '
;

*
Methodology: Select the data limited the Aircraft_Category is only Airplane, and
the Purpose_of_Flight are only Business or Personal. Then use PROC FREQ to print
the frequency table by Injury_Severity.

Limitations: There are too many levels in Injury_Severity, because it listed
all the fatal accidents based on the death number. And the output doesn't have
any order, it is not easy to quickly find the desired result.

Possible Follow-up Steps: There are two possible ways. Firtst, group the fatal 
accidents into small groups based on the death number, for example, grouped as
"less than 5 death", "6 to 20 death", "20 to 50 death", ">50 death". Or second,
order the output result on descending order based on the accidents results. For
example, list the result in follwing order, fatal(14), fatal(10), fatal(9),
fatal(8)etc.
;

proc freq data= AviationData_analytic_file;
    tables Injury_Severity;
    where Aircraft_Category="Airplane" 
          and Purpose_of_Flight in ("Personal","Business");
run;
title;
footnote; 



title1
'Research Question: List the top 5 air carriers who have the most number of accidents when the aircraft category is airplane?'
;

title2
'Rationale: Fly safety is the top concern to the customers, this can help the customer to avoid the air companies have the higher number of acccidents.'
;

footnote1
'Based on the above result, the top 5 air carriers who have the most number of accidents are: Southwest Airlines Co; Delta Air Lines Inc; Delta Air Lines; Southwest Airlines; and American Airlines Inc.'
; 

*
Methodology: Use PROC FREQ to list the frequency of the name of the aircarriers
, and use order option to sort the frequency by desending order to find out the
top 5 carriers.

Limitations: There are a lots of missing values, plus the air carrier name have
duplicate values due to the capitolized letters and differnet names under the
same carriers.

Possible Follow-up Steps: Carefully clean the data, transform the air carriers
either to uppercase or to lowercase. And make sure all the air carriers have
the unqie single name for the same companies. Also, the output result has a
long list, you don't have to print out all the results if you are only
interested in the top n results.
;

proc freq data=AviationData_analytic_file order=freq;
    tables Air_Carrier;
    where Aircraft_Category="Airplane";
run;
title;
footnote;


title1
'Research Question: Is bad weather condition caused more accidents?'
;

title2
'Rationale: Weather condition is an important factor for the flight safety, normally, bad weather increase the risk of the accidents, it that true?'
;

footnote1
'Based on the above result, you can''t tell that bad weather condition caused more accidents. In fact, there are much more accidents happend under good weather conditions.'
;

*
Methodology: Use PROC FREQ to produce the frequency of accidents under different
weather conditions.

Limitations: There are too many missing values about the weather condition, and
what is 'Unkown' mean?

Possible Follow-up Steps: Carefully clean the data, add more descriptive label
to explain what is 'Unkown' mean. 
;

proc freq data= AviationData_analytic_file;
    tables Weather_Condition;
    where Aircraft_Category="Airplane";
	format Weather_Condition $WeatherConditionFmt.;
run;
title;
footnote;
