use strict;
use IO::Socket;
my($sock, $oldmsg, $newmsg, $hisaddr, $hishost, $MAXLEN, $PORTNO);
$MAXLEN = 1024;
$PORTNO = 5151;
$sock = IO::Socket::INET->new(LocalPort => $PORTNO, Proto => 'udp')
  or die "socket: $@";
print "Awaiting UDP messages on port $PORTNO\n";
$oldmsg = "This is the starting message.";
while ($sock->recv($newmsg, $MAXLEN)) {
  my $t = <>;
  my($port, $ipaddr) = ($sock->peerhost, $sock->peerport);  
  print "Client ($port, $ipaddr) said  ''$newmsg''\n";
  $sock->send($t);
  print $t;
  $oldmsg = "[$hishost] $newmsg";
}
die "recv: $!";
