<cfinclude template="header.cfm">

<h1>ColdBox Legacy App Demo</h1>

<p>
Welcome to a demo of how to integrate ColdBox into a legacy application that you don't want to rewrite from scratch in the first pass.  Your legacy application 
might use FuseBox, or another framework, or it could simply be a basic site of stand-alone .cfm pages.  One can always run the ColdBox portions of the app
from a subdirectory as a standalone application, but that isn't ideal if you want to share application scopes, settings, etc.  
</p>

<p>
It's possible for ColdBox and your legacy code to live side-by-side in the same application context. The only requirement is that you use Application.cfc.
In this example, our Application.cfc is extending the ColdBox bootstrap class, and the onRequestStart() method has a conditional statement that decides
what URL paths should get processed by ColdBox or by the legacy app.  You can modify this conditional as you finish your conversion, until one day you're
entire application will be converted over to ColdBox!
</p>

<p>	
Let's take a look at the Application.cfc code:

<pre>
component extends='coldbox.system.Bootstrap' {
	
	// request start
	public boolean function onRequestStart(String targetPage){
		
		// Determine if the URL path is destined for ColdBox.
		if( findNoCase( 'index.cfm', listLast( arguments.targetPage, '/' ) ) ){
			
			// Verify ColdBox is loaded
			reloadChecks();
			
			processColdBoxRequest();
			// Returning false prevents the legacy code from also kicking in
			return false;
		}
		
		// Else proceed to legacy code
		return true;
	}

}
</pre>  
</p>

<cfinclude template="footer.cfm">