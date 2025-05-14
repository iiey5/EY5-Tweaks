
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
$statusFont = New-Object Drawing.Font("Arial", 14, [Drawing.FontStyle]::Bold)
$noteFont = New-Object Drawing.Font("Arial", 10, [Drawing.FontStyle]::Regular)

# === Title Label ===
$title = New-Object Windows.Forms.Label
$title.Text = "EY5 TWEAKS!"
$title.ForeColor = "Red"
$title.Font = $headerFont
$title.AutoSize = $true
$title.Location = New-Object Drawing.Point(350, 60)
$form.Controls.Add($title)

# === Server Status ===
$serverStatus = New-Object Windows.Forms.Label
$serverStatus.Text = "TWEAK SERVER STATUS:`nUP TO DATE"
$serverStatus.ForeColor = "Lime"
$serverStatus.Font = $statusFont
$serverStatus.AutoSize = $true
$serverStatus.Location = New-Object Drawing.Point(300, 130)
$form.Controls.Add($serverStatus)

# === Animated Background Panel ===
$glowPanel = New-Object Windows.Forms.Panel
$glowPanel.Size = $form.ClientSize
$glowPanel.BackColor = "Black"
$glowPanel.Location = New-Object Drawing.Point(0, 0)
$glowPanel.SendToBack()
$form.Controls.Add($glowPanel)

# === Buttons ===
function New-NavButton($text, $x, $url) {
    $btn = New-Object Windows.Forms.Button
    $btn.Text = $text
    $btn.Font = $buttonFont
    $btn.BackColor = "Black"
    $btn.ForeColor = "Red"
    $btn.FlatStyle = "Flat"
    $btn.Size = New-Object Drawing.Size(150, 40)
    $btn.Location = New-Object Drawing.Point($x, 10)
    $btn.Add_Click({ Start-Process $url })
    $form.Controls.Add($btn)
}
New-NavButton "WEBSITE" 20 "https://ey5store.com"
New-NavButton "Discord" 190 "https://discord.gg/ey5"
New-NavButton "Tiktok" 360 "https://www.tiktok.com/@66wj"

# EY5 TWEAKS button (shows message)
$btnEY5 = New-Object Windows.Forms.Button
$btnEY5.Text = "EY5 TWEAKS"
$btnEY5.Font = $buttonFont
$btnEY5.BackColor = "Black"
$btnEY5.ForeColor = "Lime"
$btnEY5.FlatStyle = "Flat"
$btnEY5.Size = New-Object Drawing.Size(150, 40)
$btnEY5.Location = New-Object Drawing.Point(530, 10)
$btnEY5.Add_Click({ [Windows.Forms.MessageBox]::Show("the best tweaks ever!") })
$form.Controls.Add($btnEY5)

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

# === Timer for Time & Glow Animation ===
$timer = New-Object Windows.Forms.Timer
$timer.Interval = 1000
$glowState = $true
$timer.Add_Tick({
    # Time update
    $lastUpdate.Text = "Last Update: " + (Get-Date).ToString("HH:mm:ss")

    # Glow effect (toggle background)
    if ($glowState) {
        $btnTweaks.ForeColor = "White"
    } else {
        $btnTweaks.ForeColor = "Red"
    }
    $glowState = -not $glowState
})
$timer.Start()

# === Run the GUI ===
[void]$form.ShowDialog()
