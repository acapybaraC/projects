function ifrunning{ #Checks if file is running
    $time = 0
    while ($true){
        $time -eq ($time + 1)
        if (!(Get-Process -Name notepad -ErrorAction SilentlyContinue)){
            Invoke-Item C:\Windows\notepad.exe
            #replace notepad.exe with filename
        }
        elseif ($time -eq 900) {
            break
        }
        else{
            Start-Sleep -Seconds 1
        }
    }
}

function timeChecker_normal #Mon-Thu Dismissal
{
    if ((($LocalTime.Hour) -eq 13) -and (($LocalTime.Minute) -eq 55)) {
        "True" #Replace with runFilename
        ifrunning
        #Preschool 
    }
    elseif ((($LocalTime.Hour) -eq 14) -and (($LocalTime.Minute) -eq 25)) {
        "True" #Replace with runFilename
        ifrunning
        #Year 1-2 
    }
    elseif ((($LocalTime.Hour) -eq 14) -and (($LocalTime.Minute) -eq 55)) {
        "True" #Replace with runFilename
        ifrunning
        #Year 3-6 
    }
    elseif ((($LocalTime.Hour) -eq 15) -and (($LocalTime.Minute) -eq 15)) {
        "True" #Replace with runFilename
        ifrunning
        #Secondary/Sixth Form
    }
    elseif ((($LocalTime.Hour) -eq 16) -and (($LocalTime.Minute) -eq 05)) {
        "True" #Replace with runFilename
        ifrunning
        #CCA Combined
    }
    else{
        Start-Sleep -Seconds 60
    }
}

function timeChecker_short #Friday Dismissal
{
    if ((($LocalTime.Hour) -eq 11) -and (($LocalTime.Minute) -eq 55)) {
        "True" #Replace with runFilename
        ifrunning
        #Preschool
    }
    elseif ((($LocalTime.Hour) -eq 11) -and (($LocalTime.Minute) -eq 55)) {
        "True" #Replace with runFilename
        ifrunning
        #Year 1-2
    }
    elseif ((($LocalTime.Hour) -eq 12) -and (($LocalTime.Minute) -eq 25)) {
        "True" #Replace with runFilename
        ifrunning
        #Year 3-6
    }
    elseif ((($LocalTime.Hour) -eq 12) -and (($LocalTime.Minute) -eq 55)) {
        "True" #Replace with runFilename
        ifrunning
        #Secondary/Sixth Form
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
