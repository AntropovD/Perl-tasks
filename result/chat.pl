use threads;
use threads::shared;

use My_Socket;
use My_Client;

our @to_send : shared;
our @recved : shared;
our $finish : shared;

#-----------------------------------------------------------------------	 
	push @threads, threads->create(\&My_Client::start);
	push @threads, threads->create(\&My_Socket::start);	

	foreach (@threads) {
		  $_->join();		  
	}
#-----------------------------------------------------------------------
