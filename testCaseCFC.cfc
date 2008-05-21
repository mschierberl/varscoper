<!--- Problem Files --->
<!--- 


 --->
<cfcomponent name="testCaseCFC" hint="I am the worst written CFC ever, my vars are horribly scoped">
	<cfset variables.fooGlobalVar = "blah">

	<cffunction name="TODO_cfscript_return">
		<cfreturn 0>
		<cfscript>
			return newStruct(ok="false", errorMessage="!", sValidationMsg="#getCaseString(attr)#",
					field="#stResult.fieldname#", rules="#stRules#", result="#stResult#"); 
		</cfscript>
	
	</cffunction>

	<cffunction name="TODO">
		<cfreturn 1>
		<!--- NOTE: this should return a violation even though we can't evaluate #i# at runtime --->
		<!--- I'd like this in to indicate to the users that they might have an issue --->
		<cfset "test#i#" = 1 /> 
	</cffunction>

	<cffunction name="simpleVarTest">
		<cfset var correctSimpleVar = "" />
		<cfset   var correctSimpleVar2 = "" />
		<CFsET var correctSimpleVar3 = "" />
		<cfset   VAR correctSimpleVar4 = "" />
		
		<!--- This return value should be updated when the unit test case changes --->
		<cfreturn 5>
		
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
		
		<cfreturn 9>
		<!--- This return value should be updated when the unit test case changes --->
		
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
		
		<!--- This is for unit test, update if test case changes --->
		<cfreturn 3>
		
		<cfquery name=qryNoName datasource="#blah#" >

		</cfquery>
		
		<cfquery name="correctQuery1" dbType="query"></cfquery>
		<cfquery name="unScopedQuery1" dbType="query"></cfquery>
		<cfquery dbType="query"
			name= 'unScopedQuery2'>
		</cfquery>
		
	</cffunction>
	
	<cffunction name="structVariables">
	
		<cfset var correctStruct = structNew()>
		<cfset var correct_Struct2 = structNew()>
		
		<!--- This is for unit test, update if test case changes --->
		<cfreturn 4>
		
		<cfset correctStruct.foo = "">
		<cfset correctStruct.foo2 = "">
		<cfset correctStruct[foo3] = "">
		<cfset correct_Struct2.foo = "">

		<cfset unscopedStruct.foo = "" />
		<cfset unscopedStruct2[foo] = "" />
		<cfset unscoped_2.unscopedStruct = "" />
		
		<!--- This is a new example, should be showing up --->
		<cfset unscopedStruct25["someKey"] = correctStruct  />

	</cffunction>
	
	<cffunction name="invokeTest">
		<cfset var correctInvoke = "">
		<cfset var correctStruct = structNew() />
		<cfset var correctArray = structNew() />
		
		<!--- This is for unit test, update if test case changes --->
		<cfreturn 3>		
		
		<cfinvoke returnvariable="correctInvoke" method="foo">
		<cfinvoke returnvariable="unscopedInvoke"  method="foo">
		<cfinvoke returnvariable="correctStruct.Invoke"  method="foo">
		<cfinvoke returnvariable="unscopedstruct.Invoke"  method="foo">
		<cfinvoke returnvariable="correctArray[Invoke]"  method="foo">
		<cfinvoke returnvariable="unscopedarray[Invoke]"  method="foo">
		
	</cffunction>

	<cffunction name="problem_b">
			
		<!--- This is for unit test, update if test case changes --->
		<cfreturn 2>
		
		<cffeed query="#foo2#" source="blah" />
		<cffeed query="unscoped" action="read" source="http://">
		
		<cfprocparam variable="correctProcParamIn" type="in" cfsqltype="CF_SQL_BIGINT" />
		<cfprocparam variable="unscopedProcParamOut" type="out" cfsqltype="CF_SQL_BIGINT" />
		

	</cffunction>
	
	<cffunction name="problem_a">
		<cfset var properScope = structNEw()>	
		
		<cfreturn 3>
		
		<cfset properScope.foo2['#foo2#'] = ""/> 

		
		<cfset "test.go#i#" = 1 />
		
		<cfset foo2.unscoped.foo[i] = "" /> 
		<cfset foo5.unscoped.foo["i"] = "" />
		
	</cffunction>
	
	<cffunction name="cfparam">
		<cfreturn 1>
		<!---	These were resolved in 1.00 --->
		<cfparam name="foo.results.foo[i]" default="" />
		<!--- Returns false positives --->
		<cfparam name="variables.foo2[""#foo2#""]" default="">
		<cfparam name="variables.foo3.#arguments.message#" default="">
		
	</cffunction>
	
	<!--- This returns false positives --->
	<cffunction name="invokeListener" access="public">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="false" />
		<cfargument name="listener" required="false" />
		<cfargument name="method" type="string" required="false" />
		<cfargument name="resultKey" type="string" required="false" default="" />
	
		<cfreturn 0>
	
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
	
	<cffunction name="cfscript_vars_a" access="public" >
		<cfscript>
			var correctSimpleVar ="bar";
			VAR correctSimpleVar2 = "";
			vAr correctSimpleVar3 ="bar";
			var correctSimpleVar4 = "";
			var correctSimpleVar5 = ""; //comments after var
		</cfscript>
	
		<cfreturn 4>
	
		<cfscript>
			correctSimpleVar ="bar";
			correctSimpleVar2 = "";
			correctSimpleVar3 ="bar";
			correctSimpleVar4 = '';
			correctSimpleVar4 
				= 
				"" 
				;
			correctSimpleVar5 = "b l a" ; //comments 
			
			unscopedSimpleVar ="bar";
			unscopedSimpleVar2 = "";
			unscopedSimpleVar3 ="bar";
			unscopedSimpleVar4 
				= 
				"" 
				;
		</cfscript>
	
	
	</cffunction>
	
	<cffunction name="cfscript_loops_structs" access="public" >
		<cfscript>

			var correctStruct = structNew();
			var correctLoop = "";

	
			var stFile = "";
			var sFileName = "";
			var rowData = "";
			var foo4 = "";
		</cfscript>
		
		<cfreturn 2>
		
		<cfscript>

			correctStruct.test = ""
			;
			
			for(correctLoop=1;correctLoop LTE 10; correctLoop=correctLoop+1) correctSimpleVar = correctLoop;

			for ( correctLoop=1;correctLoop LTE 10; correctLoop=correctLoop+1) correctSimpleVar = correctLoop;for(correctLoop=1;correctLoop LTE 10; correctLoop=correctLoop+1) correctSimpleVar = correctLoop;

 			for (unscopedLoop=1;unscopedLoop LTE 10; unscopedLoop=unscopedLoop+1) unscopedSimpleVar = unscopedLoop;
			
			for (correctLoop = someFunction();correctLoop LTE 10; correctLoop = correctLoop+1) ;
			
			
			unscopedStruct.test = ""
			;
			
		</cfscript>
		
	</cffunction>
	
	
	<cffunction name="cfscript_problems" access="public" >
		<cfscript>
			var stFile_ok = '';
			var sFileName_ok = '';
			var rowdata2_ok = '';
		</cfscript>
		
		<cfreturn 4>
		
		<cfscript>

			stFile["#variables.sRelatedField#"] = variables.related_ID;
			stFile_ok["#variables.sRelatedField#"] = variables.related_ID;
			
			// replace special characters
			sFileName = variables.oFileSystem.checkFileName(stUploadedFile.ClientFile);
			sFileName_ok = variables.oFileSystem.checkFileName(stUploadedFile.ClientFile);

			rowdata2[fieldElement.XmlAttributes["name"]] = fieldElement.XmlAttributes["value"];
			rowdata2_ok[fieldElement.XmlAttributes["name"]] = fieldElement.XmlAttributes["value"];

			"dynamic.st#I18n#" = structNew();

			variables.logger.writelog('Access Denied for
			#sFacade.getUserBean().getEmailAddress()# @ #cgi.remote_addr# to event=#arguments.event.getValue("requestedEvent")#', "ERROR");


		</cfscript>
		
		<cfscript>variables.Logger.logDebug("looking in NDS server #ndsServer# as #ndsUser# for cn=#arguments.username#");</cfscript>

	</cffunction>
	
	<cffunction name="cfscript_complex">
		
		<cfscript>
			var arr = "";
			var startRow = ""; 
		</cfscript>
		
		<cfreturn 3>
		<cfscript>
			arr[1] = foo;
			
			if (1 EQ 1)
				startRow = 1;
			else 
				startRow = 2;
				
			CheckMimeType(mimetype_ID=qFile.mimetype_ID);
			
			unscoped3.unscoped.foo["i"] = "";
			unscoped10.unscoped.foo['i'] = "";
			unscoped4.unscoped.foo["#i#"] = "";
		</cfscript>
		
	</cffunction>
	
	<cffunction name="cfscript_vars_2">
	    <cfscript>
            var currentMode=''; // loop index
            var currentKeyword=''; // loop index
            var tmpQuery=''; // temp query holder
            var ReturnStruct=structnew(); 
            
            return 0;
            
            ReturnStruct.Query='';
            ReturnStruct.TotRows='';
            currentMode = '';
            
        </cfscript>
	</cffunction>

	<cffunction name="cfscript_comments" access="public" >
		<cfscript>
			var correctSimpleVar5 = ""; //comments after var

			// var withinComments = "";
			/* var withincomments2 = ""; */
			/*  
				var withincomments3 = ""; /*
			 */

		</cfscript>
		
		<cfreturn 3>
		
		<cfscript>
			withinComments = "foo";
			withinComments2 = "foo";
			withinComments3 = "foo";
		</cfscript>
	</cffunction>

</cfcomponent>