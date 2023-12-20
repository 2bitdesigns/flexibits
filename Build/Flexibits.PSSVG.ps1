$ErrorActionPreference = 'continue'

$assetsPath = $PSScriptRoot | Split-Path | Join-Path -ChildPath "Assets"

if (-not (Test-Path $assetsPath)) {
    $null = New-Item -ItemType Directory -Force $assetsPath 
}

"Debugging Build Problems with Logo, Part 2" | Out-Host

$innerCircles = @(
    $xPercent = 48..52
    $amplitude = 2
    foreach ($n in 0..4) {
        $x = 50 + $(if ($n % 2) {
            ($n + 1) * 2
        } else { 
            $n * -2
        })

        $degrees = (360 / 10) * $n
        $y = 52.5 + [Math]::Cos($degrees*[Math]::PI/180)
        
        svg.circle -Class "ansi$($n+1)-fill" -Fill '#4488ff' -Cx "$x%" -Cy "$y%" -R 0.5%
    }
)

"Debugging Build Problems with Logo, Part 3" | Out-Host

svg -ViewBox 400,400 @(
    svg.defs @(
        SVG.GoogleFont -FontName Abel
    )
        
    svg.ellipse -StrokeWidth 1.25 -Fill transparent -Cx 50% -Cy 50% -Stroke '#4488ff' -Ry 75 -Rx 50 -Class foreground-stroke
    svg.text -FontSize 24 -Content flexibits -X 50% -Y 47.5% @fontSettings -Class foreground-fill -Fill '#4488ff'
    $innerCircles
    # svg.text -FontSize 28 -Content 'bits' -X 50% -Y 55% @fontSettings -Class foreground-fill -Fill '#4488ff'
) -OutputPath (Join-Path $assetsPath "Flexibits.svg")


"Debugging Build Problems with Logo, Part 4" | Out-Host


