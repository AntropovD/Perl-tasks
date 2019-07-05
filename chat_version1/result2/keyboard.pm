package keyboard;
	use IO::Select;
	#------------------------------------------------------------------	
	sub new{		
		$class = shift;	
		my $in = IO::Select->new(\*STDIN);			
		my $out = IO::Select->new(\*STDOUT);	
		$self = {in => $in, out => $out};
		return bless $self, $class;		
	}
	#------------------------------------------------------------------
	sub can(){	
		$self = shift;
		if ($self->{in}->can_read(2)){			
			return 1;
		}
		return 0;
	}
	#------------------------------------------------------------------
	sub readline{
		return <STDIN>;
	}
	#------------------------------------------------------------------
	sub printline{		
		$class = shift;
		$what = shift;		
		print <STDOUT>, $what;
	}
	#------------------------------------------------------------------
1;
