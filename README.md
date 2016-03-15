# CFWheels ModelMonitor Plugin

A CFWheels JDBC call monitor.

Intercepts all model calls and logs the raw 'post adaptor' SQL statement to a simple interface for review. Excellent for confirming your data-tier transactions are ocurring as expected.

Please note: Logs your queries into a .json file in your /files/ directory, which could be publicly available on your web server. ** Not Recommended for Production Use **

# Dependencies

Uses CDN for AngularJS and Bootstrap to make the interface nicer, no additional installation is required.

# Documentation

Install the Attachments plugin and click the modelMonitor link in the Plugins section of the debugging section of your CFWheels application's footer to view the interface.