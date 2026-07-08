Program pixpang;
import "image"
//import "net.dll"
Const
	classic=0; //0 para pixpang, 1 para super pang
	pixpangcd=0; // por defecto
Global
	op_guardar=1; // guardar o no guardar...
	i; // bucle for i
	string fichero_lng[30];
	Struct ops;
		int op_lang=-1; 	// 0 = castellano, 1 = catalán, 2 = francés, 3 = inglés
		byte op_music=1;
		byte op_sombras=1;
		byte op_sonido=1;
		byte p1_control=0; //por defecto teclado
		byte p2_control=1; //por defecto raton
		byte p1_personaje=1; //por defecto el mío!
		byte p2_personaje=0; //por defecto el mío!
		byte ventana=0;
		byte cd_audio=1;
		byte dificultad=1; //la normal
		byte records=0;
		Struct palanca;
			int arriba;
			int abajo;
			int izquierda;
			int derecha;
		End
	End
	Struct datos;
		string rec_puntos[20];
		String rec_nombres[20];
	End
	Struct pantalla;
		Int bx[200];
		Int by[200];
		Int btipo[200];
		Int br[200];
		Int btime;
	End
	Struct botones;
		int p1[5];
		Int p2[5];
	End
	String nombrep1;
	String nombrep2;
	byte primerapartida;
	int id_p1;
	int p1_vidas=10;
	byte p1_arma;
	int p1_bolas; //ganando
	int p1_bonus; //ganando
	int p1_puntos; //ganando
	byte p1_proteccion;
	byte p1_estrella;
	int p1_disparos[2];
	byte p1_muere;
	byte p1_invocacion;
	int id_p2;
	int p2_vidas=10;
	byte p2_arma;
	int p2_bolas; //ganando
	int p2_bonus;
	int p2_puntos;
	byte p2_proteccion;
	int p2_disparos[2];
	byte p2_estrella;
	byte p2_muere;
	byte p2_invocacion;
	byte players;
	byte ganando;
	byte animglobal;
	byte ready;
	byte prisa;
	byte efepeese=60;
	int escenario;
	int fnt1;
	int fnt2;
	int fnt3;
	int fnt4;
	byte reloj;
	byte relojarena;
	byte dinamita;
	int time_puesto=120;
	byte bolas;
	byte matabolas;
	int velocidad=200;
	int graph_fondo;
	byte num_disp;
	byte bola_estrella=0;
        String prompt="_";
        String entry;
	inputText;
	byte iniciando;
	int cont;
	int zbolas;
	byte parpadea;
	byte modo_juego;
	byte torneo=0; //pa juego normal
	int segundos;
	word mundo;
	int id_titulo;
	int id_lang;
	int cocos;
	int borrar;
	int id_bolas[400];
	word mundo_alcanzado;
	int file_muneco1;
	int file_muneco2;
	byte partida_rapida;
	byte vidap1fuera;
	byte vidap2fuera;
	byte vidajefefuera;
	int secs;
	int screenshot;
// sonidos
	s1; s2; s3; s4; s5; s6; s7; s8; s9; s10; s11; s12; s13; s14; s15; s16;
// cosas raras
	Int contaor;
	byte menu_chetos;
	byte cheto_diox;
	byte cheto_epilepsia;
	byte cheto_borracho;
	byte cheto_ayudante;
	byte cheto_salto;
	byte cheto_viejuno;
	byte cheto_choca;
	byte jefe=0;
	byte pixel_mola;
	int raton;
	int transicion;
	int fpg_creditos;
	int fpg_lang;
	int fpg_jefe;
	int fondo_safari;
	int img_pixpang;
	int txt_safari_combo;
	int txt_fondos[1];
	int filerecs;
	byte cd_fallido;
	byte ahora_toca;
	int color_texto[8];
	byte que_toca;
	byte tour_levels;
// MODULOS
	byte mod_england; int mod_england_png;
	byte mod_andorra; int mod_andorra_png;
	byte mod_custom; byte cus_levels; int mod_custom_png;
// multilenguaje
    String textos[119];
Local
	int bugazo;
	word ancho;
	word alto;
Private
    lee_archivo;
    guarda_archivo;
    intejer;
    num;
    pit;
Begin  
	select_joy(0);
	if(pixpangcd==1) ops.cd_audio=0; end
    If(argv[1]=="/?" OR argv[1]=="--help") info(); Return; End
	While(intejer<5)             
		If(argv[intejer]=="--window") Full_screen=false; End
	       	If(argv[intejer]=="--nosound") ops.op_sonido=0; End
    		If(argv[intejer]=="--nosave") op_guardar=0; End
	        If(argv[intejer]=="--nomusic") ops.op_music=0; End
	        If(argv[intejer]=="--noalpha") ops.op_sombras=0; End
	        intejer++;
	        Frame;
	End
	If(op_guardar)
		If(pixpangcd)
		    if(file_exists("c:\PiXPang\opciones.dat"))
		                load("c:\PiXPang\opciones.dat",ops);
				//load("c:\PiXPang\records.dat",datos);
				/*filerecs=fopen("c:\PiXPang\records.dat",o_zread);
				fread(filerecs,datos);
				fclose(filerecs);*/
			if(file_exists("c:\PiXPang\chetos")) menu_chetos=1; end
	   	    Else
			primerapartida=1;
		        mkdir("c:\PiXPang");
   	    		mkdir("c:\PiXPang\pantallas");
		        mkdir("c:\PiXPang\custom");
		        mkdir("c:\PiXPang\rec");
	    		mkdir("c:\PiXPang\custom\tour");
		        mkdir("c:\PiXPang\custom\fondos");
		        load(".\pantallas\cero.pang",pantalla);
		        save("c:\PiXPang\custom\tour\1.pang",pantalla);
		        Frame;
		        save("c:\PiXPang\opciones.dat",ops);
		    End
    		Else
			if(file_exists(".\opciones.dat"))
				load(".\opciones.dat",ops);
				//load("records.dat",datos);
				/*filerecs=fopen("records.dat",o_zread);
				fread(filerecs,datos);
				fclose(filerecs);*/
				if(file_exists(".\chetos")) menu_chetos=1; end
			else
				primerapartida=1;
			end
		End
	End
	sound_freq=44100;
	sound_mode=1;
	borrar=new_map(1,1,8);
	Graph_mode=mode_16bits;
	Alpha_steps=64;
	set_title("PiX Pang!");
	if(ops.ventana==0) Full_screen=true; else full_screen=false; end
	set_mode(m800x600);
	If(is_playing_cd()) stop_cd(); End
	If(classic==0) load_fpg(".\fpg\pixpang.fpg"); Else load_fpg(".\fpg\spang.fpg"); End
	fpg_creditos=load_fpg(".\fpg\creditos.fpg");
	While(pit<9)
		color_texto[pit]=map_get_pixel(0,load_png(".\cosas\textos.png"),pit,0);
		pit++;
		Frame;
	End
	fondo_safari=load_image(".\cosas\safari.jpg");
//	If(classic==0) img_pixpang=load_png(".\cosas\pixpang.png"); Else  img_pixpang=load_image(".\cosas\spang.jpg"); End
        If(classic==0) img_pixpang=load_png(".\cosas\pixpangfinal.png"); Else  img_pixpang=load_image(".\cosas\spang.jpg"); End

	set_icon(0,401);

if(rand(0,1)==0)
		fnt4=load_fnt(".\fnt\creditos.fnt");
		fnt3=load_fnt(".\fnt\textos2.fnt");
		fnt2=load_fnt(".\fnt\conta.fnt");
		fnt1=load_fnt(".\fnt\textos.fnt");
	else
		fnt4=load_fnt(".\fnt\creditos.fnt");
		fnt2=load_fnt(".\fnt\conta.fnt");
		fnt3=load_fnt(".\fnt\textos2.fnt");
		fnt1=load_fnt(".\fnt\textos.fnt");
	end


//	dias especiales!!
	if(atoi(ftime("%d",time()))==29 and atoi(ftime("%d",time()))==12) cheto_borracho=1; end
	if(atoi(ftime("%d",time()))==31 and atoi(ftime("%d",time()))==12) cheto_viejuno=1; end
	if(atoi(ftime("%d",time()))==6 and atoi(ftime("%d",time()))==1) cheto_epilepsia=1; end
	if(atoi(ftime("%d",time()))==12 and atoi(ftime("%d",time()))==1) cheto_diox=1; end
	if(atoi(ftime("%d",time()))==15 and atoi(ftime("%d",time()))==1) cheto_choca=1; end
//


	carga_sonidos();
	set_fps(efepeese,9);
	If(ops.op_lang==-1) id_lang=elige_lenguaje(); else logos(); End
End

Process info();
Begin
    write(0,0,0,0,textos[46]);
    write(0,0,10,0,textos[47]);
    write(0,0,10,0,textos[48]);
    write(0,0,20,0,textos[49]);
    write(0,0,30,0,textos[50]);
    write(0,0,40,0,textos[51]);
    write(0,0,50,0,textos[52]);
    While(!key(_esc))
        Frame;
    End
End

Process muneco1();
Private
	anim;
	grav;
	if_id_disp;
	hexo;
	id_colisionado;
	toca;
	escaleras;
	subiendo;
	parpadeas=120;
	pulsando_control;
	controller;
	cont_1;
	y_statico;
	l;
	snd_muere;
	inercia;
	saltando;
Begin
	If(p1_vidas<0) Return; End
	botones.p1[0]=0; botones.p1[1]=0; botones.p1[2]=0; botones.p1[3]=0; botones.p1[4]=0;
	controller=controlador_player1();
	If(classic==0) file=file_muneco1; End
	x=370;
	graph=501;
	alto=graphic_info(file,graph,g_height);
	y_statico=500-(alto/2);
	y=y_statico;
	z=0;
	Frame;
	Loop
		ancho=graphic_info(file,graph,g_wide);
		alto=graphic_info(file,graph,g_height);
		If(cheto_borracho==1) If(rand(0,2338)==1) p1_muere=1; End End
		While(ready==0 AND ganando==0 AND p1_muere==0)
			graph=501;
			Frame;
			End
		While(ganando==1)
			graph=507;
			Frame;
		End
		If(!collision(Type escaleras))
			If(toca=collision(Type bloques))
				If(toca.y<y)
					grav++;
					cont_1=grav;
					While(cont_1>0 AND toca.y<y)
						y+=1;
						cont_1--;
					End
				Else
					y=toca.y-(toca.alto/2)-(id.alto/2);
					if(saltando==1)	saltando=0; end
					grav=0;
				End
			Else	
				grav++;
				cont_1=grav;
				While(cont_1>0)
					y+=1;
					cont_1--;
				End
				While(cont_1<0)
					y-=1;
					cont_1++;
				End
			End
		Else
			If(y>y_statico) y=y_statico; End
			if(saltando==1)	saltando=0; end
			grav=0;
		End
		If(!collision(Type bloques) AND !key(_up))
			subiendo=0;
		End
		If(y>y_statico)	if(saltando==1)	saltando=0; end y=y_statico; grav=0; End
		if(saltando==1) angle+=15000; else angle=0; end
		if(botones.p1[5]==1 and saltando==0 and cheto_salto==1) saltando=1; grav=-20; end
		escaleras=collision(Type escaleras);
		If(escaleras=collision(Type escaleras))
			If(escaleras.graph!=429) subiendo=0; End
			If(escaleras.graph==429 AND botones.p1[2]==1 AND botones.p1[0]==0 AND botones.p1[1]==0)
				x=escaleras.x;
				subiendo=1; y-=4;
				If(anim<11)
					anim++;
				Else
					anim=0;
				End
				If(graph<510 OR graph>513) graph=510; End
				If(graph<513 AND anim>10)
					graph++;
				End
				If(graph==513)
					graph=510;
				End
			End
			If(escaleras.graph==429 AND botones.p1[3]==1 AND botones.p1[0]==0 AND botones.p1[1]==0)
				x=escaleras.x;
				subiendo=1; y+=4;
				If(anim<11)
					anim++;
				Else
					anim=0;
				End
				If(graph<513 AND anim>10) 
					graph++; 
				End
				If(graph<510 OR graph>513) graph=510; End
				If(graph==513) 
					graph=510; 
				End
			End
		Else
			If(botones.p1[2]==1 OR botones.p1[3]==1)
				graph=501;
			End
		End
		If(botones.p1[1]==1 AND (botones.p1[2]==0 AND botones.p1[3]==0))
			If(graph==501 OR graph==506 OR graph>510)
				graph=502;
				End
			If(x<755)
				If(collision(type col_hielo)) inercia++; if(inercia>4 or inercia<-4) x+=inercia/5; end end
				If(toca=collision(Type bloques))
					If((toca.x=<x AND toca.y=<y) OR toca.y=>y) x+=4; End
				Else
					x+=4;
				subiendo=0;
				End
				End
			If(anim<11)
				anim++;
			Else
				anim=0;
			End
			If(graph<506 AND anim>10) 
				graph++; 
				End
			If(graph==506) 
				graph=502; 
				End
			flags=0;  
			End
		If(botones.p1[0]==1 AND (botones.p1[2]==0 AND botones.p1[3]==0))
			If(graph==501 OR graph==506 OR graph>510)
				graph=502;
				End
			If(x>45) 
				If(collision(type col_hielo)) inercia--; if(inercia>4 or inercia<-4) x+=inercia/5; end end
				If(toca=collision(Type bloques))
					If((toca.x=>x AND toca.y=<y) OR toca.y=>y) x-=4; End
				Else
					x-=4;
					subiendo=0;
				End
		End
		If(anim<11)
				anim++;
			Else
				anim=0;
			End
			If(graph<506 AND anim>10)
				graph++;
				End
			If(graph==506)
				graph=502; 
				End
			flags=1; 
			End
		If(botones.p1[4]==0) pulsando_control=0; End
		If(pulsando_control==0 AND botones.p1[4]==1 AND ((p1_arma==1 AND p1_disparos[1]<1) OR (p1_arma==2 AND (p1_disparos[1]<1 OR p1_disparos[2]<1)) OR (p1_arma==3 AND p1_disparos[1]<1) OR (p1_arma==4 AND (p1_disparos[1]<1 OR p1_disparos[2]<1))))
			graph=506;
			angle=0;
			If(parpadeas<120) flags+=4; End Frame; If(parpadeas<120) parpadeas++; flags-=4; End 
			If(parpadeas<120) flags+=4; End Frame; If(parpadeas<120) parpadeas++; flags-=4; End
			If(parpadeas<120) flags+=4; End Frame; If(parpadeas<120) parpadeas++; flags-=4; End
			If(cheto_borracho==1) Frame(rand(100,1000)); End
			pulsando_control=1; 
//			If(flags==1) If(p1_disparos[1]>0) If(p1_disparos[2]<1) p1_disparos[2]=dispcab2(p1_arma,x-3,y,2); End End If(p1_disparos[1]<1) p1_disparos[1]=dispcab(p1_arma,x-3,y,1); End End 
//			If(flags==0) If(p1_disparos[1]>0) If(p1_disparos[2]<1) p1_disparos[2]=dispcab2(p1_arma,x+5,y,2); End End If(p1_disparos[1]<1) p1_disparos[1]=dispcab(p1_arma,x+5,y,1); End End

			If(flags==1) If(p1_disparos[1]>0) If(p1_disparos[2]<1) p1_disparos[2]=dispcab2(p1_arma,x-3,y,2); End End If(p1_disparos[1]<1) p1_disparos[1]=dispcab(p1_arma,x-3,y,1); End End 
			If(flags==0) If(p1_disparos[1]>0) If(p1_disparos[2]<1) p1_disparos[2]=dispcab2(p1_arma,x+5,y,2); End End If(p1_disparos[1]<1) p1_disparos[1]=dispcab(p1_arma,x+5,y,1); End End

		End
		If(!collision(type col_hielo) and inercia!=0) inercia=0; end
		If(botones.p1[0]==0 AND botones.p1[1]==0 AND botones.p1[2]==0 AND botones.p1[3]==0) 
			graph=501;
			if(inercia>4 or inercia<-4) x+=inercia/3; end
			If(subiendo==1) graph=511; Else anim=0; End
			End
		If(botones.p1[1]==1 AND botones.p1[0]==1)
			graph=501; 
			if(inercia>4 or inercia<-4) x+=inercia/3; end
			If(subiendo==1) graph=511; Else anim=0; End
			End
		If(p1_muere==1)
			If(p1_proteccion==1) 
				p1_proteccion=0;
//				suena(s12);
					l=(x*255)/800;
					snd_muere=play_wav(s12,0); 
					set_panning(snd_muere,255-l,l);
				parpadeas=0;
			Else
				If(parpadeas==120)
					If((cheto_diox==1 OR cheto_borracho==1) AND ((segundos>0 and modo_juego==2) or modo_juego==1))
					ready=0;
					parpadeo();
					suena(s4);
					grav=rand(50,250);
					While(y<464)
						If(ops.op_sombras==1) sombra(graph,x,y,flags,1); End
						If(flags==0) x+=12; End
						If(flags==1) x-=12; End
						If(x=>755) flags=1; End
						If(x=<45) flags=0; End
						If(grav>0) graph=508; End
						If(grav<0) graph=509; End
						grav-=5;
						y-=grav/10;
						l=(x*255)/800;
						set_panning(snd_muere,255-l,l);
						Frame;
					End
					y=y_statico;
					ready=1;
					grav=0;
					itemreloj(3);
					p1_muere=0;
				Else
					Break;
				End
				Else
					p1_muere=0;
				End
			End
		End
		hexo=0;
		If(parpadeas<120) flags+=4; End
		If(x>755) x=755; end
		If(x<45) x=45; end
		If(cheto_epilepsia==0) Frame; Else Frame(50); If(ops.op_sombras==1) sombra(graph,x,y,flags,1); End End
		If(parpadeas<120) parpadeas++; flags-=4; End
	End
	ready=0;
	vidap1fuera=1;
	parpadeo();
	timer[2]=0;
	While(timer[2]<50) Frame; End
	suena(s4);
	grav=rand(50,250);
	While(y<480)
		If(ops.op_sombras==1) sombra(graph,x,y,flags,1); End
		If(flags==0) x+=12; End
		If(flags==1) x-=12; End
		If(x=>755) flags=1; End
		If(x=<45) flags=0; End
		If(grav>0) graph=508; End 
		If(grav<0) graph=509; End 
		grav-=5;
		y-=grav/10;
		Frame;
	End
	suena(s5);
	p1_vidas--;
	p1_muere=3;
	say("cacona");
	If(players==3 AND p2_muere==0) ready=1; itemreloj(3); End
	signal(controller,s_kill_tree);
End

Process muneco2();
Private
	anim;
	grav;
	if_id_disp;
	hexo;
	id_colisionado;
	toca;
	escaleras;
	subiendo;
	parpadeas=120;
	pulsando_control;
	controller;
	cont_1;
	y_statico;
	saltando;
	l;
	snd_muere;
	inercia;
Begin
	If(p2_vidas<0) Return; End
	botones.p2[0]=0; botones.p2[1]=0; botones.p2[2]=0; botones.p2[3]=0; botones.p2[4]=0;
	controller=controlador_player2();
	If(classic==0) file=file_muneco2; End
	graph=551;
	x=430;
	alto=graphic_info(file,graph,g_height);
	y_statico=500-(alto/2);
	y=y_statico;
	z=1;
	Loop
		While(ready==0 AND ganando==0 AND p2_muere==0)
			graph=551;
			Frame;
			End
		While(ganando==1)
			graph=557;
			Frame;
			End
		If(!collision(Type escaleras))
			If(toca=collision(Type bloques))
				If(toca.y<y)
					grav++;
					cont_1=grav;
					While(cont_1>0 AND toca.y<y)
						y+=1;
						cont_1--;
					End
				Else
					y=toca.y-(toca.alto/2)-(id.alto/2);
					if(saltando==1)	saltando=0; end
					grav=0;
				End
			Else	
				grav++;
				cont_1=grav;
				While(cont_1>0)
					y+=1;
					cont_1--;
				End
				While(cont_1<0)
					y-=1;
					cont_1++;
				End
			End
		Else
			If(y>y_statico) y=y_statico; End
			if(saltando==1)	saltando=0; end
			grav=0;
		End
		If(!collision(Type bloques) AND !key(_up))
			subiendo=0;
		End
		If(y>y_statico)	if(saltando==1)	saltando=0; end y=y_statico; grav=0; End
		if(saltando==1) angle+=15000; else angle=0; end
		if(botones.p2[5]==1 and saltando==0 and cheto_salto==1) saltando=1; grav=-20; end
		escaleras=collision(Type escaleras);
		If(escaleras=collision(Type escaleras))
			If(escaleras.graph!=429) subiendo=0; End
			If(escaleras.graph==429 AND botones.p2[2]==1 AND botones.p2[0]==0 AND botones.p2[1]==0)
				x=escaleras.x;
				subiendo=1; y-=4;
				If(anim<11)
					anim++;
				Else
					anim=0;
				End
				If(graph<560 OR graph>563) graph=560; End
				If(graph<562 AND anim>10)
					graph++;
				End
				If(graph==563)
					graph=560;
				End
			End
			If(escaleras.graph==429 AND botones.p2[3]==1 AND botones.p2[0]==0 AND botones.p2[1]==0)
				x=escaleras.x;
				subiendo=1; y+=4; 
				If(anim<11)
					anim++;
				Else
					anim=0;
				End
				If(graph<560 OR graph>563) graph=560; End
				If(graph<562 AND anim>10) 
					graph++; 
				End
				If(graph==563) 
					graph=560; 
				End
			End
		Else
			If(botones.p2[2]==1 OR botones.p2[3]==1)
				graph=551;
			End
		End
		If(botones.p2[1]==1 AND (botones.p2[2]==0 AND botones.p2[3]==0))
			If(graph==551 OR graph==556 OR graph>560)
				graph=552;
				End
			If(x<755) 
				If(collision(type col_hielo)) inercia++; if(inercia>4 or inercia<-4) x+=inercia/5; end end
				If(toca=collision(Type bloques))
					If((toca.x=<x AND toca.y=<y) OR toca.y=>y) x+=4; End
				Else
				x+=4;
				subiendo=0;
				End
				End
			If(anim<11)
				anim++;
			Else
				anim=0;
			End
			If(graph<556 AND anim>10) 
				graph++; 
				End
			If(graph==556) 
				graph=552; 
				End
			flags=0;  
			End
		If(botones.p2[0]==1 AND (botones.p2[2]==0 AND botones.p2[3]==0))
			If(graph==551 OR graph==556 OR graph>560)
				graph=552;
				End
			If(x>45) 
				If(collision(type col_hielo)) inercia--; if(inercia>4 or inercia<-4) x+=inercia/5; end end
				If(toca=collision(Type bloques))
					If((toca.x=>x AND toca.y=<y) OR toca.y=>y) x-=4; End
				Else
					x-=4;
					subiendo=0;
				End
				End
			If(anim<11)
				anim++;
			Else
				anim=0;
			End
			If(graph<556 AND anim>10)
				graph++; 
				End
			If(graph==556) 
				graph=552; 
				End
			flags=1; 
			End
		If(botones.p2[4]==0) pulsando_control=0; End
		If(pulsando_control==0 AND botones.p2[4]==1 AND ((p2_arma==1 AND p2_disparos[1]<1) OR (p2_arma==2 AND (p2_disparos[1]<1 OR p2_disparos[2]<1)) OR (p2_arma==3 AND p2_disparos[1]<1) OR (p2_arma==4 AND (p2_disparos[1]<1 OR p2_disparos[2]<1))))
			graph=556; 
			Frame(300);
			pulsando_control=1; 
			If(flags==1) If(p2_disparos[1]>0) If(p2_disparos[2]<1) p2_disparos[2]=dispcab4(p2_arma,x-3,y,2); End End If(p2_disparos[1]<1) p2_disparos[1]=dispcab3(p2_arma,x-3,y,1); End End 
			If(flags==0) If(p2_disparos[1]>0) If(p2_disparos[2]<1) p2_disparos[2]=dispcab4(p2_arma,x+5,y,2); End End If(p2_disparos[1]<1) p2_disparos[1]=dispcab3(p2_arma,x+5,y,1); End End
		End
		If(!collision(type col_hielo) and inercia!=0) inercia=0; end
		If(botones.p2[0]==0 AND botones.p2[1]==0 AND botones.p2[2]==0 AND botones.p2[3]==0) 
			graph=551; 
			if(inercia>4 or inercia<-4) x+=inercia/3; end
			If(subiendo==1) graph=551; End
			anim=0;
			End
		If(botones.p2[1]==1 AND botones.p2[0]==1)
			graph=551; 
			if(inercia>4 or inercia<-4) x+=inercia/3; end
			If(subiendo==1) graph=551; End
			anim=0;
			End
		If(p2_muere==1)
			If(p2_proteccion==1) 
				p2_proteccion=0;
				parpadeas=0;
