<!--- Problem Files --->
<!--- 


 --->
<cfcomponent name="testCaseCFC" hint="I am the worst written CFC ever, my vars are horribly scoped">
	<cfset variables.fooGlobalVar = "blah">
		
	<cffunction name="cfquery_order_a">
	
		<cfset var a = structNew()>
		<cfset a.name='admin'>
		<cfset a.password='test'>
		<cfreturn 1>
		
		<cfquery name="emailExists" username="#a.name#" password="#a.password#" datasource="data">
			SELECT email
			FROM emails
		</cfquery>
		
	</cffunction>
	
	<cffunction name="cfquery_order_b">
	
		<cfset var a = structNew()>
		<cfset a.name='admin'>
		<cfset a.password='test'>
		
		<cfreturn 1>
		<cfquery username="#a.name#" password="#a.password#" name="emailExists" datasource="data">
			SELECT email
			FROM emails
		</cfquery>
	
	</cffunction>

	<cffunction name="setStaticFields"  >
		<cfscript>
			
			var counter = 1;
			
			return 0;
			for(; counter <= len; counter++)
			{
			 
			}
		</cfscript>
	</cffunction>

	<cffunction name="cfftp_variables">
		<cfset var scopedFtp = "">
		<cfset var ListDirs = "">
	
		<cfreturn 1>	
		<!--- <cfftp 
			connection =""
		    action = "LISTDIR"
		    name = "ListDirs"
		    directory = "/"> --->

		<cfftp 
			connection = "myConnection"
			action="close" 
			transferMode = "binary" 
			result="scopedFtp"
			>

		
		<cfset cfftp.test = "" />
		<cfset scopedFtp.test = "" />
		<cfset listDirs.test = ""/>
		
	</cffunction>	
	
	<cffunction name="issue_18">
		<cfreturn 1>
		<!--- http://varscoper.riaforge.org/index.cfm?event=page.issueedit&issueid=83600F2D-F568-1871-197DE915EF2AB2C6 --->
		<cfset scope[getLoggingPath()].data = arrayConcat(data["emailLogger"].data, scope[getLoggingPath()].data) />
	</cffunction>
	
	<cffunction name="issue_17">
		<cfreturn 0>
		<cfloop condition="">
		
		</cfloop>
	</cffunction>
	
	<cffunction name="testVar_Issue_19">
		<cfscript>
			var testVar = true;
	
			return 0;
			
			//This does not work: says ") testVar" is not scoped.
			if (testVar EQ "true")
			   testVar = false;
			else
			   testVar = true;
			
			//This does validate correctly.
			if (testVar EQ "true") {
			   testVar = false;
			}
			else {
			   testVar = true;
			}
		</cfscript>
		  
	</cffunction>
	
	<cffunction name="negative_TODO">
		<cfreturn 0>
		
		<cfset read(id=pkId,object=foo) />

	</cffunction>
	
	<cffunction name="TODO_cfscript_return">
		<cfreturn 0>
		<cfscript>
			return newStruct(ok="false", errorMessage="!", sValidationMsg="#getCaseString(attr)#",
					field="#stResult.fieldname#", rules="#stRules#", result="#stResult#"); 
		</cfscript>
	
	</cffunction>

	<cffunction name="resolved_TODO">
		<cfset var cfcatch = ''>
		<cfreturn 1>
		<!--- NOTE: this should return a violation even though we can't evaluate #i# at runtime --->
		<!--- I'd like this in to indicate to the users that they might have an issue --->
		<cfset "test#i#" = 1 /> 
	</cffunction>
	
	<cffunction name="falsepositive" >
		<cfset var cfcatch = ''>
		
		<cfreturn 1>
		<!--- NOTE: this should return a violation even though we can't evaluate #i# at runtime --->
		<!--- I'd like this in to indicate to the users that they might have an issue --->
		<cfset "test#i#" = 1 /> 
	</cffunction>

	<cffunction name="resolved_TODO_BUGS">
	    <cfreturn 1>

		<cfset unscoped = ''>
		
		<cfscript>
			someFunction();
		</cfscript>

	</cffunction>

	<cffunction name="resolved_TODO_comments" output="false">
		<cfset var outsideComments = "" />
		<cfset var WithinComments = "" /> --->  <!--- Note, leave the extra trailing comment here, when we include the ability to strip comments it introduces problems in other functions --->
		
		
		<cfreturn 0>
		<!--- <cfset WithinComments = ""/> --->
		
	</cffunction>
	
	<cffunction name="falsePositive_comments">
		<cfreturn 0>
		<!--- <cfset withinComments = ""> --->
	</cffunction>

	<cffunction name="transfer_example" >
		
		<cfscript>
		var table = '';
		return 0;
			return table & "." & object.getPropertyByName(arguments.condition.getProperty()).getColumn() & " = '" & arguments.condition.getValue() & "'";

		</cfscript>
	</cffunction>

	<cffunction name="cfscript_nested_square_brackets_with_operation" access="public" hint="Quite unusual but has been seen on wild.">
		<cfscript>
			var aScopedArray1 = arrayNew(1);
			var aScopedArray2 = arrayNew(1);
		
			return 0;
		
			aScopedArray1[1] = "Hello World";
			aScopedArray2[1] = 1;  
		
			aScopedArray1[aScopedArray2[1] + 1] = "Foobar";
		</cfscript>
	</cffunction>

	<cffunction name="cfscript_semicolon_within_quoted_string" access="public" hint="This can easily happen when building URL parameters">
		<cfscript>
			var sScoped = "";
			return 0;
			sScoped = "&amp;quotedString=value";
		</cfscript>
	</cffunction> 

	<cffunction name="cfscript_with_dash">
		<cfscript>
	
			var LOCAL = StructNew();
			return 0;
	
			LOCAL.CSS[ "background-color" ] = "";
	
		</cfscript>
	</cffunction>
	
	<cffunction name="cfscript_sFileName">
		<cfscript>
			var sFileName = "";
			var stReturn  = "";		
			return 0;
			
			if (variables.oFileSystem.checkFilePath(sDestination&sFileName))
					sFileName = variables.oFileSystem.getAlternativeFileName(sDestination,sFileName);
			if (Compare(stUploadedFile.ServerFile,sFileName)) {
 					stReturn.bFileRenamed = true;
			}	
			
		</cfscript>
	</cffunction>
	
	<cffunction name="cfscript_complex_for">
		<!--- Note, this example was from harry, the //data was from an XMLParse in the var statement --->
		<cfscript>
			var length = len("//data");
			return 1;
			for (i=1; i lte ArrayLen(arrTables);i=i+1) {};
		</cfscript>
	</cffunction>
	
	<cffunction name="cfscript_funny_chars">
		<cfscript>
			var iMail = find("@", '');
 	   	 	var notallowed = " ;:!$%/()=?*";
 	    	return 0;
 	    </cfscript>
	</cffunction>
	
	<cffunction name="bug_4">
		<cfset var proper = ''>
		<cfreturn 1>
		<cfscript>
			url[getUrlPageIndicator()] = urlPageNo;
			proper[getUrlPageIndicator()] = urlPageNo;
			unscoped[getUrlPageIndicator()] = urlPageNo;
		</cfscript>
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
		
		<!--- <cfscript>
			thread = createObject("java", "java.lang.Thread");
			thread.sleep(3000);
		</cfscript> --->
		<!--- <cfset result = existingFile.checkIn(context:variables.xythosContext) />
		<cfscript>
			thread = createObject("java", "java.lang.Thread");
			thread.sleep(2000);
		</cfscript> --->
		
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
		<cfreturn 1>
		
		
		<cfprocparam variable="unscopedProcParamOut" type="out" cfsqltype="CF_SQL_BIGINT" />
		<cfprocparam variable="correctProcParamIn" type="in" cfsqltype="CF_SQL_BIGINT" />
		

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
			
			for(; counter <= 10; counter++);
			
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

			stFile = variables.related_ID;
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
			var newStruct = structNew();
		</cfscript>
		
		<cfreturn 5>
		<cfscript>
			arr[1] = foo;
			
			if (1 EQ 1)
				startRow = 1;
			else 
				startRow = 2;
				
			if (len(sFileext))
				sNewFilename = sNewFilename & "." & sFileext;
		
			if ( Find( '.', prefix ) eq 1 )
				prefix = RemoveChars( prefix, 1, 1 );

			if (structKeyExists(newStruct, prefix) AND structKeyExists(newStruct, prefix)) 
				"request.st#listLast(sBundle, "\/")#" = prefix;
			else
				"request.st#listLast(sBundle, "\/")#" = prefix;
				
				
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
            var stUploadedFile='';
            
            return 0;
            
            ReturnStruct.Query='';
            ReturnStruct.TotRows='';
            currentMode = '';
    		stUploadedFile = variables.oFileSystem.uploadFile(arguments.sFormField,variables.sTempPath,"*/* "); 
    		        
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