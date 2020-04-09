#NoTrayIcon
Global $sScript_Content

If $CmdLine[0] < 1 Then
$CameyoFile = FileOpenDialog('Please select file', @DesktopDir, "Cameyo Package (*.cameyo.exe)", 1 + 2)
	If @Error Then Exit
Else
$CameyoFile = $CmdLine[1]
EndIF


$RandomTempFileName = _RandomText(10)
$CameyoFileName = StringRegExpReplace ( $CameyoFile, "(^.*)\\(.*)\.(.*)$", "\2")
$sAutoIt_File = @TempDir & "\CameyoExtractorTemp\" & $RandomTempFileName & ".bat"
$sScript_Content &= 'set CAMEYO_BASEDIRNAME=%%ExeDir%%\' & FileGetShortName($CameyoFileName) & '' & @CRLF
$sScript_Content &= '' & $CameyoFile & ' -ExtractAll' & @CRLF

$hFile = FileOpen($sAutoIt_File, 2 +8)
FileWrite($hFile, $sScript_Content)
FileClose($hFile)
ShellExecute($sAutoIt_File,'','','',@SW_HIDE)
$sFileNameNoExt = StringRegExpReplace(StringRegExpReplace($CameyoFile, "^.*\\", ""), '\.[^.]*$', '')
WinWait ($sFileNameNoExt)
$sTexts = WinGetText($sFileNameNoExt)
WinClose($sFileNameNoExt)

; Delete the temporary file.
$iDelete = FileDelete($sAutoIt_File)

If $iDelete Then
$RegExpRep = StringRegExpReplace($sTexts, 'OK', ' ')
Else
MsgBox(0, "Cameyo Extractor", "Error")
EndIF

If $CmdLine[0] < 1 Then
;MsgBox(0, $sFileNameNoExt, $RegExpRep)
MsgBox(0, "Cameyo Extractor", $RegExpRep)
Else
ConsoleWrite($RegExpRep)
Exit
EndIF

Func _RandomText($length)
    Local $text = "", $temp
    For $i = 1 To $length
        $temp = Random(55, 116, 1)
        $text&= Chr($temp+6*($temp>90)-7*($temp<65))
    Next
    Return $text
EndFunc   ;==>_RandomText

