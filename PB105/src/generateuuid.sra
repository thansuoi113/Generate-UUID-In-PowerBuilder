$PBExportHeader$generateuuid.sra
$PBExportComments$Generated Application Object
forward
global type generateuuid from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables

end variables

global type generateuuid from application
string appname = "generateuuid"
end type
global generateuuid generateuuid

on generateuuid.create
appname="generateuuid"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on generateuuid.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;Open(w_main)

end event

