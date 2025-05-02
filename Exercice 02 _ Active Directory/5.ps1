Set-ADDefaultDomainPasswordPolicy -Identity laplateforme.io `
    -ComplexityEnabled $true `
    -LockoutDuration "00:30:00" `
    -LockoutObservationWindow "00:30:00" `
    -LockoutThreshold 5 `
    -MaxPasswordAge "42.00:00:00" `
    -MinPasswordAge "1.00:00:00" `
    -MinPasswordLength 8 `
    -PasswordHistoryCount 24 `
    -ReversibleEncryptionEnabled $false