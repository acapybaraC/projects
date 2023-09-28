$shortRelease = [PSCustomObject]@{
    Hour = 12
    Minute = 55
}

function timeChecker_normal
{
    if ((($LocalTime.Hour) -eq 15) -and (($LocalTime.Minute) -eq 15)) {
        "True" #Replace with runFilename
    }
    else{
        Start-Sleep -Seconds $timeDifference
    }
}

function timeChecker_short
{
    if ((($LocalTime.Hour) -eq ($shortRelease.hour)) -and (($LocalTime.Minute) -eq ($shortRelease.minute))) {
        "True" #Replace with runFilename
    }
    else{
        Start-Sleep -Seconds 60
    }
}

function day{
    Switch ($LocalTime.DayOfWeek)
    {
        (5) {timeChecker_short}
        (6) {Start-Sleep -Seconds 360}
        (7) {Start-Sleep -Seconds 360}
        default {timeChecker_normal}
    }
    }
#Determines when students are scheduled to leave school

while ($true) {
    $LocalTime = Get-CimInstance -ClassName Win32_LocalTime
    day
}
#Repeatedly gets current time from local server
