$PBExportHeader$pbbase64.sra
$PBExportComments$Generated Application Object
forward
global type pbbase64 from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type pbbase64 from application
string appname = "pbbase64"
end type
global pbbase64 pbbase64

type prototypes

end prototypes
on pbbase64.create
appname="pbbase64"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pbbase64.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_main)
end event

