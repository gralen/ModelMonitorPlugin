<cfinclude template="_header.cfm">

<body ng-app="myapp">	
    <div ng-controller="Ctrl">
        <div class="container-fluid">
        	<div ng-show="requests.length ==0">
        		<div class="alert alert-info" role="alert">
        			<strong>No CRUD requests have been logged. Visit a page in your wheels app, then return here.</strong>
        			<BR>
        		</div>	
        	</div>
        	<div ng-repeat="requestId in requests | reverse">        		
	        	<table class='table table-condensed table-bordered'>
	        		<tr>
	        			<th colspan=5 style='background-color: #ccc;'>Request {{$index+1}}</th>
	        		</tr>
	        		<tr>	        			
			        	<th width="10%">Time</th>       	
			        	<th width="10%">Model</th>
			        	<th width="10%">Action</th>
			        	<th width="10%">Records</th>
			        	<th width="60%">Query</th>
			        </tr>		   
			    				
			        <tr ng-repeat="log in getLogEntriesForRequest(requestId)" class='{{ actionColors[log.action] }}'>
			        	<td>{{ log.time }} {{ actionColors[log.action] }}</td>       	
			        	<td>{{ log.model }}</td>
			        	<td>{{ log.action }}</td>
			        	<td>{{ log.records }}</td>
			        	<td>			   
				        	<pre style='width: 400px; overflow: auto;'>{{ log.data | json}}</pre>			        	
			        		<span ng-show="log.data.order">order by {{ log.data.order }}</span>
			        	</td>
			        </tr>
		        </table>
	        </div>
        </div>      
    </div>    
</body>