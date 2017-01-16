# SIPp_LAB
Lab for SIPp

First you will want to set up two vanilla CentOS 7 (or EL7 variants) systems that are able to talk to eachother via IP.

Then you will want to yum update and install docker-engine on both of these systems:
~~~~
yum update
curl -fsSL https://get.docker.com/ | sh
~~~~

Enable and start the Docker service:
~~~~
systemctl enable docker.service
systemctl enable docker.service
~~~~

Add a docker group (or ensure one exists) and then add your regular user to the docker group:
~~~~
groupadd docker
usermod -aG docker your_username
~~~~

Now all that is left to do is to git clone this repository to both servers.
~~~~
git clone https://github.com/Toggie/SIPp_LAB.git
~~~~

Then cd into SIPp_LAB/dockerfiles/sipp (again on both servers), and run:
~~~~
docker build -t="sipp" .
~~~~

You now should have a docker image ready to run with a convenient shell for launching a couple of SIPp scenarios.

From here you can run a test with media between your two servers.  In this example server-1 is the server and server-2 is the client.  Run the server command first and the client command shortly after.

Server-1:
~~~~
docker run -t sipp ip_of_server-1 ip_of_server-2 server
~~~~

Server-2:
~~~~
docker run -t sipp ip_of_server-1 ip_of_server-2 client
~~~~

This will launch a scenario on both sides for bidirectional media.  You can capture both with tcpdump to see the RTP stream and the average latency, jitter, and many other factors with wireshark.  You can even listen to the media being played in the RTP stream (which you can find in this repository as SIPp_LAB/dockerfiles/sipp/includes/sipp_working/cello.wav

One such example of a tcpdump command you might run to capture everything would be
~~~~
sudo tcpdump -p -i eth0 -n -s 0 -C 25 -w /tmp/load_uas.pcap
~~~~
