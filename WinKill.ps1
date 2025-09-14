# V7614 WinKill v2.0.0 (C) V7614 Tech
# Safe version with Task Manager launch, red warnings, case-insensitive confirmations
# Added 'version' command (main shell only)

# --- Banner ---
$psVer = $PSVersionTable.PSVersion.ToString()
$winVer = (Get-CimInstance Win32_OperatingSystem).Caption
Write-Host "V7614 WinKill v2.0.0 (C) V7614 Tech"
Write-Host "Running on PowerShell $psVer, $winVer"
Write-Host "Type 'help' to see all available commands"
Write-Host ""

function Main-Shell {
    while ($true) {
        $input = Read-Host "V7614-WinKill"
        switch ($input.ToLower()) {
            "help" {
                Write-Host "Available commands:"
                Write-Host "  help      - Show this help"
                Write-Host "  kill      - Enter Kill shell"
                Write-Host "  power     - Enter Power shell"
                Write-Host "  version   - Show WinKill version"
                Write-Host "  exit      - Quit WinKill"
            }
            "kill"   { Kill-Shell }
            "power"  { Power-Shell }
            "version" {
                Write-Host "V7614 WinKill v2.0.0 (C) V7614 Tech"
            }
            "exit" { return }
            default  { Write-Host "Unknown command: $input" }
        }
    }
}

# --- KILL SHELL ---
function Kill-Shell {
    Write-Host "Kill shell, part of V7614 WinKill (C) V7614 Tech"
    Write-Host "Type 'help' to see all commands or 'exit' to exit this shell"
    while ($true) {
        $input = Read-Host "Kill"
        switch ($input.ToLower()) {
            "help" {
                Write-Host "Kill commands:"
                Write-Host "  explorer   - Kill Windows Explorer" -ForegroundColor Red
                Write-Host "              (Task Manager will open automatically)"
                Write-Host "  specific   - Kill a specific process"
                Write-Host "  version    - Only works in the main shell!" -ForegroundColor Yellow
                Write-Host "  exit       - Exit Kill shell"
            }
            "explorer" {
                $confirm = Read-Host "WARNING! This will kill Explorer. Are you sure? (Y/N)"
                if ($confirm.ToUpper() -eq "Y") {
                    Write-Host "Killing Explorer..." -ForegroundColor Red
                    Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
                    Write-Host "Opening Task Manager..."
                    Start-Process taskmgr
                } else { Write-Host "Cancelled." }
            }
            "specific" {
                $proc = Read-Host "Enter process name to kill"
                Stop-Process -Name $proc -Force -ErrorAction SilentlyContinue
                Write-Host "Attempted to kill $proc"
            }
            "version" { Write-Host "Hey! this command can only be executed in the main prompt!" -ForegroundColor Yellow }
            "exit" { return }
            default { Write-Host "Unknown command: $input" }
        }
    }
}

# --- POWER SHELL ---
function Power-Shell {
    Write-Host "Power shell, part of V7614 WinKill (C) V7614 Tech"
    Write-Host "Type 'help' to see all commands or 'exit' to exit this shell"
    while ($true) {
        $input = Read-Host "Power"
        switch ($input.ToLower()) {
            "help" {
                Write-Host "Power commands:"
                Write-Host "  shutdown        - Normal shutdown"
                Write-Host "  restart         - Normal restart"
                Write-Host "  fshutdown       - Force shutdown" -ForegroundColor Red
                Write-Host "  frestart        - Force restart" -ForegroundColor Red
                Write-Host "  version         - Only works in the main shell!" -ForegroundColor Yellow
                Write-Host "  exit            - Exit Power shell"
            }
            "shutdown"   { shutdown /s /t 0 }
            "restart"    { shutdown /r /t 0 }
            "fshutdown"  {
                $confirm = Read-Host "WARNING! This will FORCE shutdown your PC. Are you sure? (Y/N)"
                if ($confirm.ToUpper() -eq "Y") { shutdown /s /f /t 0 } else { Write-Host "Cancelled." }
            }
            "frestart"   {
                $confirm = Read-Host "WARNING! This will FORCE restart your PC. Are you sure? (Y/N)"
                if ($confirm.ToUpper() -eq "Y") { shutdown /r /f /t 0 } else { Write-Host "Cancelled." }
            }
            "version" { Write-Host "Hey! this command can only be executed in the main prompt!" -ForegroundColor Yellow }
            "exit" { return }
            default { Write-Host "Unknown command: $input" }
        }
    }
}

# --- Start main loop ---
Main-Shell