//				suena(s12);
					l=(x*255)/800;
					snd_muere=play_wav(s12,0); 
					set_panning(snd_muere,255-l,l);
			Else
				If(parpadeas==120)
					If(cheto_diox==1 AND segundos>0)
					ready=0;
					parpadeo();
					suena(s4);
					grav=rand(50,250);
					While(y<464)
						If(ops.op_sombras==1) sombra(graph,x,y,flags,1); End
						If(flags==0) x+=12; End
						If(flags==1) x-=12; End
						If(x=>755) flags=1; End
						If(x=<45) flags=0; End
						If(grav>0) graph=558; End 
						If(grav<0) graph=559; End 
						grav-=5;
						y-=grav/10;
						l=(x*255)/800;
						set_panning(snd_muere,255-l,l);
						Frame;
					End
					y=462;
					ready=1;
					grav=0;
					itemreloj(3);
					p2_muere=0;
				Else
					Break;
				End	
				Else
					p2_muere=0;
				End
			End
		End
		hexo=0;
		If(parpadeas<120) flags+=4; End
		If(x>755) x=755; end
		If(x<45) x=45; end
		If(cheto_epilepsia==0) Frame; Else Frame(50); If(ops.op_sombras==1) sombra(graph,x,y,flags,1); End End
		If(parpadeas<120) parpadeas++; flags-=4; End
	End
	ready=0;
	vidap2fuera=1;
	parpadeo();
	timer[2]=0;
	While(timer[2]<50) Frame; End
	suena(s4);
	grav=rand(50,250);
	While(y<480)
		If(ops.op_sombras==1) sombra(graph,x,y,flags,1); End
		If(flags==0) x+=12; End
		If(flags==1) x-=12; End
		If(x=>755) flags=1; End
		If(x=<45) flags=0; End
		If(grav>0) graph=558; End
		If(grav<0) graph=559; End
		grav-=5;
		y-=grav/10;
		Frame;
	End
	suena(s5);
	p2_vidas--;
	p2_muere=3;
	If(players==3 AND p1_muere==0) ready=1; itemreloj(3); End
	signal(controller,s_kill_tree); raton=0;
End

Process dispcab(arma,x,y,num_disp);
Private
	cachos;
	cachos_y;
	y_keko;
	disparo;
	metralleta_x;
	graphcacho;
	distancia;
	cont_ganxo;
	toca;
Begin
	disparo=num_disp;
	z=2;
	y_keko=y+(graphic_info(father.file,father.graph,g_height)/2);
	y=y_keko-graphic_info(father.file,father.graph,g_height);
	graph=601;
	define_region(2,1,1,800,y_keko);
	If(p1_arma==1)
		suena(s1);
		While(!collision (Type grafico))
			If(ready==1) 
				y-=5; 
				If(animglobal<=15) graphcacho=602; End
				If(animglobal<=30 AND animglobal>15) graphcacho=603; End
				If(animglobal<45 and animglobal>30) graphcacho=607; End
				If(animglobal=>45) graphcacho=603; end
				if(y<0) break; end
			End
			cachos=((y_keko-y)+39)/39;
			While(cachos>0)
				cachos_y=y+39*(cachos+1);
				cachodisp(x,cachos_y-50,graphcacho);
				cachos--;
			End
			Frame;
		End
	End
	If(p1_arma==2)
		suena(s1);
		While(!collision (Type grafico) and y>0)
			If(ready==1) 
				y-=5; 
				If(animglobal<=15) graphcacho=602; End
				If(animglobal<=30 AND animglobal>15) graphcacho=603; End
				If(animglobal<45 and animglobal>30) graphcacho=607; End
				If(animglobal=>45) graphcacho=603; end
				if(y<0) break; end
			End
			cachos=((y_keko-y)+39)/39;
			While(cachos>0)
				cachos_y=y+39*(cachos+1);
				If(disparo==1) cachodisp(x,cachos_y-50,graphcacho); End
				If(disparo==2) cachodisp2(x,cachos_y-50,graphcacho); End
				cachos--;
			End
			Frame;
		End
	End
	If(p1_arma==3)
		suena(s1);
		While(!collision (Type grafico) AND !collision(Type bloques) and y>0)
			If(ready==1) y-=5; 
				if(y<0) break; end
			End
			cachos=(y_keko-y)/5;
			While(cachos>0)
				cachos_y=y+5*(cachos+1);
				cachodisp(x,cachos_y-5,graphcacho);
				cachos--;
			End
			graphcacho=608; 
			Frame;
		End
		suena(s7);
		While(cont_ganxo<3*efepeese)
			if(ready==1)
				If(botones.p1[4]==0) cont_ganxo++; Else cont_ganxo+=3; End
			end
			graph=609;
			cachos=(y_keko-y)/5;
			While(cachos>0)
				cachos_y=y+5*(cachos+1);
				cachodisp(x,cachos_y-5,graphcacho);
				cachos--;
			End
			If(cont_ganxo<2*efepeese) graphcacho=608; Else  graph=611; graphcacho=610; End
			if(y<0) break; end
			Frame;
		End
	End
	If(p1_arma==4)
		graph=borrar;
		y+=50;
		While(y>18)
			If(ready==1) y-=10; metralleta_x+=2; End
			cachos_y=y;
			cachodisp(x-(metralleta_x),cachos_y-43,604);
			cachodisp(x-(metralleta_x/2),cachos_y-43,605); 
			cachodisp(x+(metralleta_x/2),cachos_y-43,605); 
			cachodisp(x+(metralleta_x),cachos_y-43,606); 
			Frame;
		End
	End
	p1_disparos[1]=0;
End

Process dispcab2(arma,x,y,num_disp);
Private
	cachos;
	cachos_y;
	y_keko;
	disparo;
	metralleta_x;
	graphcacho;
Begin
	disparo=num_disp;
	z=2;
	y_keko=y+(graphic_info(father.file,father.graph,g_height)/2);
	y=y_keko-graphic_info(father.file,father.graph,g_height);
	define_region(3,1,1,800,y_keko);
	graph=601;       
	If(p1_arma==2)
		suena(s1);
		While(!collision (Type grafico) and y>0)
			If(ready==1) 
				y-=5; 
				If(animglobal<=15) graphcacho=602; End
				If(animglobal<=30 AND animglobal>15) graphcacho=603; End
				If(animglobal<45 and animglobal>30) graphcacho=607; End
				If(animglobal=>45) graphcacho=603; end
				if(y<0) break; end
			End
			cachos=((y_keko-y)+39)/39;
			While(cachos>0)
				cachos_y=y+39*(cachos+1);
				If(disparo==1) cachodisp(x,cachos_y-50,graphcacho); End
				If(disparo==2) cachodisp2(x,cachos_y-50,graphcacho); End
				cachos--;
			End
			Frame;
		End
	End
	If(p1_arma==4)
		graph=borrar;
		y+=50;
		While(y>18)
			If(ready==1) y-=10; metralleta_x+=2; End
			cachos_y=y;
			cachodisp2(x-(metralleta_x),cachos_y-43,604); 
			cachodisp2(x-(metralleta_x/2),cachos_y-43,605); 
			cachodisp2(x+(metralleta_x/2),cachos_y-43,605); 
			cachodisp2(x+(metralleta_x),cachos_y-43,606); 
			Frame;
		End
	End
	p1_disparos[2]=0;
End

Process cachodisp(x,y,graph);
Begin
	z=2;  
	region=2;   
	Frame;
End

Process cachodisp2(x,y,graph);
Begin
	z=2;      
	region=3;   
	Frame;
End

Process dispcab3(arma,x,y,num_disp);
Private
	cachos;
	cachos_y;
	y_keko;
	disparo;
	metralleta_x;
	graphcacho;
	distancia;
	cont_ganxo;
	toca;
Begin
	disparo=num_disp;
	z=2;
	y_keko=y+(graphic_info(father.file,father.graph,g_height)/2);
	y=y_keko-graphic_info(father.file,father.graph,g_height);
	define_region(4,1,1,800,y_keko);
	graph=612;
	If(p2_arma==1)
		suena(s1);
		While(!collision (Type grafico) and y>0)
			If(ready==1) 
				y-=5; 
				If(animglobal<=15) graphcacho=613; End
				If(animglobal<=30 AND animglobal>15) graphcacho=614; End
				If(animglobal<45 and animglobal>30) graphcacho=618; End
				If(animglobal=>45) graphcacho=614; end
				if(y<0) break; end
			End
			cachos=((y_keko-y)+39)/39;
			While(cachos>0)
				cachos_y=y+39*(cachos+1);
				cachodisp3(x,cachos_y-50,graphcacho);
				cachos--;
			End
			Frame;
		End
	End
	If(p2_arma==2)
		suena(s1);
		While(!collision (Type grafico) and y>0)
			If(ready==1) 
				y-=5; 
				If(animglobal<=15) graphcacho=613; End
				If(animglobal<=30 AND animglobal>15) graphcacho=614; End
				If(animglobal<45 and animglobal>30) graphcacho=618; End
				If(animglobal=>45) graphcacho=614; end
				if(y<0) break; end
			End
			cachos=((y_keko-y)+39)/39;
			While(cachos>0)
				cachos_y=y+39*(cachos+1);
				If(disparo==1) cachodisp3(x,cachos_y-50,graphcacho); End
				If(disparo==2) cachodisp4(x,cachos_y-50,graphcacho); End
				cachos--;
			End
			Frame;
		End
	End
	If(p2_arma==3)
		suena(s1);
		While(!collision (Type grafico) AND !collision(Type bloques) and y>0)
			If(ready==1) y-=5; End
			cachos=(y_keko-y)/5;
			While(cachos>0)
				cachos_y=y+5*(cachos+1);
				cachodisp3(x,cachos_y-5,graphcacho);
				cachos--;
			End
			graphcacho=619; 
			Frame;
		End
		suena(s7);
		While(cont_ganxo<3*efepeese)
			if(ready==1)
				If(botones.p2[4]==0) cont_ganxo++; Else cont_ganxo+=3; End
			end
			graph=620;
			If(cont_ganxo<2*efepeese) graphcacho=619; Else graph=622; graphcacho=621; End
			cachos=(y_keko-y)/5;
			While(cachos>0)
				cachos_y=y+5*(cachos+1);
				cachodisp(x,cachos_y-5,graphcacho);
				cachos--;
			End
			if(y<0) break; end
			Frame;
		End
	End
	If(p2_arma==4)
		graph=borrar;
		y+=50;
		While(y>18)
			If(ready==1) y-=10; metralleta_x+=2; End
			cachos_y=y;
			cachodisp3(x-(metralleta_x),cachos_y-43,615); 
			cachodisp3(x-(metralleta_x/2),cachos_y-43,616); 
			cachodisp3(x+(metralleta_x/2),cachos_y-43,616); 
			cachodisp3(x+(metralleta_x),cachos_y-43,617); 
			Frame;
		End
	End
	p2_disparos[1]=0;
End

Process dispcab4(arma,x,y,num_disp);
Private
	cachos;
	cachos_y;
	y_keko;
	disparo;
	metralleta_x;
	graphcacho;
Begin
	disparo=num_disp;
	z=2;
	y_keko=y+(graphic_info(father.file,father.graph,g_height)/2);
	y=y_keko-graphic_info(father.file,father.graph,g_height);
	define_region(5,1,1,800,y_keko);
	graph=612;
	If(p2_arma==2)
		suena(s1);
		While(!collision (Type grafico) and y>0)
			If(ready==1) 
				y-=5; 
				If(animglobal<=15) graphcacho=613; End
				If(animglobal<=30 AND animglobal>15) graphcacho=614; End
				If(animglobal<45 and animglobal>30) graphcacho=618; End
				If(animglobal=>45) graphcacho=614; end
				if(y<0) break; end
			End
			cachos=((y_keko-y)+39)/39;
			While(cachos>0)
				cachos_y=y+39*(cachos+1);
				If(disparo==1) cachodisp3(x,cachos_y-50,graphcacho); End
				If(disparo==2) cachodisp4(x,cachos_y-50,graphcacho); End
				cachos--;
			End
			Frame;
		End
	End
	If(p2_arma==4)
		graph=borrar;
		y+=50;
		While(y>18 and y>0)
			If(ready==1) y-=10; metralleta_x+=2; End
			cachos_y=y;
			cachodisp4(x-(metralleta_x),cachos_y-43,615);
			cachodisp4(x-(metralleta_x/2),cachos_y-43,616); 
			cachodisp4(x+(metralleta_x/2),cachos_y-43,616); 
			cachodisp4(x+(metralleta_x),cachos_y-43,617); 
			Frame;
		End
	End
	p2_disparos[2]=0;
End

Process cachodisp3(x,y,graph);
Begin
	z=2;
	region=4;
	Frame;
End

Process cachodisp4(x,y,graph);
Begin
	z=2;
	region=5;
	Frame;
End


Process bola(x,y,tamano,lao); //tamano 1:pekeña 2:medio-pekeña 3:medio-grande 4:grande
Private
	grav;
	grav_org;
	ancho_bola;
	altura_bola;
	ancho_bloque;
	alto_bloque;
	id_disp;
	rota;
	toca;                    
	peq_izq;       
	contator;
	asdrugol;
	varibiliosa;
	mutante;
	viejunidad;
	matando;
