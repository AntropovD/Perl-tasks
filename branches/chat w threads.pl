    use IO::Socket;
    use threads;
	use threads::shared;

	my $server_port = 55678;
	    
    my @threads;
    my @list_of_users : shared;
    my $nick_name : shared;
    
    #~ share @list_of_Users, $nick_name;
    
	push @threads, threads->create(\&my_server);
	push @threads, threads->create(\&my_client);

	foreach (@threads) {
		  $_->join();
	}
     
    sub my_server{         
        $server = IO::Socket::INET->new(LocalPort=>$server_port, 
										Broadcast=>1, 
										Proto=>"udp") 
		or die "Невозможно запустить udp сервер на порту $server_port: $@\n"; 		
				
		while(){						
			$server->recv($recieved_data,1024);			
			
			if ($recieved_data ne ''){
				@mas = split(' ', $recieved_data);
				
				$peer_address = $server->peerhost();
				$peer_port = $server->peerport();			
								
				if (@mas[0] eq 'EXIT'){
					if (@mas[1] eq $nick_name){
						last;
					}
					else{
						for (0..$#list_of_users){
							if (@list_of_users[$i] eq @mas[1]){
								@list_of_users[$i]=undef;
							}
						}
					}
				}
				
				if (@mas[0] eq 'NEWUSER'){													
						push @list_of_users, @mas[1];						
				}				
				print  "($peer_address , $peer_port) said : $recieved_data\n";
			}
		}		
		print "Server over\n";
		$server->close();
    }    
    
    sub my_client{
		print "Hello it's a new peer-to-peer Chat.\n";
		
		while (){
			print "Please enter your name:";
			$nick_name = <STDIN>;
			chop($nick_name);
			if ($nick_name ne ''){last;}
		}
		print "Type help for more information\n";
		
		$socket = new IO::Socket::INET (PeerHost   => inet_ntoa(INADDR_BROADCAST),
										PeerPort   => $server_port, 
										#LocalHost => '127.0.0.1',
										#LocalPort => '5000',
										Proto       => 'udp',
										Broadcast  =>1)
		or die "ERROR in Socket Creation : $!\n";				
		
		send $socket, "NEWUSER $nick_name", 0;
		send $socket, "GETLIST $nick_name", 0;
		
		while (<STDIN>)	{					
			if ($_ eq ''){ next;}
			chop($_);
			@mes = split(' ', $_);		
			
			if (@mes[0] eq 'list'){				
				print @list_of_users;				
				next;
			}			
			if (@mes[0] eq 'exit'){ 
				print "The program will ends now\n";
				send $socket, "EXIT $nick_name", 0; 
				sleep(1); 
				last; 
			}	
			if (@mes[0] eq 'help'){ 
				print "This is a short help about porgram\n"; 
				sleep(1);
				next;
			}
			if (@mes[0] eq 'send'){ 	
				$message = $nick_name.' '.join(' ', @mes[1..$#mes]);			
				send $socket, $message, 0; 
				send $socket, '',0;	
				sleep(1);
				next;
			}					
					
			print "Unknown command try once more\n";						
		}					
		print "Client over";
		$socket->close();	
		exit 0;
 }

