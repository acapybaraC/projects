$normalRelease = [PSCustomObject]@{
    Hour = 3
    Minute = 15
}
$shortRelease = [PSCustomObject]@{
    Hour = 12
    Minute = 55
}

function timeChecker_normal
{
    if ((($LocalTime.Hour) -eq ($normalRelease.hour)) -and (($LocalTime.Minute) -eq ($normalRelease.minute))) {
        "True" #Replace with runFilename
    }
    else{
        $hour = $normalRelease.hour - $LocalTime.Hour
        $minute = $normalRelease.minute - $LocalTime.Minute
        $timeDifference = 60 * $minute * (60 * $hour)
        Start-Sleep -Seconds $timeDifference
    }
}

function timeChecker_short
{
    if ((($LocalTime.Hour) -eq ($shortRelease.hour)) -and (($LocalTime.Minute) -eq ($shortRelease.minute))) {
        "True" #Replace with runFilename
    }
    else{
        $hour = $shortRelease.hour - $LocalTime.Hour
        $minute = $shortRelease.minute - $LocalTime.Minute
        $timeDifference = 60 * $minute * (60 * $hour)
        Start-Sleep -Seconds $timeDifference
    }
}

$normalRelease = [PSCustomObject]@{
    Hour = 3
    Minute = 15
}
$shortRelease = [PSCustomObject]@{
    Hour = 12
    Minute = 55
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
