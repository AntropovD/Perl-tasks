package Fake_keyboard;		
		
				
	our @data_in = ();
	our @data_out = ();
	
	#------------------------------------------------------------------
	sub add_message{
		$class = shift;
		$what = shift;
		push @data_in, $what;						
	}
	#------------------------------------------------------------------	
	sub new{			
		$class = shift;			
		$self = {in => @data_in, out => @data_out};
		return bless $self, $class;		
	}
	#------------------------------------------------------------------
	sub can{	
		$self = shift;
		if (@data_in){
			return 1;
		}	
		return 0;
	}
	#------------------------------------------------------------------
	sub readline{
		$class = shift;
		$what = shift @data_in;		
		#~ for (@data_in){
			#~ print $_;
		#~ }
		return $what;
	}
	#------------------------------------------------------------------
	sub printline{		
		$class = shift;
		$what = shift;
		push @data_out, $what;		
		#~ for (@data_out){
			#~ print $_;
		#~ }
		return;
	}
	#------------------------------------------------------------------
	sub for_check{
		$what = shift @data_out;
		return $what;
	}		
1;
