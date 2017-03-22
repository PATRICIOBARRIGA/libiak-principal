HA$PBExportHeader$uo_pipe.sru
forward
global type uo_pipe from pipeline
end type
end forward

global type uo_pipe from pipeline
end type
global uo_pipe uo_pipe

type variables
 statictext   ist_status_read, ist_status_written, ist_status_error

end variables

forward prototypes
public function integer start ()
end prototypes

public function integer start ();return 1
end function

on uo_pipe.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_pipe.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event pipemeter;ist_status_read.text    = string(RowsRead)
ist_status_written.text = string(RowsWritten)
ist_status_error.text   = string(RowsInError)

end event

