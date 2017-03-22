HA$PBExportHeader$w_tmp_clientes.srw
forward
global type w_tmp_clientes from window
end type
type cb_1 from commandbutton within w_tmp_clientes
end type
end forward

global type w_tmp_clientes from window
integer width = 3465
integer height = 1924
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
end type
global w_tmp_clientes w_tmp_clientes

on w_tmp_clientes.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_tmp_clientes.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_tmp_clientes
integer x = 1531
integer y = 296
integer width = 343
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;String ls_ruc,ls_contacto,ls_fono

declare cliente cursor for

select ruc,telefono
from dinamic.tmp_clientes ;


open cliente;
do 
	fetch cliente into :ls_ruc,:ls_fono;	
	if sqlca.sqlcode <> 0 then exit

			
			  UPDATE fa_clien
			  SET  ce_telbod = :ls_fono
			  WHERE ce_rucic = :ls_ruc;
			  IF SQLCA.SQLCODE < 0 THEN
				  Rollback;
				  messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar datos "+sqlca.sqlerrtext)				  
				  Return
			  END IF	
	
loop while true
close cliente;
commit;
Messagebox("","Listo")

end event

