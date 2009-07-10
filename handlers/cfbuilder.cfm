<cfset start = getTickCount()/>
<cfset noErrors=true />
<cfparam name="ideeventinfo"> 

<cfif not isXML(ideeventinfo)>
	<cfexit>
</cfif>

<cfset data = xmlParse(ideeventinfo)>
<cfset resource = data.event.ide.projectview.resource>

<cfset files = []>
<cfif resource.xmlAttributes.type is "file">
	<cfset arrayAppend(files, resource.xmlAttributes.path)>
<cfelse>
	<cfdirectory directory="#resource.xmlAttributes.path#" type="file" recurse="true" name="fileDir" filter="*.cfc|*.cfm">
	<cfloop query="fileDir">
		<cfset arrayAppend(files, directory & "/" & name)>
	</cfloop>
</cfif>

<cfsavecontent variable="responseContent">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
  <title>varScoper</title>
</head>
<style>
body,td{
	font-family: Arial,Helvetica,sans-serif;
	font-size:90%;
}
</style>
<body>
<cfloop index="f" array="#files#">
	<cftry>
		<cfset fileParseText = fileRead(f)>
		<cfcatch>
			<cfset fileParseText = "">
		</cfcatch>
	</cftry>
	<cfset showDuplicates="false">
	<cfset showLineNumbers = "true">
	<cfset parseCfscript="true">

	<cfif len(fileParseText)>
		<cfset varscoperArgs = structNew() />
		<cfset varscoperArgs.fileParseText = fileParseText />
		<cfset varscoperArgs.showDuplicates = showDuplicates />
		<cfset varscoperArgs.showLineNumbers = showLineNumbers />
		<cfset varscoperArgs.parseCfscript = parseCfscript />
		
		<cfinvoke component="varScoper" method="init" argumentcollection="#varscoperArgs#" returnvariable="varscoper">
		
		<cfset varscoper.runVarscoper() />
		<cfset res = varscoper.getResultsArray() />
		<cfif arrayLen(res)>
			<cfset noErrors=false/>
			<cfoutput>
			<table border="1" width="100%">
				<tr>
					<th colspan="3" style="background-color:##89ceff;text-align:left">
					#arrayLen(res)# unscoped variables in #f#
					</th>
				</tr>
				<cfloop index="item" array="#res#">
					<tr>
						<th colspan="3" style="background-color:##aabbff;text-align:left">&lt;cffunction name="#item.functionname#"&gt; (Line: #item.linenumber#)</td>
					</tr>
					<cfloop index="line" array="#item.unscopedArray#">
						<tr>
							<td>#line.variablename#</td>
							<td>#line.linenumber#</td>
							<td>#line.variablecontext#</td>
						</tr>
					</cfloop>
				</cfloop>
			</table>
			</cfoutput>	
		</cfif>
	</cfif>
	
</cfloop>

<cfoutput>
<cfset end = getTickCount() />
<p>
<b>Processed #arrayLen(files)# files in #end-start#ms.</b>
</p>

</cfoutput>
</body>
</html>
</cfsavecontent>

<cfheader name="Content-Type" value="text/xml">
<cfoutput> 
<cfif noErrors>
	<response showresponse="false" status="success" > 
	<ide message="No unscoped variables found. Processed #arrayLen(files)# files in #end-start#ms.">
<cfelse>
	<response showresponse="true"  > 
	<ide > 
</cfif>
<dialog width="800" height="600" /> 
<body> 
<![CDATA[ 
#responseContent#
]]> 
</body> 
</ide> 
</response> 
</cfoutput>

