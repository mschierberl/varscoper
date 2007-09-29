LICENSE 
Copyright 2006 Mike Schierberl

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.


varScoper
Project Homepage:
http://www.schierberl.com/varscoper


Installation Instructions:
	Extract all files to a publicly accesible directory on your CFMX 6 or 7 server.  
	Navigate to index.cfm or varscoper.cfm and enter the absolute or relative 
	path to the template or directory that you would like to check. 


Features:
	-Identifies unscoped variables within cffunctions
	-can return line numbers of functions/variables

Known Limitations:
	
	-Returns false positive when variables are set within a comments block
	-If you don't scope an argument value, and then reference that value it 
	 will "technically" return a false positive...
		<cfargument name="foo">
		<cfset foo.foo2 = bar /> 
	instead of...
		<cfset arguments.foo.foo2 />

Future TODOs:
	-create a library of all cf tags that can create variables
	-cfscript
	-ignore things in comments (May need to use lookbehind?  Not supported in CF as far as I know)
	-Integration with cfeclipse

How can I help?
	-I need help extending the testCaseCFC file.  If you come across false positives (or negatives)
	 within your code, please send me a snippet so I can add it to the testCaseCFC
	-I need help finding all cftags that create variables (cfloop, cfquery, etc)
	 I'm sure there are some corner cases out there, I'd like to compile a comprehensive list.
	-Send all requests for help or suggestions to mike@schierberl.com



