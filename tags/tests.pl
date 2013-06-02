#-----------------------------------------------------------------------
use threads;
use threads::shared;

use My_Client;

our @to_send : shared;
our @recved : shared;
our $finish : shared;

use Fake_keyboard;

my $keyboard = new Fake_keyboard();
#-----------------------------------------------------------------------
	push @threads, threads->create(\&My_Client::start($keyboard));
	push @threads, threads->create(\&start);		 

	foreach (@threads) {
		  $_->join();		  
	}
#-----------------------------------------------------------------------


sub start{	
	$|=1;
	#use Test::Simple => 1;
	#$keyboard->add_message('aaaaaaaaaaa');	
	sleep(1);
	print $keyboard->for_check
	
	
	
	 #~ while (){	
		#~ if (@::to_send){
			#~ for (@::to_send){
				#~ push @::recved, $_;
				#~ sleep(1);
				#~ shift @::to_send;
			#~ }
		#~ }				
		#~ sleep(1);							
	#~ }		
}	

