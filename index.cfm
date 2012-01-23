<cfinclude template="plugin/config.cfm" />
<cfsavecontent variable="body">
<cfoutput>
<h2>Google Analytics Mura Plugin</h2>
<p></p>
<dl>
	<dt class="first">
		<p>This plugin is for hooking into Google Analytics via the common js Google provides.</p> 
		
		<p><i>
		"Google Analytics is the enterprise-class web analytics solution that gives you rich insights into your website traffic and marketing effectiveness. Powerful, flexible and easy-to-use features now let you see and analyze your traffic data in an entirely new way. With Google Analytics, you're more prepared to write better-targeted ads, strengthen your marketing initiatives and create higher converting websites."
		</i><br />- www.google.com
		</p>
	</dt>
	<dt>
		<strong>You must have the following information at hand:</strong><br />
			- Your Web Property ID provided by Google<br />
			- Your site ID<br />
			- Your domain<br />
			<br /><br />
	</dt>
	<dt>
		<h3>Here is how you use the plugin.</h3> 
		<p>There are 3 fields available. Each field dictates how the Google Analytics js code renders. Each field is setup to accept multiple entries which must be new line delimited.</p>
		
		<p>As a page renders for a given site the plugin will take that site's ID and check it against the fields. The first field that has the site ID assigned to it wins.</p>
		
		<h4>Single Domain - Google Analytics Keys</h4>
		<p><strong>FORMAT:</strong> <i>{site ID}={Web Property ID}</i><br />
		<strong>FINISHED FORMAT:</strong> <i>siteA=UA-12345678-1</i>
		</p>
		Place your site ID and Web Property ID here if you have your Google Analytics account setup for a Single Domain. 
		<p></p>
		
		<h4>One domain with multiple subdomain - Google Analytics Keys</h4>
		<p>
			<strong>FORMAT:</strong> <i>{site ID}={Web Property ID},{domain}</i><br />
			<strong>FINISHED FORMAT:</strong> <i>siteA=UA-12345678-1,.domain.com</i>
		</p>
		Place your site ID and Web Property ID here if you have your Google Analytics account setup for a One domain with multiple subdomains. 
		<p></p>
		
		<p>
		<h4>Multiple top-level domain - Google Analytics Keys</h4>
		<p><strong>FORMAT:</strong> <i>{site ID}={Web Property ID}</i><br />
		<strong>FINISHED FORMAT:</strong> <i>siteA=UA-12345678-1</i>
		</p>
		Place your site ID and Web Property ID here if you have your Google Analytics account setup for Multiple top-level domains. 
		</p>
	</dt>
</dl>

</cfoutput>
</cfsavecontent>
<cfoutput>
#application.pluginManager.renderAdminTemplate(body=body,pageTitle=request.pluginConfig.getName())#
</cfoutput>

