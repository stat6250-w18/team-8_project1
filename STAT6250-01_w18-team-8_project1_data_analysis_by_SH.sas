*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address three research
questions regarding civil aviation accidents from 1962 to 2017.
Dataset Name: AviationData_analytic_file created in external file
STAT6250-01_w18-team-8_project1_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
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

title1
'Research Question: What is the distribution of accidents during each phase of flight?'
;

title2
'Rationale: This will help determine if there is a phase a flight that may be more prone to error or danger resulting in an accident.'
;

title1
'Research Question: What are the percentage of accidents that occur in each state according to year?'
;

title2
'Rationale: This will help determine if there is a pattern of accidents by year and by state.'
;
