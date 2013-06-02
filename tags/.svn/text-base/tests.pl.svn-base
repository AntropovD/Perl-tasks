#use Test::Simple tests => 15;

#-----------------------------------------------------------------------
use threads;
use threads::shared;

use My_Socket;
use My_Client;

our @to_send : shared;
our @recved : shared;
our $finish : shared;

use Fake_keyboard;
use Fake_socket;

my $keyboard = new Fake_keyboard();
#-----------------------------------------------------------------------
	push @threads, threads->create(\&Fake_socket::start);		 
	push @threads, threads->create(\&My_Client::start($keyboard));
	

	foreach (@threads) {
		  $_->join();		  
	}
#-----------------------------------------------------------------------