Begin        
    While(exists(id_bolas[contator]))
        contator++;
    End
    id_bolas[contator]=id;
	zbolas--;
	z=zbolas;
	bolas++;
	If(tamano==1) If(lao==1 AND modo_juego==1) peq_izq=1; End graph=701; grav_org=100; End //normal
	If(tamano==2) graph=702; grav_org=120; End
	If(tamano==3) graph=703; grav_org=140; End
	If(tamano==4) graph=704; grav_org=160; End 
	If(tamano==5) graph=705; grav_org=180; End
	If(tamano==6) If(lao==1 AND modo_juego==1) peq_izq=1; End graph=711; grav_org=160; End //verde
	If(tamano==7) graph=713; grav_org=180; End
	If(tamano==8) graph=715; grav_org=200; End
	If(tamano==9) graph=716; grav_org=220; End
	If(tamano==10) If(lao==1 AND modo_juego==1) peq_izq=1; End graph=801; size=33; grav_org=0; grav=1; End //rotativa
	If(tamano==11) graph=801; size=66; grav_org=0; grav=1; End
	If(tamano==12) graph=801; size=100; grav_org=0; grav=1; End
	If(tamano==13) If(lao==1 AND modo_juego==1) peq_izq=1; End graph=717; grav_org=255; End //bota al revés
	If(tamano==14) graph=718; grav_org=220; End
	If(tamano==15) graph=719; grav_org=210; End
	If(tamano==16) graph=720; grav_org=200; End
	If(tamano==17) graph=721; bola_estrella=1; grav_org=180; End //bola estrella
	//tamano 18 reservado para bola estrella!
	If(tamano==19) graph=723; grav_org=180; End //bola perseguidora
	if(tamano==20) graph=724; grav_org=120; end //bola estática verticalmente
	if(tamano==21) graph=725; grav_org=120; end //bota estática y bota normal...
	if(tamano==22) mutante=1; tamano=1; If(lao==1 AND modo_juego==1) peq_izq=1; End graph=701; grav_org=100; end
	if(cheto_borracho==1) size=rand(20,200); end
	ancho_bola=graphic_info(0,graph,g_wide);
	altura_bola=graphic_info(0,graph,g_height);
	If((tamano==5 OR tamano==9 OR tamano==12 OR tamano==16 or tamano==17 or tamano==19 or tamano==20 or tamano==21) AND (modo_juego==1 OR modo_juego==-1)) 
		y=(0-altura_bola);
		While(y<0+(altura_bola/2) AND matabolas==0)
			if(ready) y+=1; end
			Frame;
		End
	End
	if(modo_juego==2 and ops.op_sombras==1 and ready==0)
		from alpha=0 to 255 step 2; frame; end
	end
	alpha=255;
	Repeat
		if(cheto_viejuno and modo_juego==1)
			if(viejunidad<200) viejunidad++; else
				viejunidad=0;
				if(tamano!=5 and tamano!=9 and tamano!=12 and tamano!=16 and tamano!=18 and tamano!=21 and tamano!=22) 
					tamano++;
					suena(s3);
					If(tamano==1) If(lao==1 AND modo_juego==1) peq_izq=1; End graph=701; grav_org=100; End //normal
					If(tamano==2) graph=702; grav_org=120; End
					If(tamano==3) graph=703; grav_org=140; End
					If(tamano==4) graph=704; grav_org=160; End 
					If(tamano==5) graph=705; grav_org=180; End
					If(tamano==6) If(lao==1 AND modo_juego==1) peq_izq=1; End graph=711; grav_org=160; End //verde
					If(tamano==7) graph=713; grav_org=180; End
					If(tamano==8) graph=715; grav_org=200; End
					If(tamano==9) graph=716; grav_org=220; End
					If(tamano==10) If(lao==1 AND modo_juego==1) peq_izq=1; End graph=801; size=33; grav_org=0; grav=1; End //rotativa
					If(tamano==11) graph=801; size=66; grav_org=0; grav=1; End
					If(tamano==12) graph=801; size=100; grav_org=0; grav=1; End
					If(tamano==13) If(lao==1 AND modo_juego==1) peq_izq=1; End graph=717; grav_org=255; End //bota al revés
					If(tamano==14) graph=718; grav_org=220; End
					If(tamano==15) graph=719; grav_org=210; End
					If(tamano==16) graph=720; grav_org=200; End
					If(tamano==17) graph=721; bola_estrella=1; grav_org=180; End //bola estrella
					//tamano 18 reservado para bola estrella!
					If(tamano==19) graph=723; grav_org=180; End //bola perseguidora
					if(tamano==20) graph=724; grav_org=120; end //bola estática verticalmente
					if(tamano==21) graph=725; grav_org=120; end //bota estática y bota normal...
					if(tamano==22) mutante=1; tamano=1; If(lao==1 AND modo_juego==1) peq_izq=1; End graph=701; grav_org=100; end
				end
			end
		end
		If(ops.op_sombras==1 AND grav_org>0) sombra(graph,x,y,flags,1); End
		While(ready==0) 
			Frame;
		End
		If(parpadea==1) If(flags==0) flags=4; Else flags=0; End End
		If(dinamita==1 AND tamano>1 AND tamano!=6 AND tamano!=10 and tamano!=13 and tamano!=17and tamano!=18 and tamano!=19 and tamano!=20 and tamano!=21) Frame(velocidad); Break; End
		If(reloj==0 AND grav_org==0)
			flags=0;
			angle+=1000;
			If(toca=collision(Type bloques))
				If(toca.graph!=429)
					ancho_bloque=graphic_info(0,toca.graph,g_wide);
					alto_bloque=graphic_info(0,toca.graph,g_height);
					If((toca.x+(ancho_bloque/100*size/2))<x) lao=0; End
					If((toca.x-(ancho_bloque/100*size/2))>x) lao=1; End
					If((toca.y-(alto_bloque/100*size/2))>y) grav=1; End
					If((toca.y+alto_bloque/100*size/2)<y) grav=0; End
					if(mutante==1) mutante=2; end
				End
			End        
			If(lao==0) x+=3; End
			If(lao==1) x-=3; End
			If(grav==1) y-=3; End
			If(grav==0) y+=3; End
			If(animglobal<60) graph=802; End
			If(animglobal<45) graph=801; End
			If(animglobal<30) graph=802; End
			If(animglobal<15) graph=801; End
			If(x=>800-18-(ancho_bola/2)) lao=1; End
			If(x=<(((ancho_bola)/2))+18) lao=0; End
			If(y>(500-(altura_bola/2))) grav=1; if(mutante==1) mutante=2; end End
			If(y<(18+(altura_bola/2))) grav=0; End
			If((collision(Type muneco1) OR collision(Type personaje_demo1)) and p1_estrella==0) if(matando==5) p1_muere=1; If(p1_proteccion==1) Break; End matando=0; else matando++; end End
			If((collision(Type muneco2) OR collision(Type personaje_demo2)) and p2_estrella==0) if(matando==5) p2_muere=1; If(p2_proteccion==1) Break; End matando=0; else matando++; end End
			If((!collision(Type muneco1)) and (!collision(Type personaje_demo1)) and (!collision(Type muneco2)) and (!collision(Type personaje_demo2))) matando=0; End
			If(collision(type muneco1) and p1_estrella) p1_bolas++; break; end
			If(collision(type muneco2) and p2_estrella) p2_bolas++; break; end
			If(collision(Type cocodrilo) OR collision(Type volador)) Break; End
			If(peq_izq==1 and jefe==0) If(flags==4) flags=0; Else flags=4; End End
		End
		If(reloj==0 AND grav_org>0 and tamano<13 or tamano==17 or tamano==18 or tamano==19 or tamano==20 or tamano==21)
			flags=0;
			If(toca=collision(Type bloques))
				If(toca.graph!=429)
					if(mutante==1) mutante=2; end
					ancho_bloque=graphic_info(0,toca.graph,g_wide);
					alto_bloque=graphic_info(0,toca.graph,g_height);
					If((toca.x+(ancho_bloque/2))<x) lao=0; End
					If((toca.x-(ancho_bloque/2))>x) lao=1; End
					If((toca.y-(alto_bloque/2))>y) 
						if(((500-y)/80)!=0) 
							grav=grav_org/((500-y)/80);
						else 
							grav=grav_org; 
						end 
					End
					If((toca.y+alto_bloque/2)<y) 
						grav=0-grav_org;
						if(tamano==21)
							if(varibiliosa==0) varibiliosa=1; else varibiliosa=0; end
						end
						if(tamano==19)
							if(exists(id_p1) and exists(id_p2))
								if(get_dist(id_p1)>get_dist(id_p2))
									if(id_p1.x<x) lao=1; else lao=0; end
								else
									if(id_p2.x<x) lao=1; else lao=0; end
								end
							end
							if(exists(id_p1) and !exists(id_p2))
								if(id_p1.x<x) lao=1; else lao=0; end
							end
							if(exists(id_p2) and !exists(id_p1))
								if(id_p2.x<x) lao=1; else lao=0; end
							end
						end
					End
				End
			End        
			if(cheto_choca) If(toca=collision(Type bola))
				ancho_bloque=graphic_info(0,toca.graph,g_wide);
				alto_bloque=graphic_info(0,toca.graph,g_height);
				If((toca.x+(ancho_bloque/2))<x) lao=0; End
				If((toca.x-(ancho_bloque/2))>x) lao=1; End
				If((toca.y-(alto_bloque/2))>y) 
					if(((500-y)/80)!=0) 
						grav=grav_org/((500-y)/80);
					else 
						grav=grav_org; 
					end 
				End
				If((toca.y+alto_bloque/2)<y) 
					grav=0-grav_org;
					if(tamano==21)
						if(varibiliosa==0) varibiliosa=1; else varibiliosa=0; end
					end
				End
			End        
			End //cheto choca

			If(lao==0 and tamano!=20 and varibiliosa==0) x+=3; End
			If(lao==1 and tamano!=20 and varibiliosa==0) x-=3; End
			If(x=>800-18-(ancho_bola/2)) x=800-18-(ancho_bola/2); lao=1; End
			If(x=<(((ancho_bola)/2))+18) x=(((ancho_bola)/2))+18; lao=0; End
			if(asdrugol<10) asdrugol++; end
			If(y>(500-(altura_bola/2)) and asdrugol==10) 
				if(mutante==1) mutante=2; end
				asdrugol=0; 
				if(tamano==17) tamano=18; graph=722; else if(tamano==18) tamano=17; graph=721; end end 
				grav=grav_org; 
				if(tamano==19)
					if(exists(id_p1) and exists(id_p2))
						if(get_dist(id_p1)>get_dist(id_p2))
							if(id_p1.x<x) lao=1; else lao=0; end
						else
							if(id_p2.x<x) lao=1; else lao=0; end
						end
					end
					if(exists(id_p1) and !exists(id_p2))
						if(id_p1.x<x) lao=1; else lao=0; end
					end
					if(exists(id_p2) and !exists(id_p1))
					if(id_p2.x<x) lao=1; else lao=0; end
					end
				end
				if(tamano==21)
					if(varibiliosa==0) varibiliosa=1; else varibiliosa=0; end
				end

			End
			grav-=5;
			y-=3+(grav/20);
			If((collision(Type muneco1) OR collision(Type personaje_demo1)) and p1_estrella==0) if(matando==5) p1_muere=1; If(p1_proteccion==1) Break; End matando=0; else matando++; end End
			If((collision(Type muneco2) OR collision(Type personaje_demo2)) and p2_estrella==0) if(matando==5) p2_muere=1; If(p2_proteccion==1) Break; End matando=0; else matando++; end End
			If((!collision(Type muneco1)) and (!collision(Type personaje_demo1)) and (!collision(Type muneco2)) and (!collision(Type personaje_demo2))) matando=0; End
			If(collision(type muneco1) and p1_estrella) p1_bolas++; break; end
			If(collision(type muneco2) and p2_estrella) p2_bolas++; break; end
			If(collision(Type cocodrilo) OR collision(Type volador)) Break; End
			If(peq_izq==1 and jefe==0) If(flags==4) flags=0; Else flags=4; End End
		End      
		If(reloj==0 AND grav_org>0 and tamano>12 and tamano<17)
			flags=0;
			If(toca=collision(Type bloques))
				If(toca.graph!=429)
					if(mutante==1) mutante=2; end
					ancho_bloque=graphic_info(0,toca.graph,g_wide);
					alto_bloque=graphic_info(0,toca.graph,g_height);
					If((toca.x+(ancho_bloque/2))<x) lao=0; End
					If((toca.x-(ancho_bloque/2))>x) lao=1; End
					If((toca.y-(alto_bloque/2))>y) if(((16+y)/80)!=0) grav=grav_org/((16+y)/80); else grav=grav_org; end End
					If((toca.y+alto_bloque/2)<y) grav=0-grav_org; End
				End
			End        
			If(lao==0) x+=3; End
			If(lao==1) x-=3; End
			If(x=>800-18-(ancho_bola/2)) lao=1; End
			If(x=<(((ancho_bola)/2))+18) lao=0; End
			If(y<(16+(altura_bola/2))) grav=grav_org; if(mutante==1) mutante=2; end End
			grav-=5;
			y+=3+(grav/20);
			angle+=6000;
			If((collision(Type muneco1) OR collision(Type personaje_demo1)) and p1_estrella==0) if(matando==5) p1_muere=1; If(p1_proteccion==1) Break; End matando=0; else matando++; end End
			If((collision(Type muneco2) OR collision(Type personaje_demo2)) and p2_estrella==0) if(matando==5) p2_muere=1; If(p2_proteccion==1) Break; End matando=0; else matando++; end End
			If((!collision(Type muneco1)) and (!collision(Type personaje_demo1)) and (!collision(Type muneco2)) and (!collision(Type personaje_demo2))) matando=0; End
			If(collision(type muneco1) and p1_estrella) p1_bolas++; break; end
			If(collision(type muneco2) and p2_estrella) p2_bolas++; break; end
			If(collision(Type cocodrilo) OR collision(Type volador)) Break; End
			If(peq_izq==1 and jefe==0) If(flags==4) flags=0; Else flags=4; End End
		End
		if(mutante==2)
			if(tamano<20) tamano++; else tamano=1; end
			grav=0;
			grav_org=0;
			ancho_bola=0;
			altura_bola=0;
			ancho_bloque=0;
			alto_bloque=0;
			id_disp=0;
			rota=0;
			toca=0;                    
			peq_izq=0;       
			contator=0;
			varibiliosa=0;
			If(tamano==1) If(lao==1 AND modo_juego==1) peq_izq=1; End graph=701; grav_org=100; End //normal
			If(tamano>1 and tamano<6) tamano=6; End
			If(tamano==6) If(lao==1 AND modo_juego==1) peq_izq=1; End graph=711; grav_org=160; End //verde
			If(tamano>6 and tamano<19) tamano=19; End
			If(tamano==19) graph=723; grav_org=180; End //bola perseguidora
			if(tamano==20) graph=724; grav_org=120; end //bola estática verticalmente
			grav=grav_org;
			if(cheto_borracho==1) size=rand(20,200); end
			ancho_bola=graphic_info(0,graph,g_wide);
			altura_bola=graphic_info(0,graph,g_height);
			mutante=1;
		end
		if(y<20) y=20; end
			if(tamano!=19) Frame(velocidad/2); else frame(velocidad/3); end
	Until((id_disp=collision(Type cachodisp)) OR (id_disp=collision(Type cachodisp2)) OR (id_disp=collision(Type dispcab) OR (id_disp=collision(Type dispcab2)) OR (id_disp=collision(Type cachodisp3)) OR (id_disp=collision(Type cachodisp4)) OR (id_disp=collision(Type dispcab3)) OR (id_disp=collision(Type dispcab4)) OR matabolas==1 OR rota==1))
	If(peq_izq==1 and matabolas==0 and jefe==0) if(reloj==0) itemreloj(1); else secs+=60; end End
	If((collision(Type cachodisp) OR collision(Type dispcab)) AND (collision(Type cachodisp2) OR collision(Type dispcab2)))
		signal(p1_disparos[1],s_kill); p1_disparos[1]=0; signal(p1_disparos[2],s_kill); p1_disparos[2]=0; 
		If(players==1 OR players==3) p1_bonus+=100; p1_puntos+=500; End
		p1_bolas++; 
		if(tamano==17) p1_bolas+=20; end
	End
	If(collision(Type cachodisp) OR collision(Type dispcab) OR collision(Type cachodisp2) OR collision(Type dispcab2))
		If(p1_arma==4) signal(id_disp,s_kill); End
		If(collision(Type cachodisp) OR collision(Type dispcab)) signal(p1_disparos[1],s_kill); p1_disparos[1]=0; End
		If(collision(Type cachodisp2) OR collision(Type dispcab2)) signal(p1_disparos[2],s_kill); p1_disparos[2]=0;  End
		If(players==1 OR players==3) p1_bonus+=100; p1_puntos+=500; End
		p1_bolas++; 
		if(tamano==17) p1_bolas+=20; end
	End
	If((collision(Type cachodisp3) OR collision(Type dispcab3)) AND (collision(Type cachodisp4) OR collision(Type dispcab4)))
		signal(p2_disparos[1],s_kill); p2_disparos[1]=0; signal(p2_disparos[2],s_kill); p2_disparos[2]=0; 
		If(players==2 OR players==3) p2_bonus+=100; p2_puntos+=500; End
		p2_bolas++; 	
		if(tamano==17) p2_bolas+=20; end
	End
	If(collision(Type cachodisp3) OR collision(Type dispcab3) OR collision(Type cachodisp4) OR collision(Type dispcab4))
		If(p2_arma==4) signal(id_disp,s_kill); End
		If(collision(Type cachodisp3) OR collision(Type dispcab3)) signal(p2_disparos[1],s_kill); p2_disparos[1]=0; End
		If(collision(Type cachodisp4) OR collision(Type dispcab4)) signal(p2_disparos[2],s_kill); p2_disparos[2]=0; End
		If(players==2 OR players==3) p2_bonus+=100; p2_puntos+=500; End
		p2_bolas++; 
		if(tamano==17) p2_bolas+=20; end
	End
	If(tamano!=1 AND tamano!=6 AND tamano!=10 and tamano!=13 and tamano!=17 and tamano!=18 and tamano!=19 and tamano!=20 and tamano!=21 and tamano!=22) if(cheto_borracho==0 or matabolas==1 or dinamita==1) bola(x-(ancho_bola/4),y,tamano-1,1); bola(x+(ancho_bola/4),y,tamano-1,0); else if(rand(0,3)==0 and tamano<17) bola(x-(ancho_bola/4),y,tamano,1); bola(x+(ancho_bola/4),y,tamano,0); else bola(x-(ancho_bola/4),y,tamano-1,1); bola(x+(ancho_bola/4),y,tamano-1,0); End End End
	If(tamano==1 OR tamano==6 OR tamano==10 or tamano==13) size=0; End
	From graph=706 To 710; Frame(200); End
	suena(s2);
	bolas--;
	if(tamano==17) bola_estrella=0; if(primerapartida==0) matabolas=1; frame(6000); matabolas=0; end end
	if(tamano==18) bola_estrella=0; if(primerapartida==0) itemreloj(10); end end
	If(tamano!=1 AND tamano!=6 and tamano!=10 and tamano!=13 AND modo_juego==2 and primerapartida==0) If(rand(0,10)<3) items(x,y,rand(0,9)); End End
End

Process marcadores();
Begin
	Set_text_color(color_texto[0]);
	If(modo_juego==2) 
		grafico(350,539,403,-1,0,fpg_lang); 
		Set_text_color(color_texto[0]);
		write(fnt1,400,550,2,Textos[53]);
		Set_text_color(color_texto[0]);
		write(fnt1,430,550,0,itoa(mundo+1));
	End
	If(players==1) vidasp1();
	    If(modo_juego==2) armap1(); grafico(234,560,402,-1,0,0); End
	    If(modo_juego!=3) grafico(666,560,404,-1,1,fpg_lang); End if(torneo==0) write(0,100,520,0,TExtos[0]); write_int(0,115,528,0,OFFSET p1_puntos); else write(fnt1,0,0,0,TExtos[0]); write_int(fnt1,0,50,0,OFFSET p1_puntos); End end
	If(players==2) vidasp2();
	    If(modo_juego==2) armap2(); grafico(566,560,402,-1,0,0); End
	    grafico(134,560,404,-1,1,fpg_lang); write(0,700,520,2,TExtos[1]); write_int(0,660,528,2,OFFSET p2_puntos); End
	If(players==3) vidasp1(); vidasp2();
	    If(modo_juego==2) armap1(); armap2(); grafico(234,560,402,-1,0,0); grafico(566,560,402,-1,0,0); End
	    write(0,100,520,0,TExtos[0]); write_int(0,115,528,0,OFFSET p1_puntos); write(0,700,520,2,TExtos[1]); write_int(0,660,528,2,OFFSET p2_puntos); End
	escenario();
End

Process grafico(x,y,graph,z,parpadeo,file);
Private
	exgraph;
Begin
	exgraph=graph;
	Loop
		if(ops.op_sombras==0)
			If(parpadeo==1) If(graph==exgraph) graph=borrar; Else graph=exgraph; End End
		else
			if(parpadeo==1) 
				graph=exgraph;
				from alpha=255 to 0 step -3; frame; end
				from alpha=0 to 255 step 3; frame; end
			end
		end
	Frame(2000);
	End
End

Process escenario();
Begin
	x=400;
	y=300;
	grafico(400,559,7,1,0,0);
	If(modo_juego==1 OR modo_juego==-1) 
		grafico(400,300,2,2,0,0);
	    If(modo_juego==1) barra_nivel(); End
	End
	If(modo_juego==2) 
		grafico(400,300,1,2,0,0);
	End
	If(modo_juego==3)
		grafico(401,15,4,2,0,0);
		grafico(401,502,6,2,0,0);
	End		
	Loop
		Frame;
	End
End

Process barra_nivel();
Private
   energia=0;
Begin
   graph=444;
   // Se asignan las coordenadas
   x=305; y=575; z=0;
   grafico(400,540,442,0,0,fpg_lang);
   grafico(400,575,443,-1,0,0);
   Loop
      energia=((p1_bolas+p2_bolas)-((cont-1)*50));
      size_x=energia*2;
	if(size_x>100) size_x=100; end
      Frame;
   End
End

Process musica(cancion);
Private
    cargada;
    String numerito;
	int numerete;
Begin
	If(is_playing_song()) stop_song(); End
	If(is_playing_cd()) stop_cd(); End
// nota para el señor programador, osea yop: esto es un **** lío
// cuando puedas bórralo todo y hazlo tal como se usa ahora!
	If((cancion=>1 AND cancion=<4) AND ops.cd_audio==1 AND cd_fallido==0)
		If(ops.op_music)
        		If(cancion=>1 AND cancion=<4)
					numerete=mundo+1;
					if(numerete==1 and modo_juego==1) numerete=rand(1,13); end
					while(numerete>13) numerete-=13; end
					play_cd(numerete,0); 
					If(is_playing_cd()==0) cd_fallido=1; musica(cancion); End
        		End
        End
		Frame;
	Else
		If(cancion>-1) stop_song();  unload_song(cargada); End
		numerete=mundo+1;
		if(numerete==1 and modo_juego==1) numerete=rand(1,13); end
		while(numerete>13) numerete-=13; end
		numerito=itoa(numerete);
		If(cancion==0) cargada=load_song("./cd-ogg/23.ogg"); End
        	//
		//If(cancion=>1 AND cancion=<4) cargada=load_song("./cd-ogg/"+numerito+".ogg"); End
		numerete=mundo;
		while(numerete>2) numerete-=3; end
		If(cancion=>1 AND cancion=<4) 
			switch(numerete) 
				case 0:
					cargada=load_song("./cd-ogg/23.ogg"); 
				end
				case 1: 
					cargada=load_song("./cd-ogg/pang2.ogg"); 
				end 
				case 2: 
					cargada=load_song("./cd-ogg/pang3.ogg"); 
				end 
			End
		end
		// no hay mucha música oficial por ahora...
		
		If(cancion==5) cargada=load_song("./cd-ogg/menu.ogg"); End
		If(cancion==6) cargada=load_song("./cd-ogg/20.ogg"); End
    	    If(cancion==7) //prisa!
//        	    If(modo_juego==2) cargada=load_song("./cd-ogg/17.ogg"); End //tour
//	            If(modo_juego==1 OR modo_juego==3) cargada=load_song("./cd-ogg/24.ogg"); End //panic y safari!
			cargada=load_song("./cd-ogg/24.ogg");
	        End
	    If(cancion==8) cargada=load_song("./cd-ogg/18.ogg"); End
	    If(cancion==9) cargada=load_song("./cd-ogg/19.ogg"); End
	    If(cancion==10) cargada=load_song("./cd-ogg/intro.ogg"); End
	    If(cancion==-1)
		    fade_music_off(250);
		    Return;
	    End
	    If(ops.op_music==1)
	        If(cancion!=6 AND cancion!=8)
	            play_song(cargada,999);
	        Else
	            play_song(cargada,0);
	        End
	    End
	If(cd_fallido==1) cd_fallido=0; End
    	Frame;
	End
End

Process vidasp1();
Private
	escrito;
Begin
	if(classic==0)
	    vidap1(921);
		Loop
			If(p1_vidas>99) p1_vidas=99; End
			If(p1_muere=>3) p1_muere++; End
			If(p1_muere=>35) p1_muere=2; Break; End
			If(escrito==0) escrito=1; Set_text_color(color_texto[0]); write(fnt2,106,548,0,"x"); write_int(fnt2,136,548,0,OFFSET p1_vidas); End
			z=-1;
			Frame;
		End
	else
		loop
			If(p1_muere=>3) p1_muere++; End
			If(p1_muere=>35) p1_muere=2; Break; End
			If(p1_vidas==1) vidap1(1); End
			If(p1_vidas==2) vidap1(1); vidap1(2); End
			If(p1_vidas==3) vidap1(1); vidap1(2); vidap1(3); End
			If(p1_vidas=>4) vidap1(1); vidap1(2); vidap1(3); vidap1(3); 
			If(escrito==0) escrito=1; write_int(0,136,578,0,OFFSET p1_vidas); End End
			z=-1;
			Frame;
		End
	end
End

Process vidap1(vidan);
Begin
	If(classic==0)
		file=file_muneco1;
		z=-3;
		y=550;
		x=-50;
		vidap1fuera=0;
		graph=vidan;
		While(vidap1fuera==0)
			If(x<50) x+=2; Frame; End
			Frame;
		End
		While(x>-50) x-=2; Frame; End
		Frame;
	else
		y=579;
		x=52;
		graph=401;
		If(vidan==1) x=52; End
		If(vidan==2) x=85; End
		If(vidan==3) x=119; End
		If(ganando==1)
			If(animglobal<15) flags=0; graph=401; End
			If(animglobal=>15 AND animglobal<30) graph=405; flags=1; End
			If(animglobal=>30 AND animglobal<45) graph=401; flags=0; End
			If(animglobal=>45 AND animglobal<60) graph=405; flags=0; End
		End
		If(p1_muere=>3)
			If(p1_muere=<12) graph=416; End
			If(p1_muere=>12 AND p1_muere<24) graph=417; End
			If(p1_muere=>24) graph=418; End
		End
		Frame;
	end
End

Process vidasp2();
Private
	escrito;
Begin
        If(classic==0)
	    If(modo_juego==1) if(jefe!=0) vidap2(0); else vidap2(922); End end
	    If(modo_juego==2) vidap2(922); End
	    If(modo_juego==3) vidap2(924); End
	    Loop
		    If(p2_vidas>99) p2_vidas=99; End
		    If(p2_muere=>3) p2_muere++; End
		    If(p2_muere=>35) p2_muere=2; Break; End
		    If(escrito==0) escrito=1; Set_text_color(color_texto[0]); write(fnt2,694,548,2,"x");
		        If(modo_juego!=3) Set_text_color(color_texto[0]); write_int(fnt2,664,548,2,OFFSET p2_vidas); Else Set_text_color(color_texto[0]); write_int(fnt2,664,548,2,OFFSET contaor); End
		    End
		    z=-1;
		    Frame;
	    End
	else
		Loop
			If(p2_muere=>3) p2_muere++; End
			If(p2_muere=>35) p2_muere=2; Break; End
			If(p2_vidas==1) vidap2(1); End
			If(p2_vidas==2) vidap2(1); vidap2(2); End
			If(p2_vidas==3) vidap2(1); vidap2(2); vidap2(3); End
			If(p2_vidas=>4) vidap2(1); vidap2(2); vidap2(3); vidap2(3); 
				If(escrito==0) escrito=1; write_int(0,664,578,2,OFFSET p2_vidas); End
			End
			z=-1;
			Frame;
		End
	end
End

Process vidajefe();
Private
	escrito;
	id_textuales[1];
Begin
    vidajefe2();
    Set_text_color(color_texto[0]); id_textuales[0]=write(fnt2,694,48,2,"x");
    Set_text_color(color_texto[0]); id_textuales[1]=write_int(fnt2,664,48,2,OFFSET contaor);
    While(!vidajefefuera)
	Frame;
    End
    delete_text(id_textuales[0]);
    delete_text(id_textuales[1]);
End

Process vidajefe2();
Begin
	file=fpg_jefe;
	graph=100;
	z=-3;
	y=50;
	x=850;
	vidap2fuera=0;
	While(!vidajefefuera)
		If(x>750) x-=2; Frame; End
		Frame;
	End
	While(x<850) x+=2; Frame; End
	Frame;
End

Process vidap2(vidan);
Begin
	If(classic==0) 
		if(vidan!=0)
			file=file_muneco2;
			graph=vidan;
		else
			file=fpg_jefe;
			graph=100;
		end
		z=-3;
		y=550;
		x=850;
		vidap2fuera=0;
		While(vidap2fuera==0)
			If(x>750) x-=2; Frame; End
			Frame;
		End
		While(x<850) x+=2; Frame; End
		Frame;
	else
		y=579;
		x=748;
		graph=400;
		If(vidan==1) x=748; End
		If(vidan==2) x=715; End
		If(vidan==3) x=681; End
		If(ganando==1)
			If(animglobal<15) flags=0; graph=400; End
			If(animglobal=>15 AND animglobal<30) graph=441; flags=1; End
			If(animglobal=>30 AND animglobal<45) graph=400; flags=0; End
			If(animglobal=>45 AND animglobal<60) graph=441; flags=0; End
		End
		If(p2_muere=>3)
			If(p2_muere=<12) graph=438; End
			If(p2_muere=>12 AND p2_muere<24) graph=439; End
			If(p2_muere=>24) graph=440; End
		End
		Frame;
	end
End

Process anim_global();
Begin
	Loop
		If(animglobal<60) animglobal++;
			Else animglobal=0;
		End
		Frame;
	End
End

Process carga_sonidos();
Begin
    s1=load_wav("./wav/s001.wav");
    s2=load_wav("./wav/s002.wav");
    s3=load_wav("./wav/s003.wav");
    s4=load_wav("./wav/s004.wav");
    s5=load_wav("./wav/s005.wav");
    s6=load_wav("./wav/s006.wav");
    s7=load_wav("./wav/s007.wav");
    s8=load_wav("./wav/s008.wav");
    s9=load_wav("./wav/s009.wav");
    s10=load_wav("./wav/s010.wav");
    s11=load_wav("./wav/s011.wav");
    s12=load_wav("./wav/s012.wav");
    s13=load_wav("./wav/s013.wav");
    s14=load_wav("./wav/s014.wav");
    s15=load_wav("./wav/s015.wav");
    Frame;
End

Process suena(sonido);
Private
	l;
	id_sonido;
Begin
    If(ops.op_sonido==1)
	l=(father.x*255)/800;
	id_sonido=play_wav(sonido,0); 
	set_panning(id_sonido,255-l,l);
	Frame;
    End
End

Process tiempo(segs);
Begin
	If(segs==-1) Return; End
	segs=segs*efepeese;
	Set_text_color(color_texto[0]); write_int(fnt2,460,539,4,OFFSET segundos);
	Loop
		If(ready==1 AND reloj==0) segs--; End
		If(ready==0) End
		segundos=segs/efepeese;
		Frame;
		If(segundos<21 AND prisa==0) prisa=1; hayprisa(); End
		If(segs<10 AND (p1_muere==0 OR p2_muere==0)) p1_muere=1; p2_muere=1; ready=0; End
	End
End

Process hayprisa();
Begin
	if(jefe==0) musica(7); end
	if(modo_juego==1 and jefe==0 and bola_estrella==0) bola(rand(60,740),0,17,rand(0,1)); end
	If(modo_juego==2) grafico(350,539,103,-2,0,fpg_lang); End
End

Process armap1(); //1=normal, 2=2 tiros, 3=gancho, 4=metralleta
Begin
	x=234;
	y=560;
	z=-2;
	Loop
		If(p1_arma==1) 
			graph=borrar;
		End
		If(p1_arma==2)
			graph=411;
		End
		If(p1_arma==3)
			graph=412;
		End
		If(p1_arma==4)
			graph=413;
		End
		Frame;
	End
End

Process armap2(); //1=normal, 2=2 tiros, 3=gancho, 4=metralleta
Begin
	x=566;
	y=560;
	z=-2;
	Loop
		If(p2_arma==1) 
			graph=borrar;
		End
		If(p2_arma==2)
			graph=411;
		End
		If(p2_arma==3)
			graph=412;
		End
		If(p2_arma==4)
			graph=413;
		End
		Frame;
	End
End

Process itemreloj(eltiempo);
Private
	segundox;
	rolex;
Begin
	if(p1_estrella or p2_estrella) return; end
	secs=eltiempo;
	suena(s9);
	secs=secs*efepeese;
	Set_text_color(color_texto[0]); 
	While(secs=>1)
		reloj=1;
		if(p1_estrella or p2_estrella) secs=1; parpadea=0; end
		rolex=write(fnt1,400,200,4,textos[3]+itoa(segundox)+textos[5]);
		If(ready==1) 
			secs--;
		else			while(ready==0) frame; end
			Set_text_color(color_texto[0]); 
		End
		segundox=secs/efepeese;
		If(segundox<2) parpadea=1; End
		Frame;
		delete_text(rolex); 
	End
	reloj=0; parpadea=0;
	delete_text(rolex); 
End


Process proteccion(num_muneco);
Private
	rolling;
	algo;
Begin
	if(num_muneco==1) graph=514; else graph=515; end
	while((p1_proteccion and num_muneco==1) or (p2_proteccion and num_muneco==2))
		if(num_muneco==1)
			x=id_p1.x;
			y=id_p1.y+10;
			z=id_p1.z-1;
		else
			x=id_p2.x;
			y=id_p2.y+10;
			z=id_p2.z-1;
		end
		alpha=100+rolling;
		size_x=100+(rolling/6);
		size_y=100-(rolling/4);
		if(algo==false)
			if(rolling<100) rolling++; else algo=true; end
		else
			if(rolling>0) rolling--; else algo=false; end
		end
		frame;
	end
	from alpha=255 to 0 step -5; frame; end
End

Process estrella();
Private
	rolling;
	algo;
	tiempo_estrella;
	segundox;
	rolex;
	tenia_protec[1];
Begin
	if(p1_estrella) return; end
	p1_estrella=1;
	p2_estrella=1;
	suena(s9);
	Set_text_color(color_texto[0]); 
	tiempo_estrella=5*60;
	cheto_epilepsia=1;
	cheto_salto=1;
	tenia_protec[0]=p1_proteccion;
	tenia_protec[1]=p2_proteccion;
	p1_proteccion=0;
	p2_proteccion=0;
	switch(players)
		case 1:
			sub_estrella(1);
		end
		case 2: 
			sub_estrella(2);
		end
		case 3:
			if(exists(type muneco1)) sub_estrella(1); end
			if(exists(type muneco2)) sub_estrella(2); end
		end
	end
	while(tiempo_estrella>2 and ganando==0)
		if(ready==1) 
			tiempo_estrella--;
			rolex=write(fnt1,400,200,4,textos[3]+itoa(segundox)+textos[5]);
		else
			delete_text(rolex);
			while(ready==0) frame; end
			Set_text_color(color_texto[0]); 
		end
		segundox=tiempo_estrella/efepeese;
		frame;
		delete_text(rolex);
	end
	suena(s12);
	if(tenia_protec[0]) suena(s11); p1_proteccion=1; proteccion(1); end
	if(tenia_protec[1]) suena(s11); p2_proteccion=1; proteccion(2); end
	p1_estrella=0;
	p2_estrella=0;
	delete_text(rolex);
	cheto_epilepsia=0;
	cheto_salto=0;
End

Process sub_estrella(num_muneco);
Private
	rolling;
	algo;
Begin
	graph=519;
	while((num_muneco==1 and p1_estrella==1) or (num_muneco==2 and p2_estrella==1))
		if(num_muneco==1)
			x=id_p1.x;
			y=id_p1.y;
			z=id_p1.z-1;
		else
			x=id_p2.x;
			y=id_p2.y;
			z=id_p2.z-1;
		end
		alpha=100+rolling;
		size_x=100+(rolling/6);
		size_y=100-(rolling/4);
		angle+=5000;
		frame;
		if(algo==false)
			if(rolling<100) rolling++; else algo=true; end
		else
			if(rolling>0) rolling--; else algo=false; end
		end
	end
	from alpha=255 to 0 step -5; frame; end
End

Process ganar();
Begin
	if(ready==0) Return; End
	ganando=1;
	ready=0;
	If(modo_juego==2)
		If(players==1 OR players==3) cuadro_ganar(1); End
		If(players==2 OR players==3) cuadro_ganar(2); End
		mundo++;
		if(op_guardar)
			if(pixpangcd)
				load("C:\PiXPang\tour.sav",mundo_alcanzado);
			else
				load(".\tour.sav",mundo_alcanzado);
			end
		end
		if(mundo_alcanzado<mundo and partida_rapida==0 and mundo<100) 
			mundo_alcanzado=mundo; 
			if(op_guardar)
				if(pixpangcd)
					save("C:\PiXPang\tour.sav",mundo_alcanzado);
				else
					save(".\tour.sav",mundo_alcanzado);
				end
			end
		end
		If(!mod_custom AND !partida_rapida) guarda_juego(); End
	End
	musica(6);
	stage_clear();
	timer[5]=0;
	if(modo_juego==2) frame(15000); faderaro(-2); end
	While(modo_juego!=2 and timer[5]<500) Frame; End
	If(modo_juego==1 OR modo_juego==3)
		faderaro(img_pixpang);
		If(modo_juego==3) stop_scroll(0); End
		let_me_alone();
		creditos2();
	End
	If(partida_rapida==1) partida_rapida=0; let_me_alone(); id_titulo=titulo(); Return; End
	If(modo_juego==2) If(mundo==tour_levels+1 OR (mundo==104 AND mod_england) OR (mundo==105 AND mod_andorra) OR (mundo==cus_levels AND mod_custom)) If(mod_custom OR mod_andorra OR mod_england) let_me_alone(); titulo(); Return; End creditos2(); Else inicio(); End End
End

Process cuadro_ganar(num);
Begin
	graph=406;
	y=345;
	Set_text_color(color_texto[0]); 
	If(num==1) 
		x=210; 
		If(p1_bolas>0) grafico(120,363,410,-2,0,fpg_lang); write_int(fnt1,250,363,4,OFFSET p1_bonus); Else grafico(200,363,409,-2,0,fpg_lang); End
		If(p1_bolas>p2_bolas) grafico(310,323,408,-2,0,fpg_lang); End
		If(p1_bolas<p2_bolas) grafico(310,323,407,-2,0,fpg_lang); End
		If(p1_bolas==p2_bolas) grafico(310,323,407,-2,0,fpg_lang); End //cambiar por TIE
		write_int(fnt1,140,323,4,OFFSET p1_bolas); 
	End
	If(num==2) 
		x=590; 
		If(p2_bolas>0) grafico(680,363,410,-2,0,fpg_lang); write_int(fnt1,550,363,4,OFFSET p2_bonus); Else grafico(600,363,409,-2,0,fpg_lang); End
		If(p2_bolas>p1_bolas) grafico(490,323,408,-2,0,fpg_lang); End
		If(p2_bolas<p1_bolas) grafico(490,323,407,-2,0,fpg_lang); End
		If(p2_bolas==p1_bolas) grafico(490,323,407,-2,0,fpg_lang); End //cambialo por TIE
		write_int(fnt1,660,323,4,OFFSET p2_bolas); 
	End
	While(ganando==1) Frame; End
End

Process stage_clear();
Begin
	y=162;
	x=400;
	file=fpg_lang;
	graph=414;
	if(ops.op_sombras)
		from alpha=0 to 255 step 5; frame; end
	end
	While(ganando==1)
		Frame;
	End
End

Process sombra(graph,x,y,flags,num);
Begin
	flags+=4;
	file=father.file;
	size=father.size;
	size_x=father.size_x;
	size_y=father.size_y;
	angle=father.angle;
	Frame;
	sombra2(graph,x,y,flags);
End

Process sombra2(graph,x,y,flags);
Begin
	flags+=4;
	file=father.file;
	size=father.size;
	size_x=father.size_x;
	size_y=father.size_y;
	angle=father.angle;
	Frame(100);
End

Process relojarena();
Private
	cont_arena;
	velocidad_antes;
Begin
	relojarena=1;
	velocidad_antes=velocidad;
	suena(s13);
	From velocidad=velocidad_antes To velocidad_antes*2 Step 5; Frame; End
	While(cont_arena<200)
		cont_arena++;
		Frame;
	End
	suena(s14);
	From velocidad=velocidad_antes*2 To velocidad_antes Step -5; Frame; End
	relojarena=0;
End

Process fondos_panic();
Private
	png_fondo;
	cambiado;  
	id_fondo;
Begin
	x=400;
	y=260;
	z=512;
	Loop
		If(p1_bolas+p2_bolas=>0 AND cont==0) texto_fondos("1.Ashura"); png_fondo=load_image(".\fondos\3.jpg"); cont=1; End
		If(p1_bolas+p2_bolas=>50 AND cont==1) If(p1_bolas+p2_bolas<100) texto_fondos("2.Alejandro"); png_fondo=load_image(".\fondos\1.jpg"); End  cambiado=0; cont=2; End // alejo
		If(p1_bolas+p2_bolas=>100 AND cont==2) If(p1_bolas+p2_bolas<150) texto_fondos("3.HH Sigmar MC"); png_fondo=load_image(".\fondos\2.jpg"); End cambiado=0; cont=3; End // carlos
		If(p1_bolas+p2_bolas=>150 AND cont==3) If(p1_bolas+p2_bolas<200) texto_fondos("4.Donan"); png_fondo=load_image(".\fondos\10.jpg"); End cambiado=0; cont=4; End // carlos
		If(p1_bolas+p2_bolas=>200 AND cont==4) If(p1_bolas+p2_bolas<250) texto_fondos("5.Donan 2"); png_fondo=load_image(".\fondos\4.jpg"); End cambiado=0; cont=5; End // donan
		If(p1_bolas+p2_bolas=>250 AND cont==5) If(p1_bolas+p2_bolas<300) texto_fondos("6.Donan 3"); png_fondo=load_image(".\fondos\5.jpg"); End cambiado=0; cont=6; End // donan
		If(p1_bolas+p2_bolas=>300 AND cont==6) If(p1_bolas+p2_bolas<350) texto_fondos("7.SiNk!"); png_fondo=load_image(".\fondos\6.jpg"); End cambiado=0; cont=7; End // carlos166
		If(p1_bolas+p2_bolas=>350 AND cont==7) If(p1_bolas+p2_bolas<400) texto_fondos("8.Wakroo"); png_fondo=load_image(".\fondos\7.jpg"); End cambiado=0; cont=8; End // carlos166
		If(p1_bolas+p2_bolas=>400 AND cont==8) If(p1_bolas+p2_bolas<450) texto_fondos("9.Wakroo 2"); png_fondo=load_image(".\fondos\8.jpg"); End cambiado=0; cont=9; End // santi
		If(p1_bolas+p2_bolas=>450 AND cont==9) If(p1_bolas+p2_bolas<500) texto_fondos("10.Wakroo 3"); png_fondo=load_image(".\fondos\9.jpg"); End cambiado=0; cont=10; End // dani el negro
		If(p1_bolas+p2_bolas=>500 AND cont==10) If(p1_bolas+p2_bolas<550) texto_fondos("11.Aryadna y Emilio"); png_fondo=load_image(".\fondos\30.jpg"); End cambiado=0; cont=11; End // donan 3
		If(p1_bolas+p2_bolas=>550 AND cont==11) If(p1_bolas+p2_bolas<600) texto_fondos("12.???????"); png_fondo=load_image(".\fondos\11.jpg"); End cambiado=0; cont=12; End // ???
		if(jefe!=0)
			If(exists(id_fondo)) signal(id_fondo,s_kill); End
			return;
		end
		If(cambiado==0) 
			If(exists(id_fondo)) signal(id_fondo,s_kill); End
			If(ops.op_sombras==1) alpha=0; End
			graph=png_fondo;
			If(ops.op_sombras==1) dump_type=1; restore_type=1; End
			While(alpha<255	AND ops.op_sombras==1)
				alpha+=15;
				Frame;
			End
			dump_type=0;
			restore_type=0;
			id_fondo=pon_fondo(png_fondo);
			cambiado=1; 
			graph=borrar;
		End
		Frame;
	End
End                     

Process fondos_tour();
Private
	png_fond;
