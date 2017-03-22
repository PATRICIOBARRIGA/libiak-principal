HA$PBExportHeader$w_rep_hoja_tecnica.srw
$PBExportComments$Si.Hoja T$$HEX1$$e900$$ENDHEX$$cnica de un producto dado
forward
global type w_rep_hoja_tecnica from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_hoja_tecnica
end type
end forward

global type w_rep_hoja_tecnica from w_sheet_1_dw_rep
int Width=3146
int Height=1473
boolean TitleBar=true
string Title="Hoja T$$HEX1$$e900$$ENDHEX$$cnica"
long BackColor=12632256
dw_1 dw_1
end type
global w_rep_hoja_tecnica w_rep_hoja_tecnica

type variables

end variables

on w_rep_hoja_tecnica.create
int iCurrent
call w_sheet_1_dw_rep::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
end on

on w_rep_hoja_tecnica.destroy
call w_sheet_1_dw_rep::destroy
destroy(this.dw_1)
end on

event open;dw_1.InsertRow(0)
this.ib_notautoretrieve = true
call super::open
end event

event resize;call super::resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_retrieve;beep(1)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_hoja_tecnica
int X=1
int Y=117
int Width=3114
int Height=1241
int TabOrder=20
string DataObject="d_rep_cab_hoja_tecnica"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_hoja_tecnica
int TabOrder=30
boolean BringToTop=true
end type

type dw_1 from datawindow within w_rep_hoja_tecnica
int Width=3114
int Height=117
int TabOrder=10
boolean BringToTop=true
string DataObject="d_sel_producto"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

event itemchanged;string  ls,ls_nombre,ls_codant
string  ls_pepa, ls_marca, ls_hojatec  
choose case this.getcolumnname()
case 'codigo'
	ls = this.gettext()
	 // con este voy a buscar
	 //primero por codigo anterior
	 select it_codigo, it_nombre, ma_codigo
		into :ls_pepa, :ls_nombre, :ls_marca
		from in_item
	  where em_codigo = : str_appgeninfo.empresa
	    and it_codant = :ls;
   if sqlca.sqlcode <> 0 then
		MessageBox("ERROR","C$$HEX1$$f300$$ENDHEX$$digo no existe, por favor revise lista")
		return(1)
	else
		this.SetItem(1,"nombre",ls_nombre)
		//Busco si la HT es por producto
		SELECT HT_CODHOJA
        INTO :ls_hojatec  
        FROM IN_HOJTEC
       WHERE ( EM_CODIGO = :str_appgeninfo.empresa ) AND  
             ( IT_CODIGO = :ls_pepa) AND  
             ( HT_VIGENTE = 'S' );
		if sqlca.sqlcode <> 0 then
			//Busco por marca del producto
			SELECT HT_CODHOJA
			  INTO :ls_hojatec  
			  FROM IN_HOJTEC
			 WHERE ( EM_CODIGO = :str_appgeninfo.empresa ) AND  
					 ( MA_CODIGO = :ls_marca ) AND   
					 ( HT_VIGENTE = 'S' );
			  if sqlca.sqlcode <> 0 then
				  messageBox('Error','Hoja t$$HEX1$$e900$$ENDHEX$$cnica para este producto no existe o no est$$HEX2$$e1002000$$ENDHEX$$vigente')
				  return -1
			  end if
		end if
		dw_datos.retrieve(str_appgeninfo.empresa, ls_pepa, ls_marca, ls_hojatec)
	end if

END CHOOSE
end event

