package keyboard;
	use IO::Select;
		
	sub new{		
		$class = shift;		
		$in = IO::Select->new(\*STDIN);
		$out = IO::Select->new(\*STDOUT);
		$self = {in=>$in, y=>$out};
		return bless $self, $class;
	}
	
	sub can_read{
		$self = shift;
		if ($self->{in}->can_read(5)){
			return 1;
		}
		return 0;
	}
	
	sub readline{
		return <STDIN>;
	}
1;


$|=1;
my $k = new keyboard();
print $k->can_read;
print "111111111111111111111111111111111111111111111111111111";
#~ if ($k->can_read(2)){
	#~ print (1);
	#~ print $k->readline();
#~ }


#~ package Fake
#~ 
	#~ sub new{		
	#~ }
	#~ 
	#~ sub 
#~ 
#~ 
#~ 1;


