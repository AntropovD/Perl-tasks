    use IO::Socket;
    use IO::Pipe;
    use IO::Select;   
    use IO::Handle;
    
    pipe(READ,  WRITE) or die $!;
	WRITE->autoflush(1);

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
			print "serv 0";
			$server->recv($recieved_data,1024);			
								
			print WRITE "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaAA";			
			
			print "server ok";
			$peer_address = $server->peerhost();
			$peer_port = $server->peerport();
			
			open F, ">>1.txt";
			print "server ok2";
						
			print F "\n($peer_address , $peer_port) said : $recieved_data";			
			
			close F;
			print "server ok3";
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
				
		my $select = IO::Select->new();
		$select->add(\*READ);
					
		open F, ">>huuu";	
		print "scu";
		while (1)		
		{					
			$_=<STDIN>;
			print $_;
			print "sicj";
			
			chop($_);
			@mes = split(' ', $_);		
			
			send $socket, $_, 0;		
			
			print "client send";
			if ($select->can_read(1)){
				print <READ>;
			}
			
			if (@mes[0] eq 'exit'){ print "The program will ends now\n"; sleep(1); last; }	
			if (@mes[0] eq 'help'){ print "This is a short help about porgram\n"; next;}
			if (@mes[0] eq 'send'){ send $socket, join('',@mes), 0;	print "client ok";next;}		
					
			print "Unknown command try once more\n";						
		}	
		
		close F;			
		print "Session closed";
		$socket->close();	
		kill("TERM", $kidpid);
		exit(0);          	
    }

