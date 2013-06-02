
use POSIX 'setsid';

sub become_daemon {
	die "Can't fork" unless defined (my $child = fork);
	exit 0 if $child;
	setsid();
	open(STDIN, "</dev/null");
	open(STDOUT,">/dev/null");
	open(STDERR,">&STDOUT");
	
	chdir '/';
	umask(0);
	$ENV{PATH} = '/bin:/sbin:/usr/bin:/usr/sbin';
	return $$;
}

become_daemon;
#~ 
#~ Алггоритм чата:
#~ 1) узнаем свой ip adress
#~ 2) открываем сервер слушающий свой ip  на определенном порту ( Все работают на одном порту)
#~ нет посылаем все на 255.255.255.255 
#~ 3) посылаем broadcastный запрос newUser на свой ip c последним октетом 255 
#~ 4) при получении сервера запроса newUser добваляем его в список пользователей.
#~ 5) реализуем команды 
					 #~ send(посылка всем), 
					 #~ list(список пользователей), 
					 #~ up (обновить список пользователей)
					 #  exit
#~ 6) при команде сервера exit посылается всем useram из списка (nickName, ipAddr)

#~ Algo titts
	#~ создать mysql id points image(blob)
	#~ заполнить ее самое неприятное...
	#~ Говорят что хранить в mysql картинки плохой тон но для тренировки сойдет...
	////////////////////////////////////////////////////////////
	////////////////////MATCH///////////////////////////////////	
	////////////////////////////////////////////////////////////
	..............топ...................автор...................
	
	
			aaaaaaaaaaa					bbbbbbbbbbb			
			aaaaaaaaaaa					bbbbbbbbbbb
			aaaaaaaaaaa					bbbbbbbbbbb
			aaaaaaaaaaa					bbbbbbbbbbb				
			aaaaaaaaaaa					bbbbbbbbbbb
			aaaaaaaaaaa					bbbbbbbbbbb
			aaaaaaaaaaa					bbbbbbbbbbb
			aaaaaaaaaaa					bbbbbbbbbbb

							кол-во игр
	................date/time....................................








