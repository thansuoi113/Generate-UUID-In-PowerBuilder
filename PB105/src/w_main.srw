$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cbx_hyphen from checkbox within w_main
end type
type cbx_case from checkbox within w_main
end type
type rb_mt2 from radiobutton within w_main
end type
type rb_mt1 from radiobutton within w_main
end type
type st_1 from statictext within w_main
end type
type sle_uuid from singlelineedit within w_main
end type
type cb_generateuuid from commandbutton within w_main
end type
end forward

global type w_main from window
integer width = 2757
integer height = 496
boolean titlebar = true
string title = "Generate UUID"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cbx_hyphen cbx_hyphen
cbx_case cbx_case
rb_mt2 rb_mt2
rb_mt1 rb_mt1
st_1 st_1
sle_uuid sle_uuid
cb_generateuuid cb_generateuuid
end type
global w_main w_main

type prototypes

end prototypes

on w_main.create
this.cbx_hyphen=create cbx_hyphen
this.cbx_case=create cbx_case
this.rb_mt2=create rb_mt2
this.rb_mt1=create rb_mt1
this.st_1=create st_1
this.sle_uuid=create sle_uuid
this.cb_generateuuid=create cb_generateuuid
this.Control[]={this.cbx_hyphen,&
this.cbx_case,&
this.rb_mt2,&
this.rb_mt1,&
this.st_1,&
this.sle_uuid,&
this.cb_generateuuid}
end on

on w_main.destroy
destroy(this.cbx_hyphen)
destroy(this.cbx_case)
destroy(this.rb_mt2)
destroy(this.rb_mt1)
destroy(this.st_1)
destroy(this.sle_uuid)
destroy(this.cb_generateuuid)
end on

type cbx_hyphen from checkbox within w_main
integer x = 1865
integer y = 44
integer width = 329
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "hyphen"
boolean checked = true
end type

type cbx_case from checkbox within w_main
integer x = 2231
integer y = 44
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Upper Case"
boolean checked = true
boolean threestate = true
end type

event clicked;If cbx_case.Checked Then
	If cbx_case.ThirdState Then
		This.Text = "Lower Case"
	Else
		This.Text = "Upper Case"
	End If
Else
	This.Text = "Nomal"
End If


end event

type rb_mt2 from radiobutton within w_main
integer x = 1170
integer y = 44
integer width = 366
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Method 2"
end type

event clicked;cbx_hyphen.enabled = this.checked
end event

type rb_mt1 from radiobutton within w_main
integer x = 768
integer y = 44
integer width = 366
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Method 1"
boolean checked = true
end type

event clicked;cbx_hyphen.enabled = rb_mt2.checked
end event

type st_1 from statictext within w_main
integer x = 30
integer y = 204
integer width = 183
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "UUID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_uuid from singlelineedit within w_main
integer x = 219
integer y = 192
integer width = 2450
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_generateuuid from commandbutton within w_main
integer x = 219
integer y = 32
integer width = 489
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Generate UUID"
end type

event clicked;nvo_uuid lnvo_uuid
String ls_case, ls_uuid

If cbx_case.Checked Then
	If cbx_case.ThirdState Then
		ls_case = "L"
	Else
		ls_case = "U"
	End If
Else
	ls_case = "N"
End If

If rb_mt1.Checked Then
	ls_uuid = lnvo_uuid.of_generate_uuid(ls_case )
ElseIf rb_mt2.Checked Then
	If cbx_hyphen.Checked Then
		ls_uuid = lnvo_uuid.of_generate_uuid2("F", ls_case )
	Else
		ls_uuid = lnvo_uuid.of_generate_uuid2("R", ls_case )
	End If
End If

sle_uuid.Text = ls_uuid


end event

