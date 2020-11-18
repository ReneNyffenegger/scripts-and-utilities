$b = get-cimInstance Win32_Battery

$batteryStatus =( @{
    1 = 'Discharing'
    2 = 'Connected to AC' # 'Unknown'
    3 = 'Fully charged'
    4 = 'Low'
    5 = 'Critical'
    6 = 'Charging'
    7 = 'Charging/High'
    8 = 'Charging/Low'
    9 = 'Charging/Critical'
   10 = 'Undefined'
   11 = 'Partially Charged'
}
)[ $b.batteryStatus -as [int] ]


"$($b.caption) $($b.name): $($b.status)"
"  Status:              $batteryStatus ($($b.batteryStatus))"
"  Charged:             $($b.estimatedChargeRemaining) %"

if ($b.timeToFullCharge) {
"  Time to full charge: $($b.timeToFullCharge) Minutes"
}
