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
'Research Question: What are the top five makes of planes that had the most accidents?'
;

title2
'Rationale: This should help identify whether or not there is a particular make of plane that is more prone to accidents.'
;

footnote1
'Based on the above output, the top five makes of planes that had the most accidents are Cessna, Piper, Beech, Boeing, and Bell.'
;

*
Methodology: Use PROC FREQ to generate a frequency table based on the dataset
that counts the accidents by Make. Then, use PROC SORT to sort the data by 
descending count, in order to find the top five makes of planes to have an 
accident. Finally, use PROC PRINT of the first nine observations, this is due
to the inconsistency in the values of the Make column. There are makes that
are in all uppercase, while the same make is also in all lowercase, which 
causes them to be counted separately. 

Limitations: This methodology does not account for accidents with missing data.
It also does not attempt to validate the data in any way.

Possible Follow-up Steps: More carefully clean the values of the variable Make,
so that the values are either all uppercase or all lowercase. Also, better 
handle missing data, whether it be find the values that belong in the missing
data or omit the entires with missing Make values. 
;

proc freq
       data = AviationData_analytic_file
   ;
   table
       Make / out = FreqCount list
   ;
run;

proc sort
       data = FreqCount
       out = FreqCount_Desc
   ;
   by
       descending count
   ;
run;

proc print
       data = FreqCount_Desc(obs=9)
   ;
run;
title;
footnote;



title1
'Research Question: What is the distribution of accidents during each phase of flight?'
;

title2
'Rationale: This will help determine if there is a phase of flight that may be more prone to error or danger that results in an accident.'
;

footnote1
'Based on the above output, the distribution of accidents are as follows: 26.73% during landing, 20.95% during takeoff, 13.91% during cruise, 13.5% during manuvering, and 10.5% during approach.'
;

footnote2
'The rest of the phases of flight have such a small distribution that it is not significant.'
;

*
Methodology: Use PROC FREQ to generate a frequency table based on the dataset
that counts the accidents by Broad Phase of Flight. Then, use PROC SORT to 
sort the data by descending percent. 

Limitations: This methodology does not account for accidents with missing 
Broad Phase of Flight data. It also does not attempt to validate the data in 
any way. 

Possible Follow-up Steps: Better handle missing data whether it be find the 
values that belong in the missingdata or omit the entires with missing Broad
Phase of Flight values. 
;

proc freq
       data = AviationData_analytic_file
   ;
   table
       Broad_Phase_of_Flight / out = FreqCount list
   ;
run;

proc sort
       data = FreqCount
       out = FreqCount_Desc
   ;
   by
       descending percent
   ;
run;

proc print
        data = FreqCount_Desc 
   ;
run;
title;
footnote;



title1
'Research Question: What are the top three years that had the greatest amount of accidents and the top three years that had the least amount of accidents?'
;

title2
'Rationale: This will help determine if aviation safety is getting any better.'
;

footnote1
'Based on the above output, the top three years with the greatest amount of accidents are as follows: 1987 had 2,828 accidents, 1988 had 2,730 accidents, and 1989 had 2,544 accidents.' 
;

footnote2
'The top three years with the least amount of accidents are as follows: 1986 had 1,111, 2017 had 1,487 accidents, and 2014 had 1,543 accidents.'
;

footnote3
'It seems as though some recent years saw more accidents than it should have considering that safety should be getting better, but overall aviation safety seems to have improved.'
;


*
Methodology: Use PROQ FREQ to generate a dataset that counts the accidents by 
year, and then use PROC SORT to sort the data by descending count. 

Limitations: This methodology does not attempt to validate the data in any way. 

Possible Follow-up Steps: Further analyze the accidents during the 2000s that
saw more accidents than earlier years to figure out why this is the case.
;

proc freq
       data = AviationData_analytic_file
   ;
   table
       Event_Date / out = FreqCount list
   ;
   format
       Event_Date year4.
    ;
run;

proc sort
       data = FreqCount
       out = FreqCount_Desc
   ;
   by
       descending count
   ;
run;

proc print
        data = FreqCount_Desc 
    ;
run;
title;
footnote;
