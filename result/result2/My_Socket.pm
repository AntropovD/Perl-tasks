package My_Socket;		
#-----------------------------------------------------------------------
	use IO::Socket;
	use IO::Select;
	use threads::shared;
	
	sub start{
		$|=1;		
		my $socket = IO::Socket::INET->new(LocalPort => 5151,
											Proto => "udp")
											or die "socket: $@";						
		$::finish = 1;
		my $select = IO::Select->new(\*$socket);
		while ($::finish){
			while ($select->can_read(2) || @::to_send){
				if (@::to_send){
					onBroadcast();
				}								
				my $msg;	 			
				recv $socket, $msg, 1024, MSG_DONTWAIT;	
				if ($msg ne ''){						
					push @::recved, $msg;
				}			
			}				
		}
		close $socket;
	}	
#-----------------------------------------------------------------------
	sub onBroadcast(){
		my $broadcast = IO::Socket::INET->new(PeerHost   => inet_ntoa(INADDR_BROADCAST),											
												PeerPort   => 5151,									
												Proto      => 'udp',
												Broadcast  => 1);				 
												
		for (@::to_send){	
			my @mas = split(' ', $_);
			if ($mas[0] eq 'NEWUSER'){
				$_.=' '.$broadcast->sockhost();
			}
			if ($mas[0] eq 'PRIVATE'){
				my $private = IO::Socket::INET->new(PeerHost   => $mas[1],
													PeerPort   => 5151,									
													Proto      => 'udp');
				send $private, $_, 0;
				close $private;
				shift @::to_send;
				next;
			}
									
			print "send ".$_."\n";
			send $broadcast, $_, 0;
			shift @::to_send;				 
		}	
		close $broadcast;					 					
	}
1;
#-----------------------------------------------------------------------
