*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address three research questions
regarding the aviation accidents happened within the U.S. territories from 1962
to 2017. The aviation accidents will only focus on the airplane for personal or
business use purposes.

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
'Research Question: What is the distribution of level of injury as the result of
the event?' 
;

title2
'Rationale: This would help to quickly identify how bad was the accident? How
many accidents caused death? '
;

footnote1
'Based on the output, we could see that there were 10553 Non-Fatal accidents,
137 incidents, and 2441 Fatal accidents.'
;

footnote2
'Moreover, we could see that among the fatal accidents, 1246 caused 1 death,
728 caused 2 death'
;

*
Methodology: Use PROC FREQ to print the frequency table by Injury.Severity.

Limitations: There are too many levels in Injury.Severity, because it listed
all the fatal accidents based on the death number.

Possible Follow-up Steps: Clean the data, group the fatal accidents into small
groups based on the death number, for example, grouped as "less than 5 death",
"6 to 20 death", "20 to 50 death", ">50 death".
;

proc freq data=AviationData_analytic_file;
    class Injury.Severity;
run;
title;
footnote; 



title1
'Research Question: List the top 5 air carriers who have the most number of
incidents?'
;

title2
'Rationale: Fly safely is the top concern to the customers, this can help the 
customer to avoid the air companies have the higher number of incidents.'
;

footnote1
'Based on the above result, the top 5 air carriers who have the most number of
incidents are: '
; 

*
Methodology: Use PROC FREQ to group the data based on the air carrier, then sort
the number of accidents by desending order to find out the top 5 carriers.

Limitations: There are a lots of missing value, plus the air carrier name have
duplicate values due to the capitolized letters and differnet names under the
same carriers.

Possible Follow-up Steps: Carefully clean the data, transform the air carriers
either to uppercase or to lowercase. And make sure all the air carriers have
the unqie single name even for thier subsidiary companies.
;

proc freq data=AviationData_analytic_file;
    class AirCarrier;
run;
title;
footnote;


title1
'Research Question: Is bad weather condition caused more accidents?'
;

title2
'Rationale: Weather condition is an important factor for the flight safety, but 
with the help of the modern technologies, the airplane is controlled by the 
computer most of the time, is there still more accidents based on the bad weather
condition over time?'
;

footnote1
'Based on the above result, bad weather condition still is an very important
facotr caused accidents'
;

*
Methodology: Use PROC FREQ to produce the 2 way table about the time and weather
condition.

Limitations: There are too many missing values about the weather condition, and
the description of the weather condition is not clear.

Possible Follow-up Steps: Add labels to the data to make the description of the
weather condition more easy to understand. 
;

proc freq data=AviationData_analytic_file;
    table
        Year(EventDate)*WeatherCondition;
run;
title;
footnote;
