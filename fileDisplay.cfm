<cfif structKeyExists(URL,"fileName")>
	<cffile action="read" file="#URL.fileName#" variable="fileContent" />
	
			
<cfsetting enablecfoutputonly="true">
<cfoutput><pre></cfoutput>
<cfset totalLines = 0 />
<cfset lineCheckLine = 1 />
<cfset lastLineStart = 1 />
<cfset hasMoreLines = true />
<cfloop condition="hasMoreLines EQ true">
				<cfset lineFeedArray = REFind("#chr(13)#?#chr(10)#",fileContent,lineCheckLine,true) />
				<cfif lineFeedArray.POS[1] EQ 0>
					<cfset hasMoreLines = false />
				<cfelse>
					<cfset totalLines = totalLines + 1 />
					<cfset lineCheckLine = lineFeedArray.POS[1] + lineFeedArray.LEN[1] />
				</cfif>
				<cfif lineFeedArray.POS[1] -lastLineStart GT 0>
				<cfoutput><a name="line#totalLines#">#totalLines#: #HTMLEditFormat(mid(fileContent,lastLineStart + 2,lineFeedArray.POS[1] -lastLineStart))#</cfoutput>
				</cfif>
				<cfset lastLineStart = lineFeedArray.POS[1] />
			</cfloop>

<cfoutput></pre></cfoutput>

	
</cfif>