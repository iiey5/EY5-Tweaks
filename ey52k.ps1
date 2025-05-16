# Load required assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "EY5 TWEAKS"
$form.Width = 600
$form.Height = 800
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Load the image from GitHub (raw content URL)
$imgUrl = "https://raw.githubusercontent.com/iiey5/EY5-Tweaks/main/EY5.png"
$stream = [System.Net.WebRequest]::Create($imgUrl).GetResponse().GetResponseStream()
$backgroundImage = [System.Drawing.Image]::FromStream($stream)

# Helper function to create button
function New-Button($text, $x, $y, $action) {
    $button = New-Object System.Windows.Forms.Button
    $button.Text = $text
    $button.Width = 120
    $button.Height = 40
    $button.Location = New-Object System.Drawing.Point($x, $y)
    $button.BackColor = 'Black'
    $button.ForeColor = 'Gold'
    $button.FlatStyle = 'Flat'
    $button.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
    $button.Add_Click($action)
    $form.Controls.Add($button)
}

# Buttons with actions
New-Button "EY5 TWEAKS" 230 20 { Start-Process "https://discord.gg/ey5" }
New-Button "clean memory" 50 120 { [System.GC]::Collect() }
New-Button "Task Manager" 350 120 { Start-Process taskmgr }
New-Button "DISM" 50 200 {
    Start-Process powershell -ArgumentList 'DISM.exe /Online /Cleanup-Image /Scanhealth; DISM.exe /Online /Cleanup-Image /Restorehealth'
}
New-Button "SFC" 350 200 {
    Start-Process powershell -ArgumentList 'sfc /scannow'
}
New-Button "Store" 50 280 { Start-Process "https://ey5store.com" }
New-Button "Restart Explorer" 350 280 {
    powershell -Command "Stop-Process -Name explorer -Force; Start-Process explorer"
}
New-Button "Restart PC" 50 360 {
    shutdown /r /t 0
}
New-Button "BIOS" 350 360 {
    shutdown /r /fw /t 0
}

# Run form
$form.Topmost = $true
[void]$form.ShowDialog()
