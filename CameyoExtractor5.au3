#NoTrayIcon
If $CmdLine[0] < 1 Then
$CameyoFile = FileOpenDialog('Выберите файл', @DesktopDir, "Текстовые файлы (*.exe)", 1 + 2)
	If @Error Then Exit
Else
$CameyoFile = $CmdLine[1]
EndIF
Global Const $RandomTempFileName = _RandomText(10)
$CameyoFileName = StringRegExpReplace ( $CameyoFile, "(^.*)\\(.*)\.(.*)$", "\2")
;Local $sAutoIt_File = @TempDir & "\nsnAFB7.tmp\Script_TempFile.bat"
$sAutoIt_File = @TempDir & $RandomTempFileName & '.bat'
Local $sRunLine, $sScript_Content, $hFile
$sScript_Content &= 'set CAMEYO_BASEDIRNAME=%%ExeDir%%\' & FileGetShortName($CameyoFileName) & '' & @CRLF
$sScript_Content &= '' & $CameyoFile & ' -ExtractAll' & @CRLF
$hFile = FileOpen($sAutoIt_File, 2)
FileWrite($hFile, $sScript_Content)
FileClose($hFile)
ShellExecute ( $sAutoIt_File,'','','',@SW_HIDE)
$sFileNameNoExt = StringRegExpReplace(StringRegExpReplace($CameyoFile, "^.*\\", ""), '\.[^.]*$', '')
WinWait ( $sFileNameNoExt )
If $CmdLine[0] < 1 Then
Local $sTexts = WinGetText($sFileNameNoExt)
WinClose($sFileNameNoExt )
; Delete the temporary file.
Local $iDelete = FileDelete($sAutoIt_File)
; Display a message of whether the file was deleted.
If $iDelete Then
$RegExpRep = StringRegExpReplace($sTexts, 'OK', ' ')
MsgBox(0, $sFileNameNoExt, $RegExpRep )
Else
MsgBox(0, "", "Ertor")
EndIf
Else
Local $sTexts = WinGetText($sFileNameNoExt)
WinClose($sFileNameNoExt )
FileDelete($sAutoIt_File)
$RegExpRep = StringRegExpReplace($sTexts, 'OK', ' ')
ConsoleWrite($RegExpRep)
exit
EndIF
Func _RandomText($length)
    Local $text = "", $temp
    For $i = 1 To $length
        $temp = Random(55, 116, 1)
        $text&= Chr($temp+6*($temp>90)-7*($temp<65))
    Next
    Return $text
EndFunc   ;==>_RandomText

