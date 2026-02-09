;Include "Modern UI 2" for a nicer look
!include "MUI2.nsh"
!include "version.nsh"

;Program and installer file names
Name "Lel.tar (32-bit)"
OutFile "LelTarUserSetupX86.exe"
Unicode true
ManifestDPIAware true
SetCompressor lzma

; Default Installation Directory
InstallDir "$LocalAppData\Programs\LelTarGame-x86\"
; Get installation folder from registry if it exists
InstallDirRegKey HKCU "Software\LelTarGame-x86" ""

; Only request for elevation if needed
RequestExecutionLevel user

;---------------
; Settings
;---------------

; Abort Warnings for both the installer and uninstaller
!define MUI_ABORTWARNING
!define MUI_ABORTWARNING_CANCEL_DEFAULT
!define MUI_UNABORTWARNING
!define MUI_UNABORTWARNING_CANCEL_DEFAULT

; Custom bitmaps for welcome and finish pages
!define MUI_WELCOMEFINISHPAGE_BITMAP "C:\Program Files (x86)\NSIS\Contrib\Graphics\Wizard\win.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "C:\Program Files (x86)\NSIS\Contrib\Graphics\Wizard\win.bmp"

; Custom icons for installer and uninstallers
!define MUI_ICON "C:\Program Files (x86)\NSIS\Contrib\Graphics\Icons\modern-install-colorful.ico"
!define MUI_UNICON "C:\Program Files (x86)\NSIS\Contrib\Graphics\Icons\modern-uninstall-colorful.ico"

; Header image
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "C:\Program Files (x86)\NSIS\Contrib\Graphics\Header\nsis-r.bmp"
!define MUI_HEADERIMAGE_RIGHT ; move it to the right instead of the left

!define MUI_LICENSEPAGE_BGCOLOR /windows

; Do not automatically close
; !define MUI_FINISHPAGE_NOAUTOCLOSE
; !define MUI_UNFINISHPAGE_NOAUTOCLOSE

; Add run app checkbox into the installer
!define MUI_FINISHPAGE_RUN "LelTarGame-x86.exe"

; No description for components
!define MUI_COMPONENTSPAGE_NODESC

; Tell installer that it should allow for more languages
!define MUI_LANGDLL_ALLLANGUAGES

; Add/Remove Programs registry location(s)
!define REGUNINSTKEY "Lel.tar"
!define REGHKEY HKCU
!define REGPATH_WINUNINST "Software\Microsoft\Windows\CurrentVersion\Uninstall"

;---------------
; Pages
;---------------

; Installer
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.rtf" ; Only accepts TXT and RTF files
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Uninstaller
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_COMPONENTS
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;---------------
; Languages
;---------------
!insertmacro MUI_LANGUAGE "Hungarian" ; Default
!insertmacro MUI_LANGUAGE "English"

!insertmacro MUI_RESERVEFILE_LANGDLL

; Language Strings for Desktop Shortcut
LangString DesktopShortcut ${LANG_ENGLISH} "Create Desktop Shortcut"
LangString DesktopShortcut ${LANG_HUNGARIAN} "Asztali parancsikon készítése"
LangString DesktopShortcutDP ${LANG_ENGLISH} "Creating desktop shortcut..."
LangString DesktopShortcutDP ${LANG_HUNGARIAN} "Asztali parancsikon készítése..."
; Language Strings for erasing game data
LangString GameDataClear ${LANG_ENGLISH} "Erase all game data"
LangString GameDataClear ${LANG_HUNGARIAN} "Összes játékadat törlése"
LangString GameDataClearDP ${LANG_ENGLISH} "Erasing all game data..."
LangString GameDataClearDP ${LANG_HUNGARIAN} "Összes játékadat törlése..."

;---------------
; Installer shit
;---------------
Section "Lel.tar" Main

	SectionIn RO

	SetOutPath $INSTDIR

	; Needed files go here...
	File /r "C:\Users\Asus2026\Documents\GodotProjects\LelTar\bin\windows\x86\*.*"

	; Add registry entry pointing to the install directory
	WriteRegStr HKCU "Software\LelTarGame-x86" "" $INSTDIR

	; Create the Uninstaller
	WriteUninstaller "$INSTDIR\uninstall.exe"

	; Make shortcut to the start menu
	CreateShortcut "$SMPROGRAMS\Lel.tar (32-bit).lnk" "$INSTDIR\LelTarGame-x86.exe"

	; Add to the installed programs list in Add/Remove Programs
	WriteRegStr HKCU '${REGPATH_WINUNINST}\${REGUNINSTKEY}' "DisplayName" "Lel.tar"
	WriteRegStr HKCU '${REGPATH_WINUNINST}\${REGUNINSTKEY}' "UninstallString" "$INSTDIR\uninstall.exe"
	WriteRegStr HKCU '${REGPATH_WINUNINST}\${REGUNINSTKEY}' "DisplayIcon" "$INSTDIR\LelTarGame-x86.exe,0"
	WriteRegStr HKCU '${REGPATH_WINUNINST}\${REGUNINSTKEY}' "DisplayVersion" "${APP_VERSION}"
	WriteRegStr HKCU '${REGPATH_WINUNINST}\${REGUNINSTKEY}' "Publisher" "LohinSys"
	WriteRegStr HKCU '${REGPATH_WINUNINST}\${REGUNINSTKEY}' "URLInfoAbout" "https://szb3nc3.github.io/LelTarWebsite/"
	WriteRegStr HKCU '${REGPATH_WINUNINST}\${REGUNINSTKEY}' "EstimatedSize" "118428"
	WriteRegStr HKCU '${REGPATH_WINUNINST}\${REGUNINSTKEY}' "NoModify" "1"
	WriteRegStr HKCU '${REGPATH_WINUNINST}\${REGUNINSTKEY}' "NoRepair" "1"

SectionEnd

; Desktop shortcut
Section $(DesktopShortcut) DeskShortcutCreate
	DetailPrint $(DesktopShortcutDP)
	CreateShortcut "$DESKTOP\Lel.tar (32-bit).lnk" "$INSTDIR\LelTarGame-x86.exe"
SectionEnd

;---------------
; Installer Functions
;---------------
Function .onInit

	!insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

;---------------
; Uninstaller shit
;---------------
Section "un.Lel.tar"

	SectionIn RO

	; Files go here...
	RMDir /r $INSTDIR

	; Remove registry entries
	DeleteRegKey HKCU "Software\LelTarGame-x86"
	DeleteRegKey HKCU '${REGPATH_WINUNINST}\${REGUNINSTKEY}'

	; Remove shortcuts from the start menu, desktop and taskbar (if it exists)
	Delete "$SMPROGRAMS\Lel.tar (32-bit).lnk"
	Delete "$DESKTOP\Lel.tar (32-bit).lnk"
	Delete "$AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Lel.tar (32-bit).lnk"

SectionEnd

Section /o un.$(GameDataClear) ClearGameData
	DetailPrint $(GameDataClearDP)
	RMDir /r "$AppData\Godot\app_userdata\Lel.tar\"
SectionEnd

;---------------
; Functions of the Uninstaller
;---------------
Function un.onInit

  !insertmacro MUI_UNGETLANGUAGE

FunctionEnd