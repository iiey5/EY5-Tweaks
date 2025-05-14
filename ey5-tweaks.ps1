
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# === Form Setup ===
$form = New-Object Windows.Forms.Form
$form.Text = "EY5 TWEAKS"
$form.Width = 900
$form.Height = 600
$form.BackColor = "Black"
$form.StartPosition = "CenterScreen"

# === Fonts ===
$headerFont = New-Object Drawing.Font("Arial", 26, [Drawing.FontStyle]::Bold)
$buttonFont = New-Object Drawing.Font("Arial", 12, [Drawing.FontStyle]::Bold)
$statusFont = New-Object Drawing.Font("Arial", 18, [Drawing.FontStyle]::Bold)
$noteFont = New-Object Drawing.Font("Arial", 10, [Drawing.FontStyle]::Regular)

# === Title Label ===
$title = New-Object Windows.Forms.Label
$title.Text = "EY5 TWEAKS!"
$title.ForeColor = "Red"
$title.Font = $headerFont
$title.AutoSize = $true
$title.Location = New-Object Drawing.Point(330, 60)
$form.Controls.Add($title)

# === Server Status ===
$serverStatus = New-Object Windows.Forms.Label
$serverStatus.Text = "TWEAK SERVER STATUS:`nUP TO DATE"
$serverStatus.ForeColor = "Lime"
$serverStatus.Font = $statusFont
$serverStatus.AutoSize = $true
$serverStatus.Location = New-Object Drawing.Point(290, 130)
$form.Controls.Add($serverStatus)

# === Navigation Buttons ===
function New-NavButton($text, $x, $url, $color = "Red", $msg = $null) {
    $btn = New-Object Windows.Forms.Button
    $btn.Text = $text
    $btn.Font = $buttonFont
    $btn.BackColor = "Black"
    $btn.ForeColor = $color
    $btn.FlatStyle = "Flat"
    $btn.Size = New-Object Drawing.Size(150, 40)
    $btn.Location = New-Object Drawing.Point($x, 10)
    if ($msg) {
        $btn.Add_Click({ [Windows.Forms.MessageBox]::Show($msg) })
    } else {
        $btn.Add_Click({ Start-Process $url })
    }
    $form.Controls.Add($btn)
}
New-NavButton "WEBSITE" 20 "https://ey5store.com"
New-NavButton "Discord" 190 "https://discord.gg/ey5"
New-NavButton "Tiktok" 360 "https://www.tiktok.com/@66wj"
New-NavButton "EY5 TWEAKS" 530 "" "Lime" "the best tweaks ever"

# === Start Tweaks Button ===
$tweakOn = $false
$btnTweaks = New-Object Windows.Forms.Button
$btnTweaks.Text = "Start Tweaks"
$btnTweaks.Font = $headerFont
$btnTweaks.BackColor = "Black"
$btnTweaks.ForeColor = "Red"
$btnTweaks.FlatStyle = "Flat"
$btnTweaks.Size = New-Object Drawing.Size(300, 80)
$btnTweaks.Location = New-Object Drawing.Point(300, 250)
$btnTweaks.Add_Click({
    if (-not $tweakOn) {
        $delayLabel.Text = "0 DELAY : ON"
        $delayLabel.ForeColor = "Lime"
        $tweakOn = $true
    }
})
$form.Controls.Add($btnTweaks)

# === Notes Labels ===
$noteLeft = New-Object Windows.Forms.Label
$noteLeft.Text = "This is note:`nSTART TWEAKS BUTTON`nMAKES THE SYSTEM`nWORKS AT 0.5 ms`ncurrent 0.5 like standby"
$noteLeft.ForeColor = "White"
$noteLeft.Font = $noteFont
$noteLeft.AutoSize = $true
$noteLeft.Location = New-Object Drawing.Point(20, 350)
$form.Controls.Add($noteLeft)

$noteRight = New-Object Windows.Forms.Label
$noteRight.Text = "This is note:`nWHEN CLICK`nSTART TWEAKS`nIT CHANGE TO`n0 DELAY :"
$noteRight.ForeColor = "White"
$noteRight.Font = $noteFont
$noteRight.AutoSize = $true
$noteRight.Location = New-Object Drawing.Point(680, 350)
$form.Controls.Add($noteRight)

# === Delay Status ===
$delayLabel = New-Object Windows.Forms.Label
$delayLabel.Text = "OFF"
$delayLabel.ForeColor = "Red"
$delayLabel.Font = $noteFont
$delayLabel.AutoSize = $true
$delayLabel.Location = New-Object Drawing.Point(775, 415)
$form.Controls.Add($delayLabel)

# === Last Update Label ===
$lastUpdate = New-Object Windows.Forms.Label
$lastUpdate.Text = "Last Update: ..."
$lastUpdate.ForeColor = "Lime"
$lastUpdate.Font = $noteFont
$lastUpdate.AutoSize = $true
$lastUpdate.Location = New-Object Drawing.Point(20, 520)
$form.Controls.Add($lastUpdate)

# === Timer for Time Update and Glow Effect ===
$timer = New-Object Windows.Forms.Timer
$timer.Interval = 1000
$glowState = $true
$timer.Add_Tick({
    $lastUpdate.Text = "Last Update: " + (Get-Date).ToString("HH:mm:ss")
    $btnTweaks.ForeColor = if ($glowState) { "White" } else { "Red" }
    $glowState = -not $glowState
})
$timer.Start()

# === Show the GUI ===
[void]$form.ShowDialog()
