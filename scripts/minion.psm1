function Configure() {
  $root = '.'
  $src = Join-Path $root 'src'
  $thirdparty = Join-Path $root 'thirdparty'
  $debug = Join-Path $root 'debug'

  return @{
    thirdparty_dir = $thirdparty
    src_dir = $src
    packages_dir = Join-Path $thirdparty 'packages'
    debug_dir = $debug
  }
}

$config = Configure

function CheckLastExitCode() {
  if ($? -eq $false) {
    throw 'Command Failed'
  }
}

function TryDelete($path) {
  if (Test-Path($path)) {
    Remove-Item $path -Verbose -Recurse
  }
}

function Bootstrap() {
  .\thirdparty\nuget\nuget.exe install .\src\NUnitUtilities.Nuget.Packages\common\packages.config -OutputDirectory .\thirdparty\packages\common -ExcludeVersion | Write-Host
}

function Clean() {
  TryDelete($config.debug_dir)
}

function CleanAll() {
  TryDelete($config.packages_dir)
}

function Build() {
  C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe .\src\NUnitUtilities.Build\NUnitUtilities.proj /ds /maxcpucount:6 | Write-Host
  CheckLastExitCode
}

function BuildNugetPackages() {
  tryDelete('nugetworking')
  
  New-Item .\nugetworking\samplingdecorator\lib\net20 -ItemType directory -Verbose
  
  Copy-Item .\debug\net-2.0\nunitutilities.samplingdecorator\nunitutilities.samplingdecorator.dll .\nugetworking\samplingdecorator\lib\net20 -Verbose
  Copy-Item .\src\nunitutilities.nuget.specs\nunitutilities.samplingdecorator.dll.nuspec .\nugetworking\samplingdecorator -Verbose
  
  thirdparty\nuget\nuget.exe pack .\nugetworking\samplingdecorator\nunitutilities.samplingdecorator.dll.nuspec -OutputDirectory .\nugetworking\samplingdecorator | Write-Host
  CheckLastExitCode
}

function PushNugetPackages() {
  Write-Host -ForegroundColor Yellow '--------------------!!!!!!!------------------------'
  Write-Host -ForegroundColor Yellow 'Push Nuget Packages'
  Write-Host -ForegroundColor Yellow 'Are You Sure?  Enter YES to Continue'
  $response = Read-Host

  if ($response -eq 'YES') {
    Write-Host -ForegroundColor Yellow 'Pushing'

    thirdparty\nuget\nuget.exe push .\nugetworking\samplingdecorator\NUnitUtilities.SamplingDecorator.1.0.0.1.nupkg | Write-Host
    CheckLastExitCode
  } else {
    Write-Host -ForegroundColor Yellow 'Cancelled - Nothing Pushed'
  }
}

function Minion {
  param([string[]] $commands)

  $ErrorActionPreference = 'Stop'

  $commands | ForEach {
    $command = $_
    $times = Measure-Command {
      
      Write-Host -ForegroundColor Green "command: $command"
      Write-Host ''
      
      switch ($command) {
        'bootstrap' { Bootstrap }
        'clean.all' { 
          Clean
          CleanAll 
        }
        'clean' { Clean }
        'build.all' { Build }
        'build.nuget.packages' { BuildNugetPackages }
        'push.nuget.packages' { PushNugetPackages }
        default { Write-Host -ForegroundColor Red "command not known: $command" }
      }
    }
    
    Write-Host ''
    Write-Host -ForegroundColor Green "Command completed in $($times.TotalSeconds) seconds ($($times.TotalMilliseconds) millis)"
  }
}

export-modulemember -function Minion