use strict;
use IO::Socket;

my($server, $newmsg, $max_len, $server_port);
$max_len = 1024;
$server_port = 20044;

$server = IO::Socket::INET->new(LocalPort=>$server_port, Broadcast=>1, Proto=>"udp") 
or die "Невозможно запустить udp сервер на порту $server_port: $@\n";
print "UDP Сервер стартовал на порту: $server_port\n";
$newmsg = "";
while($server->recv($newmsg,$max_len)){
	if($newmsg){
	my($port, $ipaddr) = sockaddr_in($server->peername);
	print "Client $ipaddr said $newmsg \n";
	}
}
