#NoTrayIcon
Global $sScript_Content

$CameyoFile = FileOpenDialog('Please select file', @DesktopDir, "Cameyo Package (*.cameyo.exe)", 1 + 2)
If @Error Then Exit


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

MsgBox(0, "Cameyo Extractor", $RegExpRep)

Func _RandomText($length)
    Local $text = "", $temp
    For $i = 1 To $length
        $temp = Random(55, 116, 1)
        $text&= Chr($temp+6*($temp>90)-7*($temp<65))
    Next
    Return $text
EndFunc   ;==>_RandomText

