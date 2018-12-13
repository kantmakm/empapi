# PHP-CRUD-API (v2) 

Single file PHP 7 script that adds a REST API to a MySQL 5.5 InnoDB database. PostgreSQL 9.1 and MS SQL Server 2012 are fully supported. 

NB: This is the [TreeQL](https://treeql.org) reference implementation in PHP.

NB: Forked from php-crud-api at https://github.com/mevdschee/php-crud-api/

## Requirements

  - PHP 7.0 or higher with PDO drivers for MySQL, PgSQL or SqlSrv enabled
  - MySQL 5.6 / MariaDB 10.0 or higher for spatial features in MySQL
  - PostGIS 2.0 or higher for spatial features in PostgreSQL 9.1 or higher
  - SQL Server 2012 or higher (2017 for Linux support)

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

These are all the configuration options and their default value between brackets:

- "driver": `mysql`, `pgsql` or `sqlsrv` (`mysql`)
- "address": Hostname of the database server (`localhost`)
- "port": TCP port of the database server (defaults to driver default)
- "username": Username of the user connecting to the database (no default)
- "password": Password of the user connecting to the database (no default)
- "database": Database the connecting is made to (no default)
- "middlewares": List of middlewares to load (`cors`)
- "controllers": List of controllers to load (`records,openapi`)
- "openApiBase": OpenAPI info (`{"info":{"title":"PHP-CRUD-API","version":"1.0.0"}}`)
- "cacheType": `TempFile`, `Redis`, `Memcache`, `Memcached` or `NoCache` (`TempFile`)
- "cachePath": Path/address of the cache (defaults to system's temp directory)
- "cacheTime": Number of seconds the cache is valid (`10`)
- "debug": Show errors in the "X-Debug-Info" header (`false`)

## Compilation

The code resides in the "`src`" directory. You can access it at the URL:

    http://localhost:8080/src/records/posts/1

You can compile all files into a single "`api.php`" file using:

    php build.php

NB: The script appends the classes in alphabetical order (directories first).

For Features, Limitations, and Middleware options, please reference php-crud-api at https://github.com/mevdschee/php-crud-api/



#### Basic authentication

The Basic type supports a file that holds the users and their (hashed) passwords separated by a colon (':'). 
When the passwords are entered in plain text they fill be automatically hashed.
The authenticated username will be stored in the `$_SESSION['username']` variable.
You need to send an "Authorization" header containing a base64 url encoded and colon separated username and password after the word "Basic".

    Authorization: Basic dXNlcm5hbWUxOnBhc3N3b3JkMQ

This example sends the string "username1:password1".


#### Employee REST server

Methods supported:  GET, POST, PUT, DELETE [requires authorization - see .htaccess for rules]

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



### Docker Container

Install docker using the following commands and then logout and login for the changes to take effect:

    sudo apt install docker.io
    sudo usermod -aG docker ${USER}

To run the docker tests run "build_all.sh" and "run_all.sh" from the docker directory. The output should be:

    ================================================
    Debian 9 (PHP 7.0)
    ================================================
    [1/4] Starting MariaDB 10.1 ..... done
    [2/4] Starting PostgreSQL 9.6 ... done
    [3/4] Starting SQLServer 2017 ... skipped
    [4/4] Cloning PHP-CRUD-API v2 ... skipped
    ------------------------------------------------
    mysql: 83 tests ran in 378 ms, 0 failed
    pgsql: 83 tests ran in 284 ms, 0 failed
    sqlsrv: skipped, driver not loaded
    ================================================
    Ubuntu 16.04 (PHP 7.0)
    ================================================
    [1/4] Starting MariaDB 10.0 ..... done
    [2/4] Starting PostgreSQL 9.5 ... done
    [3/4] Starting SQLServer 2017 ... done
    [4/4] Cloning PHP-CRUD-API v2 ... skipped
    ------------------------------------------------
    mysql: 83 tests ran in 381 ms, 0 failed
    pgsql: 83 tests ran in 290 ms, 0 failed
    sqlsrv: 83 tests ran in 4485 ms, 0 failed
    ================================================
    Ubuntu 18.04 (PHP 7.2)
    ================================================
    [1/4] Starting MySQL 5.7 ........ done
    [2/4] Starting PostgreSQL 10.4 .. done
    [3/4] Starting SQLServer 2017 ... skipped
    [4/4] Cloning PHP-CRUD-API v2 ... skipped
    ------------------------------------------------
    mysql: 83 tests ran in 364 ms, 0 failed
    pgsql: 83 tests ran in 294 ms, 0 failed
    sqlsrv: skipped, driver not loaded


    $ ./run.sh 
    1) debian9
    2) ubuntu16
    3) ubuntu18
    > 3
    ================================================
    Ubuntu 18.04 (PHP 7.2)
    ================================================
    [1/4] Starting MySQL 5.7 ........ done
    [2/4] Starting PostgreSQL 10.4 .. done
    [3/4] Starting SQLServer 2017 ... skipped
    [4/4] Cloning PHP-CRUD-API v2 ... skipped
    ------------------------------------------------
    mysql: 83 tests ran in 364 ms, 0 failed
    pgsql: 83 tests ran in 294 ms, 0 failed
    sqlsrv: skipped, driver not loaded
    root@b7ab9472e08f:/php-crud-api# 

As you can see the "run.sh" script gives you access to a prompt in a chosen the docker environment.
In this environment the local files are mounted. This allows for easy debugging on different environments.
You may type "exit" when you are done.
