##########
# Win 10 Setup Script/Tweaks with Menu(GUI)
#
# Modded Script + Menu(GUI) By
#  Author: Madbomb122
# Website: https://github.com/madbomb122/Win10Script/
#
# Original Basic Script By
#  Author: Disassembler0
# Website: https://github.com/Disassembler0/Win10-Initial-Setup-Script/
# Version: 2.0, 2017-01-08 (Version Copied)
#
$Script_Version = '3.4'
$Minor_Version = '4'
$Script_Date = 'July-14-2018'
$Release_Type = 'Testing'
#$Release_Type = 'Stable'
##########

## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## !!                                            !!
## !!             SAFE TO EDIT ITEM              !!
## !!            AT BOTTOM OF SCRIPT             !!
## !!                                            !!
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## !!                                            !!
## !!                  CAUTION                   !!
## !!        DO NOT EDIT PAST THIS POINT         !!
## !!                                            !!
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

<#------------------------------------------------------------------------------
The MIT License (MIT)

Copyright (c) 2017 Disassembler -Original Basic Version of Script
Copyright (c) 2017 Madbomb122 -Modded + Menu Version of Script

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

--------------------------------------------------------------------------------

.Prerequisite to run script
  System: Windows 10
  Files: This script

.DESCRIPTION
  Makes it easier to setup an existing or new install with moded setting

.BASIC USAGE
  Use the Menu and set what you want then Click Run the Script

.ADVANCED USAGE
 One of the following Methods...
  1. Edit values at bottom of the script
  2. Edit bat file and run
  3. Run the script with one of these arguments/switches (space between multiple)

-- Basic Switches --
 Switches       Description of Switch
  -atos          (Accepts ToS)
  -auto          (Implies -Atos...Closes on - User Errors, or End of Script)
  -crp           (Creates Restore Point)
  -dnr           (Do Not Restart when done)

-- Run Script Switches --
 Switches       Description of Switch
  -run           (Runs script with settings in script)
  -run FILENME   (Runs script with settings in the file FILENME)
  -run wd        (Runs script with win default settings)

-- Load Script Switches --
 Switches       Description of Switch
  -load FILENME  (Loads script with settings in the file FILENME)
  -load wd       (Loads script with win default settings)

--Update Switches--
 Switches       Description of Switch
  -usc           (Checks for Update to Script file before running)
  -sic           (Skips Internet Check)
------------------------------------------------------------------------------#>
##########
# Pre-Script -Start
##########
#Get-ItemPropertyValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion' 'ProgramFilesDir'

If([Environment]::OSVersion.Version.Major -ne 10) {
	Clear-Host
	Write-Host 'Sorry, this Script supports Windows 10 ONLY.' -ForegroundColor 'cyan' -BackgroundColor 'black'
	If($Automated -ne 1){ Read-Host -Prompt "`nPress Any key to Close..." } ;Exit
}

If($Release_Type -eq 'Stable'){ $ErrorActionPreference = 'silentlycontinue' }

$Script:PassedArg = $args
$Script:filebase = $PSScriptRoot + '\'
$TempFolder = $Env:Temp

If(!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PassedArg" -Verb RunAs ;Exit
}

$URL_Base = 'https://raw.GitHubusercontent.com/madbomb122/Win10Script/master/'
$Script:BuildVer = [Environment]::OSVersion.Version.build
If([System.Environment]::Is64BitProcess){ $Script:OSType = 64 }

##########
# Pre-Script -End
##########
# Needed Variable -Start
##########

[Array]$Script:APPS_AppsUnhide = @()
[Array]$Script:APPS_AppsHide = @()
[Array]$Script:APPS_AppsUninstall = @()

$AppsList = @(
'Microsoft.3DBuilder',
'Microsoft.Microsoft3DViewer',
'Microsoft.BingWeather',
'Microsoft.CommsPhone',
'Microsoft.windowscommunicationsapps',
'Microsoft.GetHelp',
'Microsoft.Getstarted',
'Microsoft.Messaging',
'Microsoft.MicrosoftOfficeHub',
'Microsoft.MovieMoments',
'4DF9E0F8.Netflix',
'Microsoft.Office.OneNote',
'Microsoft.Office.Sway',
'Microsoft.OneConnect',
'Microsoft.People',
'Microsoft.Windows.Photos',
'Microsoft.SkypeApp',
'Microsoft.SkypeWiFi',
'Microsoft.MicrosoftSolitaireCollection',
'Microsoft.MicrosoftStickyNotes',
'Microsoft.Wallet'
'Microsoft.WindowsSoundRecorder',
'Microsoft.WindowsAlarms',
'Microsoft.WindowsCalculator',
'Microsoft.WindowsCamera',
'Microsoft.WindowsFeedback',
'Microsoft.WindowsFeedbackHub',
'Microsoft.WindowsMaps',
'Microsoft.WindowsPhone',
'Microsoft.WindowsStore',
'XboxApps',
'Microsoft.ZuneMusic',
'Microsoft.ZuneVideo')

$TasksList = @(
'Application Experience',
'Consolidator',
'Customer Experience Improvement Program',
'DmClient',
'KernelCeipTask',
'Microsoft Compatibility Appraiser',
'ProgramDataUpdater',
'Proxy',
'QueueReporting',
'SmartScreenSpecific',
'UsbCeip')

<#
'AgentFallBack2016',
'AitAgent',
'CreateObjectTask',
#'Diagnostics',
'DmClientOnScenarioDownload',
'FamilySafetyMonitor',
'FamilySafetyRefresh',
'FamilySafetyRefreshTask',
'FamilySafetyUpload',
#'File History (maintenance mode)',
'GatherNetworkInfo',
'MapsUpdateTask',
#'Microsoft-Windows-DiskDiagnosticDataCollector',
'MNO Metadata Parser',
'OfficeTelemetryAgentFallBack',
'OfficeTelemetryAgentLogOn',
'OfficeTelemetryAgentLogOn2016',
'Sqm-Tasks',
#'StartupAppTask',
'Uploader',
'XblGameSaveTask',
'XblGameSaveTaskLogon') #>

$Xbox_Apps = @(
'Microsoft.XboxApp',
'Microsoft.XboxIdentityProvider',
'Microsoft.XboxSpeechToTextOverlay',
'Microsoft.XboxGameOverlay',
'Microsoft.Xbox.TCUI')

$colors = @(
'black',      #0
'blue',       #1
'cyan',       #2
'darkblue',   #3
'darkcyan',   #4
'darkgray',   #5
'darkgreen',  #6
'darkmagenta',#7
'darkred',    #8
'darkyellow', #9
'gray',       #10
'green',      #11
'magenta',    #12
'red',        #13
'white',      #14
'yellow')     #15

$musnotification_files = @("$Env:windir\System32\musnotification.exe","$Env:windir\System32\musnotificationux.exe")

Function MenuBlankLine { DisplayOutMenu '|'.PadRight(51) 14 0 0 ;RightLine }
Function MenuLine { DisplayOutMenu '|'.PadRight(52,'-') 14 0 0 ;DisplayOut '|' 14 0 1 }
Function LeftLine { DisplayOutMenu '| ' 14 0 0 }
Function RightLine { DisplayOut ' |' 14 0 }

Function BoxItem([String]$TxtToDisplay) {
	$TLen = $TxtToDisplay.Length
	$LLen = $TLen+9
	DisplayOutMenu "`n".PadRight($LLen,'-') 14 0 1
	DisplayOutMenu '-' 14 0 0 ;DisplayOutMenu "   $TxtToDisplay   " 6 0 0 ;DisplayOutMenu '-' 14 0 1
	DisplayOutMenu ''.PadRight($LLen-1,'-') 14 0 1
}

Function TOSLine([Int]$BC){ DisplayOutMenu '|'.PadRight(52,'-') $BC 0 0 ;DisplayOut '|' $BC 0 }
Function TOSBlankLine([Int]$BC){ DisplayOutMenu '|'.PadRight(52) $BC 0 0 ;DisplayOut '|' $BC  0 }

Function AnyKeyClose { Read-Host -Prompt "`nPress Any key to Close..." }

##########
# Needed Variable -End
##########
# Update Check -Start
##########

Function UpdateCheck {
	If(InternetCheck) {
		$VersionURL = 'https://raw.GitHubusercontent.com/madbomb122/Win10Script/master/Version/Version.csv'
		$CSV_Ver = Invoke-WebRequest $VersionURL | ConvertFrom-Csv
		If($Release_Type -ne 'Stable'){ $Line = 0 } Else{ $Line = 1 }
		$WebScriptVer = $($CSV_Ver[$Line].Version)
		$WebScriptMinorVer = $($CSV_Ver[$Line].MinorVersion)
		If(($WebScriptVer -gt $Script_Version) -or ($WebScriptVer -eq $Script_Version -And $WebScriptMinorVer -gt $Minor_Version)){ ScriptUpdateFun }
	} Else {
		Clear-Host
		MenuLine
		LeftLine ;DisplayOutMenu (''.PadRight(22)+'Error'.PadRight(27)) 13 0 0 ;RightLine
		MenuLine
		MenuBlankLine
		LeftLine ;DisplayOutMenu 'No Internet connection detected.'.PadRight(49) 2 0 0 ;RightLine
		LeftLine ;DisplayOutMenu 'Tested by pinging GitHub.com'.PadRight(49) 2 0 0 ;RightLine
		MenuBlankLine
		LeftLine ;DisplayOutMenu ' To skip use one of the following methods        ' 2 0 0 ;RightLine
		LeftLine ;DisplayOutMenu ' 1. Change ' 2 0 0 ;DisplayOutMenu 'InternetCheck' 15 0 0 ;DisplayOutMenu ' to ' 2 0 0 ;DisplayOutMenu '=1' 15 0 0 ;DisplayOutMenu ' in script file   ' 2 0 0 ;RightLine
		LeftLine ;DisplayOutMenu ' 2. Change ' 2 0 0 ;DisplayOutMenu 'InternetCheck' 15 0 0 ;DisplayOutMenu ' to ' 2 0 0 ;DisplayOutMenu '=no' 15 0 0 ;DisplayOutMenu ' in bat file     ' 2 0 0 ;RightLine
		LeftLine ;DisplayOutMenu ' 3. Run Script or Bat file with ' 2 0 0 ;DisplayOutMenu '-sic' 15 0 0 ;DisplayOutMenu ' argument    ' 2 0 0 ;RightLine
		MenuBlankLine
		MenuLine
		AnyKeyClose
	}
}

Function UpdateDisplay([String]$FullVer,[String]$DFilename) {
	Clear-Host
	MenuLine
	LeftLine ;DisplayOutMenu '                  Update Found!'.PadRight(49) 13 0 0 ;RightLine
	MenuLine
	MenuBlankLine
	LeftLine ;DisplayOutMenu 'Downloading version ' 15 0 0 1 ;DisplayOutMenu $FullVer.PadRight(29) 11 0 0 ;RightLine
	LeftLine ;DisplayOutMenu 'Will run ' 15 0 0 ;DisplayOutMenu $DFilename.PadRight(40) 11 0 0 ;RightLine
	LeftLine ;DisplayOutMenu 'after download is complete.'.PadRight(49) 15 0 0 ;RightLine
	MenuBlankLine
	MenuLine
}

