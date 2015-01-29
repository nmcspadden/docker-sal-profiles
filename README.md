Sal-Profiles
======

This is a Docker container for [Sal](https://github.com/salsoftware/sal) based on the official [Sal Docker image](https://registry.hub.docker.com/u/macadmins/sal/) that just adds [SalProfileGenerator](https://github.com/nmcspadden/SalProfileGenerator) for easy .mobileconfig profile generation for all Machine Groups.

The main difference with the Sal-profiles container is the existence of a new environmental variable, `PROFILE_PATH`.  This variable specifies a custom path to place the created profile files.  If it doesn't exist, this path will be created on script execution.  The default path is `/home/docker/profiles/` inside the container.

To Use This Container:
----

Follow the instructions for running Sal according to the official [Docker instructions](https://github.com/salsoftware/sal/blob/master/docs/Docker.md).  

Start your Postgres container:  

``` 
	$ mkdir -p /usr/local/sal_data/db  
	$ docker run -d --name="postgres-sal" \  
 	 -v /db:/var/lib/postgresql/data \  
  	-e DB_NAME=sal \  
  	-e DB_USER=saldbadmin \  
  	-e DB_PASS=password \  
  	--restart="always" \  
  	grahamgilbert/postgres  
```
 
Run the Sal-profiles container, pass in the `PROFILE_PATH` environmental variable:

```
	run -d --name sal \
	-p 80:8000 \  
	--link postgres-sal:db \  
	-e DOCKER_SAL_TZ="America/Los_Angeles" \  
	-e ADMIN_PASS=password \  
	-e DB_NAME=sal \  
	-e DB_USER=saldbadmin \  
	-e DB_PASS=password \  
	-e PROFILE_PATH=/home/docker/profiles \  
	nmcspadden/sal-profiles  
```

Access Sal via your browser: [http://localhost:80]()

Create a Business Unit.

Create a Machine Group. *(or create several for testing!)*

Run the script to generate profiles for all Machine Group keys:  
`docker exec sal /usr/local/salprofilegenerator/generate_all_profiles.sh`  
Profiles will be placed into the `$PROFILE_PATH`.

Copy the profiles out from the Docker container onto your host, for deployment to client machines:  
`docker cp sal:/home/docker/profiles /path/on/docker/host/sal-profiles`