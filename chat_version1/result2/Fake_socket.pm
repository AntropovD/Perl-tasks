package Fake_socket;

	sub start{
		while (){
			if (@::to_send){
				for (@::to_send){
					push @::recved, $_;
					sleep(1);
					shift @::to_send;
				}
			}
			sleep(1);			
		}		
	}
	
1;
