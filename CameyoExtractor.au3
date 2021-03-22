Global $Script_Content

$CameyoFile = FileOpenDialog('Please select file', @DesktopDir, "Cameyo Package (*.cameyo.exe)", 1 + 2)
If @Error Then Exit

$CameyoFileName = StringRegExpReplace ( $CameyoFile, "(^.*)\\(.*)\.(.*)$", "\2")

$Bat_File = @TempDir & "\CameyoExtractorTemp\" & _RandomText(10) & ".bat"
$Script_Content &= 'set CAMEYO_BASEDIRNAME=%%ExeDir%%\' & FileGetShortName($CameyoFileName) & '' & @CRLF
$Script_Content &= '' & $CameyoFile & ' -ExtractAll' & @CRLF

$hFile = FileOpen($Bat_File, 2 + 8)
FileWrite($hFile, $Script_Content)
FileClose($hFile)

ShellExecuteWait($Bat_File, '', '', '', @SW_HIDE)

; Delete the temporary file.
$iDelete = FileDelete($Bat_File)

Func _RandomText($length)
    Local $text = "", $temp
    For $i = 1 To $length
        $temp = Random(55, 116, 1)
        $text&= Chr($temp+6*($temp>90)-7*($temp<65))
    Next
    Return $text
EndFunc

