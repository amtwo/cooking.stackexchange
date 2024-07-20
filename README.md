# cooking.stackexchange

* Create a directory containing [SEDE_Query.sql] & [Convert-SEDEToMarkdown.ps1].
* Use the query in [SEDE_Query.sql] to run on a copy of the Data Dump or [Stack Exchange Data Explorer](data.stackexchange.com) (SEDE).
    * Ensure you modify the file to use your UserId
    * This will generate one row of data for every post _answered_ by the given UserId
* Save the results to a file named QueryResults.csv in the same directory as the .sql and .ps1 files. SEDE contains a "📄Download CSV" link.
* Execute the [Convert-SEDEToMarkdown.ps1] script.
    * This will create a docs subdirectory, containing one file for each row in the CSV (ie, one markdown file per post)
    * The docs subdirectory will also contain an index.md file, which contains links to each of the individual posts.
* The resultant directory can be used directly with GitHub pages to create a site showcasing all of your answers. 
