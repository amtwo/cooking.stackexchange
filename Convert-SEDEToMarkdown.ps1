# Define the input and output file paths
$csvFilePath = "QueryResults.csv"
$outputDirectory = "docs"
$indexPageTitle = "## Andy's [Seasoned Advice](https://cooking.stackexchange.com/) Contributions`r`n"

# Create the output directory if it doesn't exist
if (-not (Test-Path -Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

# Read the CSV file
$csvData = Import-Csv -Path $csvFilePath

# Loop through each row in the CSV data
foreach ($row in $csvData) {
    # Generate the markdown content
    $markdownContent = @"
# $($row.PostTitle)

$($row.PostBody)
"@

    # Strip out invalid characters from the file name
    $fileName = $row.PostTitle -replace '[\\/:*?"<>|]', ''

    # Generate the output file path
    $outputFilePath = Join-Path -Path $outputDirectory -ChildPath "$fileName.md"

    # Save the markdown content to the output file
    $markdownContent | Out-File -FilePath $outputFilePath -Encoding UTF8
}


# Get all markdown files in the docs subdirectory
$markdownFiles = Get-ChildItem -Path "$outputDirectory/*.md"

# Sort the markdown files alphabetically
$sortedFiles = $markdownFiles | Sort-Object -Property Name

# Create the index.md file
$indexFilePath = Join-Path -Path $outputDirectory -ChildPath "index.md"
$indexContent = $indexPageTitle
$indexContent += "All content is licensed under [CC BY-SA](https://creativecommons.org/licenses/by-sa/4.0/).`r`n"

# Generate the list of file names as hyperlinks
foreach ($file in $sortedFiles) {
    $fileName = $file.Name -replace '\.md$'
    $fileLink = "- [$fileName]($fileName.md)`r`n"
    $indexContent += $fileLink
}

# Save the index.md file
$indexContent | Out-File -FilePath $indexFilePath -Encoding UTF8
