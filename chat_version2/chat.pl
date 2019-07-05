use threads;
use threads::shared;

use My_Socket;
use My_Client;

our @to_send : shared;
our @recved : shared;
our $finish : shared;

use keyboard;

my $keyboard = new keyboard();
#-----------------------------------------------------------------------
		
	push @threads, threads->create(\&My_Socket::start);		 
	push @threads, threads->create(\&My_Client::start($keyboard));

	foreach (@threads) {
		  $_->join();		  
	}
#-----------------------------------------------------------------------
exit(0);
