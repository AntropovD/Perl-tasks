



#~ use IO::Socket::INET;
#~ 
#~ # flush after every write
#~ $| = 1;
#~ 
#~ my ($socket,$data);
#~ 
#~ #  We call IO::Socket::INET->new() to create the UDP Socket
#~ # and bind with the PeerAddr.
#~ $socket = new IO::Socket::INET (
#~ PeerAddr   => '127.0.0.1:20044',
#~ Proto        => 'udp'
#~ ) or die "ERROR in Socket Creation : $!\n”;
#~ #send operation
#~ $data = “data from client”;
#~ $socket->send($data);
#~ 
#~ #read operation
#~ $data = <$socket>;
#~ print “Data received from socket : $data\n ”;
#~ 
#~ sleep(10);
#~ $socket->close();
#~ 
#~ 









#~ use strict;
#~ use Socket;
#~ 
#~ # BroadCast messager
#~ my $PORT = 20044;
#~ my $ADDR = '10.1.255.255';
#~ 
#~ socket(UDP, PF_INET, SOCK_DGRAM, getprotobyname('udp')) or die "socket() failed: $@";
#~ setsockopt(UDP, SOL_SOCKET, SO_BROADCAST, 1) or die "setsockopt() failed: $@";
#~ 
#~ my $buff = undef;
#~ for(my $i = 1; $i <= 5; $i++) {
	#~ send(UDP, "Broadcast_packet_$i", 0);	
#~ }

#~ 
#~ use Socket;
#~ 
#~ $LOCAL_HOST="127.0.0.1";
#~ $LOCAL_PORT=1234;
#~ 
#~ socket SERVER, PF_INET, SOCK_STREAM, 0;
#~ setsockopt SERVER, SOL_SOCKET, SO_REUSEADDR, 1;
#~ 
#~ bind SERVER, sockaddr_in($LOCAL_PORT, inet_aton($LOCAL_HOST));
#~ print "bind to $LOCAL_HOST:$LOCAL_PORT\n";
#~ 
#~ listen SERVER, 10	 or die "listen: $!, died";
#~ my $invite="\n Enter Some number and get it's Square\n";
#~ 
#~ while (1){	
	#~ accept CLIENT, SERVER;
	#~ $id = fork();
	#~ if (!$id)
	#~ {		
			#~ send CLIENT, $invite, 0;	
			#~ recv CLIENT, $line, 1024, MSG_DONOTWAIT;		
			#~ send CLIENT, $line*$line, 0;
			#~ shutdown CLIENT,2;			
			#~ exit;				
	#~ }
#~ }
