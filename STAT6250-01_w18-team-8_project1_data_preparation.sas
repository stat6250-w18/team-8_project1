*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* 
This file prepares the dataset described below for analysis.

[Dataset Name] Aviation Accident Database & Synopses

[Experimental Units] Aviation Accident

[Number of Observations] 79,293

[Number of Features] 31

[Data Source] The dataset was created using the Aviation Accident Database and 
Synopses on the National Transportation Safety Board website. The dataset 
https://www.kaggle.com/khsamaha/aviation-accident-database-synopses/downloads/AviationDataEnd2016UP.csv 
was downloaded and edited to produce file AviationData-edited.xlsx by reformatting 
column headers to remove characters disallowed in SAS variable names.

[Data Dictionary] https://www.kaggle.com/khsamaha/aviation-accident-database-synopses/data

[Unique ID Schema] The column “Event_Id” is a primary key.
;


* environmental setup;

* create output formats;
proc format;
    value $WeatherConditionFmt
        'IMC'='Instrument meteorological conditions'
        'UNK'='Unknown'
        'VMC'='Visual meteorological conditions'
    ;
run;

* setup environmental parameters;
%let inputDatasetURL =
https://github.com/stat6250/team-8_project1/blob/master/AviationData-edited.xlsx?raw=true
;

* load raw Aviation dataset over the wire;
%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;
    %if
        %sysfunc(exist(&dsn.)) = 0
    %then
        %do;
            %put Loading dataset &dsn. over the wire now...;
            filename tempfile "%sysfunc(getoption(work))/tempfile.xlsx";
            proc http
                method="get"
                url="&url."
                out=tempfile
                ;
            run;
            proc import
                file=tempfile
                out=&dsn.
                dbms=&filetype.;
            run;
            filename tempfile clear;
        %end;
    %else
        %do;
            %put Dataset &dsn. already exists. Please delete and try again.;
        %end;
%mend;
%loadDataIfNotAlreadyAvailable(
    AviationData_raw,
    &inputDatasetURL.,
    xlsx
)

* check raw FRPM dataset for duplicates with respect to its composite key;
proc sort
        nodupkey
        data=AviationData_raw
        dupout=AviationData_raw_dups
        out=_null_
    ;
    by
        Event_Id
    ;
run;

* build analytic dataset from AviationData dataset with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;
data AviationData_analytic_file;
    retain
        Event_Date
        Location
        Country
        Injury_Severity
        Aircraft_Category
        Make
        Model
	Purpose_of_Flight
        Air_Carrier
        Weather_Condition
        Broad_Phase_of_Flight
    ;
    keep
        Event_Date
        Location
        Country
        Injury_Severity
        Aircraft_Category
        Make
        Model
	Purpose_of_Flight
        Air_Carrier
        Weather_Condition
        Broad_Phase_of_Flight
    ;
    set AviationData_raw;
run;
