$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type st_3 from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type st_1 from statictext within w_main
end type
type ddlb_encoding from dropdownlistbox within w_main
end type
type mle_output from multilineedit within w_main
end type
type mle_input from multilineedit within w_main
end type
type cb_decode from commandbutton within w_main
end type
type cb_encode from commandbutton within w_main
end type
end forward

global type w_main from window
integer width = 2318
integer height = 1328
boolean titlebar = true
string title = "PowerBuilder Base64"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_3 st_3
st_2 st_2
st_1 st_1
ddlb_encoding ddlb_encoding
mle_output mle_output
mle_input mle_input
cb_decode cb_decode
cb_encode cb_encode
end type
global w_main w_main

type prototypes
Function Boolean CryptBinaryToString ( Blob pbBinary, ULong cbBinary, ULong dwFlags, Ref String pszString, 	Ref ULong pcchString ) Library "crypt32.dll" Alias For "CryptBinaryToStringW"
Function Boolean CryptBinaryToString ( Blob pbBinary, ULong cbBinary, ULong dwFlags, Long pszString, Ref ULong pcchString ) Library "crypt32.dll" Alias For "CryptBinaryToStringW"
Function Boolean CryptStringToBinary ( String pszString, ULong cchString, ULong dwFlags, Ref Blob pbBinary, Ref ULong pcbBinary, Ref ULong pdwSkip, Ref ULong pdwFlags ) Library "crypt32.dll" Alias For "CryptStringToBinaryW"

end prototypes

forward prototypes
public function string wf_encode (string as_message)
public function Encoding wf_getencoding ()
public function string wf_decode (string as_encoded)
end prototypes

public function string wf_encode (string as_message);//====================================================================
// Function: w_main.wf_encode()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_message	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/06
//--------------------------------------------------------------------
// Usage: w_main.wf_encode ( string as_message )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Encoding lEncoding = EncodingAnsi!
ULong lul_MsgLen, lul_BufLen
String ls_encoded
Blob  ablb_message

Constant ULong Null = 0
Constant ULong CRYPT_STRING_BASE64 = 1
Constant ULong CRYPT_STRING_HEXRAW = 12
Constant ULong CRYPT_STRING_NOCRLF = 1073741824 // 0x40000000
Constant ULong aNULL = 0

//Get Encoding
lEncoding = wf_getEncoding()

//Data encode
ablb_message = Blob(as_message, lEncoding)


// determine size of the encoded buffer
lul_MsgLen = Len(ablb_message)
If Not CryptBinaryToString(ablb_message, lul_MsgLen, CRYPT_STRING_BASE64, aNULL, lul_BufLen) Then
	Return ""
End If

// allocate encoded buffer
ls_encoded = Space(lul_BufLen)

// encode the binary data as Base64 string
If Not CryptBinaryToString(ablb_message, lul_MsgLen, CRYPT_STRING_BASE64 + CRYPT_STRING_NOCRLF, 	ls_encoded, lul_BufLen) Then
	Return ""
End If

Return ls_encoded
end function

public function Encoding wf_getencoding ();Encoding lEncoding

lEncoding = EncodingANSI! //default

If ddlb_encoding.Text = "EncodingANSI!" Then
	lEncoding = EncodingANSI!
ElseIf ddlb_encoding.Text = "EncodingUTF8!" Then
	lEncoding = EncodingUTF8!
ElseIf ddlb_encoding.Text = "EncodingUTF16LE!" Then
	lEncoding = EncodingUTF16LE!
ElseIf ddlb_encoding.Text = "EncodingUTF16BE!" Then
	lEncoding = EncodingUTF16BE!
End If

Return  lEncoding


end function

public function string wf_decode (string as_encoded);//====================================================================
// Function: w_main.wf_decode()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_encoded	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/01/06
//--------------------------------------------------------------------
// Usage: w_main.wf_decode ( string as_encoded )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Encoding lEncoding = EncodingAnsi!
Blob lblb_Decoded, blb_Message
ULong lul_MsgLen, lul_BufLen, lul_Skip, lul_pFlags

Constant ULong Null = 0
Constant ULong CRYPT_STRING_BASE64 = 1
Constant ULong CRYPT_STRING_HEXRAW = 12
Constant ULong CRYPT_STRING_NOCRLF = 1073741824 // 0x40000000

//Get Encoding
lEncoding = wf_getencoding()

//Data decode
lul_MsgLen = Len(as_encoded)
lul_BufLen = lul_MsgLen
lblb_Decoded = Blob(Space(lul_BufLen), lEncoding)

//Decode the Base64 string
If Not CryptStringToBinary(as_encoded, lul_MsgLen, CRYPT_STRING_BASE64, lblb_Decoded, lul_BufLen, lul_Skip, lul_pFlags) Then
	Return ""
End If

blb_Message = BlobMid(lblb_Decoded, 1, lul_BufLen)

Return String(blb_Message, lEncoding)

end function

on w_main.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_encoding=create ddlb_encoding
this.mle_output=create mle_output
this.mle_input=create mle_input
this.cb_decode=create cb_decode
this.cb_encode=create cb_encode
this.Control[]={this.st_3,&
this.st_2,&
this.st_1,&
this.ddlb_encoding,&
this.mle_output,&
this.mle_input,&
this.cb_decode,&
this.cb_encode}
end on

on w_main.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_encoding)
destroy(this.mle_output)
destroy(this.mle_input)
destroy(this.cb_decode)
destroy(this.cb_encode)
end on

type st_3 from statictext within w_main
integer x = 64
integer y = 696
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Output Text:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_main
integer x = 64
integer y = 180
integer width = 329
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Input Text:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_main
integer x = 50
integer y = 44
integer width = 315
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Encoding:"
boolean focusrectangle = false
end type

type ddlb_encoding from dropdownlistbox within w_main
integer x = 366
integer y = 40
integer width = 914
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
string item[] = {"EncodingANSI!","EncodingUTF8!","EncodingUTF16LE!","EncodingUTF16BE!"}
borderstyle borderstyle = stylelowered!
end type

event constructor;ddlb_encoding.selectitem( 1)
end event

type mle_output from multilineedit within w_main
integer x = 50
integer y = 784
integer width = 2167
integer height = 400
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

type mle_input from multilineedit within w_main
integer x = 50
integer y = 260
integer width = 2167
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_decode from commandbutton within w_main
integer x = 1664
integer y = 40
integer width = 297
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Decode"
end type

event clicked;String  ls_input, ls_output

ls_input = mle_input.Text
ls_output =  wf_decode(ls_input)
mle_output.Text = ls_output

end event

type cb_encode from commandbutton within w_main
integer x = 1353
integer y = 40
integer width = 297
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Encode"
end type

event clicked;String  ls_input, ls_output

ls_input = mle_input.Text
ls_output =  wf_encode(ls_input)
mle_output.Text = ls_output

end event

