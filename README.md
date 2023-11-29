# nanoserver-nodered
Windows nanoserver container with node-red

This container was built on Windows Server 2019 with only basic windows container services.  It contains the current version of Node.JS 21.2.0 and Node-Red 3.1
# Setup Windows Server 2019
I ran these commands from windows powershell as an administrator
```
netsh advfirewall firewall add rule name="cluster_management" dir=in action=allow protocol=TCP localport=2377
>> netsh advfirewall firewall add rule name="node_communication_tcp" dir=in action=allow protocol=TCP localport=7946
>> netsh advfirewall firewall add rule name="node_communication_udp" dir=in action=allow protocol=UDP localport=7946
>> netsh advfirewall firewall add rule name="overlay_network" dir=in action=allow protocol=UDP localport=4789
>> netsh advfirewall firewall add rule name="swarm_dns_tcp" dir=in action=allow protocol=TCP localport=53
>> netsh advfirewall firewall add rule name="swarm_dns_udp" dir=in action=allow protocol=UDP localport=53
```

# Install Docker
```
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1" -o install-docker-ce.ps1
```
```
.\install-docker-ce.ps1
```

# Install Docker Compose
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
```
```
Start-BitsTransfer -Source "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-windows-x86_64.exe" -Destination $Env:ProgramFiles\Docker\docker-compose.exe
```
To run the docker container yourself:
```
docker run -itd -p 1880:1880 --name node-red brettnreno/nanoserver-nodered
```

This is a basic container service.  For production, you will want to read up on the node-red documentation on setting up a volume for persistence across reboots.  Depending on the palettes you include in your flows you may need to map additional ports and/or devices to your container.

https://nodered.org/