Function ScriptUpdateFun {
	$FullVer = "$WebScriptVer.$WebScriptMinorVer"
	$UpdateFile = $filebase + 'Update.bat'
	$UpArg = ''

	If($Accept_ToS -ne 1){ $UpArg += '-atos ' }
	If($InternetCheck -eq 1){ $UpArg += '-sic ' }
	If($CreateRestorePoint -eq 1){ $UpArg += '-crp ' }
	If($Restart -eq 0){ $UpArg += '-dnr' }
	If($RunScr){ $UpArg += "-run $TempSetting " } Else{ $UpArg += "-load $TempSetting " }

	If(Test-Path $UpdateFile -PathType Leaf) {
		$DFilename = 'Win10-Menu.ps1'
		$UpArg += '-u -w10 '
		If($Release_Type -ne 'Stable'){ $UpArg += '-test ' }
		UpdateDisplay $FullVer $DFilename
		cmd.exe /c "$UpdateFile $UpArg"
	} Else {
		$DFilename = 'Win10-Menu-Ver.' + $FullVer
		If($Release_Type -ne 'Stable'){ $DFilename += $WebScriptVer + '-Testing' ;$Script_Url = $URL_Base + 'Testing/' }
		$DFilename += '.ps1'
		UpdateDisplay $FullVer $DFilename
		$Script_Url = $URL_Base + 'Win10-Menu.ps1'
		$WebScriptFilePath = $filebase + $DFilename
		(New-Object System.Net.WebClient).DownloadFile($Script_Url, $WebScriptFilePath)
		$TempSetting = $TempFolder + '\TempSet.csv'
		SaveSettingFiles $TempSetting 0
		If($BatUpdateScriptFileName -eq 1) {
			$BatFile = $filebase + '_Win10-Script.bat'
			If(Test-Path -LiteralPath $BatFile -PathType Leaf) {
				(Get-Content -LiteralPath $BatFile) | Foreach-Object {$_ -replace "Set Script_File=.*?$" , "Set Script_File=$DFilename"} | Set-Content -LiteralPath $BatFile -Force
				MenuBlankLineLog
				LeftLineLog ;DisplayOutMenu ' Updated bat file with new script file name.     ' 13 0 0 1 ;RightLineLog
				MenuBlankLineLog
				MenuLineLog
			}
		}
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$WebScriptFilePath`" $UpArg" -Verb RunAs
	}
	Exit
}

Function InternetCheck{ If($InternetCheck -eq 1 -or (Test-Connection www.GitHub.com -Count 1 -Quiet)){ Return $True } Return $False }

##########
# Update Check -End
##########
# Multi Use Functions -Start
##########

Function ThanksDonate {
	DisplayOut "`nThanks for using my script." 11 0
	DisplayOut 'If you like this script please consider giving me a donation.' 11 0
	DisplayOut "`nLink to donation:" 15 0
	DisplayOut 'https://www.amazon.com/gp/registry/wishlist/YBAYWBJES5DE/' 2 0
}

Function cmpv { Compare-Object (Get-Variable -Scope Script) $AutomaticVariables -Property Name -PassThru | Where-Object -Property Name -ne 'AutomaticVariables' | Where-Object { $_ -NotIn $WPFList } }
Function Openwebsite([String]$Url){ [System.Diagnostics.Process]::Start($Url) }
Function ShowInvalid([Int]$InvalidA){ If($InvalidA -eq 1){ Write-Host "`nInvalid Input" -ForegroundColor Red -BackgroundColor Black -NoNewline } Return 0 }
Function CheckSetPath([String]$RPath){ While(!(Test-Path $RPath)){ New-Item -Path $RPath -Force | Out-Null } Return $RPath }
Function RemoveSetPath([String]$RPath){ If(Test-Path $RPath){ Remove-Item -Path $RPath -Recurse } }
Function DisplayOut([String]$TxtToDisplay,[Int]$TxtColor,[Int]$BGColor){ If($TxtColor -le 15){ Write-Host $TxtToDisplay -ForegroundColor $colors[$TxtColor] -BackgroundColor $colors[$BGColor] } Else{ Write-Host $TxtToDisplay } }
Function DisplayOutMenu([String]$TxtToDisplay,[Int]$TxtColor,[Int]$BGColor,[Int]$NewLine){ If($NewLine -eq 0){ Write-Host -NoNewline $TxtToDisplay -ForegroundColor $colors[$TxtColor] -BackgroundColor $colors[$BGColor] } Else{ Write-Host $TxtToDisplay -ForegroundColor $colors[$TxtColor] -BackgroundColor $colors[$BGColor] } }
Function StartOrGui{ If($RunScr -eq $True){ PreStartScript } ElseIf($AcceptToS -ne 1){ GuiStart } }

Function ScriptPreStart {
	If($PassedArg.Length -gt 0){ ArgCheck }
	If($AcceptToS -eq 1){ TOS } Else{ StartOrGui }
}

Function ArgCheck {
	For($i=0 ;$i -lt $PassedArg.Length ;$i++) {
		If($PassedArg[$i].StartsWith('-')) {
			$ArgVal = $PassedArg[$i].ToLower()
			$PasVal = $PassedArg[($i+1)]
			Switch($ArgVal) {
				'-run' { If(Test-Path -LiteralPath $PasVal -PathType Leaf) {
							LoadSettingFile $PasVal ;$Script:RunScr = $True
						} ElseIf($PasVal -eq 'wd' -or $PasVal -eq 'windefault') {
							LoadWinDefault ;$Script:RunScr = $True
						} ElseIf($PasVal.StartsWith('-')){ $Script:RunScr = $True} Break
				}
				'-load' { If(Test-Path -LiteralPath $PasVal -PathType Leaf){ LoadSettingFile $PasVal } ElseIf($PasVal -eq 'wd' -or $PasVal -eq 'windefault'){ LoadWinDefault } ;Break }
				'-sic' { $Script:InternetCheck = 1 ;Break }
				'-usc' { $Script:VersionCheck  = 1 ;Break }
				'-atos' { $Script:AcceptToS = 'Accepted-Switch' ;Break }
				'-dnr' { $Script:Restart = 0 ;Break }
				'-auto' { $Script:Automated = 1 ;$Script:AcceptToS = 'Accepted-Automated-Switch' ;Break }
				'-crp' { $Script:CreateRestorePoint = 1 ;If(!($PasVal.StartsWith('-'))){ $Script:RestorePointName = $PasVal } ;Break }
				{$_ -in'-help','-h'} { ShowHelp ;Break }
			}
		}
	}
}

Function ShowHelp {
	Clear-Host
	DisplayOut '                  List of Switches'.PadRight(53) 13 0
	DisplayOut ''.PadRight(53,'-') 14 0
	DisplayOut "`n-- Basic Switches --" 2 0
	DisplayOutMenu ' Switch ' 15 0 0 ;DisplayOut 'Description of Switch'.PadLeft(31) 14 0
	DisplayOutMenu '  -atos ' 15 0 0 ;DisplayOut 'Accepts ToS'.PadLeft(22) 14 0
	DisplayOutMenu '  -auto ' 15 0 0 ;DisplayOutMenu '           Implies ' 14 0 0 ;DisplayOutMenu '-atos' 15 0 0 ;DisplayOut '...Runs the script to be Automated.. Closes on - User Input, Errors, or End of Script' 14 0
	DisplayOutMenu '  -crp  ' 15 0 0 ;DisplayOut '           Creates Restore Point' 14 0
	DisplayOutMenu '  -dnr  ' 15 0 0 ;DisplayOut '           Do Not Restart when done' 14 0
	DisplayOut "`n-- Run Script Switches --" 2 0
	DisplayOutMenu ' Switch ' 15 0 0 ;DisplayOut 'Description of Switch'.PadLeft(31) 14 0
	DisplayOutMenu '  -run  ' 15 0 0 ;DisplayOut '           Runs script with settings in script' 14 0
	DisplayOutMenu '  -run ' 15 0 0 ;DisplayOutMenu 'FILENAME ' 11 0 0 ;DisplayOutMenu '   Runs script with settings in the file' 14 0 0 ;DisplayOut ' FILENAME' 11 0
	DisplayOutMenu '  -run wd ' 15 0 0 ;DisplayOut '         Runs script with win default settings' 14 0
	DisplayOut "`n-- Load Script Switches --" 2 0
	DisplayOutMenu ' Switch ' 15 0 0 ;DisplayOut 'Description of Switch'.PadLeft(31) 14 0
	DisplayOutMenu '  -load ' 15 0 0 ;DisplayOutMenu 'FILENAME ' 11 0 0 ;DisplayOutMenu '  Loads script with settings in the file' 14 0 0 ;DisplayOut ' FILENAME' 11 0
	DisplayOutMenu '  -load wd ' 15 0 0 ;DisplayOut '        Loads script with win default settings' 14 0
	DisplayOut "`n--Update Switches--" 2 0
	DisplayOutMenu ' Switch ' 15 0 0 ;DisplayOut 'Description of Switch'.PadLeft(31) 14 0
	DisplayOutMenu '  -usc  ' 15 0 0 ;DisplayOut '           Checks for Update to Script file before running' 14 0
	DisplayOutMenu '  -sic  ' 15 0 0 ;DisplayOut '           Skips Internet Check' 14 0
	AnyKeyClose
	Exit
}

Function TOSDisplay {
	Clear-Host
	$BorderColor = 14
	If($Release_Type -eq 'Testing') {
		$BorderColor = 15
		TOSLine 15
		DisplayOutMenu '|'.PadRight(20) 15 0 0 ;DisplayOutMenu 'WARNING!!'.PadRight(32) 13 0 0 ;DisplayOut '|' 15 0
		TOSBlankLine 15
		DisplayOutMenu '|' 15 0 0 ;DisplayOutMenu '     This version is currently being Tested.'.PadRight(51) 14 0 0 ;DisplayOut '|' 15 0
		TOSBlankLine 15
	}
	TOSLine $BorderColor
	DisplayOutMenu '|'.PadRight(20) $BorderColor 0 0 ;DisplayOutMenu 'Terms of Use'.PadRight(32) 11 0 0 ;DisplayOut '|' $BorderColor 0
	TOSLine $BorderColor
	TOSBlankLine $BorderColor
	DisplayOutMenu '|' $BorderColor 0 0 ;DisplayOutMenu ' This program comes with ABSOLUTELY NO WARRANTY.   ' 2 0 0 ;DisplayOut '|' $BorderColor 0
	DisplayOutMenu '|' $BorderColor 0 0 ;DisplayOutMenu ' This is free software, and you are welcome to     ' 2 0 0 ;DisplayOut '|' $BorderColor 0
	DisplayOutMenu '|' $BorderColor 0 0 ;DisplayOutMenu ' redistribute it under certain conditions.         ' 2 0 0 ;DisplayOut '|' $BorderColor 0
	TOSBlankLine $BorderColor
	DisplayOutMenu '|' $BorderColor 0 0 ;DisplayOutMenu ' Read License file for full Terms.'.PadRight(51) 2 0 0 ;DisplayOut '|' $BorderColor 0
	TOSBlankLine $BorderColor
	TOSLine $BorderColor
}

Function TOS {
	While($TOS -ne 'Out') {
		TOSDisplay
		$Invalid = ShowInvalid $Invalid
		$TOS = Read-Host "`nDo you Accept? (Y)es/(N)o"
		Switch($TOS.ToLower()) {
			{$_ -in 'n','no'} { Exit ;Break }
			{$_ -in 'y','yes'} { $Script:AcceptToS = 'Accepted-Script' ;$TOS = 'Out' ;StartOrGui ;Break }
			Default {$Invalid = 1}
		}
	} Return
}

Function LoadSettingFile([String]$Filename) {
	Import-Csv -LiteralPath $Filename -Delimiter ';' | ForEach-Object { Set-Variable $_.Name $_.Value -Scope Script }
	[System.Collections.ArrayList]$Script:APPS_AppsUnhide = $AppsUnhide.Split(',')
	[System.Collections.ArrayList]$Script:APPS_AppsHidel = $AppsHide.Split(',')
	[System.Collections.ArrayList]$Script:APPS_AppsUninstall = $AppsUninstall.Split(',')
}

Function SaveSettingFiles([String]$Filename) {
	ForEach($temp In $APPS_AppsUnhide){$Script:AppsUnhide += $temp + ','}
	ForEach($temp In $APPS_AppsHide){$Script:AppsHide += $temp + ','}
	ForEach($temp In $APPS_Uninstall){$Script:AppsUninstall += $temp + ','}
	If(Test-Path -LiteralPath $Filename -PathType Leaf) {
		If($ShowConf -eq 1){ $Conf = ConfirmMenu 2 } Else{ $Conf = $True }
		If($Conf){ cmpv | Select-Object Name,Value | Export-Csv -LiteralPath $Filename -Encoding 'unicode' -Force -Delimiter ';' }
	} Else {
		cmpv | Select-Object Name,Value | Export-Csv -LiteralPath $Filename -Encoding 'unicode' -Force -Delimiter ';'
	}
}

##########
# Multi Use Functions -End
##########
# GUI -Start
##########

Function Update-Window {
	[cmdletBinding()]
	Param($Control, $Property, $Value, [Switch]$AppendContent)
	If($Property -eq 'Close'){ $syncHash.Window.Dispatcher.invoke([action]{$syncHash.Window.Close()},'Normal') ;Return }
	$form.Dispatcher.Invoke([Action]{ If($PSBoundParameters['AppendContent']){ $Control.AppendText($Value) } Else{ $Control.$Property = $Value } }, 'Normal')
}

Function SetCombo([String]$Name,[String]$Item) {
	$Items = $Item.Split(',')
	$combo =  $(Get-Variable -Name ('WPF_'+$Name+'_Combo') -ValueOnly)
	[void] $combo.Items.Add('Skip')
	ForEach($CmbItm In $Items){ [void] $combo.Items.Add($CmbItm) }
	SelectComboBoxGen $Name $(Get-Variable -Name $Name -ValueOnly)
}

Function SetComboM([String]$Name,[String]$Item) {
	$Items = $Item.Split(',')
	$combo =  $(Get-Variable -Name ('WPF_'+$Name+'_Combo') -ValueOnly)
	[void] $combo.Items.Add('Skip')
	ForEach($CmbItm In $Items){ [void] $combo.Items.Add($CmbItm) }
	Switch($Name) {
		'AllMetro' { $WPF_AllMetro_Combo.SelectedIndex = 0 ;Break }
		'APP_SkypeApp' { $WPF_APP_SkypeApp_Combo.SelectedIndex = $APP_SkypeApp1 ;Break }
		'APP_WindowsFeedbak' { $WPF_APP_WindowsFeedbak_Combo.SelectedIndex = $APP_WindowsFeedbak1 ;Break }
		'APP_Zune' { $WPF_APP_Zune_Combo.SelectedIndex = $APP_ZuneMusic ;Break }
		Default { SelectComboBoxGen $Name $(Get-Variable -Name $Name -ValueOnly) ;Break }
	}
}

Function RestorePointCBCheck {
	If($CreateRestorePoint -eq 1) {
		$WPF_CreateRestorePoint_CB.IsChecked = $True
		$WPF_RestorePointName_Txt.IsEnabled = $True
	} Else {
		$WPF_CreateRestorePoint_CB.IsChecked = $False
		$WPF_RestorePointName_Txt.IsEnabled = $False
	}
}

Function ConfigGUIitms {
	If($CreateRestorePoint -eq 1){ $WPF_CreateRestorePoint_CB.IsChecked = $True } Else{ $WPF_CreateRestorePoint_CB.IsChecked = $False }
	If($VersionCheck -eq 1){ $WPF_VersionCheck_CB.IsChecked = $True } Else{ $WPF_VersionCheck_CB.IsChecked = $False }
	If($InternetCheck -eq 1){ $WPF_InternetCheck_CB.IsChecked = $True } Else{ $WPF_InternetCheck_CB.IsChecked = $False }
	If($ShowSkipped -eq 1){ $WPF_ShowSkipped_CB.IsChecked = $True } Else{ $WPF_ShowSkipped_CB.IsChecked = $False }
	If($Restart -eq 1){ $WPF_Restart_CB.IsChecked = $True } Else{ $WPF_Restart_CB.IsChecked = $False }
	$WPF_RestorePointName_Txt.Text = $RestorePointName
	RestorePointCBCheck
}

Function SelectComboBox([Array]$List,[Int]$Metro) {
	If($Metro -eq 1) {
		ForEach($Var In $List) {
			Switch($Var) {
				'APP_SkypeApp' { $WPF_APP_SkypeApp_Combo.SelectedIndex = $APP_SkypeApp1 ;Break }
				'APP_WindowsFeedbak' { $WPF_APP_WindowsFeedbak_Combo.SelectedIndex = $APP_WindowsFeedbak1 ;Break }
				'APP_Zune' { $WPF_APP_Zune_Combo.SelectedIndex = $APP_ZuneMusic ;Break }
				Default { SelectComboBoxGen $Var $(Get-Variable -Name $Var -ValueOnly) ;Break }
			}
		}
	} Else{ ForEach($Var In $List){ SelectComboBoxGen $Var $(Get-Variable -Name $Var -ValueOnly) } }
}
Function SelectComboBoxAllMetro([Int]$Numb){ ForEach($Var In $ListApp){ SelectComboBoxGen $Var $Numb } }
Function SelectComboBoxGen([String]$Name,[Int]$Numb){ $(Get-Variable -Name ('WPF_'+$Name+'_Combo') -ValueOnly).SelectedIndex = $Numb }

Function AppAraySet([String]$Get) {
	[System.Collections.ArrayList]$ListTMP = Get-Variable -Name $Get
	[System.Collections.ArrayList]$List = @()
	If($Get -eq 'WPF_*_Combo'){
		ForEach($Var In $ListTMP){ If(!($Var.Name -like 'WPF_APP_*')){ $List += $Var.Name.Split('_')[1] } }
		$List.Remove('AllMetro')
	} Else {
		ForEach($Var In $ListTMP){ $List += $Var.Name }
		$List.Remove('APP_SkypeApp1')
		$List.Remove('APP_SkypeApp2')
		$List.Remove('APP_WindowsFeedbak1')
		$List.Remove('APP_WindowsFeedbak2')
		$List.Remove('APP_ZuneMusic')
		$List.Remove('APP_ZuneVideo')
		$List.Add('APP_SkypeApp') | Out-Null
		$List.Add('APP_WindowsFeedbak') | Out-Null
		$List.Add('APP_Zune') | Out-Null
	} Return $List
}

Function OpenSaveDiaglog([Int]$SorO) {
	If($SorO -eq 0){ $SOFileDialog = New-Object System.Windows.Forms.OpenFileDialog } Else{ $SOFileDialog = New-Object System.Windows.Forms.SaveFileDialog }
	$SOFileDialog.InitialDirectory = $filebase
	$SOFileDialog.Filter = "CSV (*.csv)| *.csv"
	$SOFileDialog.ShowDialog() | Out-Null
	If($SorO -eq 0){ LoadSettingFile $SOFileDialog.Filename ;ConfigGUIitms ;SelectComboBox $VarList 0 ;SelectComboBox $ListApp 1 } Else{ GuiItmToVariable ;SaveSettingFiles $SOFileDialog.Filename }
}

Function GuiStart {
	Clear-Host
	DisplayOutMenu 'Preparing GUI, Please wait...' 15 0 1 0

[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" x:Name="Win10_Script"
Title="Windows 10 Settings/Tweaks Script By: Madbomb122" Height="405" Width="550" BorderBrush="Black" Background="White">
	<Window.Resources>
		<Style x:Key="SeparatorStyle1" TargetType="{x:Type Separator}">
			<Setter Property="SnapsToDevicePixels" Value="True"/>
			<Setter Property="Margin" Value="0,0,0,0"/>
			<Setter Property="Template">
				<Setter.Value> <ControlTemplate TargetType="{x:Type Separator}"><Border Height="24" SnapsToDevicePixels="True" Background="#FF4D4D4D" BorderBrush="#FF4D4D4D" BorderThickness="0,0,0,1"/></ControlTemplate></Setter.Value>
			</Setter>
		</Style>
		<Style TargetType="{x:Type ToolTip}"><Setter Property="Background" Value="#FFFFFFBF"/></Style>
	</Window.Resources>
	<Window.Effect><DropShadowEffect/></Window.Effect>
	<Grid>
		<Menu Height="22" VerticalAlignment="Top">
			<MenuItem Header="Help" Height="22" Width="34" Padding="3,0,0,0">
				<MenuItem Name="FeedbackButton" Header="Feedback/Bug Report" Height="22" Background="#FFF0F0F0" Padding="-20,0,-40,0"/>
				<MenuItem Name="FAQButton" Header="FAQ" Height="22" Padding="-20,0,0,0" Background="#FFF0F0F0"/>
				<MenuItem Name="AboutButton" Header="About" Height="22" Padding="-20,0,0,0" Background="#FFF0F0F0"/>
				<MenuItem Name="CopyrightButton" Header="Copyright" Height="22" Padding="-20,0,0,0" Background="#FFF0F0F0"/><Separator Height="2" Margin="-30,0,0,0"/>
				<MenuItem Name="ContactButton" Header="Contact Me" Height="22" Padding="-20,0,0,0" Background="#FFF0F0F0"/>
			</MenuItem>
			<Separator Width="2" Style="{DynamicResource SeparatorStyle1}"/>
			<MenuItem Name="DonateButton" Header="Donate to Me" Height="24" Width="88" Background="#FFFFAD2F" FontWeight="Bold" Margin="-1,-1,0,0"/>
			<MenuItem Name="Madbomb122WSButton" Header="Madbomb122's GitHub" Height="24" Width="142" Background="#FFFFDF4F" FontWeight="Bold"/>
		</Menu>
		<TabControl Name="TabControl" Margin="0,22,0,21">
			<TabItem Name="Services_Tab" Header="Script Options" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<CheckBox Name="CreateRestorePoint_CB" Content="Create Restore Point:" HorizontalAlignment="Left" Margin="8,10,0,0" VerticalAlignment="Top"/>
					<TextBox Name="RestorePointName_Txt" HorizontalAlignment="Left" Height="20" Margin="139,9,0,0" TextWrapping="Wrap" Text="Win10 Initial Setup Script" VerticalAlignment="Top" Width="188"/>
					<CheckBox Name="ShowSkipped_CB" Content="Show Skipped Items" HorizontalAlignment="Left" Margin="8,29,0,0" VerticalAlignment="Top"/>
					<CheckBox Name="Restart_CB" Content="Restart When Done" HorizontalAlignment="Left" Margin="8,49,0,0" VerticalAlignment="Top"/>
					<CheckBox Name="VersionCheck_CB" Content="Check for Update (If update found, will run and use current settings)" HorizontalAlignment="Left" Margin="8,69,0,0" VerticalAlignment="Top"/>
					<CheckBox Name="BatUpdateScriptFileName_CB" Content="Update Bat file with new Script filename" HorizontalAlignment="Left" Margin="8,89,0,0" VerticalAlignment="Top" Height="15" Width="450"/>
					<CheckBox Name="InternetCheck_CB" Content="Skip Internet Check" HorizontalAlignment="Left" Margin="8,109,0,0" VerticalAlignment="Top"/>
					<Button Name="Save_Setting_Button" Content="Save Settings" HorizontalAlignment="Left" Margin="100,133,0,0" VerticalAlignment="Top" Width="77"/>
					<Button Name="Load_Setting_Button" Content="Load Settings" HorizontalAlignment="Left" Margin="8,133,0,0" VerticalAlignment="Top" Width="77"/>
					<Button Name="WinDefault_Button" Content="Windows Default*" HorizontalAlignment="Left" Margin="192,133,0,0" VerticalAlignment="Top" Width="100"/>
					<Button Name="ResetDefault_Button" Content="Reset All Items" HorizontalAlignment="Left" Margin="306,133,0,0" VerticalAlignment="Top" Width="85"/>
					<Label Content="Notes:&#xD;&#xA;Options with items marked with * means &quot;Windows Default&quot;&#xA;Windows Default Button does not change Metro Apps or OneDrive Install" HorizontalAlignment="Left" Margin="8,160,0,0" VerticalAlignment="Top" FontStyle="Italic"/>
					<Label Content="Script Version:" HorizontalAlignment="Left" Margin="8,218,0,0" VerticalAlignment="Top" Height="25"/>
					<TextBox Name="Script_Ver_Txt" HorizontalAlignment="Left" Height="20" Margin="90,222,0,0" TextWrapping="Wrap" Text="2.8.0 (6-21-2017)" VerticalAlignment="Top" Width="124" IsEnabled="False"/>
					<TextBox Name="Release_Type_Txt" HorizontalAlignment="Left" Height="20" Margin="214,222,0,0" TextWrapping="Wrap" Text="Testing" VerticalAlignment="Top" Width="50" IsEnabled="False"/>
				</Grid>
			</TabItem>
			<TabItem Name="Privacy_tab" Header="Privacy" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Telemetry:" HorizontalAlignment="Left" Margin="67,10,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Telemetry_Combo" HorizontalAlignment="Left" Margin="128,13,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Wi-Fi Sense:" HorizontalAlignment="Left" Margin="57,37,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WiFiSense_Combo" HorizontalAlignment="Left" Margin="128,40,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="SmartScreen Filter:" HorizontalAlignment="Left" Margin="21,64,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="SmartScreen_Combo" HorizontalAlignment="Left" Margin="127,67,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Location Tracking:" HorizontalAlignment="Left" Margin="25,91,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="LocationTracking_Combo" HorizontalAlignment="Left" Margin="127,94,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Feedback:" HorizontalAlignment="Left" Margin="67,118,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Feedback_Combo" HorizontalAlignment="Left" Margin="127,121,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Advertising ID:" HorizontalAlignment="Left" Margin="43,145,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AdvertisingID_Combo" HorizontalAlignment="Left" Margin="127,148,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Cortana:" HorizontalAlignment="Left" Margin="341,10,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Cortana_Combo" HorizontalAlignment="Left" Margin="392,13,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Cortana Search:" HorizontalAlignment="Left" Margin="302,37,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="CortanaSearch_Combo" HorizontalAlignment="Left" Margin="392,40,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Error Reporting:" HorizontalAlignment="Left" Margin="301,64,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ErrorReporting_Combo" HorizontalAlignment="Left" Margin="392,67,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="AutoLogger:" HorizontalAlignment="Left" Margin="320,91,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AutoLoggerFile_Combo" HorizontalAlignment="Left" Margin="392,94,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Diagnostics Tracking:" HorizontalAlignment="Left" Margin="274,118,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="DiagTrack_Combo" HorizontalAlignment="Left" Margin="392,121,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="WAP Push:" HorizontalAlignment="Left" Margin="329,145,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WAPPush_Combo" HorizontalAlignment="Left" Margin="392,148,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="App Auto Download:" HorizontalAlignment="Left" Margin="274,172,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AppAutoDownload_Combo" HorizontalAlignment="Left" Margin="392,175,0,0" VerticalAlignment="Top" Width="72"/>
				</Grid>
			</TabItem>
			<TabItem Name="SrvTweak_Tab" Header="Service Tweaks" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="UAC Level:" HorizontalAlignment="Left" Margin="79,10,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="UAC_Combo" HorizontalAlignment="Left" Margin="142,13,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Sharing mapped drives:" HorizontalAlignment="Left" Margin="10,37,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="SharingMappedDrives_Combo" HorizontalAlignment="Left" Margin="142,40,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Administrative Shares:" HorizontalAlignment="Left" Margin="18,64,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AdminShares_Combo" HorizontalAlignment="Left" Margin="142,67,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Firewall:" HorizontalAlignment="Left" Margin="93,91,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Firewall_Combo" HorizontalAlignment="Left" Margin="142,94,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Windows Defender:" HorizontalAlignment="Left" Margin="31,118,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WinDefender_Combo" HorizontalAlignment="Left" Margin="142,121,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="HomeGroups:" HorizontalAlignment="Left" Margin="62,145,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="HomeGroups_Combo" HorizontalAlignment="Left" Margin="142,148,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Remote Assistance:" HorizontalAlignment="Left" Margin="34,172,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="RemoteAssistance_Combo" HorizontalAlignment="Left" Margin="142,175,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Remote Desktop w/o &#xD;&#xA;Network Authentication:" HorizontalAlignment="Left" Margin="7,196,0,0" VerticalAlignment="Top" Width="138" Height="39"/>
					<ComboBox Name="RemoteDesktop_Combo" HorizontalAlignment="Left" Margin="142,205,0,0" VerticalAlignment="Top" Width="72"/>
				</Grid>
			</TabItem>
			<TabItem Name="Context_Tab" Header="Context Menu/Start Menu" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Context Menu" HorizontalAlignment="Left" Margin="82,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Label Content="Cast to Device:" HorizontalAlignment="Left" Margin="43,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="CastToDevice_Combo" HorizontalAlignment="Left" Margin="128,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Previous Versions:" HorizontalAlignment="Left" Margin="26,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PreviousVersions_Combo" HorizontalAlignment="Left" Margin="128,61,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Include in Library:" HorizontalAlignment="Left" Margin="28,84,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="IncludeinLibrary_Combo" HorizontalAlignment="Left" Margin="128,88,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Pin To Start:" HorizontalAlignment="Left" Margin="59,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PinToStart_Combo" HorizontalAlignment="Left" Margin="128,115,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Pin To Quick Access:" HorizontalAlignment="Left" Margin="14,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PinToQuickAccess_Combo" HorizontalAlignment="Left" Margin="128,142,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Share With/Share:" HorizontalAlignment="Left" Margin="26,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ShareWith_Combo" HorizontalAlignment="Left" Margin="128,169,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Send To:" HorizontalAlignment="Left" Margin="76,193,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="SendTo_Combo" HorizontalAlignment="Left" Margin="128,196,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Start Menu" HorizontalAlignment="Left" Margin="352,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Rectangle Fill="#FFFFFFFF" HorizontalAlignment="Left" Margin="254,0,0,-2" Stroke="Black" Width="1"/>
					<Label Content="Bing Search in Start Menu:" HorizontalAlignment="Left" Margin="293,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="StartMenuWebSearch_Combo" HorizontalAlignment="Left" Margin="439,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Start Suggestions:" HorizontalAlignment="Left" Margin="337,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="StartSuggestions_Combo" HorizontalAlignment="Left" Margin="439,88,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Most Used Apps:" HorizontalAlignment="Left" Margin="342,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="MostUsedAppStartMenu_Combo" HorizontalAlignment="Left" Margin="439,115,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Recent Items &amp; Frequent Places:" HorizontalAlignment="Left" Margin="262,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="RecentItemsFrequent_Combo" HorizontalAlignment="Left" Margin="439,61,0,0" VerticalAlignment="Top" Width="72"/>
                    <Label Content="Unpin All Items:" HorizontalAlignment="Left" Margin="349,139,0,0" VerticalAlignment="Top"/>
                    <ComboBox Name="UnpinItems_Combo" HorizontalAlignment="Left" Margin="439,142,0,0" VerticalAlignment="Top" Width="72"/>
				</Grid>
			</TabItem>
			<TabItem Name="TaskBar_Tab" Header="Task Bar" Margin="-3,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Battery UI Bar:" HorizontalAlignment="Left" Margin="61,10,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="BatteryUIBar_Combo" HorizontalAlignment="Left" Margin="143,13,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Clock UI Bar:" HorizontalAlignment="Left" Margin="69,37,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ClockUIBar_Combo" HorizontalAlignment="Left" Margin="143,40,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Volume Control Bar:" HorizontalAlignment="Left" Margin="277,118,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="VolumeControlBar_Combo" HorizontalAlignment="Left" Margin="390,121,0,0" VerticalAlignment="Top" Width="120"/>
					<Label Content="Taskbar Search box:" HorizontalAlignment="Left" Margin="33,64,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskbarSearchBox_Combo" HorizontalAlignment="Left" Margin="143,67,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Task View button:" HorizontalAlignment="Left" Margin="44,91,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskViewButton_Combo" HorizontalAlignment="Left" Margin="143,94,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Taskbar Icon Size:" HorizontalAlignment="Left" Margin="291,37,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskbarIconSize_Combo" HorizontalAlignment="Left" Margin="390,40,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Taskbar Item Grouping:" HorizontalAlignment="Left" Margin="260,64,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskbarGrouping_Combo" HorizontalAlignment="Left" Margin="390,67,0,0" VerticalAlignment="Top" Width="90"/>
					<Label Content="Tray Icons:" HorizontalAlignment="Left" Margin="328,10,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TrayIcons_Combo" HorizontalAlignment="Left" Margin="390,13,0,0" VerticalAlignment="Top" Width="97"/>
					<Label Content="Seconds In Clock:" HorizontalAlignment="Left" Margin="44,118,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="SecondsInClock_Combo" HorizontalAlignment="Left" Margin="143,121,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Last Active Click:" HorizontalAlignment="Left" Margin="49,145,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="LastActiveClick_Combo" HorizontalAlignment="Left" Margin="143,148,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Taskbar on Multi Display:" HorizontalAlignment="Left" Margin="252,91,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskBarOnMultiDisplay_Combo" HorizontalAlignment="Left" Margin="390,94,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Taskbar Button on Multi Display:" HorizontalAlignment="Left" Margin="13,172,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskbarButtOnDisplay_Combo" HorizontalAlignment="Left" Margin="190,175,0,0" VerticalAlignment="Top" Width="197"/>
				</Grid>
			</TabItem>
			<TabItem Name="Explorer_Tab" Header="Explorer" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Process ID on Title Bar:" HorizontalAlignment="Left" Margin="308,120,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PidInTitleBar_Combo" HorizontalAlignment="Left" Margin="436,123,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Aero Snap:" HorizontalAlignment="Left" Margin="69,38,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AeroSnap_Combo" HorizontalAlignment="Left" Margin="133,41,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Aero Shake:" HorizontalAlignment="Left" Margin="63,66,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="AeroShake_Combo" HorizontalAlignment="Left" Margin="133,69,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Known Extensions:" HorizontalAlignment="Left" Margin="331,147,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="KnownExtensions_Combo" HorizontalAlignment="Left" Margin="436,150,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Hidden Files:" HorizontalAlignment="Left" Margin="58,120,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="HiddenFiles_Combo" HorizontalAlignment="Left" Margin="133,123,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="System Files:" HorizontalAlignment="Left" Margin="59,147,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="SystemFiles_Combo" HorizontalAlignment="Left" Margin="133,150,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Default Explorer View:" HorizontalAlignment="Left" Margin="10,201,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ExplorerOpenLoc_Combo" HorizontalAlignment="Left" Margin="133,204,0,0" VerticalAlignment="Top" Width="102"/>
					<Label Content="Recent Files in Quick Access:" HorizontalAlignment="Left" Margin="279,11,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="RecentFileQikAcc_Combo" HorizontalAlignment="Left" Margin="436,14,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Frequent folders in Quick_access:" HorizontalAlignment="Left" Margin="259,39,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="FrequentFoldersQikAcc_Combo" HorizontalAlignment="Left" Margin="436,41,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Window Content while Dragging:" HorizontalAlignment="Left" Margin="253,66,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WinContentWhileDrag_Combo" HorizontalAlignment="Left" Margin="436,69,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Autoplay:" HorizontalAlignment="Left" Margin="76,11,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Autoplay_Combo" HorizontalAlignment="Left" Margin="133,14,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Autorun:" HorizontalAlignment="Left" Margin="80,93,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Autorun_Combo" HorizontalAlignment="Left" Margin="133,96,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Search Store for Unkn. Extensions:" HorizontalAlignment="Left" Margin="249,94,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="StoreOpenWith_Combo" HorizontalAlignment="Left" Margin="436,96,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Task Manager Details:" HorizontalAlignment="Left" Margin="315,175,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="TaskManagerDetails_Combo" HorizontalAlignment="Left" Margin="436,177,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Powershell to Cmd:" HorizontalAlignment="Left" Margin="24,228,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WinXPowerShell_Combo" HorizontalAlignment="Left" Margin="133,231,0,0" VerticalAlignment="Top" Width="127"/>
					<Label Name="ReopenAppsOnBoot_Txt" Content="Reopen Apps On Boot:" HorizontalAlignment="Left" Margin="309,203,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ReopenAppsOnBoot_Combo" HorizontalAlignment="Left" Margin="436,205,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Name="TimeLine_Txt" Content="Window Timeline:" HorizontalAlignment="Left" Margin="336,231,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="Timeline_Combo" HorizontalAlignment="Left" Margin="436,233,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Long File Path:" HorizontalAlignment="Left" Margin="49,174,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="LongFilePath_Combo" HorizontalAlignment="Left" Margin="133,177,0,0" VerticalAlignment="Top" Width="72"/>
				</Grid>
			</TabItem>
			<TabItem Name="Desktop_Tab" Header="Desktop/This PC" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Desktop" HorizontalAlignment="Left" Margin="99,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Label Content="This PC Icon:" HorizontalAlignment="Left" Margin="54,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ThisPCOnDesktop_Combo" HorizontalAlignment="Left" Margin="128,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Network Icon:" HorizontalAlignment="Left" Margin="47,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="NetworkOnDesktop_Combo" HorizontalAlignment="Left" Margin="128,61,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Recycle Bin Icon:" HorizontalAlignment="Left" Margin="34,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="RecycleBinOnDesktop_Combo" HorizontalAlignment="Left" Margin="128,88,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Users File Icon:" HorizontalAlignment="Left" Margin="42,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="UsersFileOnDesktop_Combo" HorizontalAlignment="Left" Margin="128,115,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Control Panel Icon:" HorizontalAlignment="Left" Margin="21,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ControlPanelOnDesktop_Combo" HorizontalAlignment="Left" Margin="128,142,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Desktop Folder:" HorizontalAlignment="Left" Margin="302,31,0,0" VerticalAlignment="Top"/>
					<Rectangle Fill="#FFFFFFFF" HorizontalAlignment="Left" Margin="254,0,0,-2" Stroke="Black" Width="1"/>
					<Label Content="This PC" HorizontalAlignment="Left" Margin="364,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<ComboBox Name="DesktopIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,34,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Content="Documents Folder:" HorizontalAlignment="Left" Margin="285,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="DocumentsIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,61,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Content="Downloads Folder:" HorizontalAlignment="Left" Margin="287,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="DownloadsIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,88,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Content="Music Folder:" HorizontalAlignment="Left" Margin="315,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="MusicIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,115,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Content="Pictures Folder:" HorizontalAlignment="Left" Margin="304,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PicturesIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,142,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Content="Videos Folder:" HorizontalAlignment="Left" Margin="310,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="VideosIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,169,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Name="ThreeDobjectsIconInThisPC_Txt" Content="3D Objects Folder:" HorizontalAlignment="Left" Margin="288,194,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ThreeDobjectsIconInThisPC_Combo" HorizontalAlignment="Left" Margin="392,197,0,0" VerticalAlignment="Top" Width="88"/>
					<Label Content="**Remove may cause problems with a few things" HorizontalAlignment="Left" Margin="255,216,0,0" VerticalAlignment="Top"/>
				</Grid>
			</TabItem>
			<TabItem Name="Misc_Tab" Header="Misc/Photo Viewer/LockScreen" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Misc" HorizontalAlignment="Left" Margin="109,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Label Content="Action Center:" HorizontalAlignment="Left" Margin="46,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="ActionCenter_Combo" HorizontalAlignment="Left" Margin="128,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Sticky Key Prompt:" HorizontalAlignment="Left" Margin="23,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="StickyKeyPrompt_Combo" HorizontalAlignment="Left" Margin="128,61,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Num Lock on Startup:" HorizontalAlignment="Left" Margin="6,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="NumblockOnStart_Combo" HorizontalAlignment="Left" Margin="128,88,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="F8 Boot Menu:" HorizontalAlignment="Left" Margin="44,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="F8BootMenu_Combo" HorizontalAlignment="Left" Margin="128,115,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Remote UAC Local &#xD;&#xA;Account Token Filter:" HorizontalAlignment="Left" Margin="11,187,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="RemoteUACAcctToken_Combo" HorizontalAlignment="Left" Margin="128,197,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Hibernate Option:" HorizontalAlignment="Left" Margin="26,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="HibernatePower_Combo" HorizontalAlignment="Left" Margin="128,142,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Sleep Option:" HorizontalAlignment="Left" Margin="49,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="SleepPower_Combo" HorizontalAlignment="Left" Margin="128,169,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Photo Viewer" HorizontalAlignment="Left" Margin="346,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Rectangle Fill="#FFFFFFFF" HorizontalAlignment="Left" Margin="254,0,0,-2" Stroke="Black" Width="1"/>
					<Label Content="File Association:" HorizontalAlignment="Left" Margin="301,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PVFileAssociation_Combo" HorizontalAlignment="Left" Margin="392,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Add &quot;Open with...&quot;:" HorizontalAlignment="Left" Margin="285,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PVOpenWithMenu_Combo" HorizontalAlignment="Left" Margin="392,61,0,0" VerticalAlignment="Top" Width="72"/>
					<Rectangle Fill="#FFFFFFFF" Height="1" Margin="254,106,0,0" Stroke="Black" VerticalAlignment="Top"/>
					<Label Content="Lockscreen" HorizontalAlignment="Left" Margin="352,111,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Label Content="Lockscreen:" HorizontalAlignment="Left" Margin="323,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="LockScreen_Combo" HorizontalAlignment="Left" Margin="392,142,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Power Menu:" HorizontalAlignment="Left" Margin="316,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="PowerMenuLockScreen_Combo" HorizontalAlignment="Left" Margin="392,169,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Camera:" HorizontalAlignment="Left" Margin="342,193,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="CameraOnLockscreen_Combo" HorizontalAlignment="Left" Margin="392,196,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Name="AccountProtectionWarn_Txt" Content="Account Protection Warning:" HorizontalAlignment="Left" Margin="9,227,0,0" VerticalAlignment="Top" Width="166"/>
					<ComboBox Name="AccountProtectionWarn_Combo" HorizontalAlignment="Left" Margin="168,229,0,0" VerticalAlignment="Top" Width="72"/>
				</Grid>
			</TabItem>
			<TabItem Name="MetroApp_Tab" Header="Metro App" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Set All Metro Apps:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="72,2,0,0"/>
					<Rectangle Fill="#FFFFFFFF" Height="1" Margin="0,29,0,0" Stroke="Black" VerticalAlignment="Top" HorizontalAlignment="Left" Width="347"/>
					<ComboBox Name="AllMetro_Combo" HorizontalAlignment="Left" Margin="181,4,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="3DBuilder:" HorizontalAlignment="Left" Margin="32,32,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_3DBuilder_Combo" HorizontalAlignment="Left" Margin="94,35,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="3DViewer:" HorizontalAlignment="Left" Margin="34,56,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_3DViewer_Combo" HorizontalAlignment="Left" Margin="94,59,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Bing Weather:" HorizontalAlignment="Left" Margin="12,80,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_BingWeather_Combo" HorizontalAlignment="Left" Margin="94,83,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Phone App:" HorizontalAlignment="Left" Margin="26,104,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_CommsPhone_Combo" HorizontalAlignment="Left" Margin="94,107,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Calendar &amp; Mail:" HorizontalAlignment="Left" Margin="-1,128,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_Communications_Combo" HorizontalAlignment="Left" Margin="94,131,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Getting Started:" HorizontalAlignment="Left" Margin="4,152,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_Getstarted_Combo" HorizontalAlignment="Left" Margin="94,155,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Messaging App:" HorizontalAlignment="Left" Margin="2,176,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_Messaging_Combo" HorizontalAlignment="Left" Margin="94,179,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Get Office:" HorizontalAlignment="Left" Margin="31,203,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_MicrosoftOffHub_Combo" HorizontalAlignment="Left" Margin="94,203,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Movie Moments:" HorizontalAlignment="Left" Margin="-2,224,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_MovieMoments_Combo" HorizontalAlignment="Left" Margin="94,227,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Netflix:" HorizontalAlignment="Left" Margin="225,32,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_Netflix_Combo" HorizontalAlignment="Left" Margin="269,35,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Office OneNote:" HorizontalAlignment="Left" Margin="173,56,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_OfficeOneNote_Combo" HorizontalAlignment="Left" Margin="269,59,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Office Sway:" HorizontalAlignment="Left" Margin="198,80,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_OfficeSway_Combo" HorizontalAlignment="Left" Margin="269,83,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="One Connect:" HorizontalAlignment="Left" Margin="190,104,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_OneConnect_Combo" HorizontalAlignment="Left" Margin="269,107,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="People:" HorizontalAlignment="Left" Margin="224,128,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_People_Combo" HorizontalAlignment="Left" Margin="269,131,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Photos App:" HorizontalAlignment="Left" Margin="198,152,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_Photos_Combo" HorizontalAlignment="Left" Margin="269,155,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Skype:" HorizontalAlignment="Left" Margin="227,176,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_SkypeApp_Combo" HorizontalAlignment="Left" Margin="269,179,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Solitaire Collect:" HorizontalAlignment="Left" Margin="177,200,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_SolitaireCollect_Combo" HorizontalAlignment="Left" Margin="269,203,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Sticky Notes:" HorizontalAlignment="Left" Margin="194,224,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_StickyNotes_Combo" HorizontalAlignment="Left" Margin="269,227,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Voice Recorder:" HorizontalAlignment="Left" Margin="353,32,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_VoiceRecorder_Combo" HorizontalAlignment="Left" Margin="442,35,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Alarms &amp; Clock:" HorizontalAlignment="Left" Margin="351,56,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsAlarms_Combo" HorizontalAlignment="Left" Margin="442,59,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Calculator:" HorizontalAlignment="Left" Margin="379,80,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsCalculator_Combo" HorizontalAlignment="Left" Margin="442,83,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Camera:" HorizontalAlignment="Left" Margin="392,104,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsCamera_Combo" HorizontalAlignment="Left" Margin="442,107,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Win. Feedback:" HorizontalAlignment="Left" Margin="355,128,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsFeedbak_Combo" HorizontalAlignment="Left" Margin="442,131,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Windows Maps:" HorizontalAlignment="Left" Margin="351,152,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsMaps_Combo" HorizontalAlignment="Left" Margin="442,155,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Phone Comp.:" HorizontalAlignment="Left" Margin="361,176,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsPhone_Combo" HorizontalAlignment="Left" Margin="442,179,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="All Xbox Apps:" HorizontalAlignment="Left" Margin="359,200,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_XboxApp_Combo" HorizontalAlignment="Left" Margin="442,203,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Groove:" HorizontalAlignment="Left" Margin="394,224,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_Zune_Combo" HorizontalAlignment="Left" Margin="442,227,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Windows Store:" HorizontalAlignment="Left" Margin="353,8,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsStore_Combo" HorizontalAlignment="Left" Margin="442,11,0,0" VerticalAlignment="Top" Width="74"/>
					<Rectangle Fill="#FFFFFFFF" HorizontalAlignment="Left" Margin="171,29,0,-2" Stroke="Black" Width="1"/>
					<Rectangle Fill="#FFFFFFFF" HorizontalAlignment="Left" Margin="346,0,0,-2" Stroke="Black" Width="1"/>
					<Label Content="Get Help App:" HorizontalAlignment="Left" Margin="13,248,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_GetHelp_Combo" HorizontalAlignment="Left" Margin="94,251,0,0" VerticalAlignment="Top" Width="74"/>
					<Label Content="Wallet App:" HorizontalAlignment="Left" Margin="201,248,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="APP_WindowsWallet_Combo" HorizontalAlignment="Left" Margin="269,251,0,0" VerticalAlignment="Top" Width="74"/>
				</Grid>
			</TabItem>
			<TabItem Name="Application_Tab" Header="Application/Windows Update" Margin="-2,0,2,0">
				<Grid Background="#FFE5E5E5">
					<Label Content="Application/Feature" HorizontalAlignment="Left" Margin="79,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Label Content="OneDrive:" HorizontalAlignment="Left" Margin="69,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="OneDrive_Combo" HorizontalAlignment="Left" Margin="128,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="OneDrive Install:" HorizontalAlignment="Left" Margin="34,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="OneDriveInstall_Combo" HorizontalAlignment="Left" Margin="128,61,0,0" VerticalAlignment="Top" Width="78"/>
					<Label Content="Xbox DVR:" HorizontalAlignment="Left" Margin="66,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="XboxDVR_Combo" HorizontalAlignment="Left" Margin="128,88,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="MediaPlayer:" HorizontalAlignment="Left" Margin="53,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="MediaPlayer_Combo" HorizontalAlignment="Left" Margin="128,115,0,0" VerticalAlignment="Top" Width="78"/>
					<Label Content="Work Folders:" HorizontalAlignment="Left" Margin="49,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WorkFolders_Combo" HorizontalAlignment="Left" Margin="128,142,0,0" VerticalAlignment="Top" Width="78"/>
					<Label Name="LinuxSubsystem_Txt" Content="Linux Subsystem:" HorizontalAlignment="Left" Margin="31,193,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="LinuxSubsystem_Combo" HorizontalAlignment="Left" Margin="128,196,0,0" VerticalAlignment="Top" Width="78"/>
					<Label Content="Windows Update" HorizontalAlignment="Left" Margin="336,4,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
					<Label Content="Check for Update:" HorizontalAlignment="Left" Margin="290,31,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="CheckForWinUpdate_Combo" HorizontalAlignment="Left" Margin="392,34,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Update Check Type:" HorizontalAlignment="Left" Margin="280,58,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WinUpdateType_Combo" HorizontalAlignment="Left" Margin="392,61,0,0" VerticalAlignment="Top" Width="115"/>
					<Label Content="Update P2P:" HorizontalAlignment="Left" Margin="320,85,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="WinUpdateDownload_Combo" HorizontalAlignment="Left" Margin="392,88,0,0" VerticalAlignment="Top" Width="83"/>
					<Label Content="Update MSRT:" HorizontalAlignment="Left" Margin="310,112,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="UpdateMSRT_Combo" HorizontalAlignment="Left" Margin="392,115,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Update Driver:" HorizontalAlignment="Left" Margin="309,139,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="UpdateDriver_Combo" HorizontalAlignment="Left" Margin="392,142,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Restart on Update:" HorizontalAlignment="Left" Margin="287,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="RestartOnUpdate_Combo" HorizontalAlignment="Left" Margin="392,169,0,0" VerticalAlignment="Top" Width="72"/>
					<Rectangle Fill="#FFFFFFFF" HorizontalAlignment="Left" Margin="254,0,0,-2" Stroke="Black" Width="1"/>
					<Label Content="Update Available Popup:" HorizontalAlignment="Left" Margin="256,193,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="UpdateAvailablePopup_Combo" HorizontalAlignment="Left" Margin="392,196,0,0" VerticalAlignment="Top" Width="72"/>
					<Label Content="Fax And Scan:" HorizontalAlignment="Left" Margin="49,166,0,0" VerticalAlignment="Top"/>
					<ComboBox Name="FaxAndScan_Combo" HorizontalAlignment="Left" Margin="128,169,0,0" VerticalAlignment="Top" Width="78"/>
				</Grid>
			</TabItem>
		</TabControl>
		<Button Name="RunScriptButton" Content="Run Script" VerticalAlignment="Bottom" Height="20" FontWeight="Bold"/>
		<Rectangle Fill="#FFFFFFFF" Height="1" Margin="0,0,0,20" Stroke="Black" VerticalAlignment="Bottom"/>
	</Grid>
</Window>
"@

	[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
	$Form = [Windows.Markup.XamlReader]::Load( (New-Object System.Xml.XmlNodeReader $xaml) )
	$xaml.SelectNodes("//*[@Name]") | ForEach-Object {Set-Variable -Name "WPF_$($_.Name)" -Value $Form.FindName($_.Name) -Scope Script }
	$Script:WPFList = Get-Variable -Name 'WPF_*'

	[System.Collections.ArrayList]$VarList = AppAraySet 'WPF_*_Combo'
	[System.Collections.ArrayList]$ListApp = AppAraySet 'APP_*'

	$Runspace = [runspacefactory]::CreateRunspace()
	$PowerShell = [PowerShell]::Create()
	$PowerShell.RunSpace = $Runspace
	$Runspace.Open()
	[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null

	$WPF_Madbomb122WSButton.Add_Click({ OpenWebsite 'https://github.com/madbomb122/' })
	$WPF_FeedbackButton.Add_Click({ OpenWebsite 'https://github.com/madbomb122/Win10Script/issues' })
	$WPF_FAQButton.Add_Click({ OpenWebsite 'https://github.com/madbomb122/Win10Script/blob/master/README.md' })
	$WPF_DonateButton.Add_Click({ OpenWebsite 'https://www.amazon.com/gp/registry/wishlist/YBAYWBJES5DE/' })

	$WPF_CreateRestorePoint_CB.Add_Checked({ $WPF_CreateRestorePoint_CB.IsChecked = $True ;$WPF_RestorePointName_Txt.IsEnabled = $True })
	$WPF_CreateRestorePoint_CB.Add_UnChecked({ $WPF_CreateRestorePoint_CB.IsChecked = $False ;$WPF_RestorePointName_Txt.IsEnabled = $False })
	$WPF_AllMetro_Combo.add_SelectionChanged({ SelectComboBoxAllMetro ($WPF_AllMetro_Combo.SelectedIndex) })
	$WPF_RunScriptButton.Add_Click({ GuiDone })
	$WPF_WinDefault_Button.Add_Click({ LoadWinDefault ;SelectComboBox $VarList })
	$WPF_ResetDefault_Button.Add_Click({ SetDefault ;SelectComboBox $VarList ;SelectComboBox $ListApp 1 })
	$WPF_Load_Setting_Button.Add_Click({ OpenSaveDiaglog 0 })
	$WPF_Save_Setting_Button.Add_Click({ OpenSaveDiaglog 1 })
	$WPF_AboutButton.Add_Click({ [Windows.Forms.MessageBox]::Show('This script lets you do Various Settings and Tweaks for Windows 10. For manual or Automated use.','About', 'OK') | Out-Null })

	$WPF_CopyrightButton.Add_Click({ [Windows.Forms.MessageBox]::Show($CopyrightItems,'Copyright', 'OK') })

	$CopyrightItems = 'Copyright (c) 1999-2017 Charles "Black Viper" Sparks - Services Configuration

The MIT License (MIT)

Copyright (c) 2017 Madbomb122 - Black Viper Service Configuration Script

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'

$Skip_EnableD_Disable = @(
'Telemetry',
'WiFiSense',
'SmartScreen',
'LocationTracking',
'Feedback',
'AdvertisingID',
'Cortana',
'CortanaSearch',
'ErrorReporting',
'AutoLoggerFile',
'DiagTrack',
'WAPPush',
'CheckForWinUpdate',
'UpdateMSRT',
'UpdateDriver',
'RestartOnUpdate',
'AppAutoDownload',
'AdminShares',
'Firewall',
'WinDefender',
'HomeGroups',
'RemoteAssistance',
'CastToDevice',
'PreviousVersions',
'IncludeinLibrary',
'PinToStart',
'PinToQuickAccess',
'ShareWith',
'SendTo',
'OneDrive',
'XboxDVR',
'TaskBarOnMultiDisplay',
'StartMenuWebSearch',
'StartSuggestions',
'RecentItemsFrequent',
'Autoplay',
'Autorun',
'AeroSnap',
'AeroShake',
'StoreOpenWith',
'LockScreen',
'CameraOnLockScreen',
'ActionCenter',
'AccountProtectionWarn',
'StickyKeyPrompt',
'SleepPower',
'ReopenAppsOnBoot',
'Timeline',
'UpdateAvailablePopup')

$Skip_Enable_DisableD = @(
'SharingMappedDrives',
'RemoteDesktop',
'LastActiveClick',
'NumblockOnStart',
'F8BootMenu',
'RemoteUACAcctToken',
'PVFileAssociation',
'PVOpenWithMenu',
'LongFilePath')

$Skip_ShowD_Hide = @(
'TaskbarSearchBox',
'TaskViewButton',
'MostUsedAppStartMenu',
'FrequentFoldersQikAcc',
'WinContentWhileDrag',
'RecycleBinOnDesktop',
'PowerMenuLockScreen')

$Skip_ShowD_Hide_Remove = @(
'DesktopIconInThisPC',
'DocumentsIconInThisPC',
'DownloadsIconInThisPC',
'ThreeDobjectsIconInThisPC',
'MusicIconInThisPC',
'PicturesIconInThisPC',
'VideosIconInThisPC')


$Skip_Show_HideD = @(
'SecondsInClock',
'PidInTitleBar',
'KnownExtensions',
'HiddenFiles',
'SystemFiles',
'TaskManagerDetails',
'ThisPCOnDesktop',
'NetworkOnDesktop',
'UsersFileOnDesktop',
'ControlPanelOnDesktop')

$Skip_InstalledD_Uninstall = @('OneDriveInstall','MediaPlayer','WorkFolders','FaxAndScan')
$UpdateFile = $filebase + 'Update.bat'

	If($Release_Type -eq 'Testing'){ $Script:Restart = 0 ;$WPF_Restart_CB.IsEnabled = $False ;$WPF_Restart_CB.Content += ' (Disabled in Testing Version)' }
	If(Test-Path $UpdateFile -PathType Leaf) { $WPF_BatUpdateScriptFileName_CB.IsEnabled = $False ;$WPF_BatUpdateScriptFileName_CB.Content += ' (Update.bat Found, Option not needed)' }
	If($BuildVer -lt 14393){ $WPF_LinuxSubsystem_Combo.Visibility = 'Hidden' ;$WPF_LinuxSubsystem_Txt.Visibility = 'Hidden' }
	If($BuildVer -lt 16299){
		$WPF_ThreeDobjectsIconInThisPC_Combo.Visibility = 'Hidden' ;$WPF_ThreeDobjectsIconInThisPC_txt.Visibility = 'Hidden'
		$WPF_ReopenAppsOnBoot_Combo.Visibility = 'Hidden' ;$WPF_ReopenAppsOnBoot_txt.Visibility = 'Hidden'
	}
	If($BuildVer -lt 17133){
		$WPF_AccountProtectionWarn_Combo.Visibility = 'Hidden' ;$WPF_AccountProtectionWarn_Txt.Visibility = 'Hidden'
		$WPF_Timeline_Combo.Visibility = 'Hidden' ;$WPF_Timeline_Txt.Visibility = 'Hidden'
	}
	ForEach($Var In $Skip_EnableD_Disable){ SetCombo $Var 'Enable*,Disable' }
	ForEach($Var In $Skip_Enable_DisableD){ SetCombo $Var 'Enable,Disable*' }
	ForEach($Var In $Skip_ShowD_Hide_Remove){ SetCombo $Var 'Show/Add*,Hide,Remove**' }
	ForEach($Var In $Skip_ShowD_Hide){ SetCombo $Var 'Show*,Hide' }
	ForEach($Var In $Skip_Show_HideD){ SetCombo $Var 'Show,Hide*' }
	ForEach($Var In $Skip_InstalledD_Uninstall){ SetCombo $Var 'Installed*,Uninstall' }

	SetComboM 'AllMetro' 'Unhide,Hide,Uninstall'
	ForEach($MetroApp In $ListApp){ SetComboM $MetroApp 'Unhide,Hide,Uninstall' }

	SetCombo 'LinuxSubsystem' 'Installed,Uninstall*'
	SetCombo 'HibernatePower' 'Enable,Disable'
	SetCombo 'UAC' 'Disable,Normal*,Higher'
	SetCombo 'BatteryUIBar' 'New*,Classic'
	SetCombo 'ClockUIBar' 'New*,Classic'
	SetCombo 'VolumeControlBar' 'New(Horizontal)*,Classic(Vertical)'
	SetCombo 'TaskbarIconSize' 'Normal*,Smaller'
	SetCombo 'TaskbarGrouping' 'Never,Always*,When Needed'
	SetCombo 'TrayIcons' 'Auto*,Always Show'
	SetCombo 'TaskBarButtOnDisplay' 'All,Where Window is Open,Main & Where Window is Open'
	SetCombo 'UnpinItems' 'Unpin'
	SetCombo 'ExplorerOpenLoc' 'Quick Access*,ThisPC'
	SetCombo 'RecentFileQikAcc' 'Show/Add*,Hide,Remove'
	SetCombo 'WinXPowerShell' 'Powershell,Command Prompt'
	SetCombo 'WinUpdateType' 'Notify,Auto DL,Auto DL+Install*,Admin Config'
	SetCombo 'WinUpdateDownload' 'P2P*,Local Only,Disable'

	$WPF_Script_Ver_Txt.Text = "$Script_Version.$Minor_Version ($Script_Date)"
	$WPF_Release_Type_Txt.Text = $Release_Type

	ConfigGUIitms
	$TmpTitle = " (v.$Script_Version.$Minor_Version -$Script_Date"
	If($Release_Type -ne 'Stable'){ $TmpTitle += " -$Release_Type)" } Else{ $TmpTitle += ')' }
	$Form.Title += $TmpTitle
	Clear-Host
	DisplayOutMenu 'Displaying GUI Now' 14 0 1 0
	$Form.ShowDialog() | Out-Null
}

Function GuiDone {
	GuiItmToVariable
	$Form.Close()
	$Script:RunScr = $True
	PreStartScript
}

Function GuiItmToVariable {
	ForEach($Var In $ListApp) {
		$Value = ($(Get-Variable -Name ('WPF_'+$Var+'_Combo') -ValueOnly).SelectedIndex)
		Switch($Var) {
			'APP_SkypeApp' { Set-Variable -Name 'APP_SkypeApp1' -Value $Value -Scope Script ;Set-Variable -Name 'APP_SkypeApp2' -Value $Value -Scope Script ;Break }
			'APP_WindowsFeedbak' { Set-Variable -Name 'APP_WindowsFeedbak1' -Value $Value -Scope Script ;Set-Variable -Name 'APP_WindowsFeedbak2' -Value $Value -Scope Script ;Break }
			'APP_Zune' { Set-Variable -Name 'APP_ZuneMusic' -Value $Value -Scope Script ;Set-Variable -Name 'APP_ZuneVideo' -Value $Value -Scope Script ;Break }
			Default { Set-Variable -Name $Var -Value $Value -Scope Script ;Break }
		}
	}
	ForEach($Var In $VarList){ Set-Variable -Name $Var -Value ($(Get-Variable -Name ('WPF_'+$Var+'_Combo') -ValueOnly).SelectedIndex) -Scope Script }
	If($WPF_CreateRestorePoint_CB.IsChecked){ $Script:CreateRestorePoint = 1 } Else{ $Script:CreateRestorePoint = 0 }
	If($WPF_VersionCheck_CB.IsChecked){ $Script:VersionCheck = 1 } Else{ $Script:VersionCheck = 0 }
	If($WPF_InternetCheck_CB.IsChecked){ $Script:InternetCheck = 1 } Else{ $Script:InternetCheck = 0 }
	If($WPF_ShowSkipped_CB.IsChecked){ $Script:ShowSkipped = 1 } Else{ $Script:ShowSkipped = 0 }
	If($WPF_Restart_CB.IsChecked){ $Script:Restart = 1 } Else { $Script:Restart = 0 }
	$Script:RestorePointName = $WPF_RestorePointName_Txt.Text
}

##########
# GUI -End
##########
# Pre-Made Settings -Start
##########

Function LoadWinDefault {
	#Privacy Settings
	$Script:Telemetry = 1
	$Script:WiFiSense = 1
	$Script:SmartScreen = 1
	$Script:LocationTracking = 1
	$Script:Feedback = 1
	$Script:AdvertisingID = 1
	$Script:Cortana = 1
	$Script:CortanaSearch = 1
	$Script:ErrorReporting = 1
	$Script:AutoLoggerFile = 1
	$Script:DiagTrack = 1
	$Script:WAPPush = 1

	#Windows Update
	$Script:CheckForWinUpdate = 1
	$Script:WinUpdateType = 3
	$Script:WinUpdateDownload = 1
	$Script:UpdateMSRT = 1
	$Script:UpdateDriver = 1
	$Script:RestartOnUpdate = 1
	$Script:AppAutoDownload = 1
	$Script:UpdateAvailablePopup = 1

	#Service Tweaks
	$Script:UAC = 2
	$Script:SharingMappedDrives = 2
	$Script:AdminShares = 1
	$Script:Firewall = 1
	$Script:WinDefender = 1
	$Script:HomeGroups = 1
	$Script:RemoteAssistance = 1
	$Script:RemoteDesktop = 2

	#Context Menu Items
	$Script:CastToDevice = 1
	$Script:PreviousVersions = 1
	$Script:IncludeinLibrary = 1
	$Script:PinToStart = 1
	$Script:PinToQuickAccess = 1
	$Script:ShareWith = 1
	$Script:SendTo = 1

	#Task Bar Items
	$Script:BatteryUIBar = 1
	$Script:ClockUIBar = 1
	$Script:VolumeControlBar = 1
	$Script:TaskbarSearchBox = 1
	$Script:TaskViewButton = 1
	$Script:TaskbarIconSize = 1
	$Script:TaskbarGrouping = 2
	$Script:TrayIcons = 1
	$Script:SecondsInClock = 2
	$Script:LastActiveClick = 2
	$Script:TaskBarOnMultiDisplay = 1

	#Star Menu Items
	$Script:StartMenuWebSearch = 1
	$Script:StartSuggestions = 1
	$Script:MostUsedAppStartMenu = 1
	$Script:RecentItemsFrequent = 1

	#Explorer Items
	$Script:Autoplay = 1
	$Script:Autorun = 1
	$Script:PidInTitleBar = 2
	$Script:AeroSnap = 1
	$Script:AeroShake = 1
	$Script:KnownExtensions = 2
	$Script:HiddenFiles = 2
	$Script:SystemFiles = 2
	$Script:ExplorerOpenLoc = 1
	$Script:RecentFileQikAcc = 1
	$Script:FrequentFoldersQikAcc = 1
	$Script:WinContentWhileDrag = 1
	$Script:StoreOpenWith = 1
	If($BuildVer -ge 15063){ $Script:WinXPowerShell = 1 } Else{ $Script:WinXPowerShell = 2 }
	$Script:TaskManagerDetails = 2
	$Script:ReopenAppsOnBoot = 1
	$Script:Timeline = 1
	$Script:LongFilePath = 2

	#'This PC' Items
	$Script:DesktopIconInThisPC = 1
	$Script:DocumentsIconInThisPC = 1
	$Script:DownloadsIconInThisPC = 1
	$Script:MusicIconInThisPC = 1
	$Script:PicturesIconInThisPC = 1
	$Script:VideosIconInThisPC = 1
	$Script:ThreeDobjectsIconInThisPC = 1

	#Desktop Items
	$Script:ThisPCOnDesktop = 2
	$Script:NetworkOnDesktop = 2
	$Script:RecycleBinOnDesktop = 1
	$Script:UsersFileOnDesktop = 2
	$Script:ControlPanelOnDesktop = 2

	#Lock Screen
	$Script:LockScreen = 1
	$Script:PowerMenuLockScreen = 1
	$Script:CameraOnLockScreen = 1

	#Misc items
	$Script:AccountProtectionWarn = 1
	$Script:ActionCenter = 1
	$Script:StickyKeyPrompt = 1
	$Script:NumblockOnStart = 2
	$Script:F8BootMenu = 1
	$Script:RemoteUACAcctToken = 2
	$Script:SleepPower = 1

	# Photo Viewer Settings
	$Script:PVFileAssociation = 2
	$Script:PVOpenWithMenu = 2

	# Remove unwanted applications
	$Script:OneDrive = 1
	$Script:OneDriveInstall = 1
	$Script:XboxDVR = 1
	$Script:MediaPlayer = 1
	$Script:WorkFolders = 1
	$Script:FaxAndScan = 1
	$Script:LinuxSubsystem = 2
}

##########
# Pre-Made Settings -End
##########
# Script -Start
##########

Function PreStartScript {
	If($VersionCheck -eq 1){ UpdateCheck }

	Clear-Host
	BoxItem 'Pre-Script'
	If($CreateRestorePoint -eq 0 -And $ShowSkipped -eq 1) {
		DisplayOut 'Skipping Creation of System Restore Point...' 15 0
	} ElseIf($CreateRestorePoint -eq 1) {
		DisplayOut "Creating System Restore Point Named '$RestorePointName'" 11 1
		DisplayOut 'Please Wait...' 11 1
		Checkpoint-Computer -Description $RestorePointName | Out-Null
	}
	RunScript
}

Function RunScript {
	If(!(Test-Path 'HKCR:')){ New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null }
	If(!(Test-Path 'HKU:')){ New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null }
	$AppxCount = 0

	BoxItem 'Metro App Items'
	$APPProcess = Get-Variable -Name 'APP_*' -ValueOnly -Scope Script
	$A = 0

	ForEach($AppV In $APPProcess) {
		If($AppV -eq 1) {
			If($AppsList[$A] -ne 'XboxApps'){
				$APPS_AppsUnhide.Add($AppsList[$A]) | Out-null
			} Else {
				ForEach($AppX In $Xbox_Apps) { $APPS_AppsUnhide.Add($AppX) | Out-null }
			}
		} ElseIf($AppV -eq 2) {
			If($AppsList[$A] -ne 'XboxApps'){
				$APPS_AppsHide.Add($AppsList[$A]) | Out-null
			} Else {
				ForEach($AppX In $Xbox_Apps) { $APPS_AppsHide.Add($AppX) | Out-null }
			}
		} ElseIf($AppV -eq 3) {
			If($AppsList[$A] -ne 'XboxApps'){
				$APPS_AppsUninstall.Add($AppsList[$A]) | Out-null
			} Else {
				ForEach($AppX In $Xbox_Apps) { $APPS_AppsUninstall.Add($AppX) | Out-null }
			}
		} $A++
	}

	$APPS_AppsUnhide.Remove('') ;$Ai = $APPS_AppsUnhide.Length
	$APPS_AppsHide.Remove('') ;$Ah = $APPS_AppsHide.Length
	$APPS_AppsUninstall.Remove('') ;$Au = $APPS_AppsUninstall.Length
	If($Ah -ne $null -or $Au -ne $null){ $AppxPackages = Get-AppxProvisionedPackage -online | select-object PackageName,Displayname }

	DisplayOut "List of Apps Being Unhidden...`n------------------" 11 0
	If($Ai -ne $null) {
		ForEach($AppI In $APPS_AppsUnhide) {
			$AppInst = Get-AppxPackage -AllUsers $AppI
			If($AppInst -ne $null) {
				DisplayOut $AppI 11 0
				ForEach($App In $AppInst){
					$AppxCount++
					$Job = "Win10Script$AppxCount"
					Start-Job -Name $Job -ScriptBlock { Add-AppxPackage -DisableDevelopmentMode -Register "$($App.InstallLocation)\AppXManifest.xml" }
				}
			} Else {
				DisplayOut "Unable to Unhide $AppI" 11 0
			}
		}
	} Else {
		DisplayOut 'No Apps being Unhidden' 11 0
	}

	DisplayOut "`nList of Apps Being Hiddden...`n-----------------" 12 0
	If($Ah -ne $null) {
		ForEach($AppH In $APPS_AppsHide) {
			If($AppxPackages.DisplayName.Contains($AppH)) {
				DisplayOut $AppH 12 0
				$AppxCount++
				$Job = "Win10Script$AppxCount"
				Start-Job -Name $Job -ScriptBlock { Get-AppxPackage $AppH | Remove-AppxPackage | Out-null }
			} Else {
				DisplayOut "$AppH Isn't Installed" 12 0
			}
		}
	} Else {
		DisplayOut 'No Apps being Hidden' 12 0
	}

	DisplayOut "`nList of Apps Being Uninstalled...`n--------------------" 14 0
	If($Au -ne $null) {
		ForEach($AppU In $APPS_AppsUninstall) {
			If($AppxPackages.DisplayName.Contains($AppU)) {
				DisplayOut $AppU 14 0
				$PackageFullName = (Get-AppxPackage $AppU).PackageFullName
				$ProPackageFullName = ($AppxPackages.Where{$_.Displayname -eq $AppU}).PackageName

				# Alt removal: DISM /Online /Remove-ProvisionedAppxPackage /PackageName:
				$AppxCount++
				$Job = "Win10Script$AppxCount"
				Start-Job -Name $Job -ScriptBlock {
					Remove-AppxPackage -Package $using:PackageFullName | Out-null
					Remove-AppxProvisionedPackage -Online -PackageName $using:ProPackageFullName | Out-null
				}
			} Else {
				DisplayOut "$AppU Isn't Installed" 14 0
			}
		}
	} Else {
		DisplayOut 'No Apps being Uninstalled' 14 0
	}

	BoxItem 'Privacy Settings'
	Switch($Telemetry) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Telemetry...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Telemetry...' 11 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 3
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 3
			If($OSType -eq 64){ Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 3 } ;Break
		}
		2 {	DisplayOut 'Disabling Telemetry...' 12 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 0
			If($OSType -eq 64){ Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 0 } ;Break
		}
	}

	Switch($WiFiSense) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Wi-Fi Sense...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Wi-Fi Sense...' 11 0
			$Path1 = 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi'
			$Path = CheckSetPath "$Path1\AllowWiFiHotSpotReporting"
			Set-ItemProperty -Path $Path -Name 'Value' -Type DWord -Value 1
			$Path = CheckSetPath "$Path1\AllowAutoConnectToWiFiSenseHotspots"
			Set-ItemProperty -Path $Path -Name 'Value' -Type DWord -Value 1
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config'
			Set-ItemProperty -Path $Path -Name 'AutoConnectAllowedOEM' -Type Dword -Value 0
			Set-ItemProperty -Path $Path -Name 'WiFISenseAllowed' -Type Dword -Value 0 ;Break
		}
		2 {	DisplayOut 'Disabling Wi-Fi Sense...' 12 0
			$Path1 = 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi'
			$Path = CheckSetPath "$Path1\AllowWiFiHotSpotReporting"
			Set-ItemProperty -Path $Path -Name 'Value' -Type DWord -Value 0
			$Path = CheckSetPath "$Path1\AllowAutoConnectToWiFiSenseHotspots"
			Set-ItemProperty -Path $Path -Name 'Value' -Type DWord -Value 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config' -Name 'AutoConnectAllowedOEM'
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config' -Name 'WiFISenseAllowed' ;Break
		}
	}

	Switch($SmartScreen) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping SmartScreen Filter...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling SmartScreen Filter...' 11 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'SmartScreenEnabled' -Type String -Value 'RequireAdmin'
			Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost' -Name 'EnableWebContentEvaluation'
			If($BuildVer -ge 15063) {
				$AddPath = (Get-AppxPackage -AllUsers 'Microsoft.MicrosoftEdge').PackageFamilyName
				$Path = "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\$AddPath\MicrosoftEdge\PhishingFilter"
				Remove-ItemProperty -Path $Path -Name 'EnabledV9'
				Remove-ItemProperty -Path $Path -Name 'PreventOverride'
			} ;Break
		}
		2 {	DisplayOut 'Disabling SmartScreen Filter...' 12 0
			$Path = 'SOFTWARE\Microsoft\Windows\CurrentVersion'
			Set-ItemProperty -Path "HKLM:\$Path\Explorer" -Name 'SmartScreenEnabled' -Type String -Value 'Off'
			Set-ItemProperty -Path "HKCU:\$Path\AppHost" -Name 'EnableWebContentEvaluation' -Type DWord -Value 0
			If($BuildVer -ge 15063) {
				$AddPath = (Get-AppxPackage -AllUsers 'Microsoft.MicrosoftEdge').PackageFamilyName
				$Path = CheckSetPath "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\$AddPath\MicrosoftEdge\PhishingFilter"
				Set-ItemProperty -Path $Path -Name 'EnabledV9' -Type DWord -Value 0
				Set-ItemProperty -Path $Path -Name 'PreventOverride' -Type DWord -Value 0
			} ;Break
		}
	}

	Switch($LocationTracking) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Location Tracking...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Location Tracking...' 11 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}' -Name 'SensorPermissionState' -Type DWord -Value 1
			Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration' -Name 'Status' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Disabling Location Tracking...' 12 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}' -Name 'SensorPermissionState' -Type DWord -Value 0
			Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration' -Name 'Status' -Type DWord -Value 0 ;Break
		}
	}

	Switch($Feedback) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Feedback...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Feedback...' 11 0
			Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Siuf\Rules' -Name 'NumberOfSIUFInPeriod' ;Break
		}
		2 {	DisplayOut 'Disabling Feedback...' 12 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Siuf\Rules'
			Set-ItemProperty -Path $Path -Name 'NumberOfSIUFInPeriod' -Type DWord -Value 0 ;Break
		}
	}

	Switch($AdvertisingID) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Advertising ID...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Advertising ID...' 11 0
			Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo' -Name 'Enabled'
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy'
			Set-ItemProperty -Path $Path -Name 'TailoredExperiencesWithDiagnosticDataEnabled' -Type DWord -Value 2 ;Break
		}
		2 {	DisplayOut 'Disabling Advertising ID...' 12 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo'
			Set-ItemProperty -Path $Path -Name 'Enabled' -Type DWord -Value 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy'
			Set-ItemProperty -Path $Path -Name 'TailoredExperiencesWithDiagnosticDataEnabled' -Type DWord -Value 0 ;Break
		}
	}

	Switch($Cortana) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Cortana...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Cortana...' 11 0
			$Path = 'HKCU:\SOFTWARE\Microsoft\InputPersonalization'
			Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Personalization\Settings' -Name 'AcceptedPrivacyPolicy'
			Remove-ItemProperty -Path "$Path\TrainedDataStore" -Name 'HarvestContacts'
			Set-ItemProperty -Path $Path -Name 'RestrictImplicitTextCollection' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'RestrictImplicitInkCollection' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Disabling Cortana...' 12 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Personalization\Settings'
			Set-ItemProperty -Path $Path -Name 'AcceptedPrivacyPolicy' -Type DWord -Value 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\InputPersonalization'
			Set-ItemProperty -Path $Path -Name 'RestrictImplicitTextCollection' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'RestrictImplicitInkCollection' -Type DWord -Value 1
			$Path = CheckSetPath "$Path\TrainedDataStore"
			Set-ItemProperty -Path $Path -Name 'HarvestContacts' -Type DWord -Value 0 ;Break
		}
	}

	Switch($CortanaSearch) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Cortana Search...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Cortana Search...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana' ;Break
		}
		2 {	DisplayOut 'Disabling Cortana Search...' 12 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
			Set-ItemProperty -Path $Path -Name 'AllowCortana' -Type DWord -Value 0 ;Break
		}
	}

	Switch($ErrorReporting) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Error Reporting...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Error Reporting...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting' -Name 'Disabled' ;Break
		}
		2 {	DisplayOut 'Disabling Error Reporting...' 12 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting' -Name 'Disabled' -Type DWord -Value 1 ;Break
		}
	}

	Switch($AutoLoggerFile) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping AutoLogger...' 15 0 } ;Break }
		1 {	DisplayOut 'Unrestricting AutoLogger Directory...' 11 0
			$autoLoggerDir = "$Env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
			icacls $autoLoggerDir /grant:r SYSTEM:`(OI`)`(CI`)F | Out-Null
			$Path = CheckSetPath 'HKLM:\SYSTEM\ControlSet001\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener'
			Set-ItemProperty -Path $Path -Name 'Start' -Type DWord -Value 1
			$Path += '\{DD17FA14-CDA6-7191-9B61-37A28F7A10DA}'
			Set-ItemProperty -Path $Path -Name 'Start' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Removing AutoLogger File and Restricting Directory...' 12 0
			$autoLoggerDir = "$Env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
			RemoveSetPath "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl"
			icacls $autoLoggerDir /deny SYSTEM:`(OI`)`(CI`)F | Out-Null
			$Path = CheckSetPath 'HKLM:\SYSTEM\ControlSet001\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener'
			Set-ItemProperty -Path $Path -Name 'Start' -Type DWord -Value 0
			$Path = CheckSetPath "$Path\{DD17FA14-CDA6-7191-9B61-37A28F7A10DA}"
			Set-ItemProperty -Path $Path -Name 'Start' -Type DWord -Value 0 ;Break
		}
	}

	Switch($DiagTrack) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Diagnostics Tracking...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling and Starting Diagnostics Tracking Service...' 11 0
			Set-Service 'DiagTrack' -StartupType Automatic
			Start-Service 'DiagTrack' ;Break
		}
		2 {	DisplayOut 'Stopping and Disabling Diagnostics Tracking Service...' 12 0
			Stop-Service 'DiagTrack'
			Set-Service 'DiagTrack' -StartupType Disabled ;Break
		}
	}

	Switch($WAPPush) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping WAP Push...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling and Starting WAP Push Service...' 11 0
			Set-Service 'dmwappushservice' -StartupType Automatic
			Start-Service 'dmwappushservice'
			Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\dmwappushservice' -Name 'DelayedAutoStart' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Disabling WAP Push Service...' 12 0
			Stop-Service 'dmwappushservice'
			Set-Service 'dmwappushservice' -StartupType Disabled ;Break
		}
	}

	Switch($AppAutoDownload) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping App Auto Download...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling App Auto Download...' 11 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate' -Name 'AutoDownload' -Type DWord -Value 0
			Remove-ItemProperty  -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Name 'DisableWindowsConsumerFeatures' ;Break
		}
		2 {	DisplayOut 'Disabling App Auto Download...' 12 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate'
			Set-ItemProperty -Path $Path -Name 'AutoDownload' -Type DWord -Value 2
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
			Set-ItemProperty -Path $Path -Name 'DisableWindowsConsumerFeatures' -Type DWord -Value 1 ;Break
		}
	}

	BoxItem 'Windows Update Settings'
	$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'
	Switch($CheckForWinUpdate) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Check for Windows Update...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Check for Windows Update...' 11 0
			Remove-ItemProperty -Path $Path -Name 'SetDisableUXWUAccess' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Disabling Check for Windows Update...' 12 0
			New-ItemProperty -Path $Path -Name 'SetDisableUXWUAccess' -Type DWord -Value 1 ;Break
		}
	}

	$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
	Switch($WinUpdateType) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Check for Windows Update...' 15 0 } ;Break }
		1 {	DisplayOut 'Notify for windows update download and notify for install...' 16 0
			Set-ItemProperty -Path $Path -Name 'AUOptions' -Type DWord -Value 2 ;Break
		}
		2 {	DisplayOut 'Auto Download for windows update download and notify for install...' 16 0
			Set-ItemProperty -Path $Path -Name 'AUOptions' -Type DWord -Value 3 ;Break
		}
		3 {	DisplayOut 'Auto Download for windows update download and schedule for install...' 16 0
			Set-ItemProperty -Path $Path -Name 'AUOptions' -Type DWord -Value 4 ;Break
		}
		4 {	DisplayOut 'Windows update allow local admin to choose setting...' 16 0
			Set-ItemProperty -Path $Path -Name 'AUOptions' -Type DWord -Value 5 ;Break
		}
	}

	Switch($CheckForWinUpdate) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Windows Update P2P...' 15 0 } ;Break }
		1 {	DisplayOut 'Unrestricting Windows Update P2P to Internet...' 16 0
			$Path = 'SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization'
			Remove-ItemProperty -Path "HKLM:\$Path\Config" -Name 'DODownloadMode'
			Remove-ItemProperty -Path "HKCU:\$Path" -Name 'SystemSettingsDownloadMode' ;Break
		}
		2 {	DisplayOut 'Restricting Windows Update P2P only to local network...' 16 0
			$Path1 = 'SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization'
			$Path = CheckSetPath "HKCU:\$Path1"
			Set-ItemProperty -Path $Path -Name 'SystemSettingsDownloadMode' -Type DWord -Value 3
			$Path = CheckSetPath "HKLM:\$Path1\Config"
			Set-ItemProperty -Path $Path -Name 'DODownloadMode' -Type DWord -Value 1 ;Break
		}
		3 {	DisplayOut 'Disabling Windows Update P2P...' 12 0
			$Path1 = 'SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization'
			$Path = CheckSetPath "HKCU:\$Path1"
			Set-ItemProperty -Path $Path -Name 'SystemSettingsDownloadMode' -Type DWord -Value 3
			$Path = CheckSetPath "HKLM:\$Path1\Config"
			Set-ItemProperty -Path $Path -Name 'DODownloadMode' -Type DWord -Value 0 ;Break
		}
	}

	Switch($RestartOnUpdate) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Windows Update Automatic Restart...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Windows Update Automatic Restart...' 11 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'UxOption' -Type DWord -Value 0
			$Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
			Remove-ItemProperty -Path $Path -Name 'NoAutoRebootWithLoggedOnUsers'
			Remove-ItemProperty -Path $Path -Name 'AUPowerManagement' ;Break
		}
		2 {	DisplayOut 'Disabling Windows Update Automatic Restart...' 12 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'UxOption' -Type DWord -Value 1
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
			Set-ItemProperty -Path $Path -Name 'NoAutoRebootWithLoggedOnUsers' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'AUPowerManagement' -Type DWord -Value 0 ;Break
		}
	}

	Switch($UpdateMSRT) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Malicious Software Removal Tool Update...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Malicious Software Removal Tool Update...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MRT' -Name 'DontOfferThroughWUAU' ;Break
		}
		2 {	DisplayOut 'Disabling Malicious Software Removal Tool Update...' 12 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\MRT'
			Set-ItemProperty -Path $Path -Name 'DontOfferThroughWUAU' -Type DWord -Value 1 ;Break
		}
	}

	Switch($UpdateDriver) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Driver Update Through Windows Update...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Driver Update Through Windows Update...' 11 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching' -Name 'SearchOrderConfig' -Type DWord -Value 1
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name 'ExcludeWUDriversInQualityUpdate' ;Break
		}
		2 {	DisplayOut 'Disabling Driver Update Through Windows Update...' 12 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching' -Name 'SearchOrderConfig' -Type DWord -Value 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'
			Set-ItemProperty -Path $Path -Name 'ExcludeWUDriversInQualityUpdate' -Type DWord -Value 1 ;Break
		}
	}

	Switch($UpdateAvailablePopup) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Update Available Popup...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Update Available Popup...' 11 0
			ForEach($File In $musnotification_files){
				ICACLS $File /remove:d '"Everyone"' | out-null
				ICACLS $File /grant ('Everyone' + ':(OI)(CI)F') | out-null
				ICACLS $File /setowner 'NT SERVICE\TrustedInstaller'
				ICACLS $File /remove:g '"Everyone"' | out-null
			} ;Break
		}
		2 {	DisplayOut 'Disabling Update Available Popup...' 12 0
			ForEach($File In $musnotification_files){
				Takeown /f $File | out-null
				ICACLS $File /deny '"Everyone":(F)' | out-null
			} ;Break
		}
	}

	BoxItem 'Service Tweaks'
	Switch($UpdateDriver) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping UAC Level...' 15 0 } ;Break }
		1 {	DisplayOut 'Lowering UAC level...' 16 0
			$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
			Set-ItemProperty -Path $Path -Name 'ConsentPromptBehaviorAdmin' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'PromptOnSecureDesktop' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Default UAC level...' 16 0
			$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
			Set-ItemProperty -Path $Path -Name 'ConsentPromptBehaviorAdmin' -Type DWord -Value 5
			Set-ItemProperty -Path $Path -Name 'PromptOnSecureDesktop' -Type DWord -Value 1 ;Break
		}
		3 {	DisplayOut 'Rasing UAC level...' 16 0
			$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
			Set-ItemProperty -Path $Path -Name 'ConsentPromptBehaviorAdmin' -Type DWord -Value 2
			Set-ItemProperty -Path $Path -Name 'PromptOnSecureDesktop' -Type DWord -Value 1 ;Break
		}
	}

	Switch($SharingMappedDrives) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Sharing Mapped Drives between Users...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Sharing Mapped Drives between Users...' 11 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLinkedConnections' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Disabling Sharing Mapped Drives between Users...' 12 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLinkedConnections' ;Break
		}
	}

	Switch($AdminShares) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Hidden Administrative Shares...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Hidden Administrative Shares...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name 'AutoShareWks' ;Break
		}
		2 {	DisplayOut 'Disabling Hidden Administrative Shares...' 12 0
			Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name 'AutoShareWks' -Type DWord -Value 0 ;Break
		}
	}

	Switch($Firewall) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Firewall...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Firewall...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile' -Name 'EnableFirewall' ;Break
		}
		2 {	DisplayOut 'Disabling Firewall...' 12 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile'
			Set-ItemProperty -Path $Path -Name 'EnableFirewall' -Type DWord -Value 0 ;Break
		}
	}

	Switch($WinDefender) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Windows Defender...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Windows Defender...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Name 'DisableAntiSpyware'
			$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'
			If($BuildVer -lt 15063){ $RegName = 'WindowsDefender' } Else{ $RegName = 'SecurityHealth' }
			Set-ItemProperty -Path $Path -Name $RegName -Type ExpandString -Value "`"%ProgramFiles%\Windows Defender\MSASCuiL.exe`""
			RemoveSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet' ;Break
		}
		2 {	DisplayOut 'Disabling Windows Defender...' 12 0
			$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'
			If($BuildVer -lt 15063){ $RegName = 'WindowsDefender' } Else{ $RegName = 'SecurityHealth' }
			Remove-ItemProperty -Path $Path -Name $RegName
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\'
			Set-ItemProperty -Path $Path -Name 'DisableAntiSpyware' -Type DWord -Value 1
			$Path = CheckSetPath "$Path\Spynet"
			Set-ItemProperty -Path $Path -Name 'SpynetReporting' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'SubmitSamplesConsent' -Type DWord -Value 2 ;Break
		}
	}

	Switch($HomeGroups) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Home Groups Services...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Home Groups Services...' 11 0
			Set-Service 'HomeGroupListener' -StartupType Manual
			Set-Service 'HomeGroupProvider' -StartupType Manual
			Start-Service 'HomeGroupProvider' ;Break
		}
		2 {	DisplayOut 'Disabling Home Groups Services...' 12 0
			Stop-Service 'HomeGroupListener'
			Set-Service 'HomeGroupListener' -StartupType Disabled
			Stop-Service 'HomeGroupProvider'
			Set-Service 'HomeGroupProvider' -StartupType Disabled ;Break
		}
	}

	Switch($RemoteAssistance) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Remote Assistance...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Remote Assistance...' 11 0
			Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' -Name 'fAllowToGetHelp' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Disabling Remote Assistance...' 12 0
			Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' -Name 'fAllowToGetHelp' -Type DWord -Value 0 ;Break
		}
	}

	Switch($RemoteDesktop) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Remote Desktop...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Remote Desktop w/o Network Level Authentication...' 11 0
			$Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server'
			Set-ItemProperty -Path $Path -Name 'fDenyTSConnections' -Type DWord -Value 0
			Set-ItemProperty -Path "$Path\WinStations\RDP-Tcp" -Name 'UserAuthentication' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Disabling Remote Desktop...' 12 0
			$Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server'
			Set-ItemProperty -Path $Path -Name 'fDenyTSConnections' -Type DWord -Value 1
			Set-ItemProperty -Path "$Path\WinStations\RDP-Tcp" -Name 'UserAuthentication' -Type DWord -Value 1 ;Break
		}
	}

	BoxItem 'Context Menu Items'
	Switch($CastToDevice) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Cast to Device Context item...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Cast to Device Context item...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked' -Name '{7AD84985-87B4-4a16-BE58-8B72A5B390F7}' ;Break
		}
		2 {	DisplayOut 'Disabling Cast to Device Context item...' 12 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked'
			Set-ItemProperty -Path $Path -Name '{7AD84985-87B4-4a16-BE58-8B72A5B390F7}' -Type String -Value 'Play to Menu' ;Break
		}
	}

	Switch($PreviousVersions) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Previous Versions Context item...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Previous Versions Context item...' 11 0
			New-Item -Path 'HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' -Force | Out-Null
			New-Item -Path 'HKCR:\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' -Force | Out-Null
			New-Item -Path 'HKCR:\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' -Force | Out-Null
			New-Item -Path 'HKCR:\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' -Force | Out-Null ;Break
		}
		2 {	DisplayOut 'Disabling Previous Versions Context item...' 12 0
			RemoveSetPath 'HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}'
			RemoveSetPath 'HKCR:\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}'
			RemoveSetPath 'HKCR:\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}'
			RemoveSetPath 'HKCR:\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' ;Break
		}
	}

	Switch($IncludeinLibrary) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Include in Library Context item...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Include in Library Context item...' 11 0
			Set-ItemProperty -Path 'HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location' -Name '(Default)' -Type String -Value '{3dad6c5d-2167-4cae-9914-f99e41c12cfa}' ;Break
		}
		2 {	DisplayOut 'Disabling Include in Library...' 12 0
			Set-ItemProperty -Path 'HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location' -Name '(Default)' -Type String -Value '' ;Break
		}
	}

	Switch($PinToStart) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Pin To Start Context item...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Pin To Start Context item...' 11 0
			New-Item -Path 'HKCR:\*\shellex\ContextMenuHandlers\{90AA3A4E-1CBA-4233-B8BB-535773D48449}' -Force | Out-Null
			New-Item -Path 'HKCR:\*\shellex\ContextMenuHandlers\{a2a9545d-a0c2-42b4-9708-a0b2badd77c8}' -Force | Out-Null
			Set-ItemProperty -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\{90AA3A4E-1CBA-4233-B8BB-535773D48449}' -Name '(Default)' -Type String -Value 'Taskband Pin'
			Set-ItemProperty -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\{a2a9545d-a0c2-42b4-9708-a0b2badd77c8}' -Name '(Default)' -Type String -Value 'Start Menu Pin'
			Set-ItemProperty -Path 'HKCR:\Folder\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value '{470C0EBD-5D73-4d58-9CED-E91E22E23282}'
			Set-ItemProperty -Path 'HKCR:\exefile\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value '{470C0EBD-5D73-4d58-9CED-E91E22E23282}'
			Set-ItemProperty -Path 'HKCR:\Microsoft.Website\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value '{470C0EBD-5D73-4d58-9CED-E91E22E23282}'
			Set-ItemProperty -Path 'HKCR:\mscfile\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value '{470C0EBD-5D73-4d58-9CED-E91E22E23282}' ;Break
		}
		2 {	DisplayOut 'Disabling Pin To Start Context item...' 12 0
			Remove-Item -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\{90AA3A4E-1CBA-4233-B8BB-535773D48449}' -Force
			Remove-Item -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\{a2a9545d-a0c2-42b4-9708-a0b2badd77c8}' -Force
			Set-ItemProperty -Path 'HKCR:\Folder\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value ''
			Set-ItemProperty -Path 'HKCR:\exefile\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value ''
			Set-ItemProperty -Path 'HKCR:\Microsoft.Website\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value ''
			Set-ItemProperty -Path 'HKCR:\mscfile\shellex\ContextMenuHandlers\PintoStartScreen' -Name '(Default)' -Type String -Value '' ;Break
		}
	}

	Switch($PinToQuickAccess) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Pin To Quick Access Context item...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Pin To Quick Access Context item...' 11 0
			$Path = CheckSetPath 'HKCR:\Folder\shell\pintohome'
			New-ItemProperty -Path $Path -Name 'MUIVerb' -Type String -Value '@shell32.dll,-51377'
			New-ItemProperty -Path $Path -Name 'AppliesTo' -Type String -Value 'System.ParsingName:<>"::{679f85cb-0220-4080-b29b-5540cc05aab6}" AND System.ParsingName:<>"::{645FF040-5081-101B-9F08-00AA002F954E}" AND System.IsFolder:=System.StructuredQueryType.Boolean#True'
			$Path = CheckSetPath  "$Path\command"
			New-ItemProperty -Path "$Path" -Name 'DelegateExecute' -Type String -Value '{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}'
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Classes\Folder\shell\pintohome'
			New-ItemProperty -Path $Path -Name 'MUIVerb' -Type String -Value '@shell32.dll,-51377'
			New-ItemProperty -Path $Path -Name 'AppliesTo' -Type String -Value 'System.ParsingName:<>"::{679f85cb-0220-4080-b29b-5540cc05aab6}" AND System.ParsingName:<>"::{645FF040-5081-101B-9F08-00AA002F954E}" AND System.IsFolder:=System.StructuredQueryType.Boolean#True'
			$Path = CheckSetPath  "$Path\command"
			New-ItemProperty -Path "$Path" -Name 'DelegateExecute' -Type String -Value '{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}' ;Break
		}
		2 {	DisplayOut 'Disabling Pin To Quick Access Context item...' 12 0
			RemoveSetPath 'HKCR:\Folder\shell\pintohome'
			RemoveSetPath 'HKLM:\SOFTWARE\Classes\Folder\shell\pintohome' ;Break
		}
	}

	Switch($ShareWith) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Share With/Share Context item...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Share With/Share Context item...' 11 0
			Set-ItemProperty -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}'
			Set-ItemProperty -Path 'HKCR:\Directory\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}'
			Set-ItemProperty -Path 'HKCR:\Directory\shellex\CopyHookHandlers\Sharing' -Name '(Default)' -Type String -Value '{40dd6e20-7c17-11ce-a804-00aa003ca9f6}'
			Set-ItemProperty -Path 'HKCR:\Drive\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}'
			Set-ItemProperty -Path 'HKCR:\Directory\shellex\PropertySheetHandlers\Sharing' -Name '(Default)' -Type String -Value '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}'
			Set-ItemProperty -Path 'HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}'
			Set-ItemProperty -Path 'HKCR:\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}'
			Set-ItemProperty -Path 'HKCR:\*\shellex\ContextMenuHandlers\ModernSharing' -Name '(Default)' -Type String -Value '{e2bf9676-5f8f-435c-97eb-11607a5bedf7}' ;Break
		}
		2 {	DisplayOut 'Disabling Share/Share With...' 12 0
			Set-ItemProperty -LiteralPath 'HKCR:\*\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value ''
			Set-ItemProperty -Path 'HKCR:\Directory\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value ''
			Set-ItemProperty -Path 'HKCR:\Directory\shellex\CopyHookHandlers\Sharing' -Name '(Default)' -Type String -Value ''
			Set-ItemProperty -Path 'HKCR:\Directory\shellex\PropertySheetHandlers\Sharing' -Name '(Default)' -Type String -Value ''
			Set-ItemProperty -Path 'HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value ''
			Set-ItemProperty -Path 'HKCR:\Drive\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value ''
			Set-ItemProperty -Path 'HKCR:\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing' -Name '(Default)' -Type String -Value ''
			Set-ItemProperty -Path 'HKCR:\*\shellex\ContextMenuHandlers\ModernSharing' -Name '(Default)' -Type String -Value '' ;Break
		}
	}

	Switch($SendTo) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Send To Context item...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Send To Context item...' 11 0
			$Path = CheckSetPath 'HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo'
			Set-ItemProperty -Path $Path -Name '(Default)' -Type String -Value '{7BA4C740-9E81-11CF-99D3-00AA004AE837}' | Out-Null ;Break
		}
		2 {	DisplayOut 'Disabling Send To Context item...' 12 0
			RemoveSetPath 'HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo' ;Break
		}
	}

	BoxItem 'Task Bar Items'
	Switch($BatteryUIBar) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Battery UI Bar...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling New Battery UI Bar...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell' -Name 'UseWin32BatteryFlyout' ;Break
		}
		2 {	DisplayOut 'Enabling Old Battery UI Bar...' 12 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell'
			Set-ItemProperty -Path $Path -Name 'UseWin32BatteryFlyout' -Type DWord -Value 1 ;Break
		}
	}

	Switch($ClockUIBar) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Clock UI Bar...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling New Clock UI Bar...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell' -Name 'UseWin32TrayClockExperience' ;Break
		}
		2 {	DisplayOut 'Enabling Old Clock UI Bar...' 12 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell'
			Set-ItemProperty -Path $Path -Name 'UseWin32TrayClockExperience' -Type DWord -Value 1 ;Break
		}
	}

	Switch($VolumeControlBar) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Volume Control Bar...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling New Volume Control Bar (Horizontal)...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC' -Name 'EnableMtcUvc' ;Break
		}
		2 {	DisplayOut 'Enabling Classic Volume Control Bar (Vertical)...' 12 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC'
			Set-ItemProperty -Path $Path -Name 'EnableMtcUvc' -Type DWord -Value 0 ;Break
		}
	}

	Switch($TaskbarSearchBox) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Taskbar Search box / button...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Taskbar Search box / button...' 11 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Hiding Taskbar Search box / button...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Type DWord -Value 0 ;Break
		}
	}

	Switch($TaskViewButton) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Task View button...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Task View button...' 11 0
			Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowTaskViewButton' ;Break
		}
		2 {	DisplayOut 'Hiding Task View button...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowTaskViewButton' -Type DWord -Value 0 ;Break
		}
	}

	Switch($TaskbarIconSize) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Icon Size in Taskbar...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Normal Icon Size in Taskbar...' 11 0
			Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarSmallIcons' ;Break
		}
		2 {	DisplayOut 'Showing Smaller Icons in Taskbar...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarSmallIcons' -Type DWord -Value 1 ;Break
		}
	}

	Switch($TaskbarGrouping) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Taskbar Item Grouping...' 15 0 } ;Break }
		1 {	DisplayOut 'Never Group Taskbar Items...' 16 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarGlomLevel' -Type DWord -Value 2 ;Break
		}
		2 {	DisplayOut 'Always Group Taskbar Items...' 16 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarGlomLevel' -Type DWord -Value 0 ;Break
		}
		3 {	DisplayOut 'When Needed Group Taskbar Items...' 16 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarGlomLevel' -Type DWord -Value 1 ;Break
		}
	}

	Switch($TrayIcons) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Tray icons...' 15 0 } ;Break }
		1 {	DisplayOut 'Hiding Tray Icons...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Type DWord -Value 1
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Showing All Tray Icons...' 11 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Type DWord -Value 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Type DWord -Value 0 ;Break
		}
	}

	Switch($SecondsInClock) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Seconds in Taskbar Clock...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Seconds in Taskbar Clock...' 11 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSecondsInSystemClock' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Hiding Seconds in Taskbar Clock...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSecondsInSystemClock' -Type DWord -Value 0 ;Break
		}
	}

	Switch($LastActiveClick) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Last Active Click...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Last Active Click...' 11 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LastActiveClick' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Disabling Last Active Click...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LastActiveClick' -Type DWord -Value 0 ;Break
		}
	}

	Switch($TaskBarOnMultiDisplay) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Taskbar on Multiple Displays...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Taskbar on Multiple Displays...' 11 0
			Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MMTaskbarEnabled' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Hiding Taskbar on Multiple Displays...' 12 0
			Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MMTaskbarEnabled' -Type DWord -Value 0 ;Break
		}
	}

	Switch($TaskbarButtOnDisplay) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Taskbar Buttons on Multiple Displays...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Taskbar Buttons on All Taskbars...' 16 0
			Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MMTaskbarMode' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Showing Taskbar Buttons on Taskbar where Window is open...' 16 0
			Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MMTaskbarMode' -Type DWord -Value 2 ;Break
		}
		3 {	DisplayOut 'Showing Taskbar Buttons on Main Taskbar and where Window is open...' 16 0
			Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MMTaskbarMode' -Type DWord -Value 1 ;Break
		}
	}

	BoxItem 'Star Menu Items'
	Switch($StartMenuWebSearch) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Bing Search in Start Menu...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Bing Search in Start Menu...' 11 0
			Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled'
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'DisableWebSearch' ;Break
		}
		2 {	DisplayOut 'Disabling Bing Search in Start Menu...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled' -Type DWord -Value 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
			Set-ItemProperty -Path $Path -Name 'DisableWebSearch' -Type DWord -Value 1 ;Break
		}
	}

	Switch($StartSuggestions) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Start Menu Suggestions...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Start Menu Suggestions...' 11 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
			Set-ItemProperty -Path $Path -Name 'ContentDeliveryAllowed' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'OemPreInstalledAppsEnabled' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'PreInstalledAppsEnabled' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'PreInstalledAppsEverEnabled' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'SilentInstalledAppsEnabled' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'SystemPaneSuggestionsEnabled' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'Start_TrackProgs' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'SubscribedContent-338387Enabled' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'SubscribedContent-338388Enabled' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'SubscribedContent-338389Enabled' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'SubscribedContent-338393Enabled' -Type DWord -Value 1
			Set-ItemProperty -Path $Path -Name 'SubscribedContent-338398Enabled' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Disabling Start Menu Suggestions...' 12 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
			Set-ItemProperty -Path $Path -Name 'ContentDeliveryAllowed' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'OemPreInstalledAppsEnabled' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'PreInstalledAppsEnabled' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'PreInstalledAppsEverEnabled' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'SilentInstalledAppsEnabled' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'SystemPaneSuggestionsEnabled' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'Start_TrackProgs' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'SubscribedContent-338387Enabled' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'SubscribedContent-338388Enabled' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'SubscribedContent-338389Enabled' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'SubscribedContent-338393Enabled' -Type DWord -Value 0
			Set-ItemProperty -Path $Path -Name 'SubscribedContent-338398Enabled' -Type DWord -Value 0 ;Break
		}
	}

	Switch($MostUsedAppStartMenu) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Most used Apps in Start Menu...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Most used Apps in Start Menu...' 11 0
			Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_TrackProgs' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Hiding Most used Apps in Start Menu...' 12 0
			Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_TrackProgs' -Type DWord -Value 0 ;Break
		}
	}

	Switch($RecentItemsFrequent) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Recent Items and Frequent Places...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Recent Items and Frequent Places...' 11 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'
			Set-ItemProperty -Path $Path -Name 'Start_TrackDocs' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Disabling Recent Items and Frequent Places...' 12 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'
			Set-ItemProperty -Path $Path -Name 'Start_TrackDocs' -Type DWord -Value 0 ;Break
		}
	}

	BoxItem 'Explorer Items'
	Switch($PidInTitleBar) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Process ID on Title Bar...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Process ID on Title Bar...' 11 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowPidInTitle' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Hiding Process ID on Title Bar...' 12 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowPidInTitle' ;Break
		}
	}

	Switch($AeroSnap) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Aero Snap...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Aero Snap...' 11 0
			Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'WindowArrangementActive' -Type String -Value 1 ;Break
		}
		2 {	DisplayOut 'Disabling Aero Snap...' 12 0
			Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'WindowArrangementActive' -Type String -Value 0 ;Break
		}
	}

	Switch($AeroShake) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Aero Shake...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Aero Shake...' 11 0
			Remove-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name 'NoWindowMinimizingShortcuts' ;Break
		}
		2 {	DisplayOut 'Disabling Aero Shake...' 12 0
			$Path = CheckSetPath 'HKCU:\Software\Policies\Microsoft\Windows\Explorer'
			Set-ItemProperty -Path $Path -Name 'NoWindowMinimizingShortcuts' -Type DWord -Value 1 ;Break
		}
	}

	Switch($KnownExtensions) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Known File Extensions...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Known File Extensions...' 11 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Hiding Known File Extensions...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Type DWord -Value 1 ;Break
		}
	}

	Switch($HiddenFiles) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Hidden Files...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Hidden Files...' 11 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Hiding Hidden Files...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Type DWord -Value 2 ;Break
		}
	}

	Switch($SystemFiles) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping System Files...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing System Files...' 11 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSuperHidden' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Hiding System fFiles...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSuperHidden' -Type DWord -Value 0 ;Break
		}
	}

	Switch($ExplorerOpenLoc) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Default Explorer view to Quick Access...' 15 0 } ;Break }
		1 {	DisplayOut 'Changing Default Explorer view to Quick Access...' 16 0
			Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' ;Break
		}
		2 {	DisplayOut 'Changing Default Explorer view to This PC...' 16 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -Type DWord -Value 1 ;Break
		}
	}

	Switch($RecentFileQikAcc) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Recent Files in Quick Access...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Recent Files in Quick Access...' 11 0
			$Path = 'Microsoft\Windows\CurrentVersion\Explorer'
			Set-ItemProperty -Path "HKCU:\SOFTWARE\$Path" -Name 'ShowRecent' -Type DWord -Value 1
			Set-ItemProperty -Path 'HKLM:\$Path\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}' -Name '(Default)' -Type String -Value 'Recent Items Instance Folder'
			If($OSType -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" -Name '(Default)' -Type String -Value 'Recent Items Instance Folder' } ;Break
		}
		2 {	DisplayOut 'Hiding Recent Files in Quick Access...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowRecent' -Type DWord -Value 0 ;Break
		}
		3 {	DisplayOut 'Removing Recent Files in Quick Access...' 15 0
			$Path = 'Microsoft\Windows\CurrentVersion\Explorer'
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\$Path' -Name 'ShowRecent' -Type DWord -Value 0
			RemoveSetPath "HKLM:\SOFTWARE\$Path\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}"
			RemoveSetPath "HKLM:\SOFTWARE\Wow6432Node\$Path\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" ;Break
		}
	}

	Switch($FrequentFoldersQikAcc) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Frequent Folders in Quick Access...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Frequent Folders in Quick Access...' 11 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowFrequent' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Hiding Frequent Folders in Quick Access...' 12 0
			Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowFrequent' -Type DWord -Value 0 ;Break
		}
	}

	Switch($WinContentWhileDrag) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Window Content while Dragging...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Window Content while Dragging...' 11 0
			Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'DragFullWindows' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Hiding Window Content while Dragging...' 12 0
			Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'DragFullWindows' -Type DWord -Value 0 ;Break
		}
	}

	Switch($Autoplay) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Autoplay...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Autoplay...' 11 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers' -Name 'DisableAutoplay' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Disabling Autoplay...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers' -Name 'DisableAutoplay' -Type DWord -Value 1 ;Break
		}
	}

	Switch($Autorun) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Autorun for all Drives...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Autorun for all Drives...' 11 0
			Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'NoDriveTypeAutoRun' ;Break
		}
		2 {	DisplayOut 'Disabling Autorun for all Drives...' 12 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
			Set-ItemProperty -Path $Path -Name 'NoDriveTypeAutoRun' -Type DWord -Value 255 ;Break
		}
	}

	Switch($StoreOpenWith) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Search Windows Store for Unknown Extensions...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Search Windows Store for Unknown Extensions...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'NoUseStoreOpenWith' ;Break
		}
		2 {	DisplayOut 'Disabling Search Windows Store for Unknown Extensions...' 12 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
			Set-ItemProperty -Path $Path -Name 'NoUseStoreOpenWith' -Type DWord -Value 1 ;Break
		}
	}

	Switch($WinXPowerShell) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Win+X PowerShell to Command Prompt...' 15 0 } ;Break }
		1 {	DisplayOut 'Changing Win+X Command Prompt to PowerShell...' 11 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'DontUsePowerShellOnWinX' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Changing Win+X PowerShell to Command Prompt...' 12 0
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'DontUsePowerShellOnWinX' -Type DWord -Value 1 ;Break
		}
	}

	Switch($TaskManagerDetails) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Task Manager Details...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Task Manager Details...' 11 0
			$Path =  'HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager'
			$TaskManKey = Get-ItemProperty -Path $Path -Name 'Preferences'
			If(!($TaskManKey)) {
				$taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
				While(!($TaskManKey)) {
					Start-Sleep -m 250
					$TaskManKey = Get-ItemProperty -Path $Path -Name 'Preferences'
				}
				Stop-Process $taskmgr | Out-Null
			}
			$TaskManKey.Preferences[28] = 0
			Set-ItemProperty -Path $Path -Name 'Preferences' -Type Binary -Value $TaskManKey.Preferences ;Break
		}
		2 {	DisplayOut 'Hiding Task Manager Details...' 12 0
			$Path = CheckSetPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager'
			$TaskManKey = Get-ItemProperty -Path $Path -Name 'Preferences'
			If($TaskManKey) {
				$TaskManKey.Preferences[28] = 1
				Set-ItemProperty -Path $Path -Name 'Preferences' -Type Binary -Value $TaskManKey.Preferences
			} ;Break
		}
	}

	If($BuildVer -ge 16299) {
		Switch($WinXPowerShell) {
			0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Re-Opening Apps on Boot...' 15 0 } ;Break }
			1 {	DisplayOut 'Enableing Re-Opening Apps on Boot (Apps reopen on boot)...' 11 0
				Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'DisableAutomaticRestartSignOn' -Type DWord -Value 0 ;Break
			}
			2 {	DisplayOut "Disabling Re-Opening Apps on Boot (Apps won't reopen on boot)..." 12 0
				Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'DisableAutomaticRestartSignOn' -Type DWord -Value 1 ;Break
			}
		}
	}

	If($BuildVer -ge 17133){
		Switch($WinXPowerShell) {
			0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Windows Timeline...' 15 0 } ;Break }
			1 {	DisplayOut 'Enableing Windows Timeline...' 11 0
				Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableActivityFeed' -Type DWord -Value 1 ;Break
			}
			2 {	DisplayOut "Disabling Windows Timeline..." 12 0
				Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableActivityFeed' -Type DWord -Value 0 ;Break
			}
		}
	}

	Switch($LongFilePath) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Long File Path...' 15 0 } ;Break }
		1 {	DisplayOut 'Enableing Long File Path...' 11 0
			Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Type DWord -Value 1
			Set-ItemProperty -Path 'HKLM:\SYSTEM\ControlSet001\Control\FileSystem' -Name 'LongPathsEnabled' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut "Disabling Long File Path..." 12 0
			Remove-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled'
			Remove-ItemProperty -Path 'HKLM:\SYSTEM\ControlSet001\Control\FileSystem' -Name 'LongPathsEnabled' ;Break
		}
	}

	BoxItem "'This PC' Items"
	Switch($DesktopIconInThisPC) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Desktop folder in This PC...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Desktop folder in This PC...' 11 0
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag'
			$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}'
			New-Item -Path "HKLM:\SOFTWARE\$Path" -Force
			New-Item -Path "HKLM:\SOFTWARE\$Path1" -Force
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
			If($OSType -eq 64){
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Force
				Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" -Force
			} ;Break
		}
		2 {	DisplayOut 'Hiding Desktop folder in This PC...' 12 0
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag'
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
			If($OSType -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide' } ;Break
		}
		3 {	DisplayOut 'Removing Desktop folder in This PC...' 13 0
			RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}'
			RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}' ;Break
		}
	}

	Switch($DocumentsIconInThisPC) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Documents folder in This PC...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Documents folder in This PC...' 11 0
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag'
			$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}'
			$Path2 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}'
			New-Item -Path "HKLM:\SOFTWARE\$Path" -Force
			New-Item -Path "HKLM:\SOFTWARE\$Path1" -Force
			New-Item -Path "HKLM:\SOFTWARE\$Path2" -Force
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
			If($OSType -eq 64){
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Force
				Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" -Force
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path2" -Force
			} ;Break
		}
		2 {	DisplayOut 'Hiding Documents folder in This PC...' 12 0
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag'
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
			If($OSType -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name "ThisPCPolicy" -Type String -Value "Hide" } ;Break
		}
		3 {	DisplayOut 'Removing Documents folder in This PC...' 13 0
			RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}'
			RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}'
			RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}'
			RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}' ;Break
		}
	}

	Switch($DownloadsIconInThisPC) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Downloads folder in This PC...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Downloads folder in This PC...' 11 0
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag'
			$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}'
			$Path2 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}'
			New-Item -Path "HKLM:\SOFTWARE\$Path" -Force
			New-Item -Path "HKLM:\SOFTWARE\$Path1" -Force
			New-Item -Path "HKLM:\SOFTWARE\$Path2" -Force
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
			If($OSType -eq 64){
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Force
				Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" -Force
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path2" -Force
			} ;Break
		}
		2 {	DisplayOut 'Hiding Downloads folder in This PC...' 12 0
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag'
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
			If($OSType -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name "ThisPCPolicy" -Type String -Value "Hide" } ;Break
		}
		3 {	DisplayOut 'Removing Downloads folder in This PC...' 13 0
			RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}'
			RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}'
			RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}'
			RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}' ;Break
		}
	}

	Switch($MusicIconInThisPC) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Music folder in This PC...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Music folder in This PC...' 11 0
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag'
			$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}'
			$Path2 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}'
			New-Item -Path "HKLM:\SOFTWARE\$Path" -Force
			New-Item -Path "HKLM:\SOFTWARE\$Path1" -Force
			New-Item -Path "HKLM:\SOFTWARE\$Path2" -Force
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
			If($OSType -eq 64){
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Force
				Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" -Force
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path2" -Force
			} ;Break
		}
		2 {	DisplayOut 'Hiding Music folder in This PC...' 12 0
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag'
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
			If($OSType -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name "ThisPCPolicy" -Type String -Value "Hide" } ;Break
		}
		3 {	DisplayOut 'Removing Music folder in This PC...' 13 0
			RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}'
			RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}'
			RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}'
			RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}' ;Break
		}
	}

	Switch($PicturesIconInThisPC) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Pictures folder in This PC...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Pictures folder in This PC...' 11 0
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag'
			$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}'
			$Path2 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}'
			New-Item -Path "HKLM:\SOFTWARE\$Path" -Force
			New-Item -Path "HKLM:\SOFTWARE\$Path1" -Force
			New-Item -Path "HKLM:\SOFTWARE\$Path2" -Force
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
			If($OSType -eq 64){
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Force
				Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" -Force
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path2" -Force
			} ;Break
		}
		2 {	DisplayOut 'Hiding Pictures folder in This PC...' 12 0
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag'
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
			If($OSType -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name "ThisPCPolicy" -Type String -Value "Hide" } ;Break
		}
		3 {	DisplayOut 'Removing Pictures folder in This PC...' 13 0
			RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}'
			RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}'
			RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}'
			RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}' ;Break
		}
	}

	Switch($VideosIconInThisPC) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Videos folder in This PC...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Videos folder in This PC...' 11 0
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag'
			$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}'
			$Path2 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}'
			New-Item -Path "HKLM:\SOFTWARE\$Path" -Force
			New-Item -Path "HKLM:\SOFTWARE\$Path1" -Force
			New-Item -Path "HKLM:\SOFTWARE\$Path2" -Force
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
			If($OSType -eq 64){
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Force
				Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" -Force
				New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path2"
			} ;Break
		}
		2 {	DisplayOut 'Hiding Videos folder in This PC...' 12 0
			$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag'
			Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
			If($OSType -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name "ThisPCPolicy" -Type String -Value "Hide" } ;Break
		}
		3 {	DisplayOut 'Removing Videos folder in This PC...' 13 0
			RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}'
			RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}'
			RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}'
			RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}' ;Break
		}
	}

	If($BuildVer -ge 16299){
		Switch($ThreeDobjectsIconInThisPC) {
			0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping 3D Object folder in This PC...' 15 0 } ;Break }
			1 {	DisplayOut 'Showing 3D Object folder in This PC...' 11 0
				$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag'
				$Path1 = '\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
				New-Item -Path "HKLM:\SOFTWARE\$Path" -Force
				New-Item -Path "HKLM:\SOFTWARE\$Path1" -Force
				Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
				If($OSType -eq 64){
					New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Force
					Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Show'
					New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\$Path1" -Force
				} ;Break
			}
			2 {	DisplayOut 'Hiding 3D Object folder in This PC...' 12 0
				$Path = '\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag'
				Set-ItemProperty -Path "HKLM:\SOFTWARE\$Path" -Name 'ThisPCPolicy' -Type String -Value 'Hide'
				If($OSType -eq 64){ Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\$Path" -Name "ThisPCPolicy" -Type String -Value "Hide" } ;Break
			}
			3 {	DisplayOut 'Removing 3D Object folder in This PC...' 13 0
				RemoveSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
				RemoveSetPath 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}' ;Break
			}
		}
	}

	BoxItem 'Desktop Items'
	$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu'
	Switch($ThisPCOnDesktop) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping This PC Icon on Desktop...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing This PC Shortcut on Desktop...' 11 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
			Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 0
			Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Hiding This PC Shortcut on Desktop...' 12 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
			Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 1
			Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 1 ;Break
		}
	}

	Switch($NetworkOnDesktop) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Network Icon on Desktop...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Network Icon on Desktop...' 11 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
			Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}' -Type DWord -Value 0
			Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Hiding Network Icon on Desktop...' 12 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
			Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}' -Type DWord -Value 1
			Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}' -Type DWord -Value 1 ;Break
		}
	}

	Switch($RecycleBinOnDesktop) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Recycle Bin Icon on Desktop...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Recycle Bin Icon on Desktop...' 11 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
			Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Type DWord -Value 0
			Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Hiding Recycle Bin Icon on Desktop...' 12 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
			Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Type DWord -Value 1
			Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Type DWord -Value 1 ;Break
		}
	}

	Switch($RecycleBinOnDesktop) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Users File Icon on Desktop...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Users File Icon on Desktop...' 11 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
			Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Type DWord -Value 0
			Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{59031a47-3f72-44a7-89c5-5595fe6b30ee}' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Hiding Users File Icon on Desktop...' 12 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
			Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Type DWord -Value 1
			Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{59031a47-3f72-44a7-89c5-5595fe6b30ee}' -Type DWord -Value 1 ;Break
		}
	}

	Switch($ControlPanelOnDesktop) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Control Panel Icon on Desktop...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Control Panel Icon on Desktop...' 11 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
			Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}' -Type DWord -Value 0
			Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}' -Type DWord -Value 0 ;Break
		}
		2 {	DisplayOut 'Hiding Control Panel Icon on Desktop...' 12 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons'
			Set-ItemProperty -Path "$Path\ClassicStartMenu" -Name '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}' -Type DWord -Value 1
			Set-ItemProperty -Path "$Path\NewStartPanel" -Name '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}' -Type DWord -Value 1 ;Break
		}
	}

	BoxItem 'Photo Viewer Settings'
	Switch($PVFileAssociation) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Photo Viewer File Association...' 15 0 } ;Break }
		1 {	DisplayOut 'Setting Photo Viewer File Association for bmp, gif, jpg, png and tif...' 11 0
			ForEach($type In @('Paint.Picture', 'giffile', 'jpegfile', 'pngfile')) {
				New-Item -Path $("HKCR:\$type\shell\open") -Force | Out-Null
				New-Item -Path $("HKCR:\$type\shell\open\command") | Out-Null
				Set-ItemProperty -Path $("HKCR:\$type\shell\open") -Name 'MuiVerb' -Type ExpandString -Value "@%ProgramFiles%\Windows Photo Viewer\photoviewer.dll,-3043"
				Set-ItemProperty -Path $("HKCR:\$type\shell\open\command") -Name '(Default)' -Type ExpandString -Value "%SystemRoot%\System32\rundll32.exe `"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1"
			} ;Break
		}
		2 {	DisplayOut 'Unsetting Photo Viewer File Association for bmp, gif, jpg, png and tif...' 12 0
			RemoveSetPath 'HKCR:\Paint.Picture\shell\open'
			Remove-ItemProperty -Path 'HKCR:\giffile\shell\open' -Name 'MuiVerb'
			Set-ItemProperty -Path 'HKCR:\giffile\shell\open' -Name 'CommandId' -Type String -Value 'IE.File'
			Set-ItemProperty -Path 'HKCR:\giffile\shell\open\command' -Name '(Default)' -Type String -Value "`"$Env:SystemDrive\Program Files\Internet Explorer\iexplore.exe`" %1"
			Set-ItemProperty -Path 'HKCR:\giffile\shell\open\command' -Name 'DelegateExecute' -Type String -Value '{17FE9752-0B5A-4665-84CD-569794602F5C}'
			RemoveSetPath 'HKCR:\jpegfile\shell\open' ;Break
		}
	}

	Switch($PVOpenWithMenu) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Photo Viewer Open with Menu...' 15 0 } ;Break }
		1 {	DisplayOut 'Adding Photo Viewer to Open with Menu...' 11 0
			New-Item -Path 'HKCR:\Applications\photoviewer.dll\shell\open\command' -Force | Out-Null
			New-Item -Path 'HKCR:\Applications\photoviewer.dll\shell\open\DropTarget' -Force | Out-Null
			Set-ItemProperty -Path 'HKCR:\Applications\photoviewer.dll\shell\open' -Name 'MuiVerb' -Type String -Value '@photoviewer.dll,-3043'
			Set-ItemProperty -Path 'HKCR:\Applications\photoviewer.dll\shell\open\command' -Name '(Default)' -Type ExpandString -Value "%SystemRoot%\System32\rundll32.exe `"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1"
			Set-ItemProperty -Path 'HKCR:\Applications\photoviewer.dll\shell\open\DropTarget' -Name 'Clsid' -Type String -Value '{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}' ;Break
		}
		2 {	DisplayOut 'Removing Photo Viewer from Open with Menu...' 12 0
			RemoveSetPath 'HKCR:\Applications\photoviewer.dll\shell\open' ;Break
		}
	}

	BoxItem 'Lockscreen Items'
	Switch($LockScreen) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Lock Screen...' 15 0 } ;Break }
		1 {	If($BuildVer -eq 10240 -or $BuildVer -eq 10586) {
				DisplayOut 'Enabling Lock Screen...' 11 0
				Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization' -Name 'NoLockScreen'
			} ElseIf($BuildVer -ge 14393) {
				DisplayOut 'Enabling Lock screen (removing scheduler workaround)...' 11 0
				Unregister-ScheduledTask -TaskName 'Disable LockScreen' -Confirm:$False
			} Else {
				DisplayOut 'Unable to Enable Lock screen...' 11 0
			} ;Break
		}
		2 {	If($BuildVer -eq 10240 -or $BuildVer -eq 10586) {
				DisplayOut 'Disabling Lock Screen...' 12 0
				$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
				Set-ItemProperty -Path $Path -Name 'NoLockScreen' -Type DWord -Value 1
			} ElseIf($BuildVer -ge 14393) {
				DisplayOut 'Disabling Lock screen using scheduler workaround...' 12 0
				$service = New-Object -com Schedule.Service
				$service.Connect()
				$task = $service.NewTask(0)
				$task.Settings.DisallowStartIfOnBatteries = $False
				$trigger = $task.Triggers.Create(9)
				$trigger = $task.Triggers.Create(11)
				$trigger.StateChange = 8
				$action = $task.Actions.Create(0)
				$action.Path = 'reg.exe'
				$action.Arguments = "add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\SessionData /t REG_DWORD /v AllowLockScreen /d 0 /f"
				$service.GetFolder('\').RegisterTaskDefinition('Disable LockScreen', $task, 6, 'NT AUTHORITY\SYSTEM', $null, 4) | Out-Null
			} Else {
				DisplayOut 'Unable to Disable Lock screen...' 12 0
			} ;Break
		}
	}

	Switch($PowerMenuLockScreen) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Power Menu on Lock Screen...' 15 0 } ;Break }
		1 {	DisplayOut 'Showing Power Menu on Lock Screen...' 11 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'shutdownwithoutlogon' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Hiding Power Menu on Lock Screen...' 12 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'shutdownwithoutlogon' -Type DWord -Value 0 ;Break
		}
	}

	Switch($CameraOnLockscreen) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Camera at Lockscreen...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Camera at Lockscreen...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization' -Name 'NoLockScreenCamera' ;Break
		}
		2 {	DisplayOut 'Disabling Camera at Lockscreen...' 12 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
			Set-ItemProperty -Path $Path -Name 'NoLockScreenCamera' -Type DWord -Value 1 ;Break
		}
	}

	BoxItem 'Misc Items'
	If($BuildVer -ge 17133){
		Switch($AccountProtectionWarn) {
			0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Account Protection Warning...' 15 0 } ;Break }
			1 {	DisplayOut 'Enabling Account Protection Warning...' 11 0
				Remove-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows Security Health\State' -Name 'AccountProtection_MicrosoftAccount_Disconnected' ;Break
			}
			2 {	DisplayOut 'Disabling Account Protection Warning...' 12 0
				$Path = CheckSetPath 'HKCU:\SOFTWARE\Microsoft\Windows Security Health\State'
				Set-ItemProperty $Path -Name 'AccountProtection_MicrosoftAccount_Disconnected' -Type DWord -Value 1 ;Break
			}
		}
	}

	Switch($ActionCenter) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Action Center...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Action Center...' 11 0
			Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'DisableNotificationCenter'
			Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' -Name 'ToastEnabled' ;Break
		}
		2 {	DisplayOut 'Disabling Action Center...' 12 0
			$Path = CheckSetPath 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
			Set-ItemProperty -Path $Path -Name 'DisableNotificationCenter' -Type DWord -Value 1
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' -Name 'ToastEnabled' -Type DWord -Value 0 ;Break
		}
	}

	Switch($StickyKeyPrompt) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Sticky Key Prompt...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Sticky Key Prompt...' 11 0
			Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name 'Flags' -Type String -Value '510' ;Break
		}
		2 {	DisplayOut 'Disabling Sticky Key Prompt...' 12 0
			Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name 'Flags' -Type String -Value '506' ;Break
		}
	}

	Switch($NumblockOnStart) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Num Lock on Startup...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Num Lock on Startup...' 11 0
			Set-ItemProperty -Path 'HKU:\.DEFAULT\Control Panel\Keyboard' -Name 'InitialKeyboardIndicators' -Type DWord -Value 2147483650 ;Break
		}
		2 {	DisplayOut 'Disabling Num Lock on Startup...' 12 0
			Set-ItemProperty -Path 'HKU:\.DEFAULT\Control Panel\Keyboard' -Name 'InitialKeyboardIndicators' -Type DWord -Value 2147483648 ;Break
		}
	}

	Switch($F8BootMenu) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping F8 boot menu options...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling F8 boot menu options...' 11 0
			bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null ;Break
		}
		2 {	DisplayOut 'Disabling F8 boot menu options...' 12 0
			bcdedit /set `{current`} bootmenupolicy Standard | Out-Null ;Break
		}
	}

	Switch($RemoteUACAcctToken) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Remote UAC Local Account Token Filter...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Remote UAC Local Account Token Filter...' 11 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'LocalAccountTokenFilterPolicy' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Disabling  Remote UAC Local Account Token Filter...' 12 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'LocalAccountTokenFilterPolicy' ;Break
		}
	}

	Switch($HibernatePower) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Hibernate Option...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Hibernate Option...' 11 0
			Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power' -Name 'HibernateEnabled' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Disabling Hibernate Option...' 12 0
			Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power' -Name 'HibernateEnabled' -Type DWord -Value 0 ;Break
		}
	}

	Switch($SleepPower) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Sleep Option...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Sleep Option...' 11 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings'
			Set-ItemProperty -Path $Path -Name 'ShowSleepOption' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Disabling Sleep Option...' 12 0
			Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings' -Name 'ShowSleepOption' -Type DWord -Value 0 ;Break
		}
	}

	Switch($UnpinItems) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Unpinning Items...' 15 0 } ;Break }
		1 {	DisplayOut "`nUnpinning All Startmenu Items..." 12 0
			If($BuildVer -le 16299){
				Get-ChildItem -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount' -Include '*.group' -Recurse | ForEach-Object {
					$data = (Get-ItemProperty -Path "$($_.PsPath)\Current" -Name 'Data').Data -Join ','
					$data = $data.Substring(0, $data.IndexOf(',0,202,30') + 9) + ',0,202,80,0,0'
					Set-ItemProperty -Path "$($_.PsPath)\Current" -Name 'Data' -Type Binary -Value $data.Split(',')
				}
			} Else {
				$key = Get-ChildItem -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount' -Recurse | Where-Object { $_ -like "*start.tilegrid`$windows.data.curatedtilecollection.tilecollection\Current" }
				$data = (Get-ItemProperty -Path $key.PSPath -Name 'Data').Data[0..25] + ([byte[]](202,50,0,226,44,1,1,0,0))
				Set-ItemProperty -Path $key.PSPath -Name 'Data' -Type Binary -Value $data
			} ;Break
		}
	}
<#
	Switch($DisableVariousTasks) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Various Scheduled Tasks...' 15 0 } ;Break }
		1 {	DisplayOut "`nEnabling Various Scheduled Tasks...`n------------------" 12 0
			ForEach($TaskN in $TasksList) { Get-ScheduledTask -TaskName $TaskN | Enable-ScheduledTask } ;Break
		}
		2 {	DisplayOut "`nDisableing Various Scheduled Tasks...`n------------------" 12 0
			ForEach($TaskN in $TasksList) { Get-ScheduledTask -TaskName $TaskN | Disable-ScheduledTask } ;Break
		}
	}
#>
	BoxItem 'Application/Feature Items'
	Switch($OneDrive) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping OneDrive...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling OneDrive...' 11 0
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' -Name 'DisableFileSyncNGSC'
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Type DWord -Value 1 ;Break
		}
		2 {	DisplayOut 'Disabling OneDrive...' 12 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive'
			Set-ItemProperty -Path $Path -Name 'DisableFileSyncNGSC' -Type DWord -Value 1
			Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Type DWord -Value 0 ;Break
		}
	}

	Switch($OneDriveInstall) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping OneDrive Installing...' 15 0 } ;Break }
		1 {	$onedriveS = "$Env:WINDIR\"
			If($OSType -eq 64){ $onedriveS += 'SysWOW64' } Else{ $onedriveS += 'System32' }
			$onedriveS += '\OneDriveSetup.exe'
			If(Test-Path $onedriveS -PathType Leaf) {
				DisplayOut 'Installing OneDrive...' 11 0
				Start-Process $onedriveS -NoNewWindow
			} Else {
				DisplayOut 'OneDrive Setup Not Found...' 13 0
			} ;Break
		}
		2 {	DisplayOut 'Uninstalling OneDrive...' 15 0
			$onedriveS = "$Env:WINDIR\"
			If($OSType -eq 64){ $onedriveS += 'SysWOW64' } Else{ $onedriveS += 'System32' }
			$onedriveS += '\OneDriveSetup.exe'
			If(Test-Path $onedriveS -PathType Leaf) {
				Stop-Process -Name OneDrive -Force
				Start-Sleep -s 3
				Start-Process $onedriveS '/uninstall' -NoNewWindow -Wait | Out-Null
				Start-Sleep -s 3
				Stop-Process -Name explorer -Force
				Start-Sleep -s 3
				Remove-Item "$Env:USERPROFILE\OneDrive" -Force -Recurse
				Remove-Item "$Env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse
				Remove-Item "$Env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse
				Remove-Item "$Env:WINDIR\OneDriveTemp" -Force -Recurse
				Remove-Item -Path 'HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Recurse
				Remove-Item -Path 'HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Force -Recurse
			} ;Break
		}
	}

	Switch($XboxDVR) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Xbox DVR...' 15 0 } ;Break }
		1 {	DisplayOut 'Enabling Xbox DVR...' 11 0
			Set-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled' -Type DWord -Value 1
			Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR' -Name 'AllowGameDVR' ;Break
		}
		2 {	DisplayOut 'Disabling Xbox DVR...' 12 0
			$Path = CheckSetPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR'
			Set-ItemProperty -Path $Path -Name 'AllowGameDVR' -Type DWord -Value 0
			Set-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled' -Type DWord -Value 0 ;Break
		}
	}

	Switch($MediaPlayer) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Windows Media Player...' 15 0 } ;Break }
		1 {	DisplayOut 'Installing Windows Media Player...' 11 0
			If((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'MediaPlayback').State){ Enable-WindowsOptionalFeature -Online -FeatureName 'WindowsMediaPlayer' -NoRestart | Out-Null } ;Break
		}
		2 {	DisplayOut 'Uninstalling Windows Media Player...' 14 0
			If(!((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'MediaPlayback').State)){ Disable-WindowsOptionalFeature -Online -FeatureName 'WindowsMediaPlayer' -NoRestart | Out-Null } ;Break
		}
	}

	Switch($MediaPlayer) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Work Folders Client...' 15 0 } ;Break }
		1 {	DisplayOut 'Installing Work Folders Client...' 11 0
			If((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'WorkFolders-Client').State){ Enable-WindowsOptionalFeature -Online -FeatureName 'WorkFolders-Client' -NoRestart | Out-Null } ;Break
		}
		2 {	DisplayOut 'Uninstalling Work Folders Client...' 14 0
			If(!((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'WorkFolders-Client').State)){ Disable-WindowsOptionalFeature -Online -FeatureName 'WorkFolders-Client' -NoRestart | Out-Null } ;Break
		}
	}

	Switch($MediaPlayer) {
		0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Fax And Scan...' 15 0 } ;Break }
		1 {	DisplayOut 'Installing Fax And Scan....' 11 0
			If((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'FaxServicesClientPackage').State){ Enable-WindowsOptionalFeature -Online -FeatureName 'FaxServicesClientPackage' -NoRestart | Out-Null } ;Break
		}
		2 {	DisplayOut 'Uninstalling Fax And Scan....' 14 0
			If(!((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'FaxServicesClientPackage').State)){ Disable-WindowsOptionalFeature -Online -FeatureName 'FaxServicesClientPackage' -NoRestart | Out-Null } ;Break
		}
	}

	If($BuildVer -ge 14393) {
		Switch($LinuxSubsystem) {
			0 { If($ShowSkipped -eq 1){ DisplayOut 'Skipping Linux Subsystem...' 15 0 } ;Break }
			1 {	DisplayOut 'Installing Linux Subsystem...' 11 0
				If((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'Microsoft-Windows-Subsystem-Linux').State){
					$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'
					Set-ItemProperty -Path $Path -Name 'AllowDevelopmentWithoutDevLicense' -Type DWord -Value 1
					Set-ItemProperty -Path $Path -Name 'AllowAllTrustedApps' -Type DWord -Value 1
					Enable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Windows-Subsystem-Linux' -NoRestart | Out-Null
				} ;Break
			}
			2 {	DisplayOut 'Uninstalling Linux Subsystem...' 14 0
				If(!((Get-WindowsOptionalFeature -Online | Where-Object featurename -Like 'Microsoft-Windows-Subsystem-Linux').State)){
					$Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'
					Set-ItemProperty -Path $Path -Name 'AllowDevelopmentWithoutDevLicense' -Type DWord -Value 0
					Set-ItemProperty -Path $Path -Name 'AllowAllTrustedApps' -Type DWord -Value 0
					Disable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Windows-Subsystem-Linux' -NoRestart | Out-Null
				} ;Break
			}
		}
	}

	If($AppxCount -ne 0) {
		BoxItem 'Waiting for Appx Task to Finish'
		Wait-Job -Name "Win10Script*"
		Remove-Job -Name "Win10Script*"
	}

	If($Restart -eq 1 -And $Release_Type -eq 'Stable') {
		Clear-Host
		ThanksDonate
		$Seconds = 15
		DisplayOutMenu "`nRestarting Computer in " 15 0 0 ;DisplayOutMenu $Seconds 11 0 0 ;DisplayOutMenu ' Seconds...' 15 0 1
		$Message = 'Restarting in'
		Start-Sleep -Seconds 1
		ForEach($Count In (1..$Seconds)){ If($Count -ne 0){ DisplayOutMenu $Message 15 0 0 ;DisplayOutMenu " $($Seconds - $Count)" 11 0 1 ;Start-Sleep -Seconds 1 } }
		DisplayOut 'Restarting Computer...' 13 0
		Restart-Computer
	} ElseIf($Release_Type -eq 'Stable') {
		Write-Host 'Goodbye...'
		If($Automated -eq 0){ Read-Host -Prompt "`nPress any key to exit" }
		Exit
	} ElseIf($Automated -eq 0) {
		ThanksDonate
		Read-Host -Prompt "`nPress any key to Exit"
	}
}

##########
# Script -End
##########

# Used to get all values BEFORE any defined so
# when exporting shows ALL defined after this point
[System.Collections.ArrayList]$Script:WPFList = @()
$AutomaticVariables = Get-Variable -Scope Script

# DO NOT TOUCH THESE
$Script:AppsUnhide = ''
$Script:AppsHide = ''
$Script:AppsUninstall = ''

Function SetDefault {
#--------------------------------------------------------------------------
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## !!                                            !!
## !!            SAFE TO EDIT VALUES             !!
## !!                                            !!
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Edit values (Option) to your preference
# Change to an Option not listed will Skip the Function/Setting

# Note: If you're not sure what something does don't change it or do a web search

# Can ONLY create 1 per 24 hours with this script (Will give an error)
$Script:CreateRestorePoint = 0      #0-Skip, 1-Create --(Restore point before script runs)
$Script:RestorePointName = "Win10 Initial Setup Script"

#Skips Term of Use
$Script:AcceptToS = 1               #1-See ToS, Anything else = Accepts Term of Use
$Script:Automated = 0               #0-Pause at End/Error, Don't Pause at End/Error

$Script:ShowSkipped = 1             #0-Don't Show Skipped, 1-Show Skipped

#Update Related
$Script:VersionCheck = 0            #0-Don't Check for Update, 1-Check for Update (Will Auto Download and run newer version)
#File will be named 'Win10-Menu-Ver.(Version HERE).ps1 (For non Test version)

$Script:BatUpdateScriptFileName = 1 #0-Don't ->, 1-Update Bat file with new script filename (if update is found)

$Script:InternetCheck = 0           #0 = Checks if you have Internet by doing a ping to GitHub.com
                                    #1 = Bypass check if your pings are blocked

#Restart when done? (I recommend restarting when done)
$Script:Restart = 1                 #0-Don't Restart, 1-Restart

#Windows Default for ALL Settings
$Script:WinDefault = 2              #1-Yes*, 2-No
# IF 1 is set then Everything Other than the following will use the Default Win Settings
# ALL Values Above this one, All Metro Apps and OneDriveInstall (Will use what you set)

#Privacy Settings
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:Telemetry = 0               #0-Skip, 1-Enable*, 2-Disable
$Script:WiFiSense = 0               #0-Skip, 1-Enable*, 2-Disable
$Script:SmartScreen = 0             #0-Skip, 1-Enable*, 2-Disable --(phishing and malware filter for some MS Apps/Prog)
$Script:LocationTracking = 0        #0-Skip, 1-Enable*, 2-Disable
$Script:Feedback = 0                #0-Skip, 1-Enable*, 2-Disable
$Script:AdvertisingID = 0           #0-Skip, 1-Enable*, 2-Disable
$Script:Cortana = 0                 #0-Skip, 1-Enable*, 2-Disable
$Script:CortanaSearch = 0           #0-Skip, 1-Enable*, 2-Disable --(If you disable Cortana you can still search with this)
$Script:ErrorReporting = 0          #0-Skip, 1-Enable*, 2-Disable
$Script:AutoLoggerFile = 0          #0-Skip, 1-Enable*, 2-Disable
$Script:DiagTrack = 0               #0-Skip, 1-Enable*, 2-Disable
$Script:WAPPush = 0                 #0-Skip, 1-Enable*, 2-Disable --(type of text message that contains a direct link to a particular Web page)

#Windows Update
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:CheckForWinUpdate = 0       #0-Skip, 1-Enable*, 2-Disable
$Script:WinUpdateType = 0           #0-Skip, 1-Notify, 2-Auto DL, 3-Auto DL+Install*, 4-Local admin chose --(May not work with Home version)
$Script:WinUpdateDownload = 0       #0-Skip, 1-P2P*, 2-Local Only, 3-Disable
$Script:UpdateMSRT = 0              #0-Skip, 1-Enable*, 2-Disable --(Malware Software Removal Tool)
$Script:UpdateDriver = 0            #0-Skip, 1-Enable*, 2-Disable --(Offering of drivers through Windows Update)
$Script:RestartOnUpdate = 0         #0-Skip, 1-Enable*, 2-Disable
$Script:AppAutoDownload = 0         #0-Skip, 1-Enable*, 2-Disable
$Script:UpdateAvailablePopup = 0    #0-Skip, 1-Enable*, 2-Disable

#Service Tweaks
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:UAC = 0                     #0-Skip, 1-Lower, 2-Normal*, 3-Higher
$Script:SharingMappedDrives = 0     #0-Skip, 1-Enable, 2-Disable* --(Sharing mapped drives between users)
$Script:AdminShares = 0             #0-Skip, 1-Enable*, 2-Disable --(Default admin shares for each drive)
$Script:Firewall = 0                #0-Skip, 1-Enable*, 2-Disable
$Script:WinDefender = 0             #0-Skip, 1-Enable*, 2-Disable
$Script:HomeGroups = 0              #0-Skip, 1-Enable*, 2-Disable
$Script:RemoteAssistance = 0        #0-Skip, 1-Enable*, 2-Disable
$Script:RemoteDesktop = 0           #0-Skip, 1-Enable, 2-Disable* --(Remote Desktop w/o Network Level Authentication)

#Context Menu Items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:CastToDevice = 0            #0-Skip, 1-Enable*, 2-Disable
$Script:PreviousVersions = 0        #0-Skip, 1-Enable*, 2-Disable
$Script:IncludeinLibrary = 0        #0-Skip, 1-Enable*, 2-Disable
$Script:PinToStart = 0              #0-Skip, 1-Enable*, 2-Disable
$Script:PinToQuickAccess = 0        #0-Skip, 1-Enable*, 2-Disable
$Script:ShareWith = 0               #0-Skip, 1-Enable*, 2-Disable
$Script:SendTo = 0                  #0-Skip, 1-Enable*, 2-Disable

#Task Bar Items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:BatteryUIBar = 0            #0-Skip, 1-New*, 2-Classic --(Classic is Win 7 version)
$Script:ClockUIBar = 0              #0-Skip, 1-New*, 2-Classic --(Classic is Win 7 version)
$Script:VolumeControlBar = 0        #0-Skip, 1-New(Horizontal)*, 2-Classic(Vertical) --(Classic is Win 7 version)
$Script:TaskbarSearchBox = 0        #0-Skip, 1-Show*, 2-Hide
$Script:TaskViewButton = 0          #0-Skip, 1-Show*, 2-Hide
$Script:TaskbarIconSize = 0         #0-Skip, 1-Normal*, 2-Smaller
$Script:TaskbarGrouping = 0         #0-Skip, 1-Never, 2-Always*, 3-When Needed
$Script:TrayIcons = 0               #0-Skip, 1-Auto*, 2-Always Show
$Script:SecondsInClock = 0          #0-Skip, 1-Show, 2-Hide*
$Script:LastActiveClick = 0         #0-Skip, 1-Enable, 2-Disable* --(Makes Taskbar Buttons Open the Last Active Window)
$Script:TaskBarOnMultiDisplay = 0   #0-Skip, 1-Enable*, 2-Disable
$Script:TaskBarButtOnDisplay = 0    #0-Skip, 1-All, 2-where window is open, 3-Main and where window is open

#Star Menu Items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:StartMenuWebSearch = 0      #0-Skip, 1-Enable*, 2-Disable
$Script:StartSuggestions = 0        #0-Skip, 1-Enable*, 2-Disable --(The Suggested Apps in Start Menu)
$Script:MostUsedAppStartMenu = 0    #0-Skip, 1-Show*, 2-Hide
$Script:RecentItemsFrequent = 0     #0-Skip, 1-Enable*, 2-Disable --(In Start Menu)
$Script:UnpinItems = 0              #0-Skip, 1-Unpin

#Explorer Items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:Autoplay = 0                #0-Skip, 1-Enable*, 2-Disable
$Script:Autorun = 0                 #0-Skip, 1-Enable*, 2-Disable
$Script:PidInTitleBar = 0           #0-Skip, 1-Show, 2-Hide* --(PID = Processor ID)
$Script:AeroSnap = 0                #0-Skip, 1-Enable*, 2-Disable --(Allows you to quickly resize the window you’re currently using)
$Script:AeroShake = 0               #0-Skip, 1-Enable*, 2-Disable
$Script:KnownExtensions = 0         #0-Skip, 1-Show, 2-Hide*
$Script:HiddenFiles = 0             #0-Skip, 1-Show, 2-Hide*
$Script:SystemFiles = 0             #0-Skip, 1-Show, 2-Hide*
$Script:ExplorerOpenLoc = 0         #0-Skip, 1-Quick Access*, 2-ThisPC --(What location it opened when you open an explorer window)
$Script:RecentFileQikAcc = 0        #0-Skip, 1-Show/Add*, 2-Hide, 3-Remove --(Recent Files in Quick Access)
$Script:FrequentFoldersQikAcc = 0   #0-Skip, 1-Show*, 2-Hide --(Frequent Folders in Quick Access)
$Script:WinContentWhileDrag = 0     #0-Skip, 1-Show*, 2-Hide
$Script:StoreOpenWith = 0           #0-Skip, 1-Enable*, 2-Disable
$Script:WinXPowerShell = 0          #0-Skip, 1-Powershell*, 2-Command Prompt
$Script:TaskManagerDetails = 0      #0-Skip, 1-Show, 2-Hide*
$Script:ReopenAppsOnBoot = 0        #0-Skip, 1-Enable*, 2-Disable
$Script:Timeline = 0                #0-Skip, 1-Enable*, 2-Disable
$Script:LongFilePath = 0            #0-Skip, 1-Enable, 2-Disable*

#'This PC' Items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:DesktopIconInThisPC = 0     #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
$Script:DocumentsIconInThisPC = 0   #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
$Script:DownloadsIconInThisPC = 0   #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
$Script:MusicIconInThisPC = 0       #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
$Script:PicturesIconInThisPC = 0    #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
$Script:VideosIconInThisPC = 0      #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
$Script:ThreeDobjectsIconInThisPC = 0   #0-Skip, 1-Show/Add*, 2-Hide, 3- Remove
# CAUTION: Removing them can cause problems

#Desktop Items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:ThisPCOnDesktop = 0         #0-Skip, 1-Show, 2-Hide*
$Script:NetworkOnDesktop = 0        #0-Skip, 1-Show, 2-Hide*
$Script:RecycleBinOnDesktop = 0     #0-Skip, 1-Show, 2-Hide*
$Script:UsersFileOnDesktop = 0      #0-Skip, 1-Show, 2-Hide*
$Script:ControlPanelOnDesktop = 0   #0-Skip, 1-Show, 2-Hide*

#Lock Screen
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:LockScreen = 0              #0-Skip, 1-Enable*, 2-Disable
$Script:PowerMenuLockScreen = 0     #0-Skip, 1-Show*, 2-Hide
$Script:CameraOnLockScreen = 0      #0-Skip, 1-Enable*, 2-Disable

#Misc items
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:AccountProtectionWarn = 0   #0-Skip, 1-Enable*, 2-Disable
$Script:ActionCenter = 0            #0-Skip, 1-Enable*, 2-Disable
$Script:StickyKeyPrompt = 0         #0-Skip, 1-Enable*, 2-Disable
$Script:NumblockOnStart = 0         #0-Skip, 1-Enable, 2-Disable*
$Script:F8BootMenu = 0              #0-Skip, 1-Enable, 2-Disable*
$Script:RemoteUACAcctToken = 0      #0-Skip, 1-Enable, 2-Disable*
$Script:HibernatePower = 0          #0-Skip, 1-Enable, 2-Disable --(Hibernate Power Option)
$Script:SleepPower = 0              #0-Skip, 1-Enable*, 2-Disable --(Sleep Power Option)
$Script:DisableVariousTasks = 0     #0-Skip, 1-Enable*, 2-Disable some scheduled tasks (This is NOT show in GUI)

# Photo Viewer Settings
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:PVFileAssociation = 0       #0-Skip, 1-Enable, 2-Disable*
$Script:PVOpenWithMenu = 0          #0-Skip, 1-Enable, 2-Disable*

# Application/Feature
# Function = Option                 #Choices (* Indicates Windows Default)
$Script:OneDrive = 0                #0-Skip, 1-Enable*, 2-Disable
$Script:OneDriveInstall = 0         #0-Skip, 1-Installed*, 2-Uninstall
$Script:XboxDVR = 0                 #0-Skip, 1-Enable*, 2-Disable
$Script:MediaPlayer = 0             #0-Skip, 1-Installed*, 2-Uninstall
$Script:WorkFolders = 0             #0-Skip, 1-Installed*, 2-Uninstall
$Script:FaxAndScan = 0              #0-Skip, 1-Installed*, 2-Uninstall
$Script:LinuxSubsystem = 0          #0-Skip, 1-Installed, 2-Uninstall* (Anniversary Update or Higher)

# Custom List of App to Install, Hide or Uninstall
# I dunno if you can Install random apps with this script
[System.Collections.ArrayList]$Script:APPS_AppsUnhide = @()         # Apps to Install
[System.Collections.ArrayList]$Script:APPS_AppsHide = @()           # Apps to Hide
[System.Collections.ArrayList]$Script:APPS_AppsUninstall = @()      # Apps to Uninstall
#$Script:APPS_Example = @('Somecompany.Appname1','TerribleCompany.Appname2','AppS.Appname3')
# To get list of Packages Installed (in powershell)
# DISM /Online /Get-ProvisionedAppxPackages | Select-string Packagename

<#          -----> NOTE!!!! <-----
App Uninstall will remove them to reinstall you can

1. Install some from Windows Store
2. Restore the files using installation medium as follows
New-Item C:\Mnt -Type Directory | Out-Null
dism /Mount-Image /ImageFile:D:\sources\install.wim /index:1 /ReadOnly /MountDir:C:\Mnt
robocopy /S /SEC /R:0 "C:\Mnt\Program Files\WindowsApps" "C:\Program Files\WindowsApps"
dism /Unmount-Image /Discard /MountDir:C:\Mnt
#>

# Metro Apps
# By Default Most of these are installed
# Function  = Option  # 0-Skip, 1-Unhide, 2- Hide, 3-Uninstall (!!Read Note Above)
$Script:APP_3DBuilder = 0           # 3DBuilder app
$Script:APP_3DViewer = 0            # 3DViewer app
$Script:APP_BingWeather = 0         # Bing Weather app
$Script:APP_CommsPhone = 0          # Phone app
$Script:APP_Communications = 0      # Calendar & Mail app
$Script:APP_GetHelp = 0             # Microsoft's Self-Help App
$Script:APP_Getstarted = 0          # Get Started link
$Script:APP_Messaging = 0           # Messaging app
$Script:APP_MicrosoftOffHub = 0     # Get Office Link
$Script:APP_MovieMoments = 0        # Movie Moments app
$Script:APP_Netflix = 0             # Netflix app
$Script:APP_OfficeOneNote = 0       # Office OneNote app
$Script:APP_OfficeSway = 0          # Office Sway app
$Script:APP_OneConnect = 0          # One Connect
$Script:APP_People = 0              # People app
$Script:APP_Photos = 0              # Photos app
$Script:APP_SkypeApp1 = 0           # Microsoft.SkypeApp
$Script:APP_SkypeApp2 = 0           # Microsoft.SkypeWiFi
$Script:APP_SolitaireCollect = 0    # Microsoft Solitaire
$Script:APP_StickyNotes = 0         # Sticky Notes app
$Script:APP_WindowsWallet = 0       # Stores Credit and Debit Card Information
$Script:APP_VoiceRecorder = 0       # Voice Recorder app
$Script:APP_WindowsAlarms = 0       # Alarms and Clock app
$Script:APP_WindowsCalculator = 0   # Calculator app
$Script:APP_WindowsCamera = 0       # Camera app
$Script:APP_WindowsFeedbak1 = 0     # Microsoft.WindowsFeedback
$Script:APP_WindowsFeedbak2 = 0     # Microsoft.WindowsFeedbackHub
$Script:APP_WindowsMaps = 0         # Maps app
$Script:APP_WindowsPhone = 0        # Phone Companion app
$Script:APP_WindowsStore = 0        # Windows Store
$Script:APP_XboxApp = 0             # Xbox apps (There is a few)
$Script:APP_ZuneMusic = 0           # Groove Music app
$Script:APP_ZuneVideo = 0           # Groove Video app
# --------------------------------------------------------------------------
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## !!                                            !!
## !!        DO NOT EDIT PAST THIS POINT         !!
## !!                                            !!
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}
SetDefault
ScriptPreStart
