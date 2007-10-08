<!--- Problem Files --->
<!--- 


 --->
<cfcomponent name="testCaseCFC" hint="I am the worst written CFC ever, my vars are horribly scoped">
	<cfset variables.fooGlobalVar = "blah">
	
	
	
	<cffunction name="simpleVarTest">
		<cfset var correctSimpleVar = "" />
		<cfset   var correctSimpleVar2 = "" />
		<CFsET var correctSimpleVar3 = "" />
		<cfset   VAR correctSimpleVar4 = "" />
		
		<cfset correctSimpleVar ="bar">
		<CFSET correctSimpleVar2 = "">
		<cfSet correctSimpleVar3 ="bar">
		<cfset correctSimpleVar4 = "">
		<!--- <cfset WithinComments = "" /> --->
		
		
		<cfset unscopedSimpleVar ="">
		<cfset unscoped.var2	="" >
		<cfset un_scopedvar3	= "" />
		<cfset   un_scopedvar4 = '' />
		<cfset
			unscopedVar5 = '' />
		
	</cffunction>
	
	<cffunction name="loopsTest">
		<!--- This should find a problem with foo2 and foo4 --->
		<cfset var correctIndexLoop = "" />
		<cfset var correctItemLoop = "" />
		
		<cfloop from="1" to="2" index="correctIndexLoop"></cfloop>
		<cfloop from="1" to="2" index="unscopedIndexLoop1"></cfloop>
		<cfloop from="1" to="2" index ="unscopedIndexLoop2"></cfloop>
		<cfloop from="1" to="2" index= "unscopedIndexLoop3"></cfloop>
		<cfloop from="1" to="2" index = "unscopedIndexLoop4"></cfloop>
		<cfloop from='1' to='2' index='unscopedIndexLoop5'></cfloop>
		<cfloop from='1' to='2' 
		index ='unscopedIndexLoop6'></cfloop>
		<!--- NOTE: This currently isn't being found --->
		<cfloop from='1' to='2' index= 
			'unscopedIndexLoop7'></cfloop>
		<cfloop from='1' to='2' index = 'unscopedIndexLoop8'></cfloop>
		<cfloop collection="foo" item="correctItemLoop"></cfloop>
		<cfloop collection="foo" item="unscopedItemLoop1"></cfloop>
	</cffunction>


	<cffunction name="unVaredQueries">
		<cfset var correctQuery1 = "" />
		
		<cfquery name=qryNoName datasource="#blah#" >

		</cfquery>
		
		<cfquery name="correctQuery1"></cfquery>
		<cfquery name="unScopedQuery1"></cfquery>
		<cfquery 
			name= 'unScopedQuery2'>
		</cfquery>
		


		
	</cffunction>
	
	<cffunction name="structVariables">
	
		<cfset var correctStruct = structNew()>
		<cfset var correct_Struct2 = structNew()>
				
		<cfset correctStruct.foo = "">
		<cfset correctStruct.foo2 = "">
		<cfset correctStruct[foo3] = "">
		<cfset correct_Struct2.foo = "">

		<cfset unscopedStruct.foo = "" />
		<cfset unscopedStruct2[foo] = "" />
		<cfset unscoped_2.unscopedStruct = "" />

	</cffunction>
	
	<cffunction name="invokeTest">
		<cfset var correctInvoke = "">
		<cfset var correctStruct = structNew() />
		<cfset var correctArray = structNew() />
		<cfinvoke returnvariable="correctInvoke">
		<cfinvoke returnvariable="unscopedInvoke">
		<cfinvoke returnvariable="correctStruct.Invoke">
		<cfinvoke returnvariable="unscopedstruct.Invoke">
		<cfinvoke returnvariable="correctArray[Invoke]">
		<cfinvoke returnvariable="unscopedarray[Invoke]">
		
	</cffunction>
	
	<cffunction name="problemCases">
		<cfset var properScope = structNEw()>
		
	<!---	These were resolved in 1.00 --->
		<cfparam name="foo.results.foo[i]" default="" />
		
		<cfset foo2.unscoped.foo[i] = "" /> 
		<cfset variables.foo[""#foo#""] = "" />
		
		<cfset properScope.foo2[""#foo2#""] = ""/> 
		
		<!--- Returns false positives --->
		<cfparam name="variables.foo2[""#foo2#""]" default="">
		<cfparam name="variables.foo3.#arguments.message#" default="">
	</cffunction>
	

	<!--- This returns false positives --->
	<cffunction name="invokeListener" access="public" returntype="void">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="listener" required="true" />
		<cfargument name="method" type="string" required="true" />
		<cfargument name="resultKey" type="string" required="false" default="" />
	
		<cftry>
			<cfinvoke 
				component="#arguments.listener#" 
				method="#arguments.method#" 
				event="#arguments.event#" 
				returnvariable="#arguments.resultKey#" />
			
			<cfcatch type="Any">
				<cfrethrow />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="cfscript_vars" access="public" returntype="void">
		<cfscript>
			var correctSimpleVar ="bar";
			VAR correctSimpleVar2 = "";
			vAr correctSimpleVar3 ="bar";
			var correctSimpleVar4 = "";
			var correctSimpleVar5 = ""; //comments after var
			var correctStruct = structNew();
			var correctLoop = "";
			var arr = "";
			var startRow = ""; 
			// var withinComments = "";
			/* var withincomments2 = ""; */
		</cfscript>
		
		<cfscript>
			correctSimpleVar ="bar";
			correctSimpleVar2 = "";
			correctSimpleVar3 ="bar";
			correctSimpleVar4 = '';
			correctSimpleVar4 
				= 
				"" 
				;
			correctStruct.test = ""
			;
			
			for(correctLoop=1;correctLoop LTE 10; correctLoop=correctLoop+1) correctSimpleVar = correctLoop;

 			for (unscopedLoop=1;unscopedLoop LTE 10; unscopedLoop=unscopedLoop+1) unscopedSimpleVar = unscopedLoop;
			
			unscopedSimpleVar ="bar";
			unscopedSimpleVar2 = "";
			unscopedSimpleVar3 ="bar";
			unscopedSimpleVar4 
				= 
				"" 
				;
			unscopedStruct.test = ""
			;
			
			arr[1] = foo;
			
			if (1 EQ 1)
				startRow = 1;
			else 
				startRow = 2;
		</cfscript>
		

	</cffunction>
	
	<cffunction name="cfscript_vars_2">
	    <cfscript>
            var currentMode=''; // loop index
            var currentKeyword=''; // loop index
            var tmpQuery=''; // temp query holder
            var ReturnStruct=structnew(); 
            ReturnStruct.Query='';
            ReturnStruct.TotRows='';
            currentMode = '';
            
        </cfscript>
	</cffunction>

</cfcomponent>