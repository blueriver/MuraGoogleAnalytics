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
<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
<cfswitch expression="#analyticsKeyType#">
	
	<cfcase value="singleDomain">
ga('create', '#trim( listFirst( analyticsKey ) )#', 'auto');
	</cfcase>
	
	<cfcase value="multiSubDomain">
ga('create', '#trim( listFirst( analyticsKey ) )#', 'auto', {'legacyCookieDomain': '#trim( listLast( analyticsKey ) )#'});
	</cfcase>

	<cfcase value="multiTopLevelDomain">
ga('create', '#trim( listFirst( analyticsKey ) )#', 'auto', {'legacyCookieDomain': 'none'});
ga('require', 'linker');
ga('linker:autoLink', ['#trim( listLast( analyticsKey ) )#'], false, true);
	</cfcase>

</cfswitch>
	ga('send', 'pageview');
</script>
				</cfoutput>
			</cfsavecontent>
			
			<!--- append script to body --->
			<cfset newContent = replaceNoCase( $.event( "__MuraResponse__" ), "</body>", analyticsJS & "</body>" ) />
			
			<!--- reset the muraresponse with the script --->
			<cfset $.event( "__MuraResponse__", newContent ) />
			
		</cfif>
		
	</cffunction>

</cfcomponent>