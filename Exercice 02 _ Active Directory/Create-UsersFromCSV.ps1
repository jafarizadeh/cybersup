# Create-UsersFromCSV.ps1
param(
    [string]$CSVPath = "C:\Users\users.csv"
)

$Domain = "laplateforme.io"
$DefaultPassword = ConvertTo-SecureString "Azerty2025!" -AsPlainText -Force

# Import CSV data
$Users = Import-Csv -Path $CSVPath

# Creating groups
$AllGroups = $Users | ForEach-Object {
    $_.group1, $_.group2, $_.group3, $_.group4, $_.group5, $_.group6
} | Where-Object { $_ -ne "" } | Select-Object -Unique

foreach ($Group in $AllGroups) {
    if (-not (Get-ADGroup -Filter { Name -eq $Group })) {
        try {
            New-ADGroup -Name $Group -GroupScope Global -Path "CN=Users,DC=laplateforme,DC=io"
            Write-Host "Group $Group created successfully." -ForegroundColor Green
        } catch {
            Write-Host "Error creating group $Group : $_" -ForegroundColor Red
        }
    }
}

# Create users
foreach ($User in $Users) {
    $Username = ($User.first_name.Substring(0,1) + $User.name
    $SamAccountName = $Username.ToLower()
    $DisplayName = "$($User.first_name) $($User.name)"
    $UserPrincipalName = "$SamAccountName@$Domain"
    
    if (-not (Get-ADUser -Filter { SamAccountName -eq $SamAccountName })) {
        try {
            New-ADUser -Name $DisplayName `
                      -GivenName $User.first_name `
                      -Surname $User.name `
                      -SamAccountName $SamAccountName `
                      -UserPrincipalName $UserPrincipalName `
                      -AccountPassword $DefaultPassword `
                      -ChangePasswordAtLogon $true `
                      -Enabled $true `
                      -Path "CN=Users,DC=laplateforme,DC=io"
            
            Write-Host "User $DisplayName created successfully." -ForegroundColor Green
            
            # Add to groups
            $Groups = $User.group1, $User.group2, $User.group3, $User.group4, $User.group5, $User.group6 | Where-Object { $_ -ne "" }
            foreach ($Group in $Groups) {
                try {
                    Add-ADGroupMember -Identity $Group -Members $SamAccountName
                    Write-Host "User $SamAccountName added to group $Group." -ForegroundColor Cyan
                } catch {
                    Write-Host "Error adding user $SamAccountName to group $Group : $_" -ForegroundColor Red
                }
            }
        } catch {
            Write-Host "Error creating user $DisplayName : $_" -ForegroundColor Red
        }
    } else {
        Write-Host "User $DisplayName already exists." -ForegroundColor Yellow
    }
}

Write-Host "User creation process completed." -ForegroundColor Green