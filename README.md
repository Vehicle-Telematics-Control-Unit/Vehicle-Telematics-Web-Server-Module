# Telematics control unit - the key to smart cars

## System layout
<center>
<img src="system layout.png" />
</center>

## Back end server
<center>
<img src="back-end-server.png"/>
</center>

### Definition and purpose
The back end server is will provide a cloud platform to allow the TCU to achieve the following functionalities.

- vehicle location tracking using GPS
- Provide daily diagnostic reports on the vehicle and updated maintenance notifications. 
- provide instant notifications if any malfunction occur as soon as it happens.
- Provide instant alert if the vehicle is being accessed when the user phone is away from it.
- provide an automated crisis management protocol to triggered by the mobile companion application or through a web interface.

### Requirements

- Data base server to store the user information.

- web api to handle user information.

- web api for the vehicle to submit it's information and generate a diagnostics report based on it's information.
including the recommended actions like maintenance.

- web api for vehicle to send an alert of any malfunction as soon as it happens.

- provide an api for the vehicle to send it's location as soon as it starts and compare it with the last known location of the device where the companion app is installed and if they are far send a notification to the owner for him to respond to this incident.

- provide an api for the user submit a request to stop his car and get a live location of his vehicle.

- Jenkins server for creating automated pipelines for handling server day to day operations and automating code migration from development to production environment using CI/CD build.


### Development model

#### For this project we will use the DevOps model

<br><br>
<center>
<img src="DevOps.png"/>
</center>

### Software architecture

#### Micro-service based architecture

<br><br>
<center>
<img src="MicroServiceArchiticture.jpg">
</center>

### Required technologies

- For the database micro-service we will use PostGreSQL
    <center>
        <img src="postgreSQL.png">
    </center>

- We will use ASP-NET core to create the web api based micro-services
    <center>
        <img src="asp-net-core.png">
    </center>

- We will use angular frontend to create the web-UI
<center>
    <img src="angular.png">
</center>

- We will use flutter to create the mobile companion app UI
<center>
    <img src="flutter.png">
</center>

- jenkins for automation and testing pipelines
    <center>
    <img src="jenkins.png">
    </center>

- Docker for creating the micro-service containers combined with Kubernetes for service orchestration
    <center>
        <img src="docker.png"> 
        <img src="kubernetes.png"> 
    </center>

- Will run use Linux based server and NGINX as a reverse proxy for request routing
    <center>
        <img src="linux.jpeg"> 
        <img src="nginx.png"> 
    </center>



