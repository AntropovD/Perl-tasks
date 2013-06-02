    use IO::Socket;
    use IO::Pipe;
    use IO::Select;   
    use IO::Handle;
    
	my ($reader, $writer);
	pipe $reader, $writer;		#создаем трубу
	$writer->autoflush(1);

	my $server_port = 1234;
    die "can't fork: $!" unless defined($kidpid = fork());
    
    # the if{} block runs only in the parent process    
    if ($kidpid) {                
        $server = IO::Socket::INET->new(LocalPort=>$server_port, 
										Broadcast=>1, 
										Proto=>"udp") 
		or die "Невозможно запустить udp сервер на порту $server_port: $@\n"; 
		print "UDP Сервер стартовал на порту: $server_port\n";
		
		close $reader;
		while(1){			
			
			print $writer 'hello';
			close $writer;
			
			$server->recv($recieved_data,1024);			

			$peer_address = $server->peerhost();
			$peer_port = $server->peerport();
			
			#open F, ">>1.txt";						
			print  "\n($peer_address , $peer_port) said : $recieved_data";						
			#close F;
		}
		
        kill("TERM", $kidpid);
    }    
    # the else{} block runs only in the child process
    else {      			
		print "Hello it's a new Client. If you want to exit type exit\n";
		$socket = new IO::Socket::INET (PeerHost   => inet_ntoa(INADDR_BROADCAST),
										PeerPort   => $server_port, 
										#LocalHost => '127.0.0.1',
										#LocalPort => '5000',
										Proto       => 'udp',
										Broadcast  =>1)
		or die "ERROR in Socket Creation : $!\n";				
		
		#~ $peer_address = $socket->peerhost();
		#~ $peer_port = $socket->peerport();
		#print "Connected to socket on ($peer_address, $peer_port)\n";
				
		#my $select = IO::Select->new();
		#$select->add(\*READ);
					
		open F, ">>huynya";	
		#$|=1;
		close $writer;
		while (<STDIN>)		
		{					
			chop($_);
			@mes = split(' ', $_);		
			
			$t = <$reader>;
			print $t;
			
			if (@mes[0] eq 'exit'){ print "The program will ends now\n"; sleep(1); last; }	
			if (@mes[0] eq 'help'){ print "This is a short help about porgram\n"; next;}
			if (@mes[0] eq 'send'){ send $socket, join('',@mes), 0; send $socket, '',0;	next;}		
					
			print "Unknown command try once more\n";						
		}	
		
		close F;			
		print "Session closed";
		$socket->close();	
		kill("TERM", $kidpid);
		exit(0);          	
    }

