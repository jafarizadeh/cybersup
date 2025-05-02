# Initial settings
$Domain = "laplateforme.io"
$CSVPath = "C:\Users\users.csv"
$DefaultPassword = ConvertTo-SecureString "Azerty2025!" -AsPlainText -Force

# Import CSV data
$Users = Import-Csv -Path $CSVPath

# Create unique groups
$AllGroups = $Users | ForEach-Object {
    $_.group1, $_.group2, $_.group3, $_.group4, $_.group5, $_.group6
} | Where-Object { $_ -ne "" } | Select-Object -Unique

foreach ($Group in $AllGroups) {
    if (-not (Get-ADGroup -Filter { Name -eq $Group })) {
        New-ADGroup -Name $Group -GroupScope Global -Path "CN=Users,DC=laplateforme,DC=io"
    }
}

# Create users
foreach ($User in $Users) {
    $Username = ($User.first_name.Substring(0,1) + $User.name)
    $SamAccountName = $Username.ToLower()
    $DisplayName = "$($User.first_name) $($User.name)"
    $UserPrincipalName = "$SamAccountName@$Domain"
    
    # Checking for user existence
    if (-not (Get-ADUser -Filter { SamAccountName -eq $SamAccountName })) {
        New-ADUser -Name $DisplayName `
                   -GivenName $User.first_name `
                   -Surname $User.name `
                   -SamAccountName $SamAccountName `
                   -UserPrincipalName $UserPrincipalName `
                   -AccountPassword $DefaultPassword `
                   -ChangePasswordAtLogon $true `
                   -Enabled $true `
                   -Path "CN=Users,DC=laplateforme,DC=io"
        
        # Adding users to groups
        $Groups = $User.group1, $User.group2, $User.group3, $User.group4, $User.group5, $User.group6 | Where-Object { $_ -ne "" }
        foreach ($Group in $Groups) {
            Add-ADGroupMember -Identity $Group -Members $SamAccountName
        }
    }
}