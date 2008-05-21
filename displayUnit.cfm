
<cfset unitTestObject = createObject("component","testCaseCFC") />


<hr>
<cfoutput>#scoperFileName#</cfoutput><br><br>
NOTE: If a false positive and negative case are contained in the same function it may report success

<hr>
<br>

<cfset resultsArray = varscoper.getResultsArray() />
<cfset resultsStruct = structNew() />

<cfloop from="1" to="#arrayLen(resultsArray)#" index="arrIdx">
	<cfset resultsStruct["#resultsArray[arrIdx].functionName#"] = arrayLen(resultsArray[arrIdx].unscopedArray) >
</cfloop>


<cfset objMetadata = getMetadata(unitTestObject).functions>

<table border="0" cellpadding="4" cellspacing="0" width="100%" class="scoperTable">
		<tr>
			<td class="fileTitle" colspan="5" nowrap>
				<cfoutput><a href="fileDisplay.cfm?fileName=#URLEncodedFormat(scoperFileName)#" target="varscoper" class="fileTitle">#scoperFileName#</a></cfoutput>
			</td>
		</tr>
<cfloop from="1" to="#arrayLen(objMetadata)#" index="resultIdx">
	<cfset currentFunction = objMetadata[resultIdx] />
	
	<cfinvoke component="#unitTestObject#" method="#currentFunction.name#" returnvariable="scopedCount">
		<tr>
			<td nowrap class="functionCell">
				<strong>
					<cfoutput>#htmlEditFormat("#currentFunction.Name#")#</cfoutput>
				</strong>
			</td>
			<cfif structKeyExists(resultsStruct,currentFunction.Name)>
				<cfset found = resultsStruct["#currentFunction.Name#"] />
			<cfelse>
				<cfset found = 0 />
			</cfif>

			<td nowrap  class="functionCell" >
				<cfif found GT scopedCount>
				 	<span style="font-weight:bold;color:#ff8000;">FAIL - false positives</span>
				<cfelseif found LT scopedCount>
					<span style="font-weight:bold;color:#c03000;">FAIL</span>
				<cfelse>
					<span style="color:green;">PASS</span>
				</cfif>
			</td>
			<td nowrap class="functionCell" >
				<cfif found NEQ scopedCount>
				 	<cfoutput>#scopedCount# expected - #found# found</cfoutput>
				<cfelse>&nbsp;
				</cfif>
			</td>
			<td width="99%" class="functionCell">&nbsp;</td>
		</tr>	

</cfloop>

</table>
<!--- <cfdump var="#varscoper.getResultsArray()#" label="Array Of Unscoped Variables"> --->
<cfflush>