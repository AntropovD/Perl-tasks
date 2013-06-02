    use IO::Socket;
 
	my $server_port = 1234;
    die "can't fork: $!" unless defined($kidpid = fork());
    
    # the if{} block runs only in the parent process    
    if ($kidpid) {                
        $server = IO::Socket::INET->new(LocalPort=>$server_port, 
										Broadcast=>1, 
										Proto=>"udp") 
		or die "Невозможно запустить udp сервер на порту $server_port: $@\n"; 
		print "UDP Сервер стартовал на порту: $server_port\n"; 				
		while(1){			
			$server->recv($recieved_data,1024);						
			$peer_address = $server->peerhost();
			$peer_port = $server->peerport();
			open F, ">>server.log";			
			print F "\n($peer_address , $peer_port) said : $recieved_data";
			close F;		
		}
        kill("TERM", $kidpid);
    }
    # the else{} block runs only in the child process
    else {      		
		print "Hello it's a new Client. If you want to exit type exit\n";
		$socket = new IO::Socket::INET (PeerHost   => '127.0.0.1',
										PeerPort   => $server_port, 
										LocalHost => '127.0.0.1',
										LocalPort => '5000',
										Proto       => 'udp')
		or die "ERROR in Socket Creation : $!\n";				
		$data = "Lenovo Client";
		$peer_address = $socket->peerhost();
		$peer_port = $socket->peerport();
		print "Connected to socket on ($peer_address, $peer_port)\n";
		while (<STDIN>)		
		{
			if ($_ == 'exit'){ print "The program will ends now"; last;}	
			if ($_ == 'help'){ print "This is a short help about porgram"; next;}
			sleep(1);
		}		
		print "Session closed";
		$socket->close();	
		kill("TERM", $kidpid);
		exit(0);          	
    }
