param(
    [string]$directoryPath = "build\windows\x64\runner\Release",  # Default directory path
    [string]$templateFilePath = "Installers\innoSetupScript_template.iss", # Path to your template file
    [string]$outputFilePath = "Installers\innoSetupScript.iss"      # Path to the output file
)

# Ensure the directory exists
if (-not (Test-Path -Path $directoryPath)) {
    Write-Host "The specified directory '$directoryPath' does not exist."
    exit 1
}

# List all files in the specified directory
$files = Get-ChildItem -Path $directoryPath -File | Select-Object -ExpandProperty Name

# Create an array to store the formatted file entries
$fileList = @()

# Format the files in the required structure
foreach ($file in $files) {
    $formattedFile = "Source: `"..\build\windows\x64\runner\Release\$file`"; DestDir: `"{app}`"; Flags: ignoreversion"
    $fileList += $formattedFile
}

# Join the file list into a single string, separated by newlines
$fileListString = $fileList -join "`n"

# Ensure the template file exists
if (-not (Test-Path -Path $templateFilePath)) {
    Write-Host "The specified template file '$templateFilePath' does not exist."
    exit 1
}

# Read the template file content
$templateContent = Get-Content -Path $templateFilePath -Raw

# Replace the {{files}} placeholder with the formatted list of files
$updatedContent = $templateContent -replace '\{\{files\}\}', $fileListString

# Write the updated content to the output file
$updatedContent | Set-Content -Path $outputFilePath

# Optionally, display the updated content
Write-Host "Updated content written to '$outputFilePath'."
