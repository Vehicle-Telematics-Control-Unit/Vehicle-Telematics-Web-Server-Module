# Telematics control unit - the key to smart cars

## Back end server
<p align="center">
    <img src="images/back-end-server.png"/>
</p>

### Definition and purpose

#### The back end server is a cloud platform that is integrated with the TCU software to extend it's functionalities in order to Allow the 

### user to

- Connect his smart device to his vehicle's TCU from multiple devices.
    - Constraints
        - Each vehicle has a Unique Identification number.
        - Each User has a unique Identification number.
        - Each User has multiple devices where 1 device only can share access to other devices.
        - All the requests a responses data are in Json format
    - When the User purchase his new vehicle, An account is created and registered to the purchased vehicle as it's owner.
    - After the initial login, the user will be asked to activate his account using the verification method provided on the account creation.
        - E-mail
        - SMS
    - After account activation the User is now connected to his vehicle and can access it's features.
    - The device is giving permission to allow sharing vehicle access with other devices and will be called the primary device from here on out. 
- Share vehicle access with other devices using the primary device
    - A request is sent to the server containing the <b>vehicle ID + device ID</b> requesting to share it's access.
    - The server will check if the device is the primary device
        - If the device can share access
            - create a new device connection request record that contains :
                - Device Id
                - User Id
                - creationTime
                - State
                - token (Hashed)
            - The reply with a randomly generated token that will be used to authenticate the new Device connection.
        - Else
            - Return error 403 (Forbidden)
    - The new device will send the <b>token + it's information</b> to the server in a POST request to connect it's self to the vehicle.
    - The server will check that token a find if a device connection request has the same token
        - if a request is found
            - if the difference between the request time and the creation time exceeds the timeout period
                - Change the state of the request to expired
                - Return error 400 (Bad request)
            - if the request state in pending state
                - Create a new device record with the User's account
                - deny that device to share access with other devices
                - Connect the device to vehicle
                - Return code 200 (Successful request)
            - else
                - Return error 400 (Bad request)
        - else
            - Return error 400 (Bad request)


- Request a live location of his vehicle.
    - will use google geoLocation API.

- Access live diagnostics information from his vehicles.
    - Constraints
        - The diagnostic information has a standard form through out all TCUs.
        - All the requests a responses data are in Json format.
    - When a User wants to access his device diagnostic information
        - he sends a request to the server containing the vehicle ID requesting the vehicle diagnostic information.
        - The server will lookup the vehicle using it's ID to get it's IP address.
        - The server will send a get request to the vehicle using the recovered IP asking for it's diagnostic information.
        - If the vehicle replies with code 200 (success)
            - The server will deserialize the the response a process the information and extract the status codes in the requests.
            - The server will get the status codes descriptions from the data base and generate a Json response containing this descriptions and the severity of the code.
            - The server will return that response to the User.
        - Else
            - return error 504 (Gate way time out)

- Receive an alert instant if any malfunction occurs.
    - Constraints
        - The alert information has a standard form through out all TCUs.
        - All the requests a responses data are in Json format.
    - When any malfunction occurs
        - the vehicle sends a request to the server containing the error code to the server.
        - The server will get the status codes descriptions from the data base and generate a Json response containing this descriptions.
        - The server will lookup the devices connected to that vehicle ID to get their IP address.
        - The server will send a POST request to the vehicle using the recovered IP to notify the device.
        - If the vehicle replies with code != 200 (success)
            - The server schedule sending those alerts the next time the device is connected to the internet.

- Be warned if the vehicle is being accessed when his phone is away from his vehicle.
    - when the vehicle is turned on.
        - A the vehicle will send a POST request to the server containing it's location to check if a device connected to it is nearby.
        - The server will lookup the last known location of the devices connected to that vehicle and find the distance between them and the vehicle
        - If the distance between any device and the vehicle exceeds a certain tolerance
            - An alert will be sent to that device to check if that is okay
            - if The device responds saying that something is wrong
                - if the device can trigger crisis management protocol
                    - Apply that protocol
                - else
                    - re-notify the users that can trigger the crisis management protocol

- Monitor his vehicle's TCU software updates and get notified when ever a new update is launched.
    - when the TCU starts or the TCU software is updated
        - the TCU will send to the server a POST request containing the vehicle ID and RXSWIN of it's software version
        - If the RXWIN sent != the stored RXWIN then an update has occured
            - Create a SUMLOG record containing
                - vehicle ID
                - update time stamp
                - Old RXWIN
                - New RXWIN
            - Overwrite the Old RXWIN in the vehicle record and update the software last update time stamp

### Vehicle manufacturer to
- Connect the vehicle owner's primary device to vehicle on purchase.
    - the manufacturer receives the owner information
    - the manufacturer sends a POST request to the server containing the vehicle ID and the User information
    - The server will create a new user record and register this user as the owner to vehicle requested.

- Register that a new software update has been released
    - when an update is released
        - the manufacturer sends a POST request to automation server with the RXWIN of the new update.
        - the automation server will iterate through all the vehicles and send a request to devices connected to that vehicle telling them to update their vehicles software.
        - the server will notify the automation server that an updated version of the software has been released
        - each 24 hours the automation server will repeat the previous step
### Development model

#### For this project we will use the <a target="_blank" href="https://aws.amazon.com/devops/what-is-devops/">DevOps model </a>

<br><br>
<p align="center">
<img src="images/DevOps.png"/>
</p>

### Software architecture

#### <a target="_blank" href="https://microservices.io/">Micro-service based architecture</a>

<br><br>
<p align="center">
<img src="images/MicroServiceArchiticture.jpg">
</p>

### Required technologies

- For the database micro-service we will use <a target="_blank" href="https://www.postgresql.org/">PostGreSQL</a>
    <p align="center">
        <img src="images/postgreSQL.png">
    </p>

- We will use ASP-NET core to create the web api based micro-services
    <p align="center">
        <img src="images/asp-net-core.png">
    </p>

- We will use <a target="_blank" href="https://angular.io">angular</a> frontend to create the manufacturer user interface 
<p align="center">
    <img src="images/angular.png">
</p>

- <a target="_blank" href="https://www.jenkins.io/">jenkins</a> for automation and testing pipelines
    <p align="center">
    <img src="images/jenkins.png">
    </p>

- <a target="_blank" href="https://www.docker.com/">Docker</a> for creating the micro-service containers combined with <a target="_blank" href="https://kubernetes.io/">Kubernetes</a> for service orchestration
    <p align="center">
        <img src="images/docker.png"> 
        <img src="images/kubernetes.png"> 
    </p>

- Will run use <a target="_blank" href="https://www.linux.org/">Linux</a> based server and <a target="_blank" href="https://www.nginx.com/">NGINX</a> as a reverse proxy for request routing
    <p align="center">
        <img src="images/linux.jpeg"> 
        <img src="images/nginx.png"> 
    </p>




