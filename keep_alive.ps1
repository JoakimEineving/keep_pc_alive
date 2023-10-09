# PowerShell script to keep PC awake 
# powershell.exe -ExecutionPolicy Bypass -File .\keep-alive.ps1

$getEndTime = Read-Host "Enter how many hours the PC should be kept alive"
$endTime = (Get-Date).AddHours($getEndTime)
Write-Host "Keeping PC awake for $getEndTime hours... (send Ctrl+C to quit)"

while ((Get-Date) -lt $endTime) {
    $timeLeft = $endTime - (Get-Date)
    $hoursLeft = [math]::Floor($timeLeft.TotalHours)
    $minutesLeft = [math]::Floor($timeLeft.TotalMinutes) % 60
    $secondsLeft = [math]::Floor($timeLeft.TotalSeconds) % 60
    $currentTime = Get-Date -Format "HH:mm:ss"

    Write-Host "`rTime left: $hoursLeft hour(s) $minutesLeft minute(s) $secondsLeft second(s)       " -NoNewline

    # Send the keep-alive key every 59 seconds
    if ($secondsLeft % 59 -eq 0) {
        $wsh = New-Object -ComObject WScript.Shell
        $wsh.SendKeys('+{F15}')
    }

    Start-Sleep -seconds 1
}

Write-Host "`n$getEndTime hours have passed. Exiting..."