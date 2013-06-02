use IO::Socket;

my $socket = IO::Socket::INET->new(LocalPort=>5151, 
									Broadcast=>1, 
									Proto=>"udp")									
or die "Невозможно запустить udp сервер на порту $server_port: $@\n"; 	 
my @toSend;
push @toSend, 'fuuuuuuuu';
$|=1;
my $data;
while ($socket->recv($data, 1024)) {	
  my($port, $ipaddr) = ($socket->peerhost, $socket->peerport);  
  if ($data ne ''){
	my $socket_2 = IO::Socket::INET->new(PeerHost   => $ipaddr,
										PeerPort   => $port,									
										Proto       => 'udp');
	send $socket_2, 'hello', 0;
	recv $socket_2, $data, 1024, MSG_DONTWAIT;
	close $socket_2;									
	}	
}
