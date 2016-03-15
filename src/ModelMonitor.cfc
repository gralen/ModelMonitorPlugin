<!--- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ModelMonitor

A collection of wrapper functions that pass-through the original wheels CRUD
operation without altering it in any way, but writes a JSON formatted
log file of each operation.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --->

<cfcomponent output="false" mixin="model">
	<cffunction name="init">
		<cfscript>
			this.version = "1.1.8,1.4.4";
			 processingdirective preserveCase="true";
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="findOne" output="false">		
		<cfset _logAction(type="findOne",args=arguments)>
		<cfreturn core.findOne(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="findAll" output="false">		
		<cfargument name="returnAs" default="query">
		<cfset var loc = { records: 0}>
		<Cfset loc.result = core.findAll(argumentCollection=arguments)>
		
		<cfif arguments.returnAs neq "query">
			<cfset loc.records = ArrayLen(loc.result)>
		<cfelse>
			<cfset loc.records = loc.result.recordCount>
		</cfif>

		<cfset _logAction(type="findAll",args=arguments,records=loc.records)>
		
		<cfreturn loc.result>
	</cffunction>

	<cffunction name="create" output="false">		
		<cfset _logAction(type="create",args=arguments)>
		<cfreturn core.create(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="createOne" output="false">		
		<cfset _logAction(type="create",args=arguments)>
		<cfreturn core.createOne(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="save" output="false">		
		<cfset _logAction(type="save",args=arguments)>
		<cfreturn core.save(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="update" output="false">		
		<cfset _logAction(type="update",args=arguments)>
		<cfreturn core.update(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="updateOne" output="false">		
		<cfset _logAction(type="update",args=arguments)>
		<cfreturn core.updateOne(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="updateAll" output="false">		
		<cfset _logAction(type="updateall",args=arguments)>
		<cfreturn core.updateAll(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="delete" output="false">		
		<cfset _logAction(type="delete",args=arguments)>
		<cfreturn core.delete(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="deleteOne" output="false">		
		<cfset _logAction(type="delete",args=arguments)>
		<cfreturn core.deleteOne(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="deleteAll" output="false">		
		<cfset _logAction(type="deleteall",args=arguments)>
		<cfreturn core.deleteAll(argumentCollection=arguments)>
	</cffunction>

	<Cffunction name="_logAction">
		<Cfargument name="args" type="struct">
		<Cfargument name="type" type="string">		
		<Cfargument name="records" type="numeric">		
		
		<cftry>
			<cfset x = get("modelMonitor")>
			<cfcatch type="any">
				<Cfset set(modelMonitor=true)>
			</cfcatch>
		</cftry> 
		<cftry>
			<cfset x = get("modelMonitorFilter")>
			<cfcatch type="any">
				<Cfset set(modelMonitorFilter="findAll,findOne")>
			</cfcatch>
		</cftry>
		
		<cfif get("modelMonitor") && not ListFind(get("modelMonitorFilter"),arguments.type)>		
			<Cfif not isDefined("request.modelMonitorRequestUUID")>
				<cfset request.modelMonitorRequestUUID = CreateUUID()>
			</Cfif>

			<cfset var d = {
				requestId: request.modelMonitorRequestUUID,
				model: '#getMetaData(this).fullname#', 
				action: '#arguments.type#',			
				data:  arguments.args,
				records: arguments.records,
				time: '#TimeFormat(Now(),'h:mm:ss.lll')#'
			}>
			
			<Cffile action="append" file="/files/#get("dataSourceName")#.json" output="#SerializeJson(d)#">
		</cfif>

	</Cffunction>
</cfcomponent>