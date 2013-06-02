package Server;
my $socket;

sub new{
	$class = shift;
	$socket = IO::Socket::INET->new(LocalPort=>$server_port, 
									 Broadcast=>1, 
									 Proto=>"udp")
	or die "Невозможно запустить udp сервер на порту $server_port: $@\n
			Возможно экземпляр программы уже запущен\n";	
		
}
1;	
#~ 
#~ sub my_client{
	#~ print "Hello it's a new peer-to-peer Chat.\n";		
#~ 
	#~ exit 0;
#~ }
