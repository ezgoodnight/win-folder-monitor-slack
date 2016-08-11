### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = "C:\Folder to Watch\"
    $watcher.Filter = "*.*"
    $watcher.IncludeSubdirectories = $false
    $watcher.EnableRaisingEvents = $true  

### DEFINE ACTIONS AFTER A EVENT IS DETECTED
    $action = { $path = $Event.SourceEventArgs.FullPath
				$shortPath = ($path -split '\\')[-1]
				$file = $Event.SourceEventArgs.File
                $changeType = $Event.SourceEventArgs.ChangeType
                $token = "token goes here"
				$channel = "#bot-testing"
				$text = "$changeType, $shortPath"
				$user = "usernumber"
				$username = "botuser"
				$bot_id = "botid"
				$as_user = "true"
				$postSlackMessage = @{token=$token; channel=$channel; text=$text; user=$user; bot_id=$bot_id; username=$username; as_user=$as_user}
				Invoke-RestMethod -Uri https://slack.com/api/chat.postMessage -Body $postSlackMessage
              }    
### DECIDE WHICH EVENTS SHOULD BE WATCHED + SET CHECK FREQUENCY  
    $created = Register-ObjectEvent $watcher "Created" -Action $action
##    $changed = Register-ObjectEvent $watcher "Changed" -Action $action
    $deleted = Register-ObjectEvent $watcher "Deleted" -Action $action
##    $renamed = Register-ObjectEvent $watcher "Renamed" -Action $action
    while ($true) {sleep 5}