-- sql ci utility tips 

-- To display data in csv format 
set sqlformat csv

-- To dispay data in json format 
set sqlformat json 


-- alias 
alias oracntsess=select count(*) from v$session;

oracntsess

-- Last cmd 5 times with delay of 3 sec 
repeat 5 3 

-- For history 
history 
history usage 

-- Can use up and down arrows for previous sql cmds 
