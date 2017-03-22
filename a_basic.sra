HA$PBExportHeader$a_basic.sra
forward
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
s_appgeninfo str_appgeninfo // username, db, etc.
end variables

global type a_basic from application
 end type
global a_basic a_basic

on a_basic.create
appname = "a_basic"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on a_basic.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

event open;if f_opendbapp(w_frame_basic, "basic.ini") = -1 then halt
end event

