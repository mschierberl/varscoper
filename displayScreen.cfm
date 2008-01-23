
<cfset currentFileName = scoperFileName />
<cfset scoperResults = varscoper.getResultsArray() />

<cfset totalUnscopedVariables = 0 />
<cfloop from="1" to="#arrayLen(scoperResults)#" index="idx">
	<cfset totalUnscopedVariables = totalUnscopedVariables + arrayLen(scoperResults[idx].unscopedArray) />
</cfloop>
	<cfif ArrayIsEmpty(scoperResults)>
		<!--- <cfoutput>Check was successful for (#htmlEditFormat(scoperFileName)#)</cfoutput><br><br> --->

	<cfelse>
		<cfif isDefined('URL.sendBadStatus')>
			<cfheader statuscode="599" statustext="unscoped">
		</cfif>
		<table border="0" cellpadding="2" cellspacing="0" width="100%" class="scoperTable">
			<tr>
				<td class="fileTitle" colspan="4">
					<cfoutput><a href="fileDisplay.cfm?fileName=#URLEncodedFormat(currentFileName)#" target="varscoper" class="fileTitle">#currentFileName#</a> (#totalUnscopedVariables# unscoped variables) </cfoutput>
				</td>
			</tr>
			
			<cfloop from="1" to="#arrayLen(scoperResults)#" index="scoperIdx">
				<cfset tempUnscopedArray = scoperResults[scoperIdx].unscopedArray />
				<cfif NOT ArrayIsEmpty(tempUnscopedArray)>
					<tr>
						<td colspan="3" class="functionCell" >
							<strong>
								<cfoutput>#htmlEditFormat("<cffunction name='#scoperResults[scoperIdx].functionName#'>")#
									<cfif structKeyExists(scoperResults[scoperIdx],"LineNumber") AND scoperResults[scoperIdx].LineNumber NEQ 1>
										<a href="fileDisplay.cfm?fileName=#URLEncodedFormat(currentFileName)###line#scoperResults[scoperIdx].LineNumber#" target="varscoper" >line: #scoperResults[scoperIdx].LineNumber#</a>
									</cfif>
								</cfoutput>
							</strong>
						</td>
					</tr>
				
						<cfloop from="1" to="#arrayLen(tempUnscopedArray)#" index="unscopedIdx">
							<cfoutput>
							<tr>
							</cfoutput>
								<td class="varNameCell" align="right"><cfoutput>#tempUnscopedArray[unscopedIdx].VariableName#</cfoutput></td>
								<cfif structKeyExists(tempUnscopedArray[unscopedIdx],"LineNumber") AND tempUnscopedArray[unscopedIdx].LineNumber NEQ 1>
								<td class="varNameCell" align="right">
									<cfoutput><a href="fileDisplay.cfm?fileName=#URLEncodedFormat(currentFileName)###line#tempUnscopedArray[unscopedIdx].LineNumber#" target="varscoper" >line: #tempUnscopedArray[unscopedIdx].LineNumber#</a></cfoutput>
								</td>
								</cfif>
								<td class="contextCell" ><cfoutput>#htmlEditFormat(left(tempUnscopedArray[unscopedIdx].VariableContext,100))#</cfoutput></td>
							</tr>
						</cfloop>
				
				</cfif>
			</cfloop>
		
		</table><br><br>
	</cfif>
		

<cfflush>