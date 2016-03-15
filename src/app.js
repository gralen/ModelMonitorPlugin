var app = angular.module('myapp', []);

app.controller('Ctrl', function($scope,$http){
    $scope.variable = "Hello";
	$scope.logData = getLogData();

	var _requests = $scope.logData.map(function(m){			
			return m.requestId;
	});
	$scope.getLogEntriesForRequest = function(requestId){
		return $scope.logData.filter(function(logEntry){			
			if (logEntry.requestId == requestId){
				return true;
			}
		});
	};

	$scope.requests = _requests.filter(function(v,i) { return _requests.indexOf(v) == i; });
	$scope.actionColors = {	
									findAll: '',
									findOne: '',
									create: 'success',
									save: 'success',
									update: 'success',
									updateAll: 'success', 
									delete: 'danger',
									deleteAll: 'danger'
								};
});

app.filter('reverse', function() {
  return function(items) {
    return items.slice().reverse();
  };
});