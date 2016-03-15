<cfparam name="params.clearLog" default="false">
<Cfset logFile = "/files/#get("dataSourceName")#.json">

<cfif params.clearLog>
	<cffile action="write" output="" file="#logFile#">
</cfif>

<Cffile action="read" file="#logFile#" variable="logText">
<Cfset logText = "[" & reReplaceNoCase(logText,"\n",",","all") & "]">
<script>
	var getLogData = function(){
		return <cfoutput>#logText#</cfoutput>;
	};
</script>

<a href="<cfoutput>#cgi.script_name#</cfoutput>?controller=wheels&action=wheels&view=plugins&name=modelmonitor&reload=true&clearlog=true">
	<div class='btn btn-danger'><i class='glyphicon glyphicon-trash'></i> Clear Log</div>
</a>
<BR><BR>

<cftry>
	<cfset x = get("modelMonitor")>
	<cfcatch type="any">
		<cfoutput>
			<div class="alert alert-danger" role="alert"><strong>Please add the following to your /config/settings.cfm file to activate this plugin:</strong><BR>			
			<code>
				&lt;cfset set(modelMonitor=true)&gt;
			</code>
			</div>
		</cfoutput>
	</cfcatch>
</cftry> 

<cftry>
	<cfset x = get("modelMonitorFilter")>
	<cfcatch type="any">
		<cfoutput>
			<div class="alert alert-danger" role="alert"><strong>Please add the following to your /config/settings.cfm file to configure this plugin:</strong><BR>			
			By default, model monitor will include all CFWheels Model CRUD functions, to filter out certain functions list them here:
			<code>
				&lt;cfset set(modelMonitorFilter="findAll,findOne")&gt;
			</code>
			</div>
		</cfoutput>
	</cfcatch>
</cftry> 

<cfinclude template="_jsHeader.cfm">

<center>
	<h3>Model &gt;&gt; Monitor</h3>
	<cfif get("modelMonitorFilter") neq "">
		<Cfoutput>(As per 'modelMonitorFilter', not showing calls to: #get("modelMonitorFilter")#)</cfoutput>
	</Cfif>
</center>
<HR>
