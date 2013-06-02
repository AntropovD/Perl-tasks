
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
			open F, ">>1.txt";			
			print F "\n($peer_address , $peer_port) said : $recieved_data";
			close F;
			$data = "Asus server\n";
			send $server, $data, 0;
		}
        kill("TERM", $kidpid);
    }
    # the else{} block runs only in the child process
    else {      		
		$socket = new IO::Socket::INET (PeerHost   => '127.0.0.2',
										PeerPort   => 1234,
										Proto       => 'udp')
		or die "ERROR in Socket Creation : $!\n";				
		$data = "Asus Client";
		send $socket, $data, 0;
		recv $socket, $data ,1024, 0;
		open F2, ">>2.txt";		
		print F2 "Data received from socket : $data\n ";
		close F2;
		sleep(10);
		$socket->close();
        exit(0);                # just in case
    }