Begin
	If(mundo==0) png_fond=load_image(".\fondos\31.jpg"); End
	If(mundo==1) png_fond=load_image(".\fondos\29.jpg"); End
	If(mundo==2) png_fond=load_image(".\fondos\28.jpg"); End  
	If(mundo==3) png_fond=load_image(".\fondos\27.jpg"); End  
	If(mundo==4) png_fond=load_image(".\fondos\26.jpg"); End  
	If(mundo==5) png_fond=load_image(".\fondos\25.jpg"); End  
	If(mundo==6) png_fond=load_image(".\fondos\24.jpg"); End  
	If(mundo==7) png_fond=load_image(".\fondos\23.jpg"); End  
	If(mundo==8) png_fond=load_image(".\fondos\22.jpg"); End
	If(mundo==9) png_fond=load_image(".\fondos\21.jpg"); End  
	If(mundo==10) png_fond=load_image(".\fondos\20.jpg"); End
	If(mundo==11) png_fond=load_image(".\fondos\19.jpg"); End  
	If(mundo==12) png_fond=load_image(".\fondos\18.jpg"); End  
	If(mundo==13) png_fond=load_image(".\fondos\17.jpg"); End  
	If(mundo==14) png_fond=load_image(".\fondos\16.jpg"); End  
	If(mundo==15) png_fond=load_image(".\fondos\15.jpg"); End
	If(mundo==16) png_fond=load_image(".\fondos\14.jpg"); End  
	If(mundo==17) png_fond=load_image(".\fondos\13.jpg"); End 
	If(mundo==18) png_fond=load_image(".\fondos\12.jpg"); End  
	If(mundo==19) png_fond=load_image(".\fondos\11.jpg"); End  
	If(mundo>19) png_fond=load_image(".\fondos\"+itoa(mundo+12)+".jpg"); End
//----------ENGLAND TOUR
	If(mundo==100 AND mod_england==1) png_fond=load_image(".\england\fondos\1.jpg"); End
	If(mundo==101 AND mod_england==1) png_fond=load_image(".\england\fondos\2.jpg"); End
	If(mundo==102 AND mod_england==1) png_fond=load_image(".\england\fondos\3.jpg"); End
	If(mundo==103 AND mod_england==1) png_fond=load_image(".\england\fondos\4.jpg"); End
//----------ANDORRA TOUR
	If(mundo==100 AND mod_andorra==1) png_fond=load_image(".\andorra\fondos\1.jpg"); End
	If(mundo==101 AND mod_andorra==1) png_fond=load_image(".\andorra\fondos\2.jpg"); End
	If(mundo==102 AND mod_andorra==1) png_fond=load_image(".\andorra\fondos\3.jpg"); End
	If(mundo==103 AND mod_andorra==1) png_fond=load_image(".\andorra\fondos\4.jpg"); End
	If(mundo==104 AND mod_andorra==1) png_fond=load_image(".\andorra\fondos\5.jpg"); End
//----------CUSTOM TOUR
	If(mundo=>100 AND mod_custom==1 AND pixpangcd) png_fond=load_image("c:\PiXPang\custom\fondos\"+itoa(mundo-99)+".jpg"); End
	If(mundo=>100 AND mod_custom==1 AND pixpangcd==0) png_fond=load_image(".\custom\fondos\"+itoa(mundo-99)+".jpg"); End
	If(png_fond<1) png_fond=load_image(".\fondos\"+rand(1,42)+".jpg"); End
	pon_fondo(png_fond);
	Frame;
End

Process pon_fondo(el_png);
Begin                                 
    y=260;
    z=512;
    x=400;
    graph=el_png;
    Frame;
    Loop
        Frame(100000000000);
    End
End

Process Input(Int x, Int y, Int max_width, String default_text)
    Begin
	max_width -= text_width(0, prompt) ;
	entry = default_text ;
	timer[4]=0;
	Loop
	    If scan_code == _backspace: entry = substr (entry, 0, -2); End
	    If(scan_code == _enter AND timer[4]>250) Return ; End
	    scan_code = 0 ;
	    If ascii >= 32 AND text_width(0, entry) < max_width:
	            entry += chr(ascii) ;
	        ascii =  0 ;
	    End
	    inputText = write (fnt1,x,y,0,entry + prompt);
	    Frame ;
	    delete_text (inputText) ;
	End
End

Process inicio();
Begin
	p1_puntos+=p1_bonus;
	p1_bonus=0;
	p2_puntos+=p2_bonus;
	p2_bonus=0;
	//frame;
	let_me_alone();
	//faderaro(0);
	if(modo_juego==2 and mundo!=0) faderaro(-1); else faderaro(0); end
	iniciando=1;
	ready=0;
	p1_muere=0;
	p2_muere=0;
	p1_arma=1;
	p2_arma=1;
	ganando=0;
	dinamita=0;
	bola_estrella=0;
	If(modo_juego==2) prisa=0; End
	relojarena=0;
	p1_proteccion=0;
	p2_proteccion=0;
	if(file_muneco1>1) unload_fpg(file_muneco1); end
	if(file_muneco2>1) unload_fpg(file_muneco2); end
	If(classic==0) 
		If(ops.p1_personaje==0) ops.p1_personaje=1; end
		If(ops.p1_personaje==1) p1_arma=2; if((atoi(ftime("%d",time()))>23 and atoi(ftime("%m",time()))==12) or (atoi(ftime("%d",time()))<8 and atoi(ftime("%m",time()))==1)) file_muneco1=load_fpg(".\fpg\charsxmas.fpg"); else file_muneco1=load_fpg(".\fpg\chars1.fpg"); end End
		If(ops.p1_personaje==2) p1_arma=3; file_muneco1=load_fpg(".\fpg\chars2.fpg"); End
		If(ops.p1_personaje==3) p1_arma=2; file_muneco1=load_fpg(".\fpg\chars3.fpg"); End
		If(ops.p1_personaje==4) p1_arma=2; file_muneco1=load_fpg(".\fpg\chars4.fpg"); End
		If(ops.p1_personaje==5) p1_arma=4; file_muneco1=load_fpg(".\fpg\chars5.fpg"); End
		if(ops.p1_personaje==6) p1_arma=2; file_muneco1=load_fpg(".\fpg\chars6.fpg"); end
		if(ops.p1_personaje==7) p1_arma=2; file_muneco1=load_fpg(".\fpg\chars7.fpg"); end
		If(ops.p2_personaje==0 and players!=1) ops.p2_personaje=1; end
		If(ops.p2_personaje==1) p2_arma=2; if((atoi(ftime("%d",time()))>23 and atoi(ftime("%m",time()))==12) or (atoi(ftime("%d",time()))<8 and atoi(ftime("%m",time()))==1)) file_muneco2=load_fpg(".\fpg\charsxmas.fpg"); else file_muneco2=load_fpg(".\fpg\chars1.fpg"); end End
		If(ops.p2_personaje==2) p2_arma=3; file_muneco2=load_fpg(".\fpg\chars2.fpg"); End
		If(ops.p2_personaje==3) file_muneco2=load_fpg(".\fpg\chars3.fpg"); End
		If(ops.p2_personaje==4) file_muneco2=load_fpg(".\fpg\chars4.fpg"); End
		If(ops.p2_personaje==5) p2_arma=4; file_muneco2=load_fpg(".\fpg\chars5.fpg"); End
		If(ops.p2_personaje==6) p2_arma=2; file_muneco2=load_fpg(".\fpg\chars6.fpg"); End
		If(ops.p2_personaje==7) p2_arma=2; file_muneco2=load_fpg(".\fpg\chars7.fpg"); End
	End
	raton=0;
	matabolas=0;
	delete_text(all_text); // borra textos
	put_screen(0,0); // borra fondo
	cont=0; // contador fondos
	timer[9]=0;
	While(timer[9]<150) Frame; End
	p1_disparos[1]=0; p1_disparos[2]=0; // reinicia p1_disparos
	p2_disparos[1]=0; p2_disparos[2]=0; // reinicia p2_disparos
	bolas=0; // indica q no hay bolas en pantalla
	If(modo_juego==1) panic_mode(); End
	
	If(modo_juego==2) musica(-1); tour_mode(); End
	
	If(p1_vidas=>0 AND p2_vidas<0 AND players==3) players=1; End
	If(p2_vidas=>0 AND p1_vidas<0 AND players==3) players=2; End
	If(players==1)
	    id_p1=muneco1(); 
	    If(cheto_ayudante) grafico(751,547,922,-3,0,0); personaje_demo2(); End
	End
	If(players==2)
	    id_p2=muneco2(); 
	    If(cheto_ayudante) grafico(50,550,921,-3,0,0); personaje_demo1(); End
	End
	If(players==3) id_p1=muneco1(); id_p2=muneco2(); End
	If(modo_juego==1 and jefe==0) fondos_panic(); End
	If(modo_juego==2) pon_pantalla(mundo); End
	anim_global();
	marcadores();
	timer[9]=0;
//	While(key(_enter) OR mouse.middle) Frame; End
//	While(timer[9]<70 AND !key(_enter)) Frame; End
	While(timer[9]<70) Frame; End
	
	if(jefe==0) readyando(); else
		switch(jefe)
			case 1: fantasma();  musica(7); end
			case 2: fantasma(); musica(7);  end
			case 3: fmars(); end
			case 4: jefe_gusano(); musica(7); end
			case 5: ultraball(); fondos_tour(); musica(7); end
			case 6: maskara(); musica(7); end
		end
	end

	p1_muere=0;
	p2_muere=0;
	p1_disparos[1]=0; p1_disparos[2]=0; // reinicia p1_disparos
	p2_disparos[1]=0; p2_disparos[2]=0; // reinicia p2_disparos
	ganando=0; 
	iniciando=0;
	reloj=0;
	transicion=0;
End

Process gameover();
Private
	id_input;
	otro_texto;
	tupapa;
Begin
	faderaro(img_pixpang);
	clear_screen();
	musica(-1);
	delete_text(all_text);
	let_me_alone();
	timer[9]=0;
	While(timer[9]<100) Frame; End
	transicion=0;
	p1_muere=0;
	p2_muere=0;
	timer[9]=0;
	put_screen(0,img_pixpang);
	if(mundo<tour_levels)
		write(fnt1,400,280,4,"¿Continuar?");
		write(fnt1,400,320,4,"(Y) Si    (N) No");
		while(!key(_n) and modo_juego==2) 
			if(key(_y)) p1_vidas=10; p2_vidas=10; p1_puntos=0; p2_puntos=0; let_me_alone(); frame; inicio(); return; end
			frame; 
		end
	end
	musica(9);
	delete_text(all_text);
	While(key(_enter)) Frame; End
	/*if(ops.records)
		if(p1_puntos>0)
			write(fnt1,400,300,4,TExtos[0]);
			write(fnt1,400,345,4,TExtos[2]);
			Set_text_color(color_texto[0]);
			id_input=Input(15,548,96,"AAAAA");
			write_int(fnt1,15,500,0,OFFSET p1_puntos);
			While(!key(_enter)) Frame; End
			nombrep1=entry;
			//enviarecords(p1_puntos,nombrep1,modo_juego);
			delete_text(all_text);
			signal(id_input,s_kill);
			suena(s2);
			While(key(_enter)) Frame; End
			timer[9]=0;
			while(timer[9]<300) frame; end
		end
		if(p2_puntos>0)
			write(fnt1,400,300,4,TExtos[1]);
			write(fnt1,400,345,4,TExtos[2]);
			Set_text_color(color_texto[0]);
			id_input=Input(15,548,96,"AAAAAA");
			write_int(fnt1,15,500,0,OFFSET p2_puntos);
			While(!key(_enter)) Frame; End
			nombrep2=entry;
			//enviarecords(p2_puntos,nombrep2,modo_juego);
			delete_text(all_text);
			signal(id_input,s_kill);
			timer[9]=0;
			While(timer[9]<300) Frame; End
		end
	End
	*/
	musica(8);
	Set_text_color(color_texto[0]);
	write(fnt1,400,300,4,textos[4]);
	timer[9]=0;
	while(torneo!=0 and !key(_esc)) frame; end
	While(timer[9]<500 AND !key(_space)) Frame; end
	delete_text(all_text);
	entry=nombrep1;
	If(entry=="DIOX")
		cheto_diox=1;
		suena(s2);
	End
	If(entry=="EPI")
		cheto_epilepsia=1;
		suena(s2);
	End
	If(entry=="BARNEY")
		cheto_borracho=1;
		suena(s2);
	End
	If(entry=="HELP")
		cheto_ayudante=1;
		suena(s2);
	End
	delete_text(all_text);
	modo_juego=0;
	//if(ops.records) records(); else titulo(); end
	titulo();
End

Process panic_mode();
Private
	txt_pausa;
	txt_fps;
	kindabolas;
Begin
	dump_type=0;
	restore_type=0;
	p1_arma=2;
	p2_arma=2;
	modo_juego=1;    
	If(cont==12) cont=11; End
	Loop
		If(pixel_mola==1 and ready==1)
			If(key(_m) AND raton==0) coloca_raton(); End
			If(key(_x)) matabolas=1; Else matabolas=0; End
			If(key(_r) AND reloj==0) reloj=1; itemreloj(5); End
			If(key(_f) AND txt_fps==0) txt_fps=write_int(fnt1,0,0,0,&fps); End
			If(key(_n)) nube(); End
			if(key(_q)) personaje_demo1(); end
			if(key(_w)) personaje_demo2(); end
		End
		If((key(_alt) or key(_esc) or key(_p) or key(_enter) or key(95)) and !exists(type opciones) and ready==1) opciones(); ready=0; End
		If((p1_bolas+p2_bolas)>100 AND rand(0,200)==0 AND classic==0) nube(); End
		If(bolas=>13 AND prisa==0) prisa=1; hayprisa(); End
		If(bolas<8 AND prisa==1) prisa=0; timer[8]=0; musica(0); End
		If(key(_d) AND key(_b) AND key(_g) and torneo==0) pixel_mola=1; End
		If(cont==12 AND ganando==0 AND bolas==0 AND ready==1) ganar(); Return; End
		If((timer[7]>1500 OR bolas<1) and jefe==0 AND (ganando==0 AND ready==1 AND p1_bolas+p2_bolas<550 and bola_estrella==0 and matabolas==0)) 
			timer[7]=0; 
			If(prisa==1) prisa=0; timer[8]=0; musica(0); End 
			if(p1_bolas+p2_bolas<200) kindabolas=rand(0,2); else kindabolas=rand(0,4); end 
			If(kindabolas==0) bola(rand(60,740),150,5,rand(0,1)); end 
			If(kindabolas==1) bola(rand(60,740),150,12,rand(0,1)); End 
			If(kindabolas==2) bola(rand(60,740),150,9,rand(0,1)); End 
			If(kindabolas==3) bola(rand(60,740),150,16,rand(0,1)); end 
			If(kindabolas==4) bola(-100,150,19,rand(0,1)); bola(900,150,rand(19,22),rand(0,1)); end
		End
		If(key(_alt) AND key(_x)) If(is_playing_cd()) stop_cd(); End exit(0,0); End
		If(zbolas<-200) zbolas=-1; End
		If(players==3)
			If(p1_muere==2 AND p2_muere==0) p1_muere=0; If(p1_vidas<0) inicio(); Else vidasp1(); id_p1=muneco1(); End End
			If(p2_muere==2 AND p1_muere==0) p2_muere=0; If(p2_vidas<0) inicio(); Else vidasp2(); id_p2=muneco2(); End End
			If(p1_muere==2 AND p2_muere==2 AND (p1_vidas=>0 OR p2_vidas=>0)) inicio(); End
			If(p1_muere==2 AND p1_vidas<0 AND p2_muere==2 AND p2_vidas<0) gameover(); End
		End
		If(players==2)
			If(p2_muere==2 AND p2_vidas=>0 AND iniciando==0) inicio(); End
			If(p2_muere==2 AND p2_vidas<0) gameover(); End
		End
		If(players==1)
			If(p1_muere==2 AND p1_vidas=>0 AND iniciando==0) inicio(); End
			If(p1_muere==2 AND p1_vidas<0) gameover(); End
		End           
		If(pixpangcd==1 AND ops.op_music==1 AND timer[8]>13100 and jefe!=0) timer[8]=0; musica(0); End
		If(relojarena==0 and jefe==0) 
			switch(ops.dificultad)			
				case 0:
					velocidad=600-(p1_bolas/3+p2_bolas/3); 
				end
				case 1:
					velocidad=550-(p1_bolas/3+p2_bolas/3); 
				end
				case 2:
					velocidad=500-(p1_bolas/3+p2_bolas/3); 
				end
				case 3:
					velocidad=400-(p1_bolas/3+p2_bolas/3); 
				end
			end
		End
		Frame;
	End                
End

Process tour_mode();
Private
	txt_pausa;
	txt_fps;
Begin
	dump_type=0;
	restore_type=0;
	p1_bolas=0;
	p2_bolas=0;
	modo_juego=2;
	cocos=0;
	Loop
		If(pixel_mola==1 and ready==1)
			If(key(_m) AND raton==0) coloca_raton(); End
			If(key(_x)) matabolas=1; Else matabolas=0; End
			If(key(_r) AND reloj==0) reloj=1; itemreloj(5); End
			if(key(_e) and p1_estrella==0) while(key(_e)) frame; end estrella(); end
			If(cocos<3 AND key(_c)) cocodrilo(rand(0,1)); End
			If(cocos<3 AND key(_v)) volador(); End
			If(key(_f) AND txt_fps==0) txt_fps=write_int(fnt1,0,0,0,&fps); End
			if(key(_q)) personaje_demo1(); end
			if(key(_w)) personaje_demo2(); end
		End
		If(key(_g)) p1_arma=1; p2_arma=1; End
		If((key(_alt) or key(_esc) or key(_p) or key(_enter) or key(95)) and !exists(type opciones) and ready==1) opciones(); ready=0; End
		If(players==1 AND key(_2) and !cheto_ayudante) players=3; suena(s6); p2_vidas=10; faderaro(-2); frame; inicio(); End
		If(players==2 AND key(_1)) players=3; suena(s6); p1_vidas=10; inicio(); End
		If(key(_d) AND key(_b) AND key(_g) and torneo==0) pixel_mola=1; End
		If(bolas==0 AND ready==1 and jefe==0) ganar(); Break; End
		If(key(_alt) AND key(_x)) If(is_playing_cd()) stop_cd(); End exit(0,0); End
		If(zbolas<-200) zbolas=-1; End
		If(cocos<3 AND rand(0,2000)==0 and torneo==0 and jefe==0) If(rand(0,1)==0) cocodrilo(rand(0,1)); Else volador(); End End
		If(players==3)
			If(p1_muere==2 AND p2_muere==2 AND (p1_vidas=>0 OR p2_vidas=>0) AND iniciando==0) musica(-1); faderaro(-2); frame; inicio(); End
			If(p1_muere==2 AND p1_vidas<0 AND p2_muere==2 AND p2_vidas<0) gameover(); End
		End
		If(players==2)
			If(p2_muere==2 AND p2_vidas=>0 AND iniciando==0) musica(-1); faderaro(-2); frame; inicio(); End
			If(p2_muere==2 AND p2_vidas<0) gameover(); End
		End
		If(players==1)
			If(p1_muere==2 AND p1_vidas=>0 AND iniciando==0) musica(-1); faderaro(-2); frame; inicio(); End
			If(p1_muere==2 AND p1_vidas<0) gameover(); End
		End
		If(relojarena==0) 
			if(p1_estrella)
				velocidad=100;
			else
				switch(ops.dificultad)			
					case 0:
						velocidad=400;
					end
					case 1:
						velocidad=300;
					end
					case 2:
						velocidad=250;
					end
					case 3:
						velocidad=200;
					end
				end
			end
		End
		Frame;
	End
End

Process intro();
Private
	id_panic;
	id_tour;
	id_elegido;
	txt_modo[1];
	txt_teclas[1];
	teclasp1;
	id_graph1;
	id_graph2;
	mods;
Begin
	players=1;
	If(op_guardar)
		If(pixpangcd)
			If(file_exists("C:\PiXPang\tour.sav")) load("C:\PiXPang\tour.sav",mundo_alcanzado); End
		Else
			If(file_exists(".\tour.sav")) load(".\tour.sav",mundo_alcanzado); End
		End
	End
	If(file_exists(".\england\tour\eng1.pang")) mod_england=1; mod_england_png=load_image(".\england\england.jpg");End
	If(file_exists(".\andorra\tour\and1.pang")) mod_andorra=1; mod_andorra_png=load_image(".\andorra\andorra.jpg"); End
	If(pixpangcd)
	    If(file_exists("c:\PiXPang\custom\tour\cus1.pang"))
		    mod_custom=1;
	 	    mod_custom_png=load_image("c:\PiXPang\custom\custom.jpg");
		    i=1;
		    cus_levels=100;
		    While(file_exists("c:\PiXPang\custom\tour\"+itoa(i)+".pang"))
			    i++;
			    cus_levels++;
			    Frame;
	  	    End
		    i=0;
	    End
	Else
		If(file_exists(".\custom\tour\cus1.pang"))
		    mod_custom=1; 
		    i=1;
		    cus_levels=100;
		    While(file_exists(".\custom\tour\"+itoa(i)+".pang"))
			    i++; 
			    cus_levels++;
			    Frame;
		    End
            i=0;
        End
	End
	While(key(_enter) OR mouse.middle) Frame; End
	musica(5); 
	put_screen(0,919);   
	z=-1;
	alpha=0;
	modo_juego=1; x=200; y=200; graph=910; 
	texto_intro(TEXtos[27],0);
	id_tour=grafico_alpha(600,y,913,0);
	id_panic=grafico_alpha(200,y+1,911,0);
	Set_text_color(color_texto[0]); txt_modo[0]=write(fnt1,x,y+120,4,TExtos[7]); 
	Set_text_color(color_texto[0]); txt_teclas[0]=write(fnt1,200,480,0,TEXTos[5]); 
	id_graph1=grafico(80,500,501,-1,0,0); 
	While(!key(_enter))
		If(alpha<255 AND ops.op_sombras==1) alpha+=5; Else alpha=255; End
		If(key(_left)) delete_text(txt_modo[0]); delete_text(txt_modo[1]); modo_juego=1; x=200; y=200; graph=910; Set_text_color(color_texto[0]); txt_modo[0]=write(fnt1,x,y+120,4,TExtos[7]); End
		If(key(_right)) delete_text(txt_modo[0]); delete_text(txt_modo[1]); modo_juego=2; x=600; y=200; graph=912; Set_text_color(color_texto[0]); txt_modo[0]=write(fnt1,x,y+120,4,TExtos[8]); End
		//If(key(_down) AND modo_juego==2 AND (mod_england==1 OR mod_andorra==1 OR mod_custom==1)) delete_text(txt_modo[0]); delete_text(txt_modo[1]); set_text_color(color_texto[0]); txt_modo[0]=write(fnt1,x,y+120,4,TExtos[9]); Else End
		//If(key(_up)) delete_text(txt_modo[0]); delete_text(txt_modo[1]); If(players==2) signal(id_graph2,s_kill); id_graph1=grafico(80,500,501,-1,0,0); End If(players==3) signal(id_graph2,s_kill); End players=1; delete_text(txt_teclas[0]); delete_text(txt_teclas[1]); set_text_color(color_texto[0]); txt_teclas[0]=write(fnt1,200,480,0,TEXTos[5]); modo_juego=3; x=400; y=250; graph=916; set_text_color(color_texto[0]); txt_modo[0]=write(fnt1,400,400,4,TExtos[10]); End
		If(key(_space)) let_me_alone(); modo_juego=2; crear_pantalla(); End
		If(key(_1) AND modo_juego!=3) If(players==2) signal(id_graph2,s_kill); id_graph1=grafico(80,500,501,-1,0,0); End If(players==3) signal(id_graph2,s_kill); End players=1; delete_text(txt_teclas[0]); delete_text(txt_teclas[1]); Set_text_color(color_texto[0]); txt_teclas[0]=write(fnt1,200,480,0,TEXTos[5]); End 
		If(key(_2) AND modo_juego!=3) If(players==1) signal(id_graph1,s_kill); id_graph2=grafico(150,500,551,-1,0,0); End If(players==3) signal(id_graph1,s_kill); End players=2; delete_text(txt_teclas[0]); delete_text(txt_teclas[1]); Set_text_color(color_texto[0]); txt_teclas[0]=write(fnt1,200,480,0,"1 Jugador (PuX)"); End 
		If(key(_3) AND modo_juego!=3) If(players==1) id_graph2=grafico(150,500,551,-1,0,0); End If(players==2) id_graph1=grafico(80,500,501,-1,0,0); End players=3; delete_text(txt_teclas[0]); delete_text(txt_teclas[1]); Set_text_color(color_texto[0]); txt_teclas[0]=write(fnt1,200,480,0,TEXTos[6]); End
		Frame;
	End
	dump_type=0;
	restore_type=0;
	If(key(_down) AND modo_juego==1)
		p1_bolas=551;
		suena(s6);
	End
	If(key(_down) AND modo_juego==2 AND (mod_england==1 OR mod_andorra==1 OR mod_custom==1))
		mundo=100;
		mods=1;
		suena(s6);
	End
	If(key(_alt) AND modo_juego==2)
		mundo=mundo_alcanzado;
		suena(s6);
	End
	If(!key(_down) OR (key(_down) AND modo_juego==2 AND (mod_england!=1 AND mod_andorra!=1 AND mod_custom!=1)))
		suena(s2);
	End
	delete_text(txt_modo[0]); delete_text(txt_modo[1]);
	While(x!=400)
		If(x<400) x+=5; Else x-=5; End
		If(modo_juego==2)
			If(mods)
				Set_text_color(color_texto[0]); 
				txt_modo[0]=write(fnt1,x,y+120,4,TExtos[9]);
			Else
				Set_text_color(color_texto[0]); 
				txt_modo[0]=write(fnt1,x,y+120,4,TExtos[8]);
			End
		End
		If(modo_juego==1)
				Set_text_color(color_texto[0]); 
				txt_modo[0]=write(fnt1,x,y+120,4,TExtos[7]);
		End
		If(modo_juego==3)
			Set_text_color(color_texto[0]); 
			txt_modo[0]=write(fnt1,400,400,4,TExtos[10]);
		End
		Frame;
		delete_text(txt_modo[0]); delete_text(txt_modo[1]);
	End
	While(alpha>10 AND ops.op_sombras==1)
		alpha-=5;
		size++;
		Frame;
	End
	graph=borrar;
	If(mods) elige_mod(); Return; 
	    Else mod_custom=0; mod_andorra=0; mod_england=0; 
	End
	timer[0]=0;
	If(modo_juego==2) faderaro(img_pixpang); End
	If(modo_juego==1) faderaro(img_pixpang); End
	If(modo_juego==3) faderaro(img_pixpang); signal(id_graph1,s_kill); dump_type=1; restore_type=-1; End
	While(timer[0]<300)
		Frame;
	End
	timer[5]=0;
	If(modo_juego==1 OR modo_juego==3) timer[8]=0; musica(0); End
	If(modo_juego!=3) inicio(); Else modo_safari(); End
End      

Process elige_mod();
Private
	opcion;
Begin
	let_me_alone();
	delete_text(all_text);
	While(key(_enter)) Frame; End
	write(fnt1,400,400,4,TExtos[11]);
	opcion=3;
	graph=mod_custom_png;
	x=400; y=300;
	If(ops.op_sombras==1) alpha=255; End
	Repeat
		If(key(_left) AND mod_england==1) opcion=1; x=200; y=200; graph=mod_england_png; delete_text(all_text); write(fnt1,200,320,4,TExtos[12]); End
		If(key(_right) AND mod_andorra==1) opcion=2; x=600; y=200; graph=mod_andorra_png; delete_text(all_text); write(fnt1,600,320,4,textos[13]); End
		If(key(_down) AND mod_custom==1) opcion=3; x=400; y=300; graph=mod_custom_png; delete_text(all_text); write(fnt1,400,400,4,TExtos[11]); End
		Frame;
	Until(key(_enter))
	While(alpha>10 AND ops.op_sombras==1)
		alpha-=5;
		size++;
		Frame;
	End
	mod_england=0;
	mod_andorra=0;
	mod_custom=0;
	If(opcion==1) mod_england=1; End
	If(opcion==2) mod_andorra=1; End
	If(opcion==3) mod_custom=1; End
	timer[0]=0;
	faderaro(img_pixpang);
	While(timer[0]<300)
		Frame;
	End
	timer[5]=0;
	inicio();
End  

Process grafico_alpha(x,y,graph,flags);
Begin
	If(ops.op_sombras==1) alpha=0; End
	While(!key(_enter))
		If(alpha<250 AND ops.op_sombras==1) alpha+=5; End
		Frame;
	End
	While(alpha>10 AND ops.op_sombras==1)
		alpha-=5;
		Frame;
	End
End

Process texto_intro(string txt_intro,int tipo);
Private
	texto[1];
Begin
	x=1100;
	y=530;
	While(x>5 AND !key(_enter))
		If(x>150) x-=5; End
		x-=5;
		Set_text_color(color_texto[0]);
		texto[0]=write(fnt1,x,y,0,txt_intro);
		Frame;
		delete_text(texto[0]);
		delete_text(texto[1]);
	End
	x=0;
	Set_text_color(color_texto[0]);
	texto[0]=write(fnt1,x,y,0,txt_intro);
	While(tipo==1)
		delete_text(texto[0]);
		delete_text(texto[1]);
		Frame(3000);
	Set_text_color(color_texto[0]);
	texto[0]=write(fnt1,x,y,0,txt_intro);
		Frame(5000);
	End
End

Process texto_fondos(String creador);
Private
	timr;
Begin
	// desactivado por ahora
	return;
	// ...
	x=1100;
	y=40;                 
	If(txt_fondos!=0) delete_text(txt_fondos); End
	While(x>25)
		If(x>100) x-=5; End
		x-=5;
		Set_text_color(color_texto[0]);
		txt_fondos=write(fnt1,x,y,0,creador);
		Frame;
		delete_text(txt_fondos);
	End
	timr=0;
	While(timr<300)
		timr++;
		Set_text_color(color_texto[0]);
		txt_fondos[0]=write(fnt1,x,y,0,creador);
		Frame;
		delete_text(txt_fondos);
	End
	While(x>-300)
		x-=5;
		Set_text_color(color_texto[0]);
		txt_fondos[0]=write(fnt1,x,y,0,creador);
		Frame;
		delete_text(txt_fondos);
	End
	delete_text(txt_fondos);
End

Process readyando();
Begin
	ready=0;
	x=400;
	y=250;
	z=-256;
	if(torneo==1)
		while(!key(_enter)) frame; end
	end
	timer[9]=0;
	if(ops.op_sombras==0) 
		While(timer[9]<300)
		    file=fpg_lang;
		    graph=415;
			ready=0;
		    if(animglobal<30 AND timer[9]>100) graph=borrar; End
		    Frame;
		End
	else
			// way to 2.0!!
		    file=fpg_lang;
		    graph=415;
		    ready=0;
		    from alpha=0 to 255 step 7; frame; end
		    from alpha=255 to 0 step -7; frame; end
		    from alpha=0 to 255 step 7; frame; end
		    from alpha=255 to 0 step -7; frame; end
		    from alpha=0 to 255 step 10; frame; end
		    Frame(2000);
	    	    If(modo_juego==2 and jefe==0)
			    musica(1);
		    end
		    ready=1;
		    from alpha=255 to 0 step -10; size++; frame; end
		    return;
	End
	If(modo_juego==2 and jefe==0)
		musica(1);
	End
	ready=1;
End

Process titulo();
Private
	tamanio;
	tiempo;
Begin
	i=0;
	while(i<400)
		id_bolas[i]=0;
		i++;
	end

	While(file_exists("./tour/"+itoa(tour_levels+1)+".pang"))
		tour_levels++;
	End

	let_me_alone();
	lee_cadenas();
	If(fpg_lang==0 and classic==0) fpg_lang=load_fpg(".\fpg\pixpang_eng.fpg"); End
	stop_scroll(0);
	delete_text(all_text);
	clear_screen();
	pa_largar();
	While(key(_enter)) Frame; End
	tiempo=5*efepeese;
	p1_vidas=10;
	p1_bolas=0;
	p1_bonus=0;
	p1_puntos=0;
	p2_vidas=10;
	p2_bolas=0;
	p2_bonus=0;
	p2_puntos=0;
	matabolas=0;
	mundo=0;
	reloj=0;
	jefe=0;
	if(classic==0) int3titulo(); return; end
	If(ops.op_sombras==1) alpha=155; End
	size=0;
	x=400;
	y=300;
	graph=img_pixpang;
	dump_type=1;
	restore_type=1;
	texto_intro(TEXTOS[35],1);
	While(size<100 AND !key(_enter) AND !key(_esc) AND !key(_l) and !key(_space))
		size++;
		If(alpha<255) alpha++; End
		Frame;
	End
	alpha=255; size=100;
	While(!key(_enter))
		p1_muere=0;
		p2_muere=0;
		ganando=0;
		players=0;
		modo_juego=0;
		If(key(_esc) or key(_p) or key(_enter) or key(95)) opciones(); ready=0; While(ready==0) Frame; End End
		If(key(_l)) let_me_alone(); id_lang=elige_lenguaje(); Frame; Return; End
		tiempo--;
		If(tiempo<0)
			If(que_toca==0) let_me_alone(); demo(); que_toca=1; Return;
			Else creditos(); que_toca=0; Return; End
		End
		Frame;
	End
	suena(s2);
	While(size<200)
		size++;
		If(ops.op_sombras==1) alpha-=3; End
		Frame;
	End
	let_me_alone();
	delete_text(all_text);
	dump_type=1; restore_type=1;
	Frame(200);
	dump_type=0; restore_type=0;
	Frame;
	intro();
End

Process items(x,y,item);
Private
	tuerestonto;
	aleatorio;
	toca;
Begin
	z=1;	
	If(item==0) graph=425; End // reloj arena
	If(item==1) graph=419; End // reloj
	If(item==2) aleatorio=rand(420,423); graph=aleatorio; End // piña
	If(item==3) graph=411; End // pistola doble
	If(item==4) graph=412; End // gancho
	If(item==5) graph=413; End // metralleta
	If(item==6) graph=424; size=150; End // protector
	If(item==7) graph=400; If(rand(0,2)!=1 and primerapartida==0) Return; End End // vida
	If(item==8) graph=426; End // dinamita
	If(item==9) graph=519; End // estrella
	If(item==10) bola(x,y,19,rand(0,1)); bolas--; return; End // bola!!
	While(tuerestonto<(5*efepeese))
	        If(item==7) 
			switch(players)
				case 3:
					If(animglobal<30) 
						file=file_muneco1; 
						graph=400; 
					Else 
						file=file_muneco2; 
						graph=401; 
					End 
				end
				case 2:
						file=file_muneco2; 
						graph=401; 
				end
				case 1:
						file=file_muneco1; 
						graph=400; 
				end			
			end
		End
		If(ready==1) tuerestonto+=3; End
		If(aleatorio==1 AND item==6) size+=3; If(size=>150) aleatorio=0; End End
		If(aleatorio==0 AND item==6) size-=3; If(size=<50) aleatorio=1; End End
		If(aleatorio==1 AND item==9) size++; angle+=15000; If(size=>70) aleatorio=0; End End
		If(aleatorio==0 AND item==9) size--; angle+=15000; If(size=<40) aleatorio=1; End End
		If(!collision(Type grafico) AND ready==1 and cheto_borracho==0)
			If(toca=collision(Type bloques))
				If(toca.y<y)
					y+=6; tuerestonto=0;
				End
			Else
					y+=6; tuerestonto=0;
			End
		End
		If(!collision(Type grafico) AND ready==1 and cheto_borracho==1)
			y-=6; tuerestonto=0;
		End
		If((collision(Type dispcab) OR collision(Type dispcab2)) AND item==2)
			p1_puntos+=2400; suena(s10); Break; 
		End
		If(collision(Type muneco1) AND p1_muere==0)
			If(item==0) relojarena(); End // reloj arena
			If(item==1 and jefe==0) If(reloj==0) itemreloj(rand(3,7)); else secs+=4*60; End End // reloj
			If(item==2) p1_puntos+=2400; suena(s10); End // piña
			If(item==3) p1_arma=2; suena(s3); signal(p1_disparos[1],s_kill); signal(p1_disparos[2],s_kill); p1_disparos[1]=0; p1_disparos[2]=0; End // pistola doble
			If(item==4) p1_arma=3; suena(s3); signal(p1_disparos[1],s_kill); signal(p1_disparos[2],s_kill); p1_disparos[1]=0; p1_disparos[2]=0; End // gancho
			If(item==5) p1_arma=4; suena(s3); signal(p1_disparos[1],s_kill); signal(p1_disparos[2],s_kill); p1_disparos[1]=0; p1_disparos[2]=0; End // metralleta
			If(item==6 and p1_proteccion==0) p1_proteccion=1; if(p1_estrella==0) proteccion(1); end suena(s11); End // protector         
			If(item==9) estrella(); End // estrella!!
			If(item==7) p1_vidas++; suena(s6); End // vida
			If(item==8 AND dinamita==0) dinamita=1; suena(s15); graph=borrar; Frame(4000); dinamita=0; End // dinamita
			Break;
		End
		If(collision(Type muneco2) AND p2_muere==0)
			If(item==0) relojarena(); End // reloj arena
			If(item==1 and jefe==0) If(reloj==0) itemreloj(rand(3,7)); else secs+=4*60; End End // reloj
			If(item==2) p2_puntos+=2400; suena(s10); End // piña
			If(item==3) p2_arma=2; suena(s3); signal(p2_disparos[1],s_kill); signal(p2_disparos[2],s_kill); p2_disparos[1]=0; p2_disparos[2]=0; End // pistola doble
			If(item==4) p2_arma=3; suena(s3); signal(p2_disparos[1],s_kill); signal(p2_disparos[2],s_kill); p2_disparos[1]=0; p2_disparos[2]=0; End // gancho
			If(item==5) p2_arma=4; suena(s3); signal(p2_disparos[1],s_kill); signal(p2_disparos[2],s_kill); p2_disparos[1]=0; p2_disparos[2]=0; End // metralleta
			If(item==6 and p2_proteccion==0) p2_proteccion=1; if(p2_estrella==0) proteccion(2); end suena(s11); End // protector         
			If(item==9) estrella(); End // estrella!!
			If(item==7) p2_vidas++; suena(s6); End // vida
			If(item==8 AND dinamita==0) dinamita=1; graph=borrar; Frame(4000); dinamita=0; End // dinamita
			Break;
		End

		If(tuerestonto>(3*efepeese)) If(flags==0) flags=4; Else flags=0; End End
		Frame(200);
	End
End

Process creditos();
Private
	tiempo;
	texto1[1]; texto1_x; texto1_y;
	texto2[1]; texto2_x; texto2_y;
Begin
	dump_type=0;
	restore_type=0;
	let_me_alone();
	While(key(_enter)) Frame; End
	pa_largar();
	musica(2);
	put_screen(0,img_pixpang);
	transicion=0;
	tiempo=5*efepeese;
	texto1_x=400; texto1_y=850; texto2_x=400; texto2_y=-200; z=-2;
	While(tiempo>0 AND !key(_enter))
		If(texto1_y>350) texto1_y-=3; End
		If(texto2_y<300) texto2_y+=3; End
		If(texto1_y<=350 AND texto2_y=>300) tiempo--; End
		texto2[1]=write(fnt1,texto2_x+3,texto2_y+3,4,TExtos[14]);
		Set_text_color(color_texto[0]);
		texto1[0]=write(fnt1,texto1_x,texto1_y,4,"[PiXeL] (Pablo A. Navarro)");
		texto2[0]=write(fnt1,texto2_x,texto2_y,4,TExtos[14]);
		Frame;
		delete_text(all_text);
	End
	tiempo=5*efepeese;
	texto1_x=-400; texto1_y=300; texto2_x=1200; texto2_y=350; z=-2;
	While(tiempo>0 AND !key(_enter))
		If(texto1_x<400) texto1_x+=5; End
		If(texto2_x>400) texto2_x-=5; End
		If(texto1_x>=400 AND texto2_x=<400) tiempo--; End
		Set_text_color(color_texto[0]);
		texto1[0]=write(fnt1,texto1_x,texto1_y,4,TExtos[15]);
		texto2[0]=write(fnt1,texto2_x,texto2_y,4,"Benny Beat");
		Frame;
		delete_text(all_text);
	End
	tiempo=5*efepeese;
	texto1_x=400; texto1_y=850; texto2_x=400; texto2_y=-200; z=-2;
	While(tiempo>0 AND !key(_enter))
		If(texto1_y>350) texto1_y-=3; End
		If(texto2_y<300) texto2_y+=3; End
		If(texto1_y<=350 AND texto2_y=>300) tiempo--; End
		Set_text_color(color_texto[1]);
		texto1[1]=write(fnt1,texto1_x+3,texto1_y+3,4,"Carles V. Ginés Muñoz");
		texto2[1]=write(fnt1,texto2_x+3,texto2_y+3,4,TExtos[16]);
		Set_text_color(color_texto[0]);
		texto1[0]=write(fnt1,texto1_x,texto1_y,4,"Carles V. Ginés Muñoz");
		texto2[0]=write(fnt1,texto2_x,texto2_y,4,TExtos[16]);
		Frame;
		delete_text(all_text);
	End
	tiempo=5*efepeese;
	texto1_x=-400; texto1_y=300; texto2_x=1200; texto2_y=350; z=-2;
	While(tiempo>0 AND !key(_enter))
		If(texto1_x<400) texto1_x+=5; End
		If(texto2_x>400) texto2_x-=5; End
		If(texto1_x>=400 AND texto2_x=<400) tiempo--; End
		Set_text_color(color_texto[1]);
		texto1[1]=write(fnt1,texto1_x+3,texto1_y+3,4,TExtos[17]);
		texto2[1]=write(fnt1,texto2_x+3,texto2_y+3,4,TExtos[18]);
		Set_text_color(color_texto[0]);
		texto1[0]=write(fnt1,texto1_x,texto1_y,4,TExtos[17]);
		texto2[0]=write(fnt1,texto2_x,texto2_y,4,TExtos[18]);
		Frame;
		delete_text(all_text);
	End
	tiempo=5*efepeese;
	texto1_x=400; texto1_y=850; texto2_x=400; texto2_y=-200; z=-2;
	While(tiempo>0 AND !key(_enter))
		If(texto1_y>350) texto1_y-=3; End
		If(texto2_y<300) texto2_y+=3; End
		If(texto1_y<=350 AND texto2_y=>300) tiempo--; End
		Set_text_color(color_texto[1]);
		texto1[1]=write(fnt1,texto1_x+3,texto1_y+3,4,"¡¡FCloud & [ICEMAN]!!");
		texto2[1]=write(fnt1,texto2_x+3,texto2_y+3,4,textos[19]);
		Set_text_color(color_texto[0]);
		texto1[0]=write(fnt1,texto1_x,texto1_y,4,"¡¡FCloud & [ICEMAN]!!");
		texto2[0]=write(fnt1,texto2_x,texto2_y,4,textos[19]);
		Frame;
		delete_text(all_text);
	End

	tiempo=5*efepeese;
	texto1_x=400; texto1_y=850; texto2_x=2800; texto2_y=-200; z=-2;
	While(texto2_x>-1800 AND !key(_enter))
		If(texto1_y>300) texto1_y-=3; End
		If(texto2_y<350) texto2_y+=3; End
		If(texto2_y=>350) texto2_x-=8; End
		Set_text_color(color_texto[1]);
		texto1[1]=write(fnt1,texto1_x+3,texto1_y+3,4,textos[20]);
		texto2[1]=write(fnt1,texto2_x+3,texto2_y+3,4,"Laura, Ashura, Nicolás, Carles, Antonio, Sigmar, Cygnus, Alejo, Virginia, Jaheira, MCD, Ari, Liane, ...");
		Set_text_color(color_texto[0]);
		texto1[0]=write(fnt1,texto1_x,texto1_y,4,textos[20]);
		texto2[0]=write(fnt1,texto2_x,texto2_y,4,"Laura, Ashura, Nicolás, Carles, Antonio, Sigmar, Cygnus, Alejo, Virginia, Jaheira, MCD, Ari, Liane, ...");
		Frame;
		delete_text(all_text);
	End
	tiempo=5*efepeese;
	texto1_x=-400; texto1_y=300; texto2_x=1200; texto2_y=350; z=-2;
	While(tiempo>0 AND !key(_enter))
		If(texto1_x<400) texto1_x+=10; End
		If(texto2_x>400) texto2_x-=10; End
		If(texto1_x>=400 AND texto2_x=<400) tiempo--; End
		Set_text_color(color_texto[1]);
		texto1[1]=write(fnt1,texto1_x+3,texto1_y+3,4,textos[21]);
		texto2[1]=write(fnt1,texto2_x+3,texto2_y+3,4,textos[22]);
		Set_text_color(color_texto[0]);
		texto1[0]=write(fnt1,texto1_x,texto1_y,4,textos[21]);
		texto2[0]=write(fnt1,texto2_x,texto2_y,4,textos[22]);
		Frame;
		delete_text(all_text);
	End
	If(ganando==1 AND modo_juego==2)
		tiempo=5*efepeese;
		texto1_x=400; texto1_y=850; texto2_x=400; texto2_y=-200; z=-2;
		While(tiempo>0 AND !key(_enter))
			If(texto1_y>350) texto1_y-=3; End
			If(texto2_y<300) texto2_y+=3; End
			If(texto1_y<=350 AND texto2_y=>300) tiempo--; End
			Set_text_color(color_texto[1]);
			texto1[1]=write(fnt1,texto1_x+3,texto1_y+3,4,textos[23]);
			texto2[1]=write(fnt1,texto2_x+3,texto2_y+3,4,textos[24]);
			Set_text_color(color_texto[0]);
			texto1[0]=write(fnt1,texto1_x,texto1_y,4,textos[23]);
			texto2[0]=write(fnt1,texto2_x,texto2_y,4,textos[24]);
			Frame;
			delete_text(all_text);
		End
	End
	If(ganando==1 AND modo_juego==3)
		tiempo=5*efepeese;
		texto1_x=400; texto1_y=850; texto2_x=400; texto2_y=-200; z=-2;
		While(tiempo>0 AND !key(_enter))
			If(texto1_y>350) texto1_y-=3; End
			If(texto2_y<300) texto2_y+=3; End
			If(texto1_y<=350 AND texto2_y=>300) tiempo--; End
			Set_text_color(color_texto[1]);
			texto1[1]=write(fnt1,texto1_x+3,texto1_y+3,4,textos[25]);
			texto2[1]=write(fnt1,texto2_x+3,texto2_y+3,4,textos[26]);
			Set_text_color(color_texto[0]);
			texto1[0]=write(fnt1,texto1_x,texto1_y,4,textos[25]);
			texto2[0]=write(fnt1,texto2_x,texto2_y,4,textos[26]);
			Frame;
			delete_text(all_text);
		End
	End
	clear_screen();
	If(ganando==1) ganando=0; gameover(); Else if(ops.records) records(); else titulo(); end End
End

Process pa_largar();
Begin
	Loop
		If(key(_alt) AND key(_x)) If(is_playing_cd()) stop_cd(); End exit(0,0); End
		Frame;
	End
End

Process col_hielo(x,y);
Begin
	graph=438;
	alpha=0;
	loop
		frame;
	end
End

Process bloques(x,y,regalo,tipo);
Private
	id_disp;
	rompible;
Begin
	z=2;
	If(tipo==1) graph=427; rompible=1; End
	If(tipo==2) graph=428; rompible=1; End
	If(tipo==3) escaleras(x,y); Return; End
	If(tipo==4) graph=430; rompible=0; End
	If(tipo==5) graph=431; rompible=0; End
	If(tipo==6) graph=432; rompible=1; End
	If(tipo==7) graph=433; rompible=1; End
	If(tipo==8) graph=434; rompible=1; End
	If(tipo==9) graph=435; rompible=0; End
	If(tipo==10) graph=436; rompible=0; End
	If(tipo==11) graph=437; rompible=1; End
	If(tipo==12) graph=438; z=-1; col_hielo(x,y-10); rompible=0; End
	if(regalo==10 and rompible==1) bolas++; end
	ancho=graphic_info(0,graph,g_wide);
	alto=graphic_info(0,graph,g_height);
	if(cheto_borracho==1) angle=rand(0,360)*1000; end
	Repeat
		If(x==0 OR y==0) Break; End
		if(rompible==1 and p1_arma==4 and (collision(Type cachodisp) OR collision(Type cachodisp2)))
			If(collision(Type cachodisp) AND p1_arma==4) signal(p1_disparos[1],s_kill); p1_disparos[1]=0; End
			If(collision(Type cachodisp2) AND p1_arma==4) signal(p1_disparos[2],s_kill); p1_disparos[2]=0;  End
		End
		If(rompible==0 AND graph!=429 AND p1_arma!=3 AND ((collision(Type cachodisp) OR collision(Type dispcab)) OR (collision(Type cachodisp2) OR collision(Type dispcab2))))
			If(collision(Type dispcab) AND collision(Type dispcab2))
				signal(p1_disparos[1],s_kill); p1_disparos[1]=0; signal(p1_disparos[2],s_kill); p1_disparos[2]=0;
			End
			If((collision(Type cachodisp) AND p1_arma==4) OR collision(Type dispcab)) signal(p1_disparos[1],s_kill); p1_disparos[1]=0; End
			If((collision(Type cachodisp2) AND p1_arma==4) OR collision(Type dispcab2)) signal(p1_disparos[2],s_kill); p1_disparos[2]=0;  End
		End
		if(rompible==1 and p2_arma==4 and (collision(Type cachodisp3) OR collision(Type cachodisp4)))
			If(collision(Type cachodisp3) AND p2_arma==4) signal(p2_disparos[1],s_kill); p2_disparos[1]=0; End
			If(collision(Type cachodisp4) AND p2_arma==4) signal(p2_disparos[2],s_kill); p2_disparos[2]=0;  End
		End
		If(rompible==0 AND graph!=429 AND p2_arma!=3 AND ((collision(Type cachodisp3) OR collision(Type dispcab3)) OR (collision(Type cachodisp4) OR collision(Type dispcab4))))
			If(collision(Type dispcab3) AND collision(Type dispcab4))
				signal(p2_disparos[1],s_kill); p2_disparos[1]=0; signal(p2_disparos[2],s_kill); p2_disparos[2]=0;
			End
			If((collision(Type cachodisp3) AND p2_arma==4) OR collision(Type dispcab3)) signal(p2_disparos[1],s_kill); p2_disparos[1]=0; End
			If((collision(Type cachodisp4) AND p2_arma==4) OR collision(Type dispcab4)) signal(p2_disparos[2],s_kill); p2_disparos[2]=0;  End
		End
		if(regalo==10 and rompible==1 and !exists(type bola) and ready==1) if(ops.dificultad==3) items(x,y,regalo); break; else bolas--; break; end end
		Frame;
//-------------------------DI00000000000XXXXXXXXXXX
Until(
	(
	(id_disp=collision(Type cachodisp) and p1_arma!=4) 
	OR 
	(id_disp=collision(Type cachodisp2) and p1_arma!=4) 
	OR 
	(id_disp=collision(Type cachodisp3) and p2_arma!=4) 
	OR 
	(id_disp=collision(Type cachodisp4) and p2_arma!=4)
	OR
	(id_disp=collision(Type dispcab) and p1_arma!=4)
	OR
	(id_disp=collision(Type dispcab2) and p1_arma!=4)
	OR 
	(id_disp=collision(Type dispcab3) and p2_arma!=4)
	OR 
	(id_disp=collision(Type dispcab4) and p2_arma!=4)
	)
AND rompible==1)
//-------------------------DI00000000000XXXXXXXXXXX

	If((collision(Type cachodisp) OR collision(Type dispcab)) AND (collision(Type cachodisp2) OR collision(Type dispcab2)))
		signal(p1_disparos[1],s_kill); p1_disparos[1]=0; signal(p1_disparos[2],s_kill); p1_disparos[2]=0; 
		If(x!=0 AND y>50) items(x,y,regalo); End
	End
	If(collision(Type cachodisp) OR collision(Type dispcab) OR collision(Type cachodisp2) OR collision(Type dispcab2)) 
		If(p1_arma==4 AND rompible==1) signal(id_disp,s_kill); End
		If(p1_arma==4) bloques(x,y,regalo,tipo); Else If(x!=0 AND y>50 AND p1_arma!=4) items(x,y,regalo); End End
		If(collision(Type cachodisp) OR collision(Type dispcab)) signal(p1_disparos[1],s_kill); p1_disparos[1]=0; End
		If(collision(Type cachodisp2) OR collision(Type dispcab2)) signal(p1_disparos[2],s_kill); p1_disparos[2]=0; End
	End
	If((collision(Type cachodisp3) OR collision(Type dispcab3)) AND (collision(Type cachodisp4) OR collision(Type dispcab4))) 
		signal(p2_disparos[1],s_kill); p2_disparos[1]=0; signal(p2_disparos[2],s_kill); p2_disparos[2]=0;
		If(p2_arma==4) bloques(x,y,regalo,tipo); Else If(x!=0 AND y>50) items(x,y,regalo); End End
	End
	If(collision(Type cachodisp3) OR collision(Type dispcab3) OR collision(Type cachodisp4) OR collision(Type dispcab4))
		If(p2_arma==4 AND rompible==1) signal(id_disp,s_kill); End
		If(p2_arma==4) bloques(x,y,regalo,tipo); Else If(x!=0 AND y>50 AND p2_arma!=4) items(x,y,regalo); End End
		If(collision(Type cachodisp3) OR collision(Type dispcab3)) signal(p2_disparos[1],s_kill); p2_disparos[1]=0; End
		If(collision(Type cachodisp4) OR collision(Type dispcab4)) signal(p2_disparos[2],s_kill); p2_disparos[2]=0; End
	End
	from alpha=255 to 0 step -10; frame; end
End

Process opciones();
Private
	opcion;
	t_opc;
	txt1;txt2;txt3;txt4;txt5;
	mano;
	txt_opmusic;
	txt_opsombras;
	txt_opsonido;
	struct partidaguardada;
		int pgpuntos[1];
		byte pgplayers;
		byte pgmundo;
		byte pgvidas[1];
	end
	fotopartida;
Begin
	suena(s8);
	graph=905;
	x=400;
	y=300;
	ready=0;
	size=0;
	z=-254;
	If(ops.op_sombras==1) alpha=180; End
	While(key(_esc))
		Frame;
	End
	From size=0 To 100 Step 5; Frame; End
	Set_text_color(color_texto[0]);
	txt1=write(fnt1,400,200,4,TExtos[28]);
	txt2=write(fnt1,400,250,4,TExtos[29]);
	txt3=write(fnt1,400,300,4,TExtos[30]);
	txt4=write(fnt1,400,350,4,TExtos[31]);
	txt5=write(fnt1,400,400,4,TExtos[32]);
	If(ops.op_sombras==1) Set_text_color(color_texto[0]); txt_opsombras=write(fnt1,550,300,4,TExtos[33]); Else Set_text_color(color_texto[0]); txt_opsombras=write(fnt1,550,300,4,TExtos[34]); End
	If(ops.op_music==1) Set_text_color(color_texto[0]); txt_opmusic=write(fnt1,550,250,4,TExtos[33]); Else Set_text_color(color_texto[0]); txt_opmusic=write(fnt1,550,250,4,TExtos[34]); End
	If(ops.op_sonido==1) Set_text_color(color_texto[0]); txt_opsonido=write(fnt1,550,350,4,TExtos[33]); Else Set_text_color(color_texto[0]); txt_opsonido=write(fnt1,550,350,4,TExtos[34]); End
	mano=grafico(250,280,702,-2,0,0);
	Repeat
		ready=0;
		If(ops.op_sombras==1) alpha=180; Else alpha=255; End
		If((key(_down)) AND !key(_up)) suena(s9); While(key(_down)) Frame; End opcion++; If(opcion==5) opcion=0; End End
		If((key(_up)) AND !key(_down)) suena(s9); While(key(_up)) Frame; End opcion--; If(opcion==-1) opcion=4; End End
		signal(mano,s_kill);
		If(opcion==0) mano=grafico(200,200,702,-256,0,0); End
		If(opcion==1) mano=grafico(200,250,702,-256,0,0); End
		If(opcion==2) mano=grafico(200,300,702,-256,0,0); End
		If(opcion==3) mano=grafico(200,350,702,-256,0,0); End
		If(opcion==4) mano=grafico(200,400,702,-256,0,0); End
		If(key(_enter) or key(_space) or key(_control))
			suena(s2);
			While(key(_enter)) Frame; End
			If(opcion==0) Break; End
			If(opcion==1) If(ops.op_music==1) ops.op_music=0; musica(-1); Else ops.op_music=1; timer[8]=0; musica(0); End 
				If(modo_juego==2) 
					If(mundo<6) musica(1); End
					If(mundo=>6 AND mundo<12) musica(2); End
					If(mundo=>12 AND mundo<19) musica(3); End
					If(mundo=>19) musica(4); End
				End
			End
			If(opcion==2) If(ops.op_sombras==1) ops.op_sombras=0; Else ops.op_sombras=1; End End
			If(opcion==3) If(ops.op_sonido==1) ops.op_sonido=0; Else ops.op_sonido=1; End End
			If(opcion==4) Break; End
		End
		delete_text(txt_opmusic);
		delete_text(txt_opsombras);
		delete_text(txt_opsonido);
		If(ops.op_sombras==1) Set_text_color(color_texto[0]); txt_opsombras=write(fnt1,550,300,4,TExtos[33]); Else Set_text_color(color_texto[0]); txt_opsombras=write(fnt1,550,300,4,TExtos[34]); End
		If(ops.op_music==1) Set_text_color(color_texto[0]); txt_opmusic=write(fnt1,550,250,4,TExtos[33]); Else Set_text_color(color_texto[0]); txt_opmusic=write(fnt1,550,250,4,TExtos[34]); End
		If(ops.op_sonido==1) Set_text_color(color_texto[0]); txt_opsonido=write(fnt1,550,350,4,TExtos[33]); Else Set_text_color(color_texto[0]); txt_opsonido=write(fnt1,550,350,4,TExtos[34]); End
		Frame;
	Until(ganando==1)
	signal(mano,s_kill);
	delete_text(txt1);
	delete_text(txt2);
	delete_text(txt3);
	delete_text(txt4);
	delete_text(txt5);
	delete_text(txt_opmusic);
	delete_text(txt_opsombras);
	delete_text(txt_opsonido);
	From size=100 To 0 Step -3; Frame; End
	If(op_guardar)
	    If(pixpangcd) 
    	    	save("c:\PiXPang\opciones.dat",ops);
	    Else                                    
    	    	save(".\opciones.dat",ops);
	    End
	End
	If(opcion==4) 
		If(is_playing_cd()) stop_cd(); End
		if(modo_juego==2)
			partidaguardada.pgpuntos[0]=p1_puntos;
			partidaguardada.pgpuntos[1]=p2_puntos;
			partidaguardada.pgplayers=players;
			partidaguardada.pgmundo=mundo;
			partidaguardada.pgvidas[0]=p1_vidas;
			partidaguardada.pgvidas[1]=p2_vidas;
			fotopartida=get_screen();
			write(fnt1,400,300,4,"Saliendo...");
			frame;
			If(op_guardar)
			    If(pixpangcd) 
		    	    	save("c:\PiXPang\partida.dat",partidaguardada);
						save_png(0,fotopartida,"c:\PiXPang\partida.png");
			    Else                                    
		    	    	save(".\partida.dat",partidaguardada);
						save_png(0,fotopartida,"./partida.png");
			    End
			End
		end
		frame;
		if(modo_juego==0) exit(0,0); else titulo(); end
	End
	ready=1;
End

Process coloca_raton();
Private
	tipo=1;
	cont_bloque;
	regalo;
	bloque_o_bola=1;
	lado_bola;
	ids_graficos[200];
Begin
	time_puesto=90;
	z=-3;
	raton=1;
	frame;
	write_int(fnt1,0,0,0,OFFSET cont_bloque);
	write_int(fnt1,450,539,4,OFFSET time_puesto);
	write_int(fnt1,800,0,2,OFFSET regalo);
	Loop
		If(x<400) lado_bola=0; Else lado_bola=1; End
		x=mouse.x;
		y=mouse.y;
		If(key(_down) AND time_puesto>40) time_puesto-=10; While(key(_down)) Frame; End End
		If(key(_up) AND time_puesto<250) time_puesto+=10; While(key(_up)) Frame; End End
		if(key(_left) and regalo>0) While(key(_left)) Frame; End regalo--; end
		if(key(_right) and regalo<11) While(key(_right)) Frame; End regalo++; end
		//regalo=rand(0,13);
		If(tipo<110 or tipo>113) size=100; End
		If(tipo==1)graph=427; End
		If(tipo==2) graph=428; End
		If(tipo==3) graph=429; End
		If(tipo==4) graph=430; End
		If(tipo==5) graph=431; End
		If(tipo==6) graph=432; End
		If(tipo==7) graph=433; End
		If(tipo==8) graph=434; End
		If(tipo==9) graph=435; End
		If(tipo==10) graph=436; End
		If(tipo==11) graph=437; End
		If(tipo==12) graph=438; End
		If(tipo==101) graph=701; End
		If(tipo==102) graph=702; End
		If(tipo==103) graph=703; End
		If(tipo==104) graph=704; End
		If(tipo==105) graph=705; End
		If(tipo==106) graph=711; End
		If(tipo==107) graph=713; End
		If(tipo==108) graph=715; End
		If(tipo==109) graph=716; End
		If(tipo==110) graph=801; size=33; End
		If(tipo==111) graph=801; size=66; End
		If(tipo==112) graph=801; size=100; End
		If(tipo==113) graph=717; End
		If(tipo==114) graph=718; End
		If(tipo==115) graph=719; End
		If(tipo==116) graph=720; End
		If(tipo==117) graph=721; End 
		If(tipo==118) tipo=119; End
		If(tipo==119) graph=723; End 
		if(tipo==120) graph=724; end 
 		if(tipo==121) graph=725; end 
		if(tipo==122) graph=726; end

		If(key(_space)) 
			While(key(_space)) Frame; End 
			If(bloque_o_bola==1) 
				tipo=101; bloque_o_bola=0; 
			Else 
				bloque_o_bola=1; tipo=1; 
			End 
		End
		If(key(_z) AND cont_bloque=>0) signal(ids_graficos[cont_bloque],s_kill); cont_bloque--; While(key(_z)) Frame; End End
		If(mouse.right==1) If((tipo<12 AND bloque_o_bola==1) OR (tipo<122 AND bloque_o_bola==0)) tipo++; Else If(bloque_o_bola==1) tipo=1; Else tipo=101; End End While(mouse.right==1) Frame; End End
		If(mouse.left==1) 
			If(tipo<100) 
				ids_graficos[cont_bloque]=bloques(x,y,regalo,tipo); 
			Else 
				ids_graficos[cont_bloque]=bola(x,y,tipo-100,lado_bola); 
			End
			pantalla.bx[cont_bloque]=x;
			pantalla.by[cont_bloque]=y;
			pantalla.btipo[cont_bloque]=tipo;
			pantalla.br[cont_bloque]=regalo;
			cont_bloque++;
			While(mouse.left==1) Frame; End 
		End
		pantalla.btime=time_puesto;
		If(cont_bloque==200) Break; End
		Frame;
	End
	raton=0;
End

Process crear_pantalla();
Private
	el_input;
Begin
	ready=0;
	matabolas=0;
	dinamita=0;
	p1_muere=3;
	players=1;
	mouse.graph=0;
	p1_vidas=2987;
	let_me_alone();
	put_screen(0,1);
	coloca_raton();
	anim_global();
	delete_text(all_text);
	write(0,0,0,0,textos[37]);
	write(0,0,8,0,textos[38]);
	write(0,0,16,0,textos[39]);
	write(0,0,24,0,textos[40]);
	write(0,0,32,0,textos[41]);
	write(0,0,40,0,textos[42]);
	write(0,0,48,0,textos[43]);
	Loop
		If(key(_n)) let_me_alone(); load(".\pantallas\cero.pang",pantalla); While(key(_n)) Frame; End coloca_raton(); anim_global(); End
		If(key(_p)) let_me_alone(); pon_pantalla(-2); anim_global(); p1_muere=0; id_p1=muneco1(); p1_arma=2; p1_disparos[1]=0; p1_disparos[2]=0; escenario(); delete_text(all_text); ready=1; itemreloj(3); End
		If(key(_l)) let_me_alone(); pon_pantalla(-1); anim_global(); While(key(_l)) Frame; End While(!key(_enter)) Frame; End delete_text(all_text); coloca_raton(); End
		If(key(_s)) 
			el_input=Input(100,560,256,"pant1");
			While(!key(_enter))
				Frame;
			End
		        While(!key(_enter))
				Frame;
	                End
			delete_text(all_text);
			If(pixpangcd) 
			    save("c:\PiXPang\pantallas\" + entry + ".pang",pantalla); 
			Else                                                              
			    save(".\pantallas\" + entry + ".pang",pantalla);
			End
			While(key(_enter)) Frame; End
			write(0,0,0,0,"S - Guardar");
			write(0,0,8,0,"L - Cargar");
			write(0,0,16,0,"N - Borrar");
			write(0,0,24,0,"Esc - Salir");
			write(0,0,32,0,"Raton Izq - Coloca");
			write(0,0,40,0,"Raton Der - Siguiente tipo");
			write(0,0,48,0,"Espacio - Elige bola/bloque");
			signal(s_kill,el_input);
		End
		If(key(_esc)) let_me_alone(); modo_juego=0; id_titulo=titulo(); End
		Frame;
	End
End

Process pon_pantalla(num);
Private
	cont_bloque;
	tipo;
	regalo;
	lado_bola;
	el_input;
Begin
	While(key(_enter)) Frame; End
	if(mundo==4) jefe=2; end
	if(mundo==9) jefe=3; end
	if(mundo==14) jefe=4; end
	if(mundo==19) jefe=5; end
	if(mundo==79) jefe=6; end
	If(num==-1) 
		el_input=Input(100,560,256,"pant1");
		While(!key(_enter))
			Frame;
		End
		delete_text(all_text);
		If(pixpangcd) 
		    load("c:\PiXPang\pantallas\" + entry + ".pang",pantalla); 
		Else 
		    load(".\pantallas\" + entry + ".pang",pantalla); 
		End
	End
	If((num=>0 and num<100) and jefe==0) load(".\tour\"+num+".pang",pantalla); end
	If(jefe!=0) load(".\tour\mostro.pang",pantalla); end
//----------ENGLAND TOUR
	If(num==100 AND mod_england==1) load(".\england\tour\eng1.pang",pantalla); End
	If(num==101 AND mod_england==1) load(".\england\tour\eng2.pang",pantalla); End
	If(num==102 AND mod_england==1) load(".\england\tour\eng3.pang",pantalla); End
	If(num==103 AND mod_england==1) load(".\england\tour\eng4.pang",pantalla); End
//----------ANDORRA TOUR
	If(num==100 AND mod_andorra==1) load(".\andorra\tour\and1.pang",pantalla); End
	If(num==101 AND mod_andorra==1) load(".\andorra\tour\and2.pang",pantalla); End
	If(num==102 AND mod_andorra==1) load(".\andorra\tour\and3.pang",pantalla); End
	If(num==103 AND mod_andorra==1) load(".\andorra\tour\and4.pang",pantalla); End
	If(num==104 AND mod_andorra==1) load(".\andorra\tour\and5.pang",pantalla); End
//----------CUSTOM TOUR
	If(num=>100 AND mod_custom==1 AND pixpangcd) load("c:\PiXPang\custom\tour\"+itoa(num-99)+".pang",pantalla); End
	If(num=>100 AND mod_custom==1 AND pixpangcd==0) load(".\custom\tour\"+itoa(num-99)+".pang",pantalla); End
	if(jefe==0) fondos_tour(); end
	While(cont_bloque<200)
		x=pantalla.bx[cont_bloque];
		y=pantalla.by[cont_bloque];
		regalo=pantalla.br[cont_bloque];
		tipo=pantalla.btipo[cont_bloque];
		If(x<400) lado_bola=0; Else lado_bola=1; End
		If(tipo<100) bloques(x,y,regalo,tipo); Else bola(x,y,tipo-100,lado_bola); End
		Frame;
		cont_bloque++;
	End
	time_puesto=pantalla.btime;
	If(num!=-1) tiempo(pantalla.btime); End
	p1_muere=0; 
	p2_muere=0;
End

Process cocodrilo(lado); // a quien no le guste que no explote que se joda xD
Private
	id_bola;
	cont_giros;
	grav;
	id_disp;
Begin
	cocos++;
	If(lado==0) x=0; flags=1; Else x=800; flags=0; End
	y=466;
	z=-2;
	Repeat
		While(ready==0 OR reloj==1) Frame; End
		If(ganando==1) Break; End
		If(animglobal<15) graph=312; End
		If(animglobal=>15 AND animglobal<30) graph=311; End
		If(animglobal=>30 AND animglobal<45) graph=310; End
		If(animglobal=>45) graph=311; End
		If(lado==0) x+=2; Else x-=2; End
		If(x=>770 AND lado==0 AND cont_giros<3) cont_giros++; lado=1; If(cheto_borracho==1) flags=1; Else flags=0; End End
		If(x=<30 AND lado==1 AND cont_giros<3) cont_giros++; lado=0; If(cheto_borracho==1) flags=0; Else flags=1; End End
		If(x>850 OR x<-50) Return; End
		Frame;
	Until((collision(Type disp_saf)) OR (id_disp=collision(Type cachodisp)) OR (id_disp=collision(Type cachodisp2)) OR (id_disp=collision(Type cachodisp3)) OR (id_disp=collision(Type cachodisp4)) OR (id_disp=collision(Type dispcab) OR (id_disp=collision(Type dispcab2)) OR (id_disp=collision(Type dispcab3)) OR (id_disp=collision(Type dispcab4))))
	If((collision(Type cachodisp) OR collision(Type dispcab)) AND (collision(Type cachodisp2) OR collision(Type dispcab2))) 
		signal(p1_disparos[1],s_kill); p1_disparos[1]=0; signal(p1_disparos[2],s_kill); p1_disparos[2]=0; 
	Else
		If(p1_arma==4) signal(id_disp,s_kill); End
		If(collision(Type cachodisp) OR collision(Type dispcab)) signal(p1_disparos[1],s_kill); p1_disparos[1]=0; End
		If(collision(Type cachodisp2) OR collision(Type dispcab2)) signal(p1_disparos[2],s_kill); p1_disparos[2]=0;  End
	End
	If((collision(Type cachodisp3) OR collision(Type dispcab3)) AND (collision(Type cachodisp4) OR collision(Type dispcab4))) 
		signal(p2_disparos[1],s_kill); p2_disparos[1]=0; signal(p2_disparos[2],s_kill); p2_disparos[2]=0; 
	Else
		If(p2_arma==4) signal(id_disp,s_kill); End
		If(collision(Type cachodisp) OR collision(Type dispcab)) signal(p2_disparos[1],s_kill); p2_disparos[1]=0; End
		If(collision(Type cachodisp2) OR collision(Type dispcab2)) signal(p2_disparos[2],s_kill); p2_disparos[2]=0; End
	End
	grav=rand(100,200);
	While(y<480)
		If(ops.op_sombras==1) sombra(graph,x,y,flags,1); End
		If(flags==0) x+=12; angle+=60000; End
		If(flags==1) x-=12; angle+=60000; End
		If(x=>755) flags=1; End
		If(x=<45) flags=0; End
		grav-=5;
		y-=grav/10;
		Frame;
	End
	cocos--;
End

Process volador();
Private
	inercia;
	y_destino;
	y_destino_final;
	lado;
	id_disp;
Begin
	graph=300;
	x=rand(100,500);
	z=-2;
	cocos++;
	y_destino_final=rand(100,400);
	Repeat
		flags=lado;
		While(ready==0 OR reloj==1) Frame; End
		While(y<y_destino AND y<y_destino_final AND !collision(Type bola))
			inercia+=3;
			y+=inercia/2; 
			If(lado==1) x+=inercia*2; Else x-=inercia*2; End
			If(animglobal<15)
				graph=300; 
			End
			If(animglobal>14 AND animglobal<30) 
				graph=301;
			End
			If(animglobal>29 AND animglobal<45) 
				graph=300; 
			End
			If(animglobal>44 AND animglobal<60) 
				graph=301; 
			End
			Frame(400);
		End
		inercia=0;
		if(lado==1) x++; else x--; end
		If(collision(Type bola))
			If(lado==1) 
				While(x<850) x+=5; 
					If(animglobal<15) 
						graph=300; 
					End
					If(animglobal>14 AND animglobal<30) 
						graph=301;
					End
					If(animglobal>29 AND animglobal<45) 
						graph=300; 
					End
					If(animglobal>44 AND animglobal<60) 
						graph=301; 
					End
					Frame; 
				End 

			Else 
				While(x>-50) x+=5; 
					If(animglobal<15) 
						graph=300; 
					End
					If(animglobal>14 AND animglobal<30) 
						graph=301;
					End
					If(animglobal>29 AND animglobal<45) 
						graph=300; 
					End
					If(animglobal>44 AND animglobal<60) 
						graph=301; 
					End
					Frame;
				End
			End
			cocos--; 
			Return;
		End
		y_destino=y+30;
		If(animglobal<30) 
			graph=300;
		Else
			graph=301;
		End
		If(lado==1 AND (animglobal==60 OR y<y_destino_final)) lado=0; 
			ElseIf(lado==0 AND (animglobal==60 OR y<y_destino_final)) lado=1; 
		End
		Frame;
	Until((collision(Type disp_saf)) OR (id_disp=collision(Type cachodisp)) OR (id_disp=collision(Type cachodisp2)) OR (id_disp=collision(Type cachodisp3)) OR (id_disp=collision(Type cachodisp4)) OR (id_disp=collision(Type dispcab) OR (id_disp=collision(Type dispcab2)) OR (id_disp=collision(Type dispcab3)) OR (id_disp=collision(Type dispcab4))))
	If((collision(Type cachodisp) OR collision(Type dispcab)) AND (collision(Type cachodisp2) OR collision(Type dispcab2))) 
		signal(p1_disparos[1],s_kill); p1_disparos[1]=0; signal(p1_disparos[2],s_kill); p1_disparos[2]=0; 
	Else
		If(p1_arma==4) signal(id_disp,s_kill); End
		If(collision(Type cachodisp) OR collision(Type dispcab)) signal(p1_disparos[1],s_kill); p1_disparos[1]=0; End
		If(collision(Type cachodisp2) OR collision(Type dispcab2)) signal(p1_disparos[2],s_kill); p1_disparos[2]=0;  End
	End
	If((collision(Type cachodisp3) OR collision(Type dispcab3)) AND (collision(Type cachodisp4) OR collision(Type dispcab4))) 
		signal(p2_disparos[1],s_kill); p2_disparos[1]=0; signal(p2_disparos[2],s_kill); p2_disparos[2]=0; 
	Else
		If(p2_arma==4) signal(id_disp,s_kill); End
		If(collision(Type cachodisp) OR collision(Type dispcab)) signal(p2_disparos[1],s_kill); p2_disparos[1]=0; End
		If(collision(Type cachodisp2) OR collision(Type dispcab2)) signal(p2_disparos[2],s_kill); p2_disparos[2]=0; End
	End
	cocos--;
	While(size>0)
		size=-5;
		angle+=25000;
		Frame;
	End
End


Process logos();
Begin
	let_me_alone();
	delete_text(all_text);
	panreyes1();
End

include "panreyes.pr-";

Process controlador_player1();
Private
	distancia;
	rata;
	gamepads;
Begin
	mouse.graph=0;

	Loop
		x=father.x;
		y=father.y;
		While(ready==0) Frame; End
		If(ops.p1_control==0)  // teclado
			If(key(_left)) botones.p1[0]=1; Else botones.p1[0]=0; End
			If(key(_right)) botones.p1[1]=1; Else botones.p1[1]=0; End
			If(key(_up)) botones.p1[2]=1; Else botones.p1[2]=0; End
			If(key(_down)) botones.p1[3]=1; Else botones.p1[3]=0; End
			If(key(_control) OR key(_space)) botones.p1[4]=1; Else botones.p1[4]=0; End
			If(key(_z)) botones.p1[5]=1; Else botones.p1[5]=0; End
		End
		If(ops.p1_control==1)  // raton
			If(raton==0) raton=1; rata=puntero_raton(); End
			distancia=get_distx(0,rata);
			If(father.x>mouse.x+7 AND distancia>10) botones.p1[0]=1; Else botones.p1[0]=0; End
			If(father.x<mouse.x-7 AND distancia>10) botones.p1[1]=1; Else botones.p1[1]=0; End
			If(mouse.right) botones.p1[0]=0; botones.p1[1]=0; End
			If(mouse.right AND father.y>mouse.y) botones.p1[2]=1; Else botones.p1[2]=0; End
			If(mouse.right AND father.y<mouse.y) botones.p1[3]=1; Else botones.p1[3]=0; End
			If(mouse.left) botones.p1[4]=1; Else botones.p1[4]=0; End
			If(mouse.middle) botones.p1[5]=1; Else botones.p1[5]=0; End
		End
		If(ops.p1_control==2)  // joystick
			
			If(get_joy_position(0)<-10000) botones.p1[0]=1; Else botones.p1[0]=0; End
			If(get_joy_position(0)>10000) botones.p1[1]=1; Else botones.p1[1]=0; End
			If(get_joy_position(1)<-7500) botones.p1[2]=1; Else botones.p1[2]=0; End
			If(get_joy_position(1)>7500) botones.p1[3]=1; Else botones.p1[3]=0; End
			If(get_joy_button(0) OR get_joy_button(1)) botones.p1[4]=1; Else botones.p1[4]=0; End
			If(get_joy_button(2) OR get_joy_button(3)) botones.p1[5]=1; Else botones.p1[5]=0; End
		End
		Frame;
	End
End

Process controlador_player2();
Private
	distancia;
	rata;
Begin

	Loop
		x=father.x;
		y=father.y;
		While(ready==0) Frame; End
		If(ops.p2_control==0)  // teclado
			If(key(_left)) botones.p2[0]=1; Else botones.p2[0]=0; End
			If(key(_right)) botones.p2[1]=1; Else botones.p2[1]=0; End
			If(key(_up)) botones.p2[2]=1; Else botones.p2[2]=0; End
			If(key(_down)) botones.p2[3]=1; Else botones.p2[3]=0; End
			If(key(_control) OR key(_space)) botones.p2[4]=1; Else botones.p2[4]=0; End
			If(key(_z)) botones.p2[5]=1; Else botones.p2[5]=0; End
		End
		If(ops.p2_control==1)  // raton
			If(raton==0) raton=1; rata=puntero_raton(); End
			distancia=get_distx(0,rata);
			If(father.x>mouse.x+7 AND distancia>10) botones.p2[0]=1; Else botones.p2[0]=0; End
			If(father.x<mouse.x-7 AND distancia>10) botones.p2[1]=1; Else botones.p2[1]=0; End
			If(mouse.right) botones.p2[0]=0; botones.p2[1]=0; End
			If(mouse.right AND father.y>mouse.y) botones.p2[2]=1; Else botones.p2[2]=0; End
			If(mouse.right AND father.y<mouse.y) botones.p2[3]=1; Else botones.p2[3]=0; End
			If(mouse.left) botones.p2[4]=1; Else botones.p2[4]=0; End
			If(mouse.middle) botones.p2[5]=1; Else botones.p2[5]=0; End
		End
		If(ops.p2_control==2)  // joystick
	            If(get_joy_position(0)<-10000) botones.p2[0]=1; Else botones.p2[0]=0; End
       		    If(get_joy_position(0)>10000) botones.p2[1]=1; Else botones.p2[1]=0; End
            If(get_joy_position(1)<-7500) botones.p2[2]=1; Else botones.p2[2]=0; End                        
			If(get_joy_position(1)>7500) botones.p2[3]=1; Else botones.p2[3]=0; End
			If(get_joy_button(0) OR get_joy_button(1)) botones.p2[4]=1; Else botones.p2[4]=0; End
			If(get_joy_button(2) OR get_joy_button(3)) botones.p2[5]=1; Else botones.p2[5]=0; End
		End
		Frame;
	End
End

Process modo_safari();
Private
	bolas_restantes;
	texto_1[1];
	texto_2[1];
Begin
	if(ops.p1_personaje==1) file=load_fpg(".\fpg\chars1.fpg"); end
	if(ops.p1_personaje==2) file=load_fpg(".\fpg\chars2.fpg"); end
	if(ops.p1_personaje==3) file=load_fpg(".\fpg\chars3.fpg"); end
	if(ops.p1_personaje==4) file=load_fpg(".\fpg\chars4.fpg"); end
	if(ops.p1_personaje==5) file=load_fpg(".\fpg\chars5.fpg"); end
	if(ops.p1_personaje==6) file=load_fpg(".\fpg\chars6.fpg"); end
	if(ops.p1_personaje==7) file=load_fpg(".\fpg\chars7.fpg"); end
	modo_juego=3; jefe=0; bolas=0;
	delete_text(all_text);
	start_scroll(0,0,fondo_safari,0,0,1);
	scroll.camera=id;
	x=400;
	ctype=c_scroll;
	p1_disparos[0]=0;
	p1_muere=0;
	bolas=0;
	marcadores();
	While(key(_enter)) Frame; End
	queco_safari();
	anim_global();
	readyando();
	Set_text_color(color_texto[0]);
	texto_1[0]=write(fnt1,30,80,0,textos[44]);
	texto_2[0]=write_int(fnt1,120,112,0,OFFSET bolas_restantes);
	transicion=0;
	Loop
		If(cocos<3 AND (rand(0,2000)==0 OR key(_c))) If(rand(0,1)==0) cocodrilo(1); Else volador(); End End
		bolas_restantes=128-p1_bolas;
		velocidad=300-(p1_bolas/4);
		If(bolas<6 AND p1_bolas!=128 AND jefe==0) bola_saf(rand(0,9),1000,300); End
		If(p1_bolas=>128 AND jefe==0) delete_text(texto_1[0]);delete_text(texto_1[1]);delete_text(texto_2[0]);delete_text(texto_2[1]); bolas=1000; jefe_saf(); End
		If(ready==1) x+=2; End
		If(p1_muere==2)
			If(p1_vidas>0)
				ready=0;
				p1_disparos[0]=0;
				p1_muere=0;
				queco_safari();
				readyando();
				vidasp1();
			Else
				stop_scroll(0);
				let_me_alone();
				gameover();
			End
			velocidad=200-(p1_bolas);		
		End
		If(pixpangcd==1 AND timer[8]>13100 AND ops.op_music==1) timer[8]=0; musica(0); End
		Frame(velocidad);
	End
End

Process puntero_raton();
Private
	tamano;
	txt_bola;
	escribido;
	angulo_raton;
	id_bola;
	mousexant;
	mouseyant;
Begin
	mouse.graph=0;
	graph=517;
	z=-255;
	While(modo_juego==3)
		While(ready==0) Frame; End
		x=mouse.x;
		y=mouse.y;
		If(tamano==1) size++; Else size--; End
		If(size==70) tamano=0; End
		If(size==50) tamano=1; End
		If(!collision(Type bola_saf)) angulo_raton=fget_angle(father.x,father.y,x,y); 
		Else
			angle+=18000;
		End
		angle=angulo_raton;
		If(escribido==1) delete_text(txt_bola); End
		If(collision(Type bola_saf)) txt_bola=write(0,x,y,4,textos[45]); escribido=1; size=100; tamano=0; flags=0; End
		Frame;
	End
	While(modo_juego==2 OR modo_juego==1)
		if(mousexant!=mouse.x or mouseyant!=mouse.y) alpha=255; else if(alpha>1) alpha-=2; end end
		mousexant=mouse.x;
		mouseyant=mouse.y;
		x=mouse.x;
		y=mouse.y;
		angulo_raton=fget_angle(father.x,father.y,x,y);
		angle=angulo_raton;
		Frame;
	End
End

Process queco_safari();
Private
	anim;
	ratangle;
	parpadeas;
	grav;
	distancia;
Begin
	raton=puntero_raton();
	x=-30;
	y=462;
	file=file_muneco1;
	graph=502;
	z=-1;
	Loop
		If(key(_esc) or key(_p) or key(_enter) or key(95)) opciones(); ready=0; End
		While(ganando==1)
			graph=507;
			Frame;
			End
		While(ready==0)
			Frame;
			End
		If(y=<461)
			grav-=5;
			y-=grav/10;
			mouse.y-=grav/10;
		Else
			y=462;
			grav=0;
			timer[4]=0;
		End
		If((key(_a) OR key(_left)) AND x>80) x-=4; mouse.x-=4; End
		If((key(_s) OR key(_down)) AND mouse.y<500) mouse.y+=10; End
		If((key(_w) OR key(_up)) AND mouse.y>18) mouse.y-=10; End
		If((key(_d) OR key(_right)) AND x<500) x+=4; mouse.x+=4; End
		ratangle=fget_angle(x,y,mouse.x,mouse.y);
		distancia=get_dist(raton)/32;
		If(mouse.left AND p1_disparos[0]==0) p1_disparos[0]=disp_saf(ratangle,distancia); End
		If(mouse.right AND y==462) grav=120; y--; End
		If(mouse.x<x) flags=1; Else flags=0; End
		If(x<80) x+=2; End
		If(anim<11)
			anim++;
		Else
			anim=0;
		End
		If(graph<506 AND anim>10)
			graph++; 
		End
		If(graph==506) 
			graph=502;
		End
		If(parpadeas<200) parpadeas++; p1_muere=0; alpha=128; else alpha=255; end
		If(p1_muere==1 and parpadeas>199) Break; End
		Frame(velocidad/2);
	End
	ready=0;
	suena(s4);
	vidap1fuera=1;
	grav=rand(50,250);
	While(y<480)
		If(ops.op_sombras==1) sombra(graph,x,y,flags,1); End
		If(flags==0) x+=12; End
		If(flags==1) x-=12; End
		If(x=>755) flags=1; End
		If(x=<45) flags=0; End
		If(grav>0) graph=508; End 
		If(grav<0) graph=509; End 
		grav-=5;
		y-=grav/10;
		Frame;
	End
	suena(s5);
	signal(raton,s_kill);
	p1_muere=3;
	p1_vidas--;
End

Process disp_saf(disp_angle,fuerza);
Private
	bolas_petas;
	id_bola;
	id_bolanterior;
	grav;
	giro;
Begin
	suena(s1);
	z=-2;
	x=father.x;
	y=father.y;
	graph=518;
	size=75;
	grav=100;
	While(!collision(Type grafico))
		If(y=<462)
			angle=giro;
			angle+=6000;
			grav-=5;
			y-=grav/10;
			giro=angle;
		Else
			Break;
		End
		If(id_bola=collision(Type bola_saf)) If(id_bola!=id_bolanterior) bolas_petas++; id_bolanterior=id_bola; End End
		disp_saf_sombra();
		Frame;
		angle=disp_angle;
		advance(fuerza);
	End
	If(bolas_petas>1) If(exists(txt_safari_combo)) signal(txt_safari_combo,s_kill); End txt_safari_combo=texto_fondos("¡"+bolas_petas+"x Combo!"); p1_puntos+=400*(bolas_petas*2); End
	p1_disparos[0]=0;
End

Process disp_saf_sombra();
Begin
	graph=father.graph;
	x=father.x;
	y=father.y;
	size=father.size;
	angle=father.angle;
	alpha=128;
	while(alpha>0)
		alpha-=8;
		frame;
	end
End

Process disp_jefe_saf(disp_angle,fuerza);
Private
	grav;
	giro;
Begin
	suena(s1);
	z=-2;
	x=father.x;
	y=father.y;
	graph=518;
	size=75;
	grav=100;
	While(!collision(Type grafico))
		If(y=<462)
			angle=giro;
			angle+=6000;
			grav-=5;
			y-=grav/10;
			giro=angle;
		Else
			Break;
		End
		If(collision(Type queco_safari)) p1_muere=1; Break; End
		disp_saf_sombra();
		Frame;
		angle=disp_angle;
		advance(fuerza);
	End
	p1_disparos[1]=0;
End	

Process jefe_saf();
Private
	ang_disp;
	distancia;
	grav;
	s_muere; s_1; s_2; s_3;
	s_aleatorio;
	cont2;
Begin
	jefe=1;        
	vidasp2();
	p1_disparos[1]=0;
	z=-2;
	x=830;
	y=462;
	musica(7);
	contaor=5;
	Repeat
	        If(cont2<60) alpha=128; Else alpha=255; End
		bolas=6;
		cont2++;
		If(x>740) x--; End
		graph=552+(animglobal/20);
		ang_disp=rand(170000,100000);
		distancia=rand(10,18);
		If(p1_disparos[1]==0 AND ready==1) disp_jefe_saf(ang_disp,distancia); p1_disparos[1]=1; End
		flags=1;
		Frame;
	        If(collision(Type disp_saf) AND cont2>60)
			contaor--;
			cont2=0;
			s_aleatorio=rand(1,3);
			Frame;
		End
	Until(contaor==0)
	grav=rand(100,200);
	vidap2fuera=1;
	While(y<480)
		If(ops.op_sombras==1) sombra(graph,x,y,flags,1); End
		If(flags==0) x+=12; angle+=60000; End
		If(flags==1) x-=12; angle+=60000; End
		If(x=>755) flags=1; End
		If(x=<45) flags=0; End
		grav-=5;
		y-=grav/10;
		Frame;
	End
	jefe=2;
	ganar();
End

Process bola_saf(tamano,x,y); //tamano 1:pekeña 2:medio-pekeña 3:medio-grande 4:grande
Private
	grav;
	grav_org;
	ancho_bola;
	altura_bola;
	ancho_bloque;
	alto_bloque;
	id_disp;
	rota;
	toca;
	lao;
Begin
	lao=0;
	//x=rand(900,1200);
	zbolas--;
	z=zbolas;
	bolas++;     
	If(tamano<1 OR tamano>12) bolas--; Return; End
	If(tamano==1) graph=701; grav_org=60; End
	If(tamano==2) graph=702; grav_org=70; End
	If(tamano==3) graph=703; grav_org=80; End
	If(tamano==4) graph=704; grav_org=90; End 
	If(tamano==5) graph=705; grav_org=100; End
	If(tamano==6) graph=711; grav_org=90; End
	If(tamano==7) graph=713; grav_org=100; End
	If(tamano==8) graph=715; grav_org=110; End
	If(tamano==9) graph=716; grav_org=120; End
	If(tamano==10) graph=715; grav_org=110; End
	If(tamano==11) graph=716; grav_org=120; End
	If(tamano==12) graph=716; grav_org=120; End
	ancho_bola=graphic_info(0,graph,g_wide);
	altura_bola=graphic_info(0,graph,g_height);
	Repeat
		If(ops.op_sombras==1) sombra(graph,x,y,flags,1); End
		If(parpadea==1) If(flags==0) flags=4; Else flags=0; End End
		If(dinamita==1 AND tamano>1 AND tamano!=6) Frame(velocidad); Break; End
		If(reloj==0 AND ready==1)
			flags=0;
			x-=4;
			If(y>(500-(altura_bola/2))) grav=grav_org; End
			grav-=5;
			y-=6+(grav/10);
			If(collision(Type queco_safari) AND !collision(Type disp_saf)) p1_muere=1; Break; End
			If(collision(Type cocodrilo) OR collision(Type volador)) Break; End
		End
		If(x<-100) bolas--; Return; End
		Frame(velocidad);
	Until(id_disp=collision(Type disp_saf) OR matabolas==1 OR rota==1)
	If(id_disp=collision(Type disp_saf)) signal(p1_disparos[0],s_kill); p1_disparos[0]=0; End
	If(tamano!=1 AND tamano!=6) bola_saf(tamano-1,x,y); End
	If(tamano==1 OR tamano==6) size=0; End
	From graph=706 To 710; Frame(200); End
	suena(s2);
	bolas--;
	p1_bolas++;
	If(matabolas==0) p1_bonus+=100; p1_puntos+=500; End
End

Process faderaro(graphh);
Private
	nosubida;
Begin
	if(ops.op_sombras==0) return; end
	x=400;
	y=300;
	z=-512;
	if(graphh>0) graph=graphh; else

		If(graphh==0) graph=920; End
		if(graphh==-2) screenshot=get_screen(); nosubida=1; end
		if(graphh!=-1 and graph!=2) transicion=1; else graph=screenshot; nosubida=1; end
	end

	If(ops.op_sombras==1) alpha=0; End
	While(alpha<255 and transicion==1 and nosubida==0)
		alpha+=15;
		Frame;
	End
	alpha=255;
	While(transicion==1) Frame; End
	While(alpha>15 AND ops.op_sombras==1)
		alpha-=15;
		Frame;
	End
	if(graph==screenshot)
		graph=0;
		unload_map(0,screenshot);
	end
End

Process escaleras(x,y);
Begin
	graph=429;
	z=3;
	Loop
		Frame;
	End
End

Process parpadeo();
Begin
	x=400; y=300;
	z=-511;
	graph=923;
	Frame(500);
End

Process nube();
Private
	tocante;
	velosidad;
	cosaxunga;
	rolling;
	algo;
	size_inicio;
Begin
	If(rand(0,1)==1) x=800; flags=1; Else x=0; flags=0; End
	if(cheto_borracho==0) y=rand(50,200); velosidad=rand(3,8); else y=rand(300,500); velosidad=rand(8,20); end
	graph=660;
	size_inicio=rand(70,100);
	If(ops.op_sombras==1) alpha=128; End
	While(flags==1 AND x>0)
		size_x=size_inicio+(rolling/6);
		size_y=size_inicio-(rolling/5);
		if(algo==false)
			if(rolling<100) rolling+=2; else algo=true; end
		else
			if(rolling>0) rolling-=2; else algo=false; end
		end
		x-=velosidad;
		If(tocante=collision(Type bola)) tocante.x-=velosidad; tocante.y--; End
		Frame(velocidad/2);
	End
	While(flags==0 AND x<800)
		size_x=size_inicio+(rolling/6);
		size_y=size_inicio-(rolling/5);
		if(algo==false)
			if(rolling<100) rolling+=2; else algo=true; end
		else
			if(rolling>0) rolling-=2; else algo=false; end
		end
		x+=velosidad;
		If(tocante=collision(Type bola)) tocante.x+=velosidad; tocante.y--; End
		Frame(velocidad/2);
	End
End

Process guarda_juego();
Begin
	If(op_guardar)
		If(pixpangcd)
			If(file_exists("c:\pixpang\tour.sav"));
				load("c:\pixpang\tour.sav",mundo_alcanzado);
			End
			If(mundo_alcanzado<mundo)
				mundo_alcanzado=mundo;
				save("c:\pixpang\tour.sav",mundo_alcanzado);
			End
		Else
			If(file_exists("./tour.sav"));
				load("./tour.sav",mundo_alcanzado);
			End
			If(mundo_alcanzado<mundo)
				mundo_alcanzado=mundo;
				save("./tour.sav",mundo_alcanzado);
			End
		End
	End
End

include "introfenix.pr-";
include "cadenas.pr-";
include "lang.pr-";
include "demo.pr-";
//include "interfaz.pr-";
include "creditos.pr-";
include "intres.pr-";
include "records.pr-";
//include "reconline.pr-";

// MONSTRUOS
include "monstruos/ultraball.pr-";
include "monstruos/fantasma.pr-";
include "monstruos/fmars.pr-";
include "monstruos/gusano.pr-";
include "monstruos/maskara.pr-";
