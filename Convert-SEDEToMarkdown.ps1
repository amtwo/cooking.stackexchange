# Define the input and output file paths
$csvFilePath = "QueryResults.csv"
$outputDirectory = "Output"

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
