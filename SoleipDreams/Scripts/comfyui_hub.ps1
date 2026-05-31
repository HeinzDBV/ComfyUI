param(
	[ValidateSet("menu", "optimized", "standard", "manager", "lowvram", "update", "update-dryrun", "backup", "backup-output", "validate")]
	[string]$Action = "menu"
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$HubScriptPath = $MyInvocation.MyCommand.Path
$RepoDir = (Resolve-Path (Join-Path $ScriptDir "..\..")).Path
$UpdateScript = Join-Path $ScriptDir "update_comfyui.ps1"
$BackupScript = Join-Path $ScriptDir "backup_comfyui.ps1"
$VenvActivate = Join-Path $RepoDir ".venv\Scripts\Activate.ps1"
$ComfyUrl = "http://127.0.0.1:8188"

function Header {
	param([string]$Title)
	Write-Host ""
	Write-Host "============================================================" -ForegroundColor Cyan
	Write-Host "  $Title" -ForegroundColor Yellow
	Write-Host "============================================================" -ForegroundColor Cyan
}

function Set-RepoContext {
	Set-Location $RepoDir
}

function Initialize-PythonEnv {
	if (-not (Test-Path $VenvActivate)) {
		throw "No se encontro el entorno virtual en $VenvActivate"
	}
	& $VenvActivate
}

function Start-Comfy {
	param(
		[string]$ModeName,
		[string[]]$LaunchOptions,
		[switch]$UseOptimizedAlloc,
		[switch]$OpenBrowserWhenReady
	)

	Set-RepoContext
	Initialize-PythonEnv

	if ($UseOptimizedAlloc) {
		$env:PYTORCH_CUDA_ALLOC_CONF = "garbage_collection_threshold:0.6,max_split_size_mb:128"
	}

	Header "ComfyUI - $ModeName"
	Write-Host "Repo: $RepoDir" -ForegroundColor Gray
	Write-Host "URL:  $ComfyUrl" -ForegroundColor White
	Write-Host "Args: main.py $($LaunchOptions -join ' ')" -ForegroundColor White
	if ($OpenBrowserWhenReady) {
		Write-Host "Browser: se abrira automaticamente cuando la UI responda" -ForegroundColor White
	}
	Write-Host ""
	Write-Host "Presiona Ctrl+C para detener" -ForegroundColor Red
	Write-Host ""

	$openBrowserJob = $null
	if ($OpenBrowserWhenReady) {
		$openBrowserJob = Start-Job -ScriptBlock {
			param($UiUrl)
			$ready = $false
			for ($i = 0; $i -lt 120; $i++) {
				try {
					$response = Invoke-WebRequest -Uri "$UiUrl/system_stats" -UseBasicParsing -TimeoutSec 2
					if ($response.StatusCode -ge 200 -and $response.StatusCode -lt 500) {
						$ready = $true
						break
					}
				} catch {
					# Espera a que el servidor termine de inicializar.
				}
				Start-Sleep -Milliseconds 800
			}

			if ($ready) {
				Start-Process $UiUrl | Out-Null
			}
		} -ArgumentList $ComfyUrl
	}

	try {
		python main.py @LaunchOptions
	} finally {
		if ($null -ne $openBrowserJob) {
			Receive-Job -Job $openBrowserJob -ErrorAction SilentlyContinue | Out-Null
			Remove-Job -Job $openBrowserJob -Force -ErrorAction SilentlyContinue
		}
	}
}

function Test-HubModes {
	Set-RepoContext
	Header "Validacion de Modos"

	$checks = @(
		@{ Name = "Repo"; Path = $RepoDir },
		@{ Name = "Python venv"; Path = $VenvActivate },
		@{ Name = "Script Hub"; Path = $HubScriptPath },
		@{ Name = "Script Update"; Path = $UpdateScript },
		@{ Name = "Script Backup"; Path = $BackupScript },
		@{ Name = "main.py"; Path = (Join-Path $RepoDir "main.py") }
	)

	$allOk = $true
	foreach ($check in $checks) {
		if (Test-Path $check.Path) {
			Write-Host "[OK] $($check.Name): $($check.Path)" -ForegroundColor Green
		} else {
			Write-Host "[X]  $($check.Name): $($check.Path)" -ForegroundColor Red
			$allOk = $false
		}
	}

	try {
		$null = git --version
		Write-Host "[OK] git disponible" -ForegroundColor Green
	} catch {
		Write-Host "[X]  git no disponible" -ForegroundColor Red
		$allOk = $false
	}

	try {
		Initialize-PythonEnv
		$py = & python -c "import sys; print(sys.version.split()[0])"
		Write-Host "[OK] Python en venv: $py" -ForegroundColor Green
	} catch {
		Write-Host "[X]  Error validando Python en venv: $($_.Exception.Message)" -ForegroundColor Red
		$allOk = $false
	}

	Write-Host ""
	if ($allOk) {
		Write-Host "Validacion completada: todos los modos tienen prerequisitos listos." -ForegroundColor Green
	} else {
		Write-Host "Validacion incompleta: revisa los errores marcados." -ForegroundColor Yellow
		exit 1
	}
}

function Show-Menu {
	while ($true) {
		Header "ComfyUI Hub Diario"
		Write-Host "1) Iniciar ComfyUI (Optimizado RTX 4060)" -ForegroundColor White
		Write-Host "2) Iniciar ComfyUI (Estandar)" -ForegroundColor White
		Write-Host "3) Iniciar ComfyUI (Con Manager)" -ForegroundColor White
		Write-Host "4) Iniciar ComfyUI (LowVRAM)" -ForegroundColor White
		Write-Host "5) Update ComfyUI" -ForegroundColor White
		Write-Host "6) Update ComfyUI (DryRun)" -ForegroundColor White
		Write-Host "7) Backup" -ForegroundColor White
		Write-Host "8) Backup (+output)" -ForegroundColor White
		Write-Host "9) Validar modos" -ForegroundColor White
		Write-Host "Q) Salir" -ForegroundColor Gray
		Write-Host ""

		$choice = (Read-Host "Selecciona una opcion").Trim().ToLowerInvariant()
		switch ($choice) {
			"1" { Start-Comfy -ModeName "Optimizado RTX 4060 + Manager" -LaunchOptions @("--enable-manager", "--preview-method", "auto") -UseOptimizedAlloc -OpenBrowserWhenReady ; return }
			"2" { Start-Comfy -ModeName "Estandar" -LaunchOptions @() -OpenBrowserWhenReady ; return }
			"3" { Start-Comfy -ModeName "Con Manager" -LaunchOptions @("--enable-manager") -OpenBrowserWhenReady ; return }
			"4" { Start-Comfy -ModeName "LowVRAM" -LaunchOptions @("--lowvram", "--preview-method", "auto") -UseOptimizedAlloc -OpenBrowserWhenReady ; return }
			"5" { & $UpdateScript; return }
			"6" { & $UpdateScript -DryRun; return }
			"7" { & $BackupScript; return }
			"8" { & $BackupScript -IncludeOutput; return }
			"9" { Test-HubModes; Read-Host "Presiona Enter para volver al menu" | Out-Null }
			"q" { return }
			default {
				Write-Host "Opcion invalida: $choice" -ForegroundColor Yellow
			}
		}
	}
}

switch ($Action) {
	"menu" { Show-Menu }
	"optimized" { Start-Comfy -ModeName "Optimizado RTX 4060 + Manager" -LaunchOptions @("--enable-manager", "--preview-method", "auto") -UseOptimizedAlloc -OpenBrowserWhenReady }
	"standard" { Start-Comfy -ModeName "Estandar" -LaunchOptions @() -OpenBrowserWhenReady }
	"manager" { Start-Comfy -ModeName "Con Manager" -LaunchOptions @("--enable-manager") -OpenBrowserWhenReady }
	"lowvram" { Start-Comfy -ModeName "LowVRAM" -LaunchOptions @("--lowvram", "--preview-method", "auto") -UseOptimizedAlloc -OpenBrowserWhenReady }
	"update" { & $UpdateScript }
	"update-dryrun" { & $UpdateScript -DryRun }
	"backup" { & $BackupScript }
	"backup-output" { & $BackupScript -IncludeOutput }
	"validate" { Test-HubModes }
}

