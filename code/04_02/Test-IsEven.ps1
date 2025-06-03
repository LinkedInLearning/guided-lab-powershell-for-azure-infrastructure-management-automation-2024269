function Test-IsEven {
    param (
        [int]$Number
    )
    # return $Number
    return ($Number % 2 -eq 0)
}