<#
.SYNOPSIS
	Adds a memo text 
.DESCRIPTION
	This PowerShell script adds the given memo text to $HOME/Memos.csv.
.PARAMETER text
	Specifies the text to memorize
.EXAMPLE
	PS> ./add-memo "Buy banana"
	✔️ added to 📄/home/Mo/Memos.csv


param([string]$text = "")

try {
	if ($text -eq "" ) { $text = read-host "Enter the memo text to add" }

	$Path = "$HOME/Memos.csv"
	$Time = get-date -format "yyyy-MM-ddTHH:mm:ssZ" -asUTC
	$User = $(whoami)
	$Line = "$Time,$User,$text"

	if (-not(test-path "$Path" -pathType leaf)) {
		write-output "Time,User,text" > "$Path"
	}
	write-output $Line >> "$Path"

	"✔️ added to 📄$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
