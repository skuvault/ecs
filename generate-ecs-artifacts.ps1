param ([string] $definitionsDirectory)
if ($definitionsDirectory -eq "") {
    $definitionsDirectory = Read-Host -Prompt "Please, provide the name of a directory with template definitions"
}

Write-Host "Creating Python Virtual Environment and installing requirements..."

python -m venv ./py-env
.\py-env\Scripts\activate.bat
pip install -r .\scripts\requirements.txt

Write-Host "Reading definition files from /ecs-definitions/$definitionsDirectory/"

python .\scripts\generator.py `
    --ref v8.4.0 `
    --subset ".\ecs-definitions\$definitionsDirectory\fields\subset.yml" `
    --include ".\ecs-definitions\skuvault-shared\fields\custom\" ".\ecs-definitions\canary\fields\custom\" `
    --out ./ecs-output/$definitionsDirectory/

Write-Host "Generated files written to /ecs-output/$definitionsDirectory/"