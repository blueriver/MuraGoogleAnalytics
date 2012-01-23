<plugin>
<name>Google Analytics</name>
<package>googleAnalytics</package>
<directoryFormat>packageOnly</directoryFormat>
<version>1.0</version>
<provider>Blue River</provider>
<providerURL>http://blueriver.com</providerURL>
<category>Application</category>
<settings>
	<setting>
		<!-- The Name attribute if what you will pull the settings value from the pluginConfig.getSettings('[setting name]') -->
		<name>singeDomainAnalyticsKeys</name>

		<!-- The Label element acts a reader friendly alias the settings element -->
		<label>Single Domain - Google Analytics Keys</label>

		<!-- The content of the Hint element show up as a tool tip for the user installing the plugin -->
		<hint>FORMAT: siteId={Google Analytics Key} separated by a new line</hint>
		<type>textarea</type>
		<required>false</required>
		
		<!-- The Validation element sets the type of validation to use. OPTIONs (email, date, numeric, regex)-->
		<validation></validation>

		<!-- The regex element is user in conjunction with the Validation element being set to regex. -->
		<regex></regex>

		<!-- The Message element is used to prompt the user when the value submitted does not pass validation. -->
		<message></message>

		<!-- The Default values element act as the settings default values when the user is first installing the plugin. -->
		<defaultvalue></defaultvalue>

		<!-- These next two elements are for select boxes.  They should contain ^ delimited list -->
		<optionlist></optionlist>
		<optionlabellist></optionlabellist>
	</setting>
	<setting>
		<!-- The Name attribute if what you will pull the settings value from the pluginConfig.getSettings('[setting name]') -->
		<name>multiSubDomainAnalyticsKeys</name>

		<!-- The Label element acts a reader friendly alias the settings element -->
		<label>One domain with multiple subdomain - Google Analytics Keys</label>

		<!-- The content of the Hint element show up as a tool tip for the user installing the plugin -->
		<hint>FORMAT: siteId={Google Analytics Key},{domain} separated by a new line</hint>
		<type>textarea</type>
		<required>false</required>
		
		<!-- The Validation element sets the type of validation to use. OPTIONs (email, date, numeric, regex)-->
		<validation></validation>

		<!-- The regex element is user in conjunction with the Validation element being set to regex. -->
		<regex></regex>

		<!-- The Message element is used to prompt the user when the value submitted does not pass validation. -->
		<message></message>

		<!-- The Default values element act as the settings default values when the user is first installing the plugin. -->
		<defaultvalue></defaultvalue>

		<!-- These next two elements are for select boxes.  They should contain ^ delimited list -->
		<optionlist></optionlist>
		<optionlabellist></optionlabellist>
	</setting>
	<setting>
		<!-- The Name attribute if what you will pull the settings value from the pluginConfig.getSettings('[setting name]') -->
		<name>multiTopLevelDomainAnalyticsKeys</name>

		<!-- The Label element acts a reader friendly alias the settings element -->
		<label>Multiple top-level domain - Google Analytics Keys</label>

		<!-- The content of the Hint element show up as a tool tip for the user installing the plugin -->
		<hint>FORMAT: siteId={Google Analytics Key} separated by a new line</hint>
		<type>textarea</type>
		<required>false</required>
		
		<!-- The Validation element sets the type of validation to use. OPTIONs (email, date, numeric, regex)-->
		<validation></validation>

		<!-- The regex element is user in conjunction with the Validation element being set to regex. -->
		<regex></regex>

		<!-- The Message element is used to prompt the user when the value submitted does not pass validation. -->
		<message></message>

		<!-- The Default values element act as the settings default values when the user is first installing the plugin. -->
		<defaultvalue></defaultvalue>

		<!-- These next two elements are for select boxes.  They should contain ^ delimited list -->
		<optionlist></optionlist>
		<optionlabellist></optionlabellist>
	</setting>
</settings>

<eventHandlers>
<eventHandler event="onApplicationLoad" component="eventHandlers.manager" persist="false" /> 
</eventHandlers>

<displayobjects location="global"/>
</plugin>
