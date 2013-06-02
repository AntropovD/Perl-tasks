package keyboard;
	use IO::Select;
		
	sub new{		
		$class = shift;	
		my $in = IO::Select->new(\*STDIN);			
		my $out = IO::Select->new(\*STDOUT);	
		$self = {in => $in, out => $out};
		return bless $self, $class;		
	}
	
	sub can(){	
		$self = shift;
		if ($self->{in}->can_read(2)){			
			return 1;
		}
		return 0;
	}
	
	sub readline{
		return <STDIN>;
	}
	sub printline{		
		$class = shift;
		$what = shift;		
		print <STDOUT>, $what;
	}


1;

$|=1;
print 1;
my $k = new kbd();

if ($k->can){
	$t = $k->readline();
	$k->printline($t);
}



#~ print $k->readline();
#~ if ($k->can_read){
	#~ print (1);
	#~ print $k->readline();
#~ }

#~ print "asd";
#~ package Fake
#~ 
	#~ sub new{		
	#~ }
	#~ 
	#~ sub 
#~ 
#~ 
#~ 1;


