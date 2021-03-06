$PBExportHeader$nvo_uuid.sru
forward
global type nvo_uuid from nonvisualobject
end type
type uuid from structure within nvo_uuid
end type
type s_uuid from structure within nvo_uuid
end type
end forward

type uuid from structure
	unsignedlong		data1
	integer		data2
	integer		data3
	blob		data4
end type

type s_uuid from structure
	unsignedlong  data1
 unsignedinteger  data2
 unsignedinteger  data3
 unsignedinteger  data4[4]
end type

global type nvo_uuid from nonvisualobject autoinstantiate
end type

type prototypes
Function Long UuidCreateSequential ( Ref UUID UUID ) Library "rpcrt4.dll"
Function Long UuidToString ( Ref UUID UUID, Ref ULong StringUuid 	) Library "rpcrt4.dll" Alias For "UuidToStringW"
Function Long RpcStringFree ( Ref ULong pString ) Library "rpcrt4.dll" Alias For "RpcStringFreeW"
Subroutine CopyMemory ( Ref String Destination, 	ULong Source, Long Length ) Library  "kernel32.dll" Alias For "RtlMoveMemory"
Function Long uuidCreate(Ref s_UUID astr_uuid) Library "Rpcrt4.dll"  Alias For "UuidCreate"



end prototypes

forward prototypes
public function String of_hex (unsignedlong aul_decimal)
public function string of_generate_uuid2 (string as_type, string as_case)
public function string of_generate_uuid (string as_case)
public function string of_generate_uuid_time ()
end prototypes

public function String of_hex (unsignedlong aul_decimal);String ls_hex
Character lch_hex[0 To 15] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b',  'c', 'd', 'e', 'f'}

// Check parameters
If IsNull(aul_decimal) Then
	SetNull(ls_hex)
	Return ls_hex
End If

Do
	ls_hex = lch_hex[Mod(aul_decimal, 16)] + ls_hex
	aul_decimal /= 16
Loop Until aul_decimal = 0

Return ls_hex

end function

public function string of_generate_uuid2 (string as_type, string as_case);//====================================================================
// Function: nvo_uuid.of_generate_uuid2()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_type	
// 	string	as_case	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/05/18
//--------------------------------------------------------------------
// Usage: nvo_uuid.of_generate_uuid2 ( string as_type, string as_case )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long ll_rc
s_uuid lstr_uuid
String ls_guid = ""

Constant Long RPC_S_OK = 0
Constant Long RPC_S_UUID_LOCAL_ONLY = 1824
Constant Long RPC_S_UUID_NO_ADDRESS = 1739

ll_rc = uuidCreate(lstr_uuid)

//  returns 
//   RPC_S_OK - The call succeeded.
//   RPC_S_UUID_LOCAL_ONLY -   The UUID is guaranteed to be unique to this computer only.
//   RPC_S_UUID_NO_ADDRESS -  Cannot get Ethernet/token-ring hardware address for this computer.

If ll_rc <> RPC_S_OK Then
	SetNull(ls_guid)
	// MessageBox("", "uuid create not ok ?!?")
Else
	If as_type = 'F' Then
		ls_guid = Right("00000000" + of_hex(lstr_uuid.data1), 8)
		ls_guid += "-" + Right("0000" + of_hex(lstr_uuid.data2), 4)
		ls_guid += "-" + Right("0000" + of_hex(lstr_uuid.data3), 4)
		ls_guid += "-" + Right("0000" + of_hex(lstr_uuid.data4[1]), 4)
		ls_guid += "-" + Right("0000" + of_hex(lstr_uuid.data4[2]), 4) + Right("0000" + of_hex(lstr_uuid.data4[3]), 4) + Right("0000" + of_hex(lstr_uuid.data4[4]), 4)
		
		If Upper(Trim(as_case))= "U" Then
			ls_guid = Upper(ls_guid)
		ElseIf Upper(Trim(as_case))= "L" Then
			ls_guid = lower(ls_guid)
		End If

	ElseIf as_type = 'R' Then
		ls_guid = Right("00000000" + of_hex(lstr_uuid.data1), 8)
		ls_guid += Right("0000" + of_hex(lstr_uuid.data2), 4)
		ls_guid += Right("0000" + of_hex(lstr_uuid.data3), 4)
		ls_guid += Right("0000" + of_hex(lstr_uuid.data4[1]), 4)
		ls_guid += Right("0000" + of_hex(lstr_uuid.data4[2]), 4) + Right("0000" + of_hex(lstr_uuid.data4[3]), 4) + Right("0000" + of_hex(lstr_uuid.data4[4]), 4)
		
		If Upper(Trim(as_case))= "U" Then
			ls_guid = Upper(ls_guid)
		ElseIf Upper(Trim(as_case))= "L" Then
			ls_guid = lower(ls_guid)
		End If
	End If
End If

Return ls_guid

end function

public function string of_generate_uuid (string as_case);//====================================================================
// Function: nvo_uuid.of_generate_uuid()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_case	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/05/18
//--------------------------------------------------------------------
// Usage: nvo_uuid.of_generate_uuid ( string as_case )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


UUID lstr_UUID
Constant Long RPC_S_OK = 0
Constant Long SZ_UUID_LEN = 36
ULong lul_ptrUuid
String ls_Uuid

lstr_UUID.Data4 = Blob(Space(8), EncodingAnsi!)
ls_Uuid = Space(SZ_UUID_LEN + 2)

Try
	If UuidCreateSequential(lstr_UUID) = RPC_S_OK Then
		If UuidToString(lstr_UUID, lul_ptrUuid) = RPC_S_OK Then
			CopyMemory(ls_Uuid, lul_ptrUuid, SZ_UUID_LEN*2)
			RpcStringFree(lul_ptrUuid)
		End If
	End If
Catch (RuntimeError rte)
	PopulateError(rte.Number, rte.Text)
End Try

If Upper(Trim(as_case)) = "U" Then
	ls_Uuid = Upper(Trim(ls_Uuid))
ElseIf Upper(Trim(as_case)) = "L" Then
	ls_Uuid = Lower(Trim(ls_Uuid))
End If

Return ls_Uuid

end function

public function string of_generate_uuid_time ();Return "ABC"+String(Now(),"yyyymmddhhmmssms")+String(Rand(1000))

end function

on nvo_uuid.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_uuid.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

