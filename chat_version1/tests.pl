use Test::Simple tests => 15;
use My_Client;

push @list_of_users, '1';
@m1 = (1,2,3,4,5);

for (1..5){
	ok (My_Client::in($_, @m1) eq 1);	
}

for (6..10){
	ok (My_Client::in($_, @m1) eq 0);
}

sub rand_word{
		my $t = rand(10);
		my $ans = '';
		for (0..$t){
			$ans.=chr(65+rand(26));
		}
		return $ans;	
}

  
#~ for (1..5){
		#~ my $t = (10);
		#~ if (1<=t && t<=4){
			#~ my $t = "USE ".$My_Client::list_of_channels[$t];
			#~ if (
			#~ ok(My_Client::onUse($t)
		#~ }
	#~ 
#~ }

for (1..5){
	my $t = "NEWUSER  ".rand_word();	
	ok(My_Client::on_NEWUSER($tmp) eq 0);
		
}

#~ print @::list_of_users;


