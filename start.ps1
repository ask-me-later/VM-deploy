#############################################
#                                           #
#   CSV Generator & VM Deployment hanlder   #
#        Developed by Bakuła, Kamil         #
#                                           #
#############################################

#Please compile this script to an .EXE file using PS2EXE-GUI and use it as an desktop application.

#This script contains POWERCLI cmdlets, please use it on a machine which has this module already installed or install the module according to VMware vendor.


Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
Add-Type -AssemblyName System.Drawing -ErrorAction SilentlyContinue
[System.Windows.Forms.Application]::EnableVisualStyles()

# Create input form object
    $LoginForm = New-Object System.Windows.Forms.Form

    # Set input form properties
    $LoginForm.Text = "Login to vCenter"
    $LoginForm.ClientSize = New-Object System.Drawing.Size(280, 100)
    $LoginForm.StartPosition = "CenterScreen"
    $LoginForm.FormBorderStyle = "FixedSingle"
    $LoginForm.MaximizeBox = $False
    $LoginForm.BackColor = [System.Drawing.Color]::WhiteSmoke

    # Icon for Login window
    $iconBase64      = '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'
    $iconBytes       = [Convert]::FromBase64String($iconBase64)
    # initialize a Memory stream holding the bytes
    $stream          = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
    $LoginForm.Icon       = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

    # Create label control
    $labelLogin = New-Object System.Windows.Forms.Label
    $labelLogin.Location = New-Object System.Drawing.Point(10, 10)
    $labelLogin.Size = New-Object System.Drawing.Size(280, 20)
    $labelLogin.BackColor = [System.Drawing.Color]::Transparent
    $labelLogin.ForeColor = [System.Drawing.Color]::Black
    $labelLogin.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $labelLogin.Text = "Login to vCenter server SAFJDEDCVI001.hre.loc"
    $LoginForm.Controls.Add($labelLogin)

    # Create Login button control
    $loginButton = New-Object System.Windows.Forms.Button
    $loginButton.Location = New-Object System.Drawing.Point(90, 40)
    $loginButton.Size = New-Object System.Drawing.Size(100, 25)
    $loginButton.BackColor = [System.Drawing.Color]::MediumSlateBlue
    $loginButton.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    $loginButton.FlatStyle = 'flat'
    $loginButton.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::Turquoise
    $loginButton.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::MediumBlue
    $loginButton.FlatAppearance.BorderColor = [System.Drawing.Color]::DarkSlateBlue
    $loginButton.Text = "Login"
    $LoginForm.Controls.Add($loginButton)

    # Define event handler for Login button click (checking if the user actually logged in)
    [void]$loginButton.Add_Click({
    Try {
        Connect-VIServer your-vcenter-server.domain.loc -credential (Get-credential -Credential DOMAIN\ -WarningAction SilentlyContinue -ErrorAction SilentlyContinue)
        $connected = $true
    }

    Catch {
        $connected = $False
    }

    if ($connected) {
        Start-Sleep 1
        [System.Windows.Forms.MessageBox]::Show("Login was successful.", "Info" , 0, "Information")
        $LoginForm.Close()

$form = New-Object System.Windows.Forms.Form
$form.Text = "CSV Creator and VM Deploy"
$form.Size = New-Object System.Drawing.Size(375,665)
$form.StartPosition = "CenterScreen"
$form.MaximizeBox = $False
$form.FormBorderStyle = "FixedSingle"
$form.BackColor = [System.Drawing.Color]::WhiteSmoke

# Icon for main window
$iconBase64      = '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'
$iconBytes       = [Convert]::FromBase64String($iconBase64)
# initialize a Memory stream holding the bytes
$stream          = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
$Form.Icon       = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

# Create the menu strip
$stripMenu = New-Object System.Windows.Forms.MenuStrip
$stripMenu.Dock = "top"

# Create the "About" menu
$aboutMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$aboutMenu.Text = "Help"
[void]$stripMenu.Items.Add($aboutMenu)

# Add click event handlers for the menu items
$aboutMenu.Add_Click({ [System.Windows.Forms.MessageBox]::Show("CSV Generator and VM Deploy handler for <custom name>.`nCSV file will always be located under C:\Temp\deploy.csv for Windows and deployLinux.csv for Linux.`n`r`nPowered by PowerShell.`n`r`nVersion 1.1 | April 2023`n`nDeveloped by Bakula, Kamil.", "Info" , 0, "Information") })

# Add the menu strip to the form
[void]$form.Controls.Add($stripMenu)

# Create Header name
$label0 = New-Object System.Windows.Forms.Label
$label0.Location = New-Object System.Drawing.Point(10,40)
$label0.Size = New-Object System.Drawing.Size(90,20)
$label0.BackColor = [System.Drawing.Color]::Transparent
$label0.ForeColor = [System.Drawing.Color]::Black
$label0.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label0.Text = "Template type:"
[void]$form.Controls.Add($label0)

# Create Dropdown list for OS Build Standard or SQL
$combo = New-Object System.Windows.Forms.ComboBox
$combo.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$combo.Items.AddRange(@("Linux RedHat 8.5", "Windows Server 2016", "Windows Server 2022"))
$combo.Location = New-Object System.Drawing.Point(110,40)
$combo.Size = New-Object System.Drawing.Size(200,20)
$global:checksum = 0
$global:checksum2 = 0
$global:checksum3 = 0
$form.Controls.Add($combo)

# Create Text Boxes
$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Point(130,70)
$textBox1.Size = New-Object System.Drawing.Size(180,20)
$textBox1.Name = "Vmname"
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(10,70)
$label1.Size = New-Object System.Drawing.Size(100,20)
$label1.BackColor = [System.Drawing.Color]::Transparent
$label1.ForeColor = [System.Drawing.Color]::Black
$label1.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label1.Text = "VM name:"
$textBox1.Enabled = $false
$label1.Enabled = $false
[void]$form.Controls.Add($textBox1)
[void]$form.Controls.Add($label1)

# Create Text Boxes
$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Point(130,100)
$textBox2.Size = New-Object System.Drawing.Size(180,20)
$textBox2.Name = "Cluster"
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,100)
$label2.Size = New-Object System.Drawing.Size(100,20)
$label2.BackColor = [System.Drawing.Color]::Transparent
$label2.ForeColor = [System.Drawing.Color]::Black
$label2.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label2.Text = "ESXi cluster:"
$textBox2.Enabled = $false
$label2.Enabled = $false
[void]$form.Controls.Add($textBox2)
[void]$form.Controls.Add($label2)

$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Location = New-Object System.Drawing.Point(130,130)
$textBox3.Size = New-Object System.Drawing.Size(180,20)
$textBox3.Name = "CPU"
$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(10,130)
$label3.Size = New-Object System.Drawing.Size(100,20)
$label3.BackColor = [System.Drawing.Color]::Transparent
$label3.ForeColor = [System.Drawing.Color]::Black
$label3.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label3.Text = "CPU cores:"
$textBox3.Enabled = $false
$label3.Enabled = $false
[void]$form.Controls.Add($textBox3)
[void]$form.Controls.Add($label3)

$textBox4 = New-Object System.Windows.Forms.TextBox
$textBox4.Location = New-Object System.Drawing.Point(130,160)
$textBox4.Size = New-Object System.Drawing.Size(180,20)
$textBox4.Name = "RAM"
$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(10,160)
$label4.Size = New-Object System.Drawing.Size(100,20)
$label4.BackColor = [System.Drawing.Color]::Transparent
$label4.ForeColor = [System.Drawing.Color]::Black
$label4.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label4.Text = "RAM amount:"
$textBox4.Enabled = $false
$label4.Enabled = $false
[void]$form.Controls.Add($textBox4)
[void]$form.Controls.Add($label4)

$textBox5 = New-Object System.Windows.Forms.TextBox
$textBox5.Location = New-Object System.Drawing.Point(130,190)
$textBox5.Size = New-Object System.Drawing.Size(180,20)
$textBox5.Name = "C"
$label5 = New-Object System.Windows.Forms.Label
$label5.Location = New-Object System.Drawing.Point(10,190)
$label5.Size = New-Object System.Drawing.Size(100,20)
$label5.BackColor = [System.Drawing.Color]::Transparent
$label5.ForeColor = [System.Drawing.Color]::Black
$label5.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label5.Text = "Disk C size:"
$textBox5.Enabled = $false
$label5.Enabled = $false
[void]$form.Controls.Add($textBox5)
[void]$form.Controls.Add($label5)

$textBox6 = New-Object System.Windows.Forms.TextBox
$textBox6.Location = New-Object System.Drawing.Point(130,220)
$textBox6.Size = New-Object System.Drawing.Size(180,20)
$textBox6.Name = "D"
$label6 = New-Object System.Windows.Forms.Label
$label6.Location = New-Object System.Drawing.Point(10,220)
$label6.Size = New-Object System.Drawing.Size(100,30)
$label6.BackColor = [System.Drawing.Color]::Transparent
$label6.ForeColor = [System.Drawing.Color]::Black
$label6.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label6.Text = "Disk D size:"
$textBox6.Enabled = $false
$label6.Enabled = $false
[void]$form.Controls.Add($textBox6)
[void]$form.Controls.Add($label6)

$textBox7 = New-Object System.Windows.Forms.TextBox
$textBox7.Location = New-Object System.Drawing.Point(130,250)
$textBox7.Size = New-Object System.Drawing.Size(180,20)
$textBox7.Name = "E"
$label7 = New-Object System.Windows.Forms.Label
$label7.Location = New-Object System.Drawing.Point(10,250)
$label7.Size = New-Object System.Drawing.Size(100,20)
$label7.BackColor = [System.Drawing.Color]::Transparent
$label7.ForeColor = [System.Drawing.Color]::Black
$label7.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label7.Text = "Disk E size:"
$textBox7.Enabled = $false
$label7.Enabled = $false
[void]$form.Controls.Add($textBox7)
[void]$form.Controls.Add($label7)

$textBox8 = New-Object System.Windows.Forms.TextBox
$textBox8.Location = New-Object System.Drawing.Point(130,280)
$textBox8.Size = New-Object System.Drawing.Size(180,20)
$textBox8.Name = "F"
$label8 = New-Object System.Windows.Forms.Label
$label8.Location = New-Object System.Drawing.Point(10,280)
$label8.Size = New-Object System.Drawing.Size(100,20)
$label8.BackColor = [System.Drawing.Color]::Transparent
$label8.ForeColor = [System.Drawing.Color]::Black
$label8.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label8.Text = "Disk F size:"
$textBox8.Enabled = $false
$label8.Enabled = $false
[void]$form.Controls.Add($textBox8)
[void]$form.Controls.Add($label8)

$textBox9 = New-Object System.Windows.Forms.TextBox
$textBox9.Location = New-Object System.Drawing.Point(130,310)
$textBox9.Size = New-Object System.Drawing.Size(180,20)
$textBox9.Name = "G"
$label9 = New-Object System.Windows.Forms.Label
$label9.Location = New-Object System.Drawing.Point(10,310)
$label9.Size = New-Object System.Drawing.Size(100,20)
$label9.BackColor = [System.Drawing.Color]::Transparent
$label9.ForeColor = [System.Drawing.Color]::Black
$label9.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label9.Text = "Disk G size:"
$textBox9.Enabled = $false
$label9.Enabled = $false
[void]$form.Controls.Add($textBox9)
[void]$form.Controls.Add($label9)

$textBox10 = New-Object System.Windows.Forms.TextBox
$textBox10.Location = New-Object System.Drawing.Point(130,340)
$textBox10.Size = New-Object System.Drawing.Size(180,20)
$textBox10.Name = "H"
$label10 = New-Object System.Windows.Forms.Label
$label10.Location = New-Object System.Drawing.Point(10,340)
$label10.Size = New-Object System.Drawing.Size(100,20)
$label10.BackColor = [System.Drawing.Color]::Transparent
$label10.ForeColor = [System.Drawing.Color]::Black
$label10.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label10.Text = "Disk H size:"
$textBox10.Enabled = $false
$label10.Enabled = $false
[void]$form.Controls.Add($textBox10)
[void]$form.Controls.Add($label10)

$textBox11 = New-Object System.Windows.Forms.TextBox
$textBox11.Location = New-Object System.Drawing.Point(130,370)
$textBox11.Size = New-Object System.Drawing.Size(180,20)
$textBox11.Name = "Ipprod"
$label11 = New-Object System.Windows.Forms.Label
$label11.Location = New-Object System.Drawing.Point(10,370)
$label11.Size = New-Object System.Drawing.Size(100,20)
$label11.BackColor = [System.Drawing.Color]::Transparent
$label11.ForeColor = [System.Drawing.Color]::Black
$label11.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label11.Text = "IP prod:"
$textBox11.Enabled = $false
$label11.Enabled = $false
[void]$form.Controls.Add($textBox11)
[void]$form.Controls.Add($label11)

$textBox12 = New-Object System.Windows.Forms.TextBox
$textBox12.Location = New-Object System.Drawing.Point(130,400)
$textBox12.Size = New-Object System.Drawing.Size(180,20)
$textBox12.Name = "Ipgate"
$label12 = New-Object System.Windows.Forms.Label
$label12.Location = New-Object System.Drawing.Point(10,400)
$label12.Size = New-Object System.Drawing.Size(100,20)
$label12.BackColor = [System.Drawing.Color]::Transparent
$label12.ForeColor = [System.Drawing.Color]::Black
$label12.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label12.Text = "IP gateway:"
$textBox12.Enabled = $false
$label12.Enabled = $false
[void]$form.Controls.Add($textBox12)
[void]$form.Controls.Add($label12)

$textBox13 = New-Object System.Windows.Forms.TextBox
$textBox13.Location = New-Object System.Drawing.Point(130,430)
$textBox13.Size = New-Object System.Drawing.Size(180,20)
$textBox13.Name = "VLAN"
$label13 = New-Object System.Windows.Forms.Label
$label13.Location = New-Object System.Drawing.Point(10,430)
$label13.Size = New-Object System.Drawing.Size(100,20)
$label13.BackColor = [System.Drawing.Color]::Transparent
$label13.ForeColor = [System.Drawing.Color]::Black
$label13.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label13.Text = "VLAN name:"
$textBox13.Enabled = $false
$label13.Enabled = $false
[void]$form.Controls.Add($textBox13)
[void]$form.Controls.Add($label13)

$textBox14 = New-Object System.Windows.Forms.TextBox
$textBox14.Location = New-Object System.Drawing.Point(130,460)
$textBox14.Size = New-Object System.Drawing.Size(180,20)
$textBox14.Name = "GetStorageType"
$label14 = New-Object System.Windows.Forms.Label
$label14.Location = New-Object System.Drawing.Point(10,460)
$label14.Size = New-Object System.Drawing.Size(100,20)
$label14.BackColor = [System.Drawing.Color]::Transparent
$label14.ForeColor = [System.Drawing.Color]::Black
$label14.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label14.Text = "Storage type:"
$textBox14.Enabled = $false
$label14.Enabled = $false
[void]$form.Controls.Add($textBox14)
[void]$form.Controls.Add($label14)

$textBox15 = New-Object System.Windows.Forms.TextBox
$textBox15.Location = New-Object System.Drawing.Point(130,490)
$textBox15.Size = New-Object System.Drawing.Size(180,20)
$textBox15.Name = "DiskCount"
$label15 = New-Object System.Windows.Forms.Label
$label15.Location = New-Object System.Drawing.Point(10,490)
$label15.Size = New-Object System.Drawing.Size(100,20)
$label15.BackColor = [System.Drawing.Color]::Transparent
$label15.ForeColor = [System.Drawing.Color]::Black
$label15.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$label15.Text = "Disk count:"
$textBox15.Enabled = $false
$label15.Enabled = $false
[void]$form.Controls.Add($textBox15)
[void]$form.Controls.Add($label15)

# Create the tick box
$checkboxNewLine = New-Object System.Windows.Forms.CheckBox
$checkboxNewLine.Location = New-Object System.Drawing.Point(10,540)
$checkboxNewLine.Size = New-Object System.Drawing.Size(150,50)
$checkboxNewLine.Enabled = $false
$checkboxNewLine.BackColor = [System.Drawing.Color]::Transparent
$checkboxNewLine.ForeColor = [System.Drawing.Color]::Black
$checkboxNewLine.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$checkboxNewLine.Text = "Add new line to modify existing CSV?"
[void]$form.Controls.Add($checkboxNewLine)

# Create button to generate CSV
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(170,530)
$button.Size = New-Object System.Drawing.Size(120,23)
$button.BackColor = [System.Drawing.Color]::MediumSlateBlue
$button.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$button.FlatStyle = 'flat'
$button.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::Turquoise
$button.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::MediumBlue
$button.FlatAppearance.BorderColor = [System.Drawing.Color]::DarkSlateBlue
$button.Text = "Generate CSV"
[void]$button.Add_Click({
if ($checkboxNewLine.Checked) {
    if (($checksum -eq 2) -and ($checksum2 -eq 2)) {
        $textBox1.Text+","+$textBox2.Text+","+$textBox3.Text+","+$textBox4.Text+","+$textBox5.Text+","+$textBox6.Text+","+$textBox7.Text+","+$textBox8.Text+","+$textBox9.Text+","+$textBox10.Text+","+$textBox11.Text+","+$textBox12.Text+","+$textBox13.Text+","+$textBox14.Text+","+$textBox15.Text | Out-File -FilePath "C:\Temp\deploy.csv" -Append
        [System.Windows.Forms.MessageBox]::Show("CSV file has been UPDATED successfully.", "Info" , 0, "Info")
        #import CSV
        $Machines = Import-Csv -Path C:\Temp\deploy.csv -Delimiter "," -Encoding UTF8
        }
    elseif (($checksum -eq 3) -and ($checksum2 -eq 3)) {
        $textBox1.Text+","+$textBox2.Text+","+$textBox3.Text+","+$textBox4.Text+","+$textBox5.Text+","+$textBox6.Text+","+$textBox7.Text+","+$textBox8.Text+","+$textBox9.Text+","+$textBox10.Text+","+$textBox11.Text+","+$textBox12.Text+","+$textBox13.Text+","+$textBox14.Text+","+$textBox15.Text | Out-File -FilePath "C:\Temp\deploy.csv" -Append
        [System.Windows.Forms.MessageBox]::Show("CSV file has been UPDATED successfully.", "Info" , 0, "Info")
        #import CSV
        $Machines = Import-Csv -Path C:\Temp\deploy.csv -Delimiter "," -Encoding UTF8
        }
    elseif (($checksum -eq 1) -and ($checksum2 -eq 1)) {
        $textBox1.Text+","+$textBox2.Text+","+$textBox3.Text+","+$textBox4.Text+","+$textBox5.Text+","+$textBox6.Text+","+$textBox7.Text+","+$textBox8.Text+","+$textBox9.Text+","+$textBox10.Text+","+$textBox13.Text+","+$textBox14.Text+","+$textBox15.Text | Out-File -FilePath "C:\Temp\deployLinux.csv" -Append
        [System.Windows.Forms.MessageBox]::Show("CSV file has been UPDATED successfully.", "Info" , 0, "Info")
        #import CSV
        $Machines = Import-Csv -Path C:\Temp\deployLinux.csv -Delimiter "," -Encoding UTF8
    }
    elseif (($checksum -eq 2) -and ($checksum2 -eq 1)) {
        [System.Windows.Forms.MessageBox]::Show("You previously CREATED CSV file for Linux RedHat 8.5."+"`r`n"+"You cannot UPDATE this CSV with Windows 16 data."+"`r`n"+"Please create new CSV for Windows Server 2016 Template.", "Error" , 0, "Error")
    }
    elseif (($checksum -eq 1) -and ($checksum2 -eq 2)) {
        [System.Windows.Forms.MessageBox]::Show("You previously CREATED CSV file for Windows Server 2016."+"`r`n"+"You cannot UPDATE this CSV with Linux data."+"`r`n"+"Please create new CSV for Linux RedHat 8.5 Template.", "Error" , 0, "Error")
    }
    elseif (($checksum -eq 2) -and ($checksum2 -eq 3)) {
        [System.Windows.Forms.MessageBox]::Show("You previously CREATED CSV file for Windows Server 2022."+"`r`n"+"You cannot UPDATE this CSV with Windows 16 data."+"`r`n"+"Please create new CSV for Windows Server 2016 Template.", "Error" , 0, "Error")
    }
    elseif (($checksum -eq 1) -and ($checksum2 -eq 3)) {
        [System.Windows.Forms.MessageBox]::Show("You previously CREATED CSV file for Windows Server 2022."+"`r`n"+"You cannot UPDATE this CSV with Linux data."+"`r`n"+"Please create new CSV for Linux RedHat 8.5 Template.", "Error" , 0, "Error")
    }
    elseif (($checksum -eq 3) -and ($checksum2 -eq 2)) {
        [System.Windows.Forms.MessageBox]::Show("You previously CREATED CSV file for Windows Server 2016."+"`r`n"+"You cannot UPDATE this CSV with Windows 22 data."+"`r`n"+"Please create new CSV for Windows Server 2022 Template.", "Error" , 0, "Error")
    }
    elseif (($checksum -eq 3) -and ($checksum2 -eq 1)) {
        [System.Windows.Forms.MessageBox]::Show("You previously CREATED CSV file for Linux RedHat 8.5."+"`r`n"+"You cannot UPDATE this CSV with Windows 22 data."+"`r`n"+"Please create new CSV for Windows Server 2022 Template.", "Error" , 0, "Error")
    }
    elseif ($checksum -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Please choose Template type first.")
    }

    }
    else {
    if ($checksum -eq 2) {
        $textBox1.Name+","+$textBox2.Name+","+$textBox3.Name+","+$textBox4.Name+","+$textBox5.Name+","+$textBox6.Name+","+$textBox7.Name+","+$textBox8.Name+","+$textBox9.Name+","+$textBox10.Name+","+$textBox11.Name+","+$textBox12.Name+","+$textBox13.Name+","+$textBox14.Name+","+$textBox15.Name+"`r`n"+$textBox1.Text+","+$textBox2.Text+","+$textBox3.Text+","+$textBox4.Text+","+$textBox5.Text+","+$textBox6.Text+","+$textBox7.Text+","+$textBox8.Text+","+$textBox9.Text+","+$textBox10.Text+","+$textBox11.Text+","+$textBox12.Text+","+$textBox13.Text+","+$textBox14.Text+","+$textBox15.Text | Out-File -FilePath "C:\Temp\deploy.csv"
        $global:checksum2 = 0+2
        $checkboxNewLine.Enabled = $true
        [System.Windows.Forms.MessageBox]::Show("CSV file has been CREATED successfully.", "Info" , 0, "Info")
        #import CSV
        $Machines = Import-Csv -Path C:\Temp\deploy.csv -Delimiter "," -Encoding UTF8
        $buttonDeploy.BackColor = [System.Drawing.Color]::MediumSlateBlue
        $buttonDeploy.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
        $buttonDeploy.FlatStyle = 'flat'
        $buttonDeploy.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::Turquoise
        $buttonDeploy.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::MediumBlue
        $buttonDeploy.FlatAppearance.BorderColor = [System.Drawing.Color]::DarkSlateBlue
        $buttonDeploy.ForeColor = [System.Drawing.Color]::Black
        $buttonDeploy.Enabled = $true
    }
    elseif ($checksum -eq 3) {
        $textBox1.Name+","+$textBox2.Name+","+$textBox3.Name+","+$textBox4.Name+","+$textBox5.Name+","+$textBox6.Name+","+$textBox7.Name+","+$textBox8.Name+","+$textBox9.Name+","+$textBox10.Name+","+$textBox11.Name+","+$textBox12.Name+","+$textBox13.Name+","+$textBox14.Name+","+$textBox15.Name+"`r`n"+$textBox1.Text+","+$textBox2.Text+","+$textBox3.Text+","+$textBox4.Text+","+$textBox5.Text+","+$textBox6.Text+","+$textBox7.Text+","+$textBox8.Text+","+$textBox9.Text+","+$textBox10.Text+","+$textBox11.Text+","+$textBox12.Text+","+$textBox13.Text+","+$textBox14.Text+","+$textBox15.Text | Out-File -FilePath "C:\Temp\deploy.csv"
        $global:checksum2 = 0+3
        $checkboxNewLine.Enabled = $true
        [System.Windows.Forms.MessageBox]::Show("CSV file has been CREATED successfully.", "Info" , 0, "Info")
        #import CSV
        $Machines = Import-Csv -Path C:\Temp\deploy.csv -Delimiter "," -Encoding UTF8
        $buttonDeploy.BackColor = [System.Drawing.Color]::MediumSlateBlue
        $buttonDeploy.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
        $buttonDeploy.FlatStyle = 'flat'
        $buttonDeploy.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::Turquoise
        $buttonDeploy.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::MediumBlue
        $buttonDeploy.FlatAppearance.BorderColor = [System.Drawing.Color]::DarkSlateBlue
        $buttonDeploy.ForeColor = [System.Drawing.Color]::Black
        $buttonDeploy.Enabled = $true
    }
    elseif ($checksum -eq 1) {
        $textBox1.Name+","+$textBox2.Name+","+$textBox3.Name+","+$textBox4.Name+","+$textBox5.Name+","+$textBox6.Name+","+$textBox7.Name+","+$textBox8.Name+","+$textBox9.Name+","+$textBox10.Name+","+$textBox13.Name+","+$textBox14.Name+","+$textBox15.Name+"`r`n"+$textBox1.Text+","+$textBox2.Text+","+$textBox3.Text+","+$textBox4.Text+","+$textBox5.Text+","+$textBox6.Text+","+$textBox7.Text+","+$textBox8.Text+","+$textBox9.Text+","+$textBox10.Text+","+$textBox13.Text+","+$textBox14.Text+","+$textBox15.Text | Out-File -FilePath "C:\Temp\deployLinux.csv"
        $global:checksum2 = 0+1
        $checkboxNewLine.Enabled = $true
        [System.Windows.Forms.MessageBox]::Show("CSV file has been CREATED successfully.", "Info" , 0, "Info")
        #import CSV
        $Machines = Import-Csv -Path C:\Temp\deployLinux.csv -Delimiter "," -Encoding UTF8
        $buttonDeploy.BackColor = [System.Drawing.Color]::MediumSlateBlue
        $buttonDeploy.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
        $buttonDeploy.FlatStyle = 'flat'
        $buttonDeploy.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::Turquoise
        $buttonDeploy.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::MediumBlue
        $buttonDeploy.FlatAppearance.BorderColor = [System.Drawing.Color]::DarkSlateBlue
        $buttonDeploy.ForeColor = [System.Drawing.Color]::Black
        $buttonDeploy.Enabled = $true
    }
    elseif ($checksum -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Please choose Template type first.", "Error" , 0, "Error")
    }

    }
})

# Add event handler for combo box selection change
$combo.add_SelectedIndexChanged({
    if ($combo.SelectedItem -eq "Linux RedHat 8.5") {
        $textBox1.Enabled = $true
        $label1.Enabled = $true
        $textBox2.Enabled = $true
        $label2.Enabled = $true
        $textBox3.Enabled = $true
        $label3.Enabled = $true
        $textBox4.Enabled = $true
        $label4.Enabled = $true
        $textBox5.Enabled = $true
        $label5.Enabled = $true
        $textBox6.Enabled = $true
        $label6.Enabled = $true
        $textBox7.Enabled = $true
        $label7.Enabled = $true
        $textBox8.Enabled = $true
        $label8.Enabled = $true
        $textBox9.Enabled = $true
        $label9.Enabled = $true
        $textBox10.Enabled = $true
        $label10.Enabled = $true
        $textBox11.Enabled = $false
        $label11.Enabled = $false
        $textBox12.Enabled = $false
        $label12.Enabled = $false
        $textBox13.Enabled = $true
        $label13.Enabled = $true
        $textBox14.Enabled = $true
        $label14.Enabled = $true
        $textBox15.Enabled = $true
        $label15.Enabled = $true
        $global:checksum = 0+1
    } 
    elseif ($combo.SelectedItem -eq "Windows Server 2016") {
        $textBox1.Enabled = $true
        $label1.Enabled = $true
        $textBox2.Enabled = $true
        $label2.Enabled = $true
        $textBox3.Enabled = $true
        $label3.Enabled = $true
        $textBox4.Enabled = $true
        $label4.Enabled = $true
        $textBox5.Enabled = $true
        $label5.Enabled = $true
        $textBox6.Enabled = $true
        $label6.Enabled = $true
        $textBox7.Enabled = $true
        $label7.Enabled = $true
        $textBox8.Enabled = $true
        $label8.Enabled = $true
        $textBox9.Enabled = $true
        $label9.Enabled = $true
        $textBox10.Enabled = $true
        $label10.Enabled = $true
        $textBox11.Enabled = $true
        $label11.Enabled = $true
        $textBox12.Enabled = $true
        $label12.Enabled = $true
        $textBox13.Enabled = $true
        $label13.Enabled = $true
        $textBox14.Enabled = $true
        $label14.Enabled = $true
        $textBox15.Enabled = $true
        $label15.Enabled = $true
        $global:checksum = 0+2
    }
    elseif ($combo.SelectedItem -eq "Windows Server 2022") {
        $textBox1.Enabled = $true
        $label1.Enabled = $true
        $textBox2.Enabled = $true
        $label2.Enabled = $true
        $textBox3.Enabled = $true
        $label3.Enabled = $true
        $textBox4.Enabled = $true
        $label4.Enabled = $true
        $textBox5.Enabled = $true
        $label5.Enabled = $true
        $textBox6.Enabled = $true
        $label6.Enabled = $true
        $textBox7.Enabled = $true
        $label7.Enabled = $true
        $textBox8.Enabled = $true
        $label8.Enabled = $true
        $textBox9.Enabled = $true
        $label9.Enabled = $true
        $textBox10.Enabled = $true
        $label10.Enabled = $true
        $textBox11.Enabled = $true
        $label11.Enabled = $true
        $textBox12.Enabled = $true
        $label12.Enabled = $true
        $textBox13.Enabled = $true
        $label13.Enabled = $true
        $textBox14.Enabled = $true
        $label14.Enabled = $true
        $textBox15.Enabled = $true
        $label15.Enabled = $true
        $global:checksum = 0+3
    }

})

# Create button to initiate deploy procedure from CSV file created by the Generate CSV button
$buttonDeploy = New-Object System.Windows.Forms.Button
$buttonDeploy.Location = New-Object System.Drawing.Point(170,560)
$buttonDeploy.Size = New-Object System.Drawing.Size(120,30)
$buttonDeploy.BackColor = [System.Drawing.Color]::Gray
$buttonDeploy.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$buttonDeploy.FlatStyle = 'flat'
$buttonDeploy.ForeColor = [System.Drawing.Color]::DarkGray
$buttonDeploy.Text = "Server Deploy"
$buttonDeploy.Enabled = $False
[void]$buttonDeploy.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show("Are you sure?", "Confirm" , 4, "Question")
    if (($result -eq "Yes") -and ($global:checksum2 -eq 2)) {
        #import CSV
        $Machines = Import-Csv -Path C:\Temp\deploy.csv -Delimiter "," -Encoding UTF8

        foreach ($Machine in $Machines) {

    #Read user data from each field in each row and assign the data to a variable as below
    $VMname = $Machine.vmname
    $Cluster = $Machine.cluster
    $IPprod = $Machine.ipprod
    $IPgate = $Machine.ipgate
    $Vlan = $Machine.VLAN
    $CPU = $Machine.cpu
    $RAM = $Machine.ram
    $StorageType = $Machine.getstoragetype
    $C = $Machine.c
    $D = $Machine.d
    $E = $Machine.e
    $F = $Machine.f
    $G = $Machine.g
    $H = $Machine.h
    $DiskCount = $Machine.DiskCount

    #get DataStore
if ($StorageType -eq "Silver")
{
Get-Cluster $Cluster | Get-Datastore -Name *slv* | select name, FreeSpaceGB | Sort-Object FreeSpaceGB | Out-File C:\Temp\Datastorelist.txt
[System.Windows.Forms.MessageBox]::Show("List of datastores will be opened in a notepad after you click OK, please copy and paste the name of a SLV datastore of your choice to the prompt window.", "Info" , 0, "Info")
C:\Temp\Datastorelist.txt
    # Create input form object
    $inputForm = New-Object System.Windows.Forms.Form

    # Set input form properties
    $inputForm.Text = "Datastore choice"
    $inputForm.ClientSize = New-Object System.Drawing.Size(300, 100)
    $inputForm.StartPosition = "CenterScreen"
    $inputForm.MaximizeBox = $False

    # Create label control
    $labelData = New-Object System.Windows.Forms.Label
    $labelData.Location = New-Object System.Drawing.Point(10, 10)
    $labelData.Size = New-Object System.Drawing.Size(280, 20)
    $labelData.Text = "Enter Datastore:"
    $inputForm.Controls.Add($labelData)

    # Create text box control for datastore variable
    $textboxData = New-Object System.Windows.Forms.TextBox
    $textboxData.Location = New-Object System.Drawing.Point(10, 35)
    $textboxData.Size = New-Object System.Drawing.Size(280, 20)
    $inputForm.Controls.Add($textboxData)

    # Create OK button control
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(100, 65)
    $okButton.Size = New-Object System.Drawing.Size(100, 25)
    $okButton.Text = "OK"
    $inputForm.Controls.Add($okButton)

    # Define event handler for OK button click
    $okButton.Add_Click({
        $global:Datastore = $textboxData.Text
        $inputForm.Close()
    })

    # Show input form
    $inputForm.ShowDialog() | Out-Null
}
Elseif ($StorageType -eq "Gold"){
Get-Cluster $Cluster | Get-Datastore -Name *gld* | select name, FreeSpaceGB | Sort-Object FreeSpaceGB | Out-File C:\Temp\Datastorelist.txt
[System.Windows.Forms.MessageBox]::Show("List of datastores will be opened in a notepad after you click OK, please copy and paste the name of a GLD datastore of your choice to the prompt window.", "Info" , 0, "Info")
C:\Temp\Datastorelist.txt
# Create input form object
    $inputForm = New-Object System.Windows.Forms.Form

    # Set input form properties
    $inputForm.Text = "Datastore choice"
    $inputForm.ClientSize = New-Object System.Drawing.Size(300, 100)
    $inputForm.StartPosition = "CenterScreen"
    $inputForm.MaximizeBox = $False

    # Create label control
    $labelData = New-Object System.Windows.Forms.Label
    $labelData.Location = New-Object System.Drawing.Point(10, 10)
    $labelData.Size = New-Object System.Drawing.Size(280, 20)
    $labelData.Text = "Enter Datastore:"
    $inputForm.Controls.Add($labelData)

    # Create text box control for datastore variable
    $textboxData = New-Object System.Windows.Forms.TextBox
    $textboxData.Location = New-Object System.Drawing.Point(10, 35)
    $textboxData.Size = New-Object System.Drawing.Size(280, 20)
    $inputForm.Controls.Add($textboxData)

    # Create OK button control
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(100, 65)
    $okButton.Size = New-Object System.Drawing.Size(100, 25)
    $okButton.Text = "OK"
    $inputForm.Controls.Add($okButton)

    # Define event handler for OK button click
    $okButton.Add_Click({
        $global:Datastore = $textboxData.Text
        $inputForm.Close()
    })

    # Show input form
    $inputForm.ShowDialog() | Out-Null
}

#Set defaultpassword for Administrator on Windows only
Get-OSCustomizationSpec your-os-custom-spec | Set-OSCustomizationSpec -AdminPassword Password123

#Change OSCustomizationNicMapping to set correct IP, gate, mask, dns for prod IP
Get-OSCustomizationSpec your-os-custom-spec | Get-OSCustomizationNicMapping | where { $_.Position -eq '1'} | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress $IPprod -SubnetMask 255.255.255.0 -DefaultGateway $IPGate -Dns 10.100.10.25

#Set OSCustTemplate and OSCustSpec
$TemplateVM = Get-Template -Location DataCenter-name -Name template-name
$OSCustomspec = Get-OSCustomizationSpec -Name your-os-custom-spec

#create VM container
New-VM -Name $VMname -Template $TemplateVM -OSCustomizationSpec $OSCustomspec -ResourcePool $Cluster -Datastore $global:Datastore
$testvm = Get-VM -Name $VMname

#set RAM and CPU
$testvm | Set-VM -NumCpu $CPU -MemoryGB $RAM -confirm:$false

#set default drives from template
Get-HardDisk -VM $testvm -name "Hard disk 1" | Set-HardDisk -CapacityGB $C -confirm:$false
Get-HardDisk -VM $testvm -name "Hard disk 2" | Set-HardDisk -CapacityGB $D -confirm:$false

#create and set new HDD + SCSI controller
if ($DiskCount -eq 3) {
$testvm | New-HardDisk -CapacityGB $E
$Disks = $testvm | Get-HardDisk | Select -Last 1
$Disks | New-ScsiController -Type ParaVirtual
}

elseif ($DiskCount -eq 4) {
$testvm | New-HardDisk -CapacityGB $E
$testvm | New-HardDisk -CapacityGB $F
$Disks = $testvm | Get-HardDisk | Select -Last 2
$Disks | New-ScsiController -Type ParaVirtual
}

elseif ($DiskCount -eq 5) {
$testvm | New-HardDisk -CapacityGB $E
$testvm | New-HardDisk -CapacityGB $F
$testvm | New-HardDisk -CapacityGB $G
$Disks = $testvm | Get-HardDisk | Select -Last 3
$Disks | New-ScsiController -Type ParaVirtual
}

elseif ($DiskCount -eq 6) {
$testvm | New-HardDisk -CapacityGB $E
$testvm | New-HardDisk -CapacityGB $F
$testvm | New-HardDisk -CapacityGB $G
$testvm | New-HardDisk -CapacityGB $H
$Disks = $testvm | Get-HardDisk | Select -Last 4
$Disks | New-ScsiController -Type ParaVirtual
}

#set portgroup for prod and backup adapter according to cluster
if ($cluster -like "*CLUSTER-NAME*"){
$networkbackup = "Secondary hardcoded network adapter name here"

#adding both prod and backup adapters to proper VLAN (port group in vdswitch) and marking Connect at power on
$testvm | Get-NetworkAdapter -Name *1* | Set-NetworkAdapter -Portgroup $Vlan -confirm:$false
$testvm | Get-NetworkAdapter -Name *1* | Set-NetworkAdapter -StartConnected:$true -confirm:$false
$testvm | Get-NetworkAdapter -Name *2* | Set-NetworkAdapter -Portgroup $networkbackup -confirm:$false
$testvm | Get-NetworkAdapter -Name *2* | Set-NetworkAdapter -StartConnected:$true -confirm:$false

#adding vm to proper vm group in a cluster
# you can change the below rules to meet your VM groups in a cluster
$LastTwo = $VMname.Substring($VMname.get_Length()-2)
$LastTwo | % {if($_ % 2 -eq 1 ) {$VMgroup = Get-DrsClusterGroup -Type VMGroup -Name *1_VM* -Cluster CLUSTER-NAME} else {$VMgroup = Get-DrsClusterGroup -Type VMGroup -Name *3_VM* -Cluster CLUSTER-NAME}}
Set-DrsClusterGroup -DrsClusterGroup $VMgroup -VM $VMname -Add -confirm:$false
}

elseif ($cluster -like "*OTHER CLUSTER-NAME*"){
$networkbackup = "Secondary hardcoded network adapter name here"

#adding both prod and backup adapters to proper VLAN (port group in vdswitch) and marking Connect at power on
$testvm | Get-NetworkAdapter -Name *1* | Set-NetworkAdapter -Portgroup $Vlan -confirm:$false
$testvm | Get-NetworkAdapter -Name *1* | Set-NetworkAdapter -StartConnected:$true -confirm:$false
$testvm | Get-NetworkAdapter -Name *2* | Set-NetworkAdapter -Portgroup $networkbackup -confirm:$false
$testvm | Get-NetworkAdapter -Name *2* | Set-NetworkAdapter -StartConnected:$true -confirm:$false

#adding vm to proper vm group in a cluster
# you can change the below rules to meet your VM groups in a cluster
$LastTwo = $VMname.Substring($VMname.get_Length()-2)
$LastTwo | % {if($_ % 2 -eq 1 ) {$VMgroup = Get-DrsClusterGroup -Type VMGroup -Name *1_VM* -Cluster OTHER CLUSTER-NAME} else {$VMgroup = Get-DrsClusterGroup -Type VMGroup -Name *3_VM* -Cluster OTHER CLUSTER-NAME}}
Set-DrsClusterGroup -DrsClusterGroup $VMgroup -VM $VMname -Add -confirm:$false
}

if ($VMname -like "TEST*") {
$ResourcepoolVM = Get-ResourcePool -Name Test_non-prod -Location $Cluster
}
elseif ($VMname -like "PROD*") {
$ResourcepoolVM = Get-ResourcePool Prod -Location $Cluster
}

$testvm | Move-VM -destination $ResourcepoolVM

[System.Windows.Forms.MessageBox]::Show("Please wait 10 seconds to make sure, that all config is complete on vCenter server's side.", "Info" , 0, "Info")
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(70, 600)
$progressBar.Size = New-Object System.Drawing.Size(200, 20)
$progressBar.Minimum = 0
$progressBar.Maximum = 10
$progressBar.Step = 1
$form.Controls.Add($progressBar)

for ($i = 1; $i -le 10; $i++) {
        Start-Sleep -Seconds 1
        $progressBar.PerformStep()
    }
    [System.Windows.Forms.MessageBox]::Show("Config complete.", "Info" , 0, "Info")

$testvm | Start-VM
[System.Windows.Forms.MessageBox]::Show("VM will be powered-on now.", "Info" , 0, "Info")

}

    } elseif (($result -eq "Yes") -and ($global:checksum2 -eq 1)) {
      #import CSV
      $Machines = Import-Csv -Path C:\Temp\deployLinux.csv -Delimiter "," -Encoding UTF8
      
    foreach ($Machine in $Machines) {

    #Read user data from each field in each row and assign the data to a variable as below
    $VMname = $Machine.vmname
    $Cluster = $Machine.cluster
    $Vlan = $Machine.VLAN
    $CPU = $Machine.cpu
    $RAM = $Machine.ram
    $StorageType = $Machine.getstoragetype
    $C = $Machine.c
    $D = $Machine.d
    $E = $Machine.e
    $F = $Machine.f
    $G = $Machine.g
    $H = $Machine.h
    $DiskCount = $Machine.DiskCount

    #get DataStore
if ($StorageType -eq "Silver")
{
Get-Cluster $Cluster | Get-Datastore -Name *slv* | select name, FreeSpaceGB | Sort-Object FreeSpaceGB | Out-File C:\Temp\Datastorelist.txt
[System.Windows.Forms.MessageBox]::Show("List of datastores will be opened in a notepad after you click OK, please copy and paste the name of a SLV datastore of your choice to the prompt window.", "Info" , 0, "Info")
C:\Temp\Datastorelist.txt
    # Create input form object
    $inputForm = New-Object System.Windows.Forms.Form

    # Set input form properties
    $inputForm.Text = "Datastore choice"
    $inputForm.ClientSize = New-Object System.Drawing.Size(300, 100)
    $inputForm.StartPosition = "CenterScreen"
    $inputForm.MaximizeBox = $False

    # Create label control
    $labelData = New-Object System.Windows.Forms.Label
    $labelData.Location = New-Object System.Drawing.Point(10, 10)
    $labelData.Size = New-Object System.Drawing.Size(280, 20)
    $labelData.Text = "Enter Datastore:"
    $inputForm.Controls.Add($labelData)

    # Create text box control for datastore variable
    $textboxData = New-Object System.Windows.Forms.TextBox
    $textboxData.Location = New-Object System.Drawing.Point(10, 35)
    $textboxData.Size = New-Object System.Drawing.Size(280, 20)
    $inputForm.Controls.Add($textboxData)

    # Create OK button control
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(100, 65)
    $okButton.Size = New-Object System.Drawing.Size(100, 25)
    $okButton.Text = "OK"
    $inputForm.Controls.Add($okButton)

    # Define event handler for OK button click
    $okButton.Add_Click({
        $global:Datastore = $textboxData.Text
        $inputForm.Close()
    })

    # Show input form
    $inputForm.ShowDialog() | Out-Null
}
Elseif ($StorageType -eq "Gold"){
Get-Cluster $Cluster | Get-Datastore -Name *gld* | select name, FreeSpaceGB | Sort-Object FreeSpaceGB | Out-File C:\Temp\Datastorelist.txt
[System.Windows.Forms.MessageBox]::Show("List of datastores will be opened in a notepad after you click OK, please copy and paste the name of a GLD datastore of your choice to the prompt window.", "Info" , 0, "Info")
C:\Temp\Datastorelist.txt
# Create input form object
    $inputForm = New-Object System.Windows.Forms.Form

    # Set input form properties
    $inputForm.Text = "Datastore choice"
    $inputForm.ClientSize = New-Object System.Drawing.Size(300, 100)
    $inputForm.StartPosition = "CenterScreen"
    $inputForm.MaximizeBox = $False

    # Create label control
    $labelData = New-Object System.Windows.Forms.Label
    $labelData.Location = New-Object System.Drawing.Point(10, 10)
    $labelData.Size = New-Object System.Drawing.Size(280, 20)
    $labelData.Text = "Enter Datastore:"
    $inputForm.Controls.Add($labelData)

    # Create text box control for datastore variable
    $textboxData = New-Object System.Windows.Forms.TextBox
    $textboxData.Location = New-Object System.Drawing.Point(10, 35)
    $textboxData.Size = New-Object System.Drawing.Size(280, 20)
    $inputForm.Controls.Add($textboxData)

    # Create OK button control
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(100, 65)
    $okButton.Size = New-Object System.Drawing.Size(100, 25)
    $okButton.Text = "OK"
    $inputForm.Controls.Add($okButton)

    # Define event handler for OK button click
    $okButton.Add_Click({
        $global:Datastore = $textboxData.Text
        $inputForm.Close()
    })

    # Show input form
    $inputForm.ShowDialog() | Out-Null
}

#Set OSCustTemplate and OSCustSpec
$TemplateVM = Get-Template -Location DataCenter -Name template-name

#create VM container
New-VM -Name $VMname -Template $TemplateVM -ResourcePool $Cluster -Datastore $global:Datastore
$testvm = Get-VM -Name $VMname

#set RAM and CPU
$testvm | Set-VM -NumCpu $CPU -MemoryGB $RAM -confirm:$false

#set default drives from template
Get-HardDisk -VM $testvm -name "Hard disk 1" | Set-HardDisk -CapacityGB $C -confirm:$false
Get-HardDisk -VM $testvm -name "Hard disk 2" | Set-HardDisk -CapacityGB $D -confirm:$false

#create and set new HDD + SCSI controller
if ($DiskCount -eq 3) {
$testvm | New-HardDisk -CapacityGB $E
$Disks = $testvm | Get-HardDisk | Select -Last 1
$Disks | New-ScsiController -Type ParaVirtual
}

elseif ($DiskCount -eq 4) {
$testvm | New-HardDisk -CapacityGB $E
$testvm | New-HardDisk -CapacityGB $F
$Disks = $testvm | Get-HardDisk | Select -Last 2
$Disks | New-ScsiController -Type ParaVirtual
}

elseif ($DiskCount -eq 5) {
$testvm | New-HardDisk -CapacityGB $E
$testvm | New-HardDisk -CapacityGB $F
$testvm | New-HardDisk -CapacityGB $G
$Disks = $testvm | Get-HardDisk | Select -Last 3
$Disks | New-ScsiController -Type ParaVirtual
}

elseif ($DiskCount -eq 6) {
$testvm | New-HardDisk -CapacityGB $E
$testvm | New-HardDisk -CapacityGB $F
$testvm | New-HardDisk -CapacityGB $G
$testvm | New-HardDisk -CapacityGB $H
$Disks = $testvm | Get-HardDisk | Select -Last 4
$Disks | New-ScsiController -Type ParaVirtual
}

#set portgroup for prod and backup adapter according to cluster
if ($cluster -like "*CLUSTER-NAME*"){
$networkbackup = "Secondary hardcoded adapter name"

#adding both prod and backup adapters to proper VLAN (port group in vdswitch) and marking Connect at power on
$testvm | Get-NetworkAdapter -Name *1* | Set-NetworkAdapter -Portgroup $Vlan -confirm:$false
$testvm | Get-NetworkAdapter -Name *1* | Set-NetworkAdapter -StartConnected:$true -confirm:$false
$testvm | Get-NetworkAdapter -Name *2* | Set-NetworkAdapter -Portgroup $networkbackup -confirm:$false
$testvm | Get-NetworkAdapter -Name *2* | Set-NetworkAdapter -StartConnected:$true -confirm:$false

#adding vm to proper vm group in a cluster
$LastTwo = $VMname.Substring($VMname.get_Length()-2)
$LastTwo | % {if($_ % 2 -eq 1 ) {$VMgroup = Get-DrsClusterGroup -Type VMGroup -Name *1_VM* -Cluster CLUSTER-NAME} else {$VMgroup = Get-DrsClusterGroup -Type VMGroup -Name *3_VM* -Cluster CLUSTER-NAME}}
Set-DrsClusterGroup -DrsClusterGroup $VMgroup -VM $VMname -Add -confirm:$false
}

elseif ($cluster -like "*OTHER CLUSTER-NAME*"){
$networkbackup = "Secondary hardcoded adapter name"

#adding both prod and backup adapters to proper VLAN (port group in vdswitch) and marking Connect at power on
$testvm | Get-NetworkAdapter -Name *1* | Set-NetworkAdapter -Portgroup $Vlan -confirm:$false
$testvm | Get-NetworkAdapter -Name *1* | Set-NetworkAdapter -StartConnected:$true -confirm:$false
$testvm | Get-NetworkAdapter -Name *2* | Set-NetworkAdapter -Portgroup $networkbackup -confirm:$false
$testvm | Get-NetworkAdapter -Name *2* | Set-NetworkAdapter -StartConnected:$true -confirm:$false

#adding vm to proper vm group in a cluster
$LastTwo = $VMname.Substring($VMname.get_Length()-2)
$LastTwo | % {if($_ % 2 -eq 1 ) {$VMgroup = Get-DrsClusterGroup -Type VMGroup -Name *1_VM* -Cluster OTHER CLUSTER-NAME} else {$VMgroup = Get-DrsClusterGroup -Type VMGroup -Name *3_VM* -Cluster OTHER CLUSTER-NAME}}
Set-DrsClusterGroup -DrsClusterGroup $VMgroup -VM $VMname -Add -confirm:$false
}

if ($VMname -like "test*") {
$ResourcepoolVM = Get-ResourcePool -Name Test_non-prod -Location $Cluster
}
elseif ($VMname -like "prod*") {
$ResourcepoolVM = Get-ResourcePool Prod -Location $Cluster
}

$testvm | Move-VM -destination $ResourcepoolVM

[System.Windows.Forms.MessageBox]::Show("Please wait 10 seconds to make sure, that all config is complete on vCenter server's side.", "Info" , 0, "Info")
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(70, 600)
$progressBar.Size = New-Object System.Drawing.Size(200, 20)
$progressBar.Minimum = 0
$progressBar.Maximum = 10
$progressBar.Step = 1
$form.Controls.Add($progressBar)

for ($i = 1; $i -le 10; $i++) {
        Start-Sleep -Seconds 1
        $progressBar.PerformStep()
    }
    [System.Windows.Forms.MessageBox]::Show("Config complete.", "Info" , 0, "Info")

$testvm | Start-VM
[System.Windows.Forms.MessageBox]::Show("VM will be powered-on now.", "Info" , 0, "Info")

}

    } elseif (($result -eq "Yes") -and ($global:checksum2 -eq 3)) {
        #import CSV
        $Machines = Import-Csv -Path C:\Temp\deploy.csv -Delimiter "," -Encoding UTF8

        foreach ($Machine in $Machines) {

    #Read user data from each field in each row and assign the data to a variable as below
    $VMname = $Machine.vmname
    $Cluster = $Machine.cluster
    $IPprod = $Machine.ipprod
    $IPgate = $Machine.ipgate
    $Vlan = $Machine.VLAN
    $CPU = $Machine.cpu
    $RAM = $Machine.ram
    $StorageType = $Machine.getstoragetype
    $C = $Machine.c
    $D = $Machine.d
    $E = $Machine.e
    $F = $Machine.f
    $G = $Machine.g
    $H = $Machine.h
    $DiskCount = $Machine.DiskCount

    #get DataStore
if ($StorageType -eq "Silver")
{
Get-Cluster $Cluster | Get-Datastore -Name *slv* | select name, FreeSpaceGB | Sort-Object FreeSpaceGB | Out-File C:\Temp\Datastorelist.txt
[System.Windows.Forms.MessageBox]::Show("List of datastores will be opened in a notepad after you click OK, please copy and paste the name of a SLV datastore of your choice to the prompt window.", "Info" , 0, "Info")
C:\Temp\Datastorelist.txt
    # Create input form object
    $inputForm = New-Object System.Windows.Forms.Form

    # Set input form properties
    $inputForm.Text = "Datastore choice"
    $inputForm.ClientSize = New-Object System.Drawing.Size(300, 100)
    $inputForm.StartPosition = "CenterScreen"
    $inputForm.MaximizeBox = $False

    # Create label control
    $labelData = New-Object System.Windows.Forms.Label
    $labelData.Location = New-Object System.Drawing.Point(10, 10)
    $labelData.Size = New-Object System.Drawing.Size(280, 20)
    $labelData.Text = "Enter Datastore:"
    $inputForm.Controls.Add($labelData)

    # Create text box control for datastore variable
    $textboxData = New-Object System.Windows.Forms.TextBox
    $textboxData.Location = New-Object System.Drawing.Point(10, 35)
    $textboxData.Size = New-Object System.Drawing.Size(280, 20)
    $inputForm.Controls.Add($textboxData)

    # Create OK button control
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(100, 65)
    $okButton.Size = New-Object System.Drawing.Size(100, 25)
    $okButton.Text = "OK"
    $inputForm.Controls.Add($okButton)

    # Define event handler for OK button click
    $okButton.Add_Click({
        $global:Datastore = $textboxData.Text
        $inputForm.Close()
    })

    # Show input form
    $inputForm.ShowDialog() | Out-Null
}
Elseif ($StorageType -eq "Gold"){
Get-Cluster $Cluster | Get-Datastore -Name *gld* | select name, FreeSpaceGB | Sort-Object FreeSpaceGB | Out-File C:\Temp\Datastorelist.txt
[System.Windows.Forms.MessageBox]::Show("List of datastores will be opened in a notepad after you click OK, please copy and paste the name of a GLD datastore of your choice to the prompt window.", "Info" , 0, "Info")
C:\Temp\Datastorelist.txt
# Create input form object
    $inputForm = New-Object System.Windows.Forms.Form

    # Set input form properties
    $inputForm.Text = "Datastore choice"
    $inputForm.ClientSize = New-Object System.Drawing.Size(300, 100)
    $inputForm.StartPosition = "CenterScreen"
    $inputForm.MaximizeBox = $False

    # Create label control
    $labelData = New-Object System.Windows.Forms.Label
    $labelData.Location = New-Object System.Drawing.Point(10, 10)
    $labelData.Size = New-Object System.Drawing.Size(280, 20)
    $labelData.Text = "Enter Datastore:"
    $inputForm.Controls.Add($labelData)

    # Create text box control for datastore variable
    $textboxData = New-Object System.Windows.Forms.TextBox
    $textboxData.Location = New-Object System.Drawing.Point(10, 35)
    $textboxData.Size = New-Object System.Drawing.Size(280, 20)
    $inputForm.Controls.Add($textboxData)

    # Create OK button control
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(100, 65)
    $okButton.Size = New-Object System.Drawing.Size(100, 25)
    $okButton.Text = "OK"
    $inputForm.Controls.Add($okButton)

    # Define event handler for OK button click
    $okButton.Add_Click({
        $global:Datastore = $textboxData.Text
        $inputForm.Close()
    })

    # Show input form
    $inputForm.ShowDialog() | Out-Null
}

#Set defaultpassword for Administrator on Windows only
Get-OSCustomizationSpec your-custom-os-spec | Set-OSCustomizationSpec -AdminPassword Password123

#Change OSCustomizationNicMapping to set correct IP, gate, mask, dns for prod IP
Get-OSCustomizationSpec your-custom-os-spec | Get-OSCustomizationNicMapping | where { $_.Position -eq '1'} | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress $IPprod -SubnetMask 255.255.255.0 -DefaultGateway $IPGate -Dns 10.100.10.25

#Set OSCustTemplate and OSCustSpec
$TemplateVM = Get-Template -Location DataCenter -Name template-name
$OSCustomspec = Get-OSCustomizationSpec -Name your-custom-os-spec

#create VM container
New-VM -Name $VMname -Template $TemplateVM -OSCustomizationSpec $OSCustomspec -ResourcePool $Cluster -Datastore $global:Datastore
$testvm = Get-VM -Name $VMname

#set RAM and CPU
$testvm | Set-VM -NumCpu $CPU -MemoryGB $RAM -confirm:$false

#set default drives from template
Get-HardDisk -VM $testvm -name "Hard disk 1" | Set-HardDisk -CapacityGB $C -confirm:$false
Get-HardDisk -VM $testvm -name "Hard disk 2" | Set-HardDisk -CapacityGB $D -confirm:$false

#create and set new HDD + SCSI controller
if ($DiskCount -eq 3) {
$testvm | New-HardDisk -CapacityGB $E
$Disks = $testvm | Get-HardDisk | Select -Last 1
$Disks | New-ScsiController -Type ParaVirtual
}

elseif ($DiskCount -eq 4) {
$testvm | New-HardDisk -CapacityGB $E
$testvm | New-HardDisk -CapacityGB $F
$Disks = $testvm | Get-HardDisk | Select -Last 2
$Disks | New-ScsiController -Type ParaVirtual
}

elseif ($DiskCount -eq 5) {
$testvm | New-HardDisk -CapacityGB $E
$testvm | New-HardDisk -CapacityGB $F
$testvm | New-HardDisk -CapacityGB $G
$Disks = $testvm | Get-HardDisk | Select -Last 3
$Disks | New-ScsiController -Type ParaVirtual
}

elseif ($DiskCount -eq 6) {
$testvm | New-HardDisk -CapacityGB $E
$testvm | New-HardDisk -CapacityGB $F
$testvm | New-HardDisk -CapacityGB $G
$testvm | New-HardDisk -CapacityGB $H
$Disks = $testvm | Get-HardDisk | Select -Last 4
$Disks | New-ScsiController -Type ParaVirtual
}

#set portgroup for prod and backup adapter according to cluster
if ($cluster -like "*CLUSTER-NAME*"){
$networkbackup = "Seconday hardcoded adapter name"

#adding both prod and backup adapters to proper VLAN (port group in vdswitch) and marking Connect at power on
$testvm | Get-NetworkAdapter -Name *1* | Set-NetworkAdapter -Portgroup $Vlan -confirm:$false
$testvm | Get-NetworkAdapter -Name *1* | Set-NetworkAdapter -StartConnected:$true -confirm:$false
$testvm | Get-NetworkAdapter -Name *2* | Set-NetworkAdapter -Portgroup $networkbackup -confirm:$false
$testvm | Get-NetworkAdapter -Name *2* | Set-NetworkAdapter -StartConnected:$true -confirm:$false

#adding vm to proper vm group in a cluster
$LastTwo = $VMname.Substring($VMname.get_Length()-2)
$LastTwo | % {if($_ % 2 -eq 1 ) {$VMgroup = Get-DrsClusterGroup -Type VMGroup -Name *1_VM* -Cluster CLUSTER-NAME} else {$VMgroup = Get-DrsClusterGroup -Type VMGroup -Name *3_VM* -Cluster CLUSTER-NAME}}
Set-DrsClusterGroup -DrsClusterGroup $VMgroup -VM $VMname -Add -confirm:$false
}

elseif ($cluster -like "*OTHER Cluster-name*"){
$networkbackup = "Seconday hardcoded adapter name"

#adding both prod and backup adapters to proper VLAN (port group in vdswitch) and marking Connect at power on
$testvm | Get-NetworkAdapter -Name *1* | Set-NetworkAdapter -Portgroup $Vlan -confirm:$false
$testvm | Get-NetworkAdapter -Name *1* | Set-NetworkAdapter -StartConnected:$true -confirm:$false
$testvm | Get-NetworkAdapter -Name *2* | Set-NetworkAdapter -Portgroup $networkbackup -confirm:$false
$testvm | Get-NetworkAdapter -Name *2* | Set-NetworkAdapter -StartConnected:$true -confirm:$false

#adding vm to proper vm group in a cluster
$LastTwo = $VMname.Substring($VMname.get_Length()-2)
$LastTwo | % {if($_ % 2 -eq 1 ) {$VMgroup = Get-DrsClusterGroup -Type VMGroup -Name *1_VM* -Cluster OTHER Cluster-name} else {$VMgroup = Get-DrsClusterGroup -Type VMGroup -Name *3_VM* -Cluster OTHER Cluster-name}}
Set-DrsClusterGroup -DrsClusterGroup $VMgroup -VM $VMname -Add -confirm:$false
}

if ($VMname -like "test*") {
$ResourcepoolVM = Get-ResourcePool -Name Test_non-prod -Location $Cluster
}
elseif ($VMname -like "prod*") {
$ResourcepoolVM = Get-ResourcePool Prod -Location $Cluster
}

$testvm | Move-VM -destination $ResourcepoolVM

[System.Windows.Forms.MessageBox]::Show("Please wait 10 seconds to make sure, that all config is complete on vCenter server's side.", "Info" , 0, "Info")
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(70, 600)
$progressBar.Size = New-Object System.Drawing.Size(200, 20)
$progressBar.Minimum = 0
$progressBar.Maximum = 10
$progressBar.Step = 1
$form.Controls.Add($progressBar)

for ($i = 1; $i -le 10; $i++) {
        Start-Sleep -Seconds 1
        $progressBar.PerformStep()
    }
    [System.Windows.Forms.MessageBox]::Show("Config complete.", "Info" , 0, "Info")

$testvm | Start-VM
[System.Windows.Forms.MessageBox]::Show("VM will be powered-on now.", "Info" , 0, "Info")
}
    } else {
        [System.Windows.Forms.MessageBox]::Show("Process has been aborted", "Info" , 0, "Info")
    }

})

[void]$form.Controls.Add($button)
[void]$form.Controls.Add($buttonDeploy)
[void]$form.ShowDialog()
[void]$stream.Dispose()
[void]$Form.Dispose()



        } else {
        [System.Windows.Forms.MessageBox]::Show("Login failed.`n`nPlease double-check your username or password and try again.`n`rPlease use the login layout: DOMAIN\Username", "Error" , 0, "Error")
        }

    })

    # Create Exit button control
    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(90, 70)
    $cancelButton.Size = New-Object System.Drawing.Size(100, 25)
    $cancelButton.BackColor = [System.Drawing.Color]::MediumSlateBlue
    $cancelButton.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    $cancelButton.FlatStyle = 'flat'
    $cancelButton.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::Turquoise
    $cancelButton.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::MediumBlue
    $cancelButton.FlatAppearance.BorderColor = [System.Drawing.Color]::DarkSlateBlue
    $cancelButton.Text = "Exit"
    $LoginForm.Controls.Add($cancelButton)

    # Define event handler for cancel button click
    $cancelButton.Add_Click({
        
        $LoginForm.Close()
    })

    # Show input form
    [void]$LoginForm.ShowDialog()
