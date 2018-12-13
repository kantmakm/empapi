# Employee API [empapi] 

Single file PHP 7 script that adds a REST API to a MySQL 5.5 InnoDB database. PostgreSQL 9.1 and MS SQL Server 2012 are fully supported. 

NB: This is the [TreeQL](https://treeql.org) reference implementation in PHP.

TB: Forked from php-crud-api at https://github.com/mevdschee/php-crud-api/

## Requirements

  - PHP 7.0 or higher with PDO drivers for MySQL, PgSQL or SqlSrv enabled
  - MySQL 5.6 / MariaDB 10.0 or higher for spatial features in MySQL

## Known issues

- Seeing integers as strings? Make sure to enable the `nd_pdo_mysql` extension and disable `pdo_mysql`.

## Installation

This is a single file application! Upload "`api.php`" somewhere and enjoy!

For local development you may run PHP's built-in web server:

    php -S localhost:8080

Test the script by opening the following URL:

    http://localhost:8080/api.php/employee/posts/1

Don't forget to modify the configuration at the bottom of the file.

## Configuration

Edit the following lines in the bottom of the file "`api.php`":

    $config = new Config([
        'username' => 'xxx',
        'password' => 'xxx',
        'database' => 'xxx',
    ]);

This implementation is an employee database reference implementation.  Please find the database script at src/db/*.sql

The code resides in the "`src`" directory. You can access it at the URL:

    http://localhost:8080/src/records/posts/1

You can compile all files into a single "`api.php`" file using:

    php build.php

NB: The script appends the classes in alphabetical order (directories first).

TB:  For Configuration, Features, Limitations, and Middleware options, please reference php-crud-api at https://github.com/mevdschee/php-crud-api/


#### Employee REST server

Methods supported:  GET, POST, PUT, DELETE [requires authorization - see .htaccess for rules]

Current live implementation is using a self-signed SSL certificate - must be accepted in the browser or SSL cert verification must be disabled in Postman.

Create a web application that exposes REST operations for employees. The API should be able to:

Get employees by an ID (sec issue: PII exposure with no auth)
	
GET request (returns Content-Type →application/json) ::  https://empapi.blockchainindustries.io/api.php/records/employees/ID [bigint(8)]
		Returns Json :
		{
		    "id": 11,
		    "first_name": "Smaller",
		    "middle_initial": "P",
		    "last_name": "Payloaded",
		    "date_of_birth": "1998-06-20",
		    "date_of_employment": "2018-02-15",
		    "status": "ACTIVE"
		}

Create new employee (sec issue: no auth required)
		
		POST request (Include Header - Content-Type → application/json) ::  https://empapi.blockchainindustries.io/api.php/records/employees/

		Body Json Payload :
		{
    		"first_name": "Jameson",
    		"middle_initial": "V",
    		"last_name": "Weller",
    		"date_of_birth": "1968-06-20",
    		"date_of_employment": "2018-02-15"
		}

Update existing employee  (sec issue:  no auth required, PATCH request can reactivate a 'deleted' employee)

		PUT request (Include Header - Content-Type → application/json) ::  https://empapi.blockchainindustries.io/api.php/records/employees/ID  [bigint(8)]

		Body Json Payload :
		{
		    "first_name": "Patches",
		    "middle_initial": "W",
		    "last_name": "TheDogge",
		    "date_of_birth": "1938-06-20",
		    "date_of_employment": "2004-02-15",
		    "status": "ACTIVE"
		}


Delete employee

	DELETE request (requires Auth header Authorization → Basic d2ViOmtlbnphbjIwMTk=  (basic auth web / kenzan2019)) ::  
	https://empapi.blockchainindustries.io/api.php/records/employees/21

		deactivates the employee record by setting status = INACTIVE


Get all employees (sec issue: PII exposure with no auth)
	GET request (returns Content-Type →application/json) ::  https://empapi.blockchainindustries.io/api.php/records/employees/
	Returns Json with all active employees



An employee is made up of the following data:

ID  - Unique identifier for an 
FirstName  - Employee first name
MiddleInitial - Employee middle initial
LastName - Employee last name
DateOfBirth - Employee birthday and year
DateOfEmployment - Employee start date
Status - ACTIVE or INACTIVE

### Virtualhost configuration

Sample configuration file for Apache

<VirtualHost *:80>
   ServerAdmin thad@blockchainindustries.io
   DocumentRoot "/var/www/html/php-crud-api"
   ServerName  54.210.168.226
   ServerAlias empapi.blockchainindustries.io

SetEnvIf Remote_Addr "127\.0\.0\.1" dontlog
SetEnvIf Remote_Addr "::1" dontlog
SetEnvIf User-Agent ".*internal dummy connection.*" dontlog

   ErrorLog logs/empapi.com-error_log
   CustomLog logs/empapi.com-access_log common
   DirectoryIndex index.php index.html jobs.xml
   LogLevel Warn


   <Directory "/var/www/html/php-crud-api/">
           Options FollowSymLinks
           AllowOverride All
           Order allow,deny
           Allow from all
   </Directory>
           AccessFileName .htaccess

</VirtualHost>

<VirtualHost *:443>

ServerAdmin thad@blockchainindustries.io
   DocumentRoot "/var/www/html/php-crud-api"
   ServerName  54.210.168.226
   ServerAlias empapi.blockchainindustries.io

SSLEngine on
SSLProtocol all -SSLv3
SSLProxyProtocol all -SSLv3
SSLHonorCipherOrder on
#SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5
#SSLProxyCipherSuite HIGH:MEDIUM:!aNULL:!MD5
SSLCertificateFile /etc/pki/tls/certs/localhost.crt
SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
#SSLCertificateChainFile /etc/pki/tls/certs/server-chain.crt
#SSLCACertificateFile /etc/pki/tls/certs/ca-bundle.crt
#SSLVerifyClient require
#SSLVerifyDepth  10
BrowserMatch "MSIE [2-5]" \
         nokeepalive ssl-unclean-shutdown \
         downgrade-1.0 force-response-1.0

SetEnvIf Remote_Addr "127\.0\.0\.1" dontlog
SetEnvIf Remote_Addr "::1" dontlog
SetEnvIf User-Agent ".*internal dummy connection.*" dontlog

   ErrorLog logs/ssl.com-error_log
   CustomLog logs/ssl.com-access_log combined env=!dontlog

DirectoryIndex index.php index.html
   LogLevel Warn

   <Directory "/var/www/html/php-crud-api">
           Options FollowSymLinks
           AllowOverride All
           Order allow,deny
           Allow from all
   </Directory>
           AccessFileName .htaccess
</VirtualHost>


#### Basic authentication

The Basic type supports a file that holds the users and their (hashed) passwords separated by a colon (':').
When the passwords are entered in plain text they fill be automatically hashed.
The authenticated username will be stored in the `$_SESSION['username']` variable.
You need to send an "Authorization" header containing a base64 url encoded and colon separated username and password after the word "Basic".

    Authorization: Basic dXNlcm5hbWUxOnBhc3N3b3JkMQ

This example sends the string "username1:password1".

The auth file in this reference implementation is /users.htpasswd
   web:{SHA}vR5BGIaoOoiH44Xrus1f5YgoYjI=

