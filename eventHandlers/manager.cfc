<cfcomponent extends="mura.plugin.pluginGenericEventHandler">

	<cffunction name="onApplicationLoad">
		<cfargument name="$" />
		
		<cfset var keys = structNew() />
		
		<!--- get all settings --->
		<cfset keys[ "singleDomain" ] = pluginConfig.getSetting( "singeDomainAnalyticsKeys" ) />
		<cfset keys[ "multiSubDomain" ] = pluginConfig.getSetting( "multiSubDomainAnalyticsKeys" ) />
		<cfset keys[ "multiTopLevelDomain" ] = pluginConfig.getSetting( "multiTopLevelDomainAnalyticsKeys" ) />
		
		<!--- store them into the plugins application scope --->
		<cfset pluginConfig.getApplication().setValue( "keys", keys ) />
		<cfset variables.pluginConfig.addEventHandler(this)>

	</cffunction>

	<cffunction name="onRenderEnd">
		<cfargument name="$" />
		
		<cfset var regexFindArray = "" />
		<cfset var newContent = "" />
		<cfset var analyticsJS = "" />
		<cfset var analyticsKey = "" />
		<cfset var analyticsKeyType = "" />
		<cfset var analyticsKeyCollection = "" />
		<cfset var analyticsKeyCollections = pluginConfig.getApplication().getValue( "keys" ) />

		<!--- loop over the key collection to find the one for this site --->
		<cfloop collection="#analyticsKeyCollections#" item="analyticsKeyCollection">
			
			<!--- get regex array results --->
			<cfset regexFindArray = ReFindNoCase( "(?m)^#trim( $.event( "siteId" ) )#=([\w\W]+?)$", analyticsKeyCollections[ analyticsKeyCollection ], 1, true ) />
			<!--- if the pos array is gte than 2 then continue  --->
			<cfif arrayLen( regexFindArray.pos ) GTE 2>
				<!--- get type --->
				<cfset analyticsKeyType = analyticsKeyCollection />
				<!--- get key from collection --->
				<cfset analyticsKey = mid( analyticsKeyCollections[ analyticsKeyCollection ], regexFindArray.pos[2], regexFindArray.len[2] ) />
				<cfbreak />
			</cfif>
		</cfloop>
		
		<!--- if a key was found  --->
		<cfif len( analyticsKey ) >
			
			<!--- create google analytics script --->
			<cfsavecontent variable="analyticsJS">
				<cfoutput>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
<cfswitch expression="#analyticsKeyType#">
	
	<cfcase value="singleDomain">
var pageTracker = _gat._getTracker( "#trim( listFirst( analyticsKey ) )#" );
	</cfcase>
	
	<cfcase value="multiSubDomain">
var pageTracker = _gat._getTracker( "#trim( listFirst( analyticsKey ) )#" );
pageTracker._setDomainName("#trim( listLast( analyticsKey ) )#");
	</cfcase>

	<cfcase value="multiTopLevelDomain">
var pageTracker = _gat._getTracker( "#trim( listFirst( analyticsKey ) )#" );
pageTracker._setDomainName("none");
pageTracker._setAllowLinker(true);
	</cfcase>

</cfswitch>
pageTracker._trackPageview();
} catch(err) {}</script>
				</cfoutput>
			</cfsavecontent>
			
			<!--- append script to body --->
			<cfset newContent = replaceNoCase( $.event( "__MuraResponse__" ), "</body>", analyticsJS & "</body>" ) />
			
			<!--- reset the muraresponse with the script --->
			<cfset $.event( "__MuraResponse__", newContent ) />
			
		</cfif>
		
	</cffunction>

</cfcomponent>