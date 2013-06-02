use threads;
use threads::shared;


my $server_port =12345;


#~ my @threads;
#~ my @list_of_users : shared;
#~ my $nick_name : shared;
#~ my $data_from_server : shared;
#~ my $want_list_of_users  : shared;
#~ $want_list_of_users = 1;
#~ share @list_of_Users, $nick_name;
#~ push @threads, threads->create(\&my_server);
#~ push @threads, threads->create(\&my_client);
#~ foreach (@threads) {
	#~ $_->join();
#~ }

Server->start();

package Server;
use IO::Socket;
use IO::Select;
sub start{	
	$|=1;
	my $socket = new IO::Socket::INET (LocalPort => 5151,
										Proto       => 'udp',
										Broadcast  =>1)
	or die "Невозможно запустить udp сервер на порту $server_port: $@";
			
	print 'server';
	while(){
	$select = IO::Select->new($socket) or die "IO::Select $!";
	@ready_clients = $select->can_read(0);
	foreach my $fh (@ready_clients)  {
		print $fh "";
		if($fh == $socket)       {
			my $new = $socket->accept();
			$select->add($new);
		}
	}
	@ready_clients = $select->can_read(0);
	foreach my $fh (@ready_clients)  {
		if($fh != $socket)  {
			chomp($data=<$socket>);
			print $data,"\n";
		}
	}
	$SIG{PIPE} =  sub
	{
	####If we receieved SIGPIPE signal then call Disconnect this client function
	print "Received SIGPIPE , removing a client..\n";
	unless(defined $current_client){
		print "No clients to remove!\n";
	}else{
		$Select->remove($current_client);
		$current_client->close;
	}
	#print Dumper $Self->Select->handles;
	print "Total connected clients =>".(($Select->count)-1)."<\n";
	};
}
}
	#~ while (){
		#~ #$t = <STDIN>;	
		#~ my $data;			
		#~ $|=1;
		#~ recv $socket, $data, 10, MSG_DONTWAIT;
		#~ sleep(1);	
		#~ 
		#~ send $socket, "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", MSG_DONTWAIT;	
		#~ sleep(1);	
		#~ print $data;
		#~ 
		#~ $peer_address = $socket->sockhost();
		#~ $peer_port = $socket->sockport();	
		#~ print  "($peer_address , $peer_port) said : $data\n";
	#~ }	
#~ }
