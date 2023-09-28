function timeChecker_normal #Mon-Thu Dismissal
{
    if ((($LocalTime.Hour) -eq 13) -and (($LocalTime.Minute) -eq 55)) {
        "True" #Replace with runFilename
        #Preschool 
    }
    elseif ((($LocalTime.Hour) -eq 14) -and (($LocalTime.Minute) -eq 25)) {
        "True" #Replace with runFilename
        #Year 1-2 
    }
    elseif ((($LocalTime.Hour) -eq 14) -and (($LocalTime.Minute) -eq 55)) {
        "True" #Replace with runFilename
        #Year 3-6 
    }
    elseif ((($LocalTime.Hour) -eq 15) -and (($LocalTime.Minute) -eq 15)) {
        "True" #Replace with runFilename
        #Secondary/Sixth Form
    }
    elseif ((($LocalTime.Hour) -eq 16) -and (($LocalTime.Minute) -eq 05)) {
        "True" #Replace with runFilename
    }
    else{
        Start-Sleep -Seconds 60
    }
}

function timeChecker_short #Friday Dismissal
{
    if ((($LocalTime.Hour) -eq 11) -and (($LocalTime.Minute) -eq 55)) {
        "True" #Replace with runFilename
        #Preschool
    }
    elseif ((($LocalTime.Hour) -eq 11) -and (($LocalTime.Minute) -eq 55)) {
        "True" #Replace with runFilename
        #Preschool
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
