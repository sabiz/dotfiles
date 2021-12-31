Param($Message)

function draw($select) {
    Write-Host -NoNewline "                                 "
    Write-Host -NoNewline "`r"
    if ($select -eq 0) {
        Write-Host -NoNewline ">"
    } else {
        Write-Host -NoNewline " "
    }
    Write-Host -NoNewline "YES"
    Write-Host -NoNewline "    "
    if ($select -eq 1) {
        Write-Host -NoNewline ">"
    } else {
        Write-Host -NoNewline " "
    }
    Write-Host -NoNewline "NO"
}

function finish($code) {
    Write-Host ""
    exit $code
}


Write-Host $Message

$CURRENT=0

while ($true) {

    draw $CURRENT

    $key = [Console]::ReadKey($true)

    switch ($key.Key) {
        "LeftArrow" { $CURRENT = $CURRENT -bxor 1 }
        "RightArrow" { $CURRENT = $CURRENT -bxor 1 }
        "Enter" { finish $CURRENT }
        "N" {
            draw 1
            finish 1
        }
        "Y" {
            draw 0
            finish 0
        }
        Default {}
    }
}