PGDMP     4                    z         
   Parlamento    14.5    14.5 �    &           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            '           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            (           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            )           1262    40965 
   Parlamento    DATABASE     h   CREATE DATABASE "Parlamento" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Italian_Italy.1252';
    DROP DATABASE "Parlamento";
                postgres    false            *           0    0 
   Parlamento    DATABASE PROPERTIES     2   ALTER DATABASE "Parlamento" CONNECTION LIMIT = 1;
                     postgres    false                        3079    40966    pldbgapi 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pldbgapi WITH SCHEMA public;
    DROP EXTENSION pldbgapi;
                   false            +           0    0    EXTENSION pldbgapi    COMMENT     Y   COMMENT ON EXTENSION pldbgapi IS 'server-side support for debugging PL/pgSQL functions';
                        false    2                       1255    41003 "   estraicognome(character varying[])    FUNCTION     5  CREATE FUNCTION public.estraicognome(character varying[]) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
 str text;
 stringa alias for $1 ;
 cognome text;
 aa text;
-- i int;
lettera char;
parlamentare character varying;
parlamentare2 char[];
i int;
begin
--i=0;
FOREACH parlamentare IN ARRAY $1
loop --{SELECT  CONCAT ( 'M', ' ', 'P')  AS name
   for i in 0..30 loop
     parlamentare2[i] = parlamentare.getchar();
	 end loop;
   foreach lettera in array parlamentare2 
   loop
      str = CONCAT(str ,'', lettera
				--substring(
	   --(select parlamentare as stringa from attivita_parlamentare)
	   --(stringa)::TEXT , i , i+1)
	   ) as str;
	--   i=i+1;
   cognome = str;
   if(lettera = ' ') 
   then return cognome;
--   else ;   -- }
	--end;-- loop;
	end if;
 --RETURN cognome;
end loop;
end loop;
end;
$_$;
 9   DROP FUNCTION public.estraicognome(character varying[]);
       public          postgres    false                       1255    41004     estraicognome(character varying)    FUNCTION     /  CREATE FUNCTION public.estraicognome(character varying) RETURNS text
    LANGUAGE plpgsql
    AS $_$declare
 str text;
 stringa alias for $1 ;
 cognome text;
 aa text;
-- i int;
lettera char[];
parlamentare character varying[];
parlamentare2 char[];
i int;
begin
--i=0;
--FOREACH parlamentare IN array stringa
--loop --{SELECT  CONCAT ( 'M', ' ', 'P')  AS name
--   for i in 0..30 loop
 --    parlamentare2[i] = parlamentare;
--	 end loop;
--	 end loop;
   --foreach lettera in array parlamentare2 
   foreach lettera in array stringa
   loop
   for i in 0..30 
   loop
   str = CONCAT(str ,'',substring(  stringa FROM stringa FOR ' ')) as str;
	--   i=i+1;
   cognome = str;
   if(lettera = ' ') 
   then return cognome;
--   else ;   -- }
	--end;-- loop;
	end if;
 --RETURN cognome;
end loop;
end loop;
end;
$_$;
 7   DROP FUNCTION public.estraicognome(character varying);
       public          postgres    false                       1255    41005 #   inserimento_attivita_parlamentare()    FUNCTION     HI  CREATE FUNCTION public.inserimento_attivita_parlamentare() RETURNS trigger
    LANGUAGE plpgsql COST 10
    AS $$declare x character varying;
t boolean;
begin 
 /*1°if*/  IF EXISTS (select 1 from timbratura_giornaliera where new.data=timbratura_giornaliera.data
        --      and timbratura_giornaliera.presenza='presente' 
          --    and new.parlamentare=timbratura_giornaliera.parlamentare
					 )
		   THEN /*1°if*/
			  foreach x in array new.parlamentare
               loop
      /*2°IF*/  if ((x=(select parlamentare from timbratura_giornaliera where timbratura_giornaliera.parlamentare=x) )
		          and 'presente'=(select presenza from timbratura_giornaliera where timbratura_giornaliera.presenza='presente'
								  and 
							  timbratura_giornaliera.parlamentare=x
								 ))
                then
                   t=true;
                else
                   t=false;
                   raise exception '% parlamentare assente il %', x, new.data;
                end if; /*2°IF*/
               end loop;
	           IF t=true  /*3°if data*/
               THEN --RETURN NEW; 
                   CASE
                   WHEN new.data IN (select data from ordine_del_giorno_ass_cam_e_sen where ordine_del_giorno_ass_cam_e_sen.data=new.data)
                   THEN --DATA 
                        if new.tipo_assemblea in (select tipo_assemblea from ordine_del_giorno_ass_cam_e_sen where ordine_del_giorno_ass_cam_e_sen.tipo_assemblea=new.tipo_assemblea)
                        then --TIPO ASSEMBLEA
                            if new.seduta_numero in (select seduta_numero from ordine_del_giorno_ass_cam_e_sen where ordine_del_giorno_ass_cam_e_sen.seduta_numero=new.seduta_numero)
                            THEN --SEDUTA_NUMERO    
                                CASE
                                    WHEN new.ddl in (select ddl from ordine_del_giorno_ass_cam_e_sen where new.ddl=ordine_del_giorno_ass_cam_e_sen.ddl 
                                                          --   and ordine_del_giorno_ass_cam_e_sen.data=new.data
													)
                                    THEN                            
                                        CASE
                                            WHEN new.commissione_camera in (select nome from commissioni_camera where new.commissione_camera=commissioni_camera.nome)
                                            THEN return new;
                                            WHEN new.commissione_senato in (select nome from commissioni_senato where new.commissione_senato=commissioni_senato.nome)
                                            THEN return new; 
                                            WHEN new.commissione_camera is null
                                            THEN return new;
                                            WHEN new.commissione_senato is null
                                            THEN return new; 
                                            ELSE RAISE EXCEPTION 'commissione non presente';
                                        END CASE;
                                    WHEN new.ddl in (select ddl from esame_ddl_e_presentazione_ddl_senato where new.ddl=esame_ddl_e_presentazione_ddl_senato.ddl 
                                                           and esame_ddl_e_presentazione_ddl_senato.data=new.data )
                                    THEN
                                        CASE
                                            WHEN new.commissione_camera in (select nome from commissioni_camera where new.commissione_camera=commissioni_camera.nome)
                                            THEN return new;
                                            WHEN new.commissione_senato in (select nome from commissioni_senato where new.commissione_senato=commissioni_senato.nome)
                                            THEN return new;  
                                            WHEN new.commissione_camera is null
                                            THEN return new;
                                            WHEN new.commissione_senato is null
                                            THEN return new;
                                            ELSE RAISE EXCEPTION 'commissione non presente';
                                        END CASE;
                                    WHEN new.ddl in (select ddl from esame_ddl_e_presentazione_ddl_camera where new.ddl=esame_ddl_e_presentazione_ddl_camera.ddl 
                                                          and esame_ddl_e_presentazione_ddl_camera.data=new.data)
                                    THEN
                                        CASE
                                            WHEN new.commissione_camera in (select nome from commissioni_camera where new.commissione_camera=commissioni_camera.nome)
                                            THEN return new;
                                            WHEN new.commissione_senato in (select nome from commissioni_senato where new.commissione_senato=commissioni_senato.nome)
                                            THEN return new;  
                                            WHEN new.commissione_camera is null
                                            THEN return new;
                                            WHEN new.commissione_senato is null
                                            THEN return new;
                                            ELSE RAISE EXCEPTION 'commissione non presente';
                                        END CASE; 
                                    ELSE RAISE EXCEPTION 'DDL non presente';                                       
                                END CASE;        
                            ELSE --SEDUTA NUMERO
                            RAISE EXCEPTION '% numero della seduta errato', NEW.seduta_numero;
                            end if; --SEDUTA_NUMERO
                        else --TIPO ASSEMBLEA
                            if new.tipo_assemblea is null
                            then
                                CASE
                                    WHEN new.commissione_camera in (select nome from commissioni_camera where new.commissione_camera=commissioni_camera.nome)
                                    THEN return new;
                                    WHEN new.commissione_senato in (select nome from commissioni_senato where new.commissione_senato=commissioni_senato.nome)
                                    THEN return new;  
                                    WHEN new.commissione_camera is null
                                    THEN return new;
                                    WHEN new.commissione_senato is null
                                    THEN return new;
                                    ELSE RAISE EXCEPTION 'commissione non presente';
                                END CASE;
                            else RAISE EXCEPTION '% tipo assemblea errato', NEW.tipo_assemblea;
                            end if;
                        end if; --TIPO ASSEMBLEA
               WHEN --DATA
                   new.data in (select data from esame_ddl_e_presentazione_ddl_camera where esame_ddl_e_presentazione_ddl_camera.data=new.data)
               THEN --DATA 2 
                   if new.tipo_assemblea in (select tipo_assemblea from ordine_del_giorno_ass_cam_e_sen where ordine_del_giorno_ass_cam_e_sen.tipo_assemblea=new.tipo_assemblea)
                   then
                       if new.seduta_numero in (select seduta_numero from ordine_del_giorno_ass_cam_e_sen where ordine_del_giorno_ass_cam_e_sen.seduta_numero=new.seduta_numero)
                       then 
                           CASE
                               WHEN new.ddl in (select ddl from ordine_del_giorno_ass_cam_e_sen where new.ddl=ordine_del_giorno_ass_cam_e_sen.ddl 
                                                and ordine_del_giorno_ass_cam_e_sen.data=new.data )
                               THEN                            
                                   CASE
                                       WHEN new.commissione_camera in (select nome from commissioni_camera where new.commissione_camera=commissioni_camera.nome)
                                       THEN return new;
                                       WHEN new.commissione_senato in (select nome from commissioni_senato where new.commissione_senato=commissioni_senato.nome)
                                       THEN return new; 
                                       WHEN new.commissione_camera is null
                                       THEN return new;
                                       WHEN new.commissione_senato is null
                                       THEN return new; 
                                       ELSE RAISE EXCEPTION 'commissione non presente';
                                   END CASE;                            
                               WHEN new.ddl in (select ddl from esame_ddl_e_presentazione_ddl_senato where new.ddl=esame_ddl_e_presentazione_ddl_senato.ddl 
                                                 and esame_ddl_e_presentazione_ddl_senato.data=new.data )
                               THEN
                                   CASE
                                       WHEN new.commissione_camera in (select nome from commissioni_camera where new.commissione_camera=commissioni_camera.nome)
                                       THEN return new;
                                       WHEN new.commissione_senato in (select nome from commissioni_senato where new.commissione_senato=commissioni_senato.nome)
                                       THEN return new;
                                       WHEN new.commissione_camera is null
                                       THEN return new;
                                       WHEN new.commissione_senato is null
                                       THEN return new;  
                                       ELSE RAISE EXCEPTION 'commissione non presente';
                                   END CASE;
                               WHEN new.ddl in (select ddl from esame_ddl_e_presentazione_ddl_camera where new.ddl=esame_ddl_e_presentazione_ddl_camera.ddl 
                                                and esame_ddl_e_presentazione_ddl_camera.data=new.data)
                               THEN
                                   CASE
                                       WHEN new.commissione_camera in (select nome from commissioni_camera where new.commissione_camera=commissioni_camera.nome)
                                       THEN return new;
                                       WHEN new.commissione_senato in (select nome from commissioni_senato where new.commissione_senato=commissioni_senato.nome)
                                       THEN return new;
                                       WHEN new.commissione_camera is null
                                       THEN return new;
                                       WHEN new.commissione_senato is null
                                       THEN return new;  
                                       ELSE RAISE EXCEPTION 'commissione non presente';
                                   END CASE;
                               ELSE RAISE EXCEPTION 'DDL non presente';       
                               END CASE;
                       else RAISE EXCEPTION '% numero della seduta errato', NEW.seduta_numero;
                       end if;
                   else 
                       if new.tipo_assemblea is null
                       then
                           CASE
                               WHEN new.commissione_camera in (select nome from commissioni_camera where new.commissione_camera=commissioni_camera.nome)
                               THEN return new;
                               WHEN new.commissione_senato in (select nome from commissioni_senato where new.commissione_senato=commissioni_senato.nome)
                               THEN return new;     
                               WHEN new.commissione_camera is null
                               THEN return new;
                               WHEN new.commissione_senato is null
                               THEN return new;
                               ELSE RAISE EXCEPTION 'commissione non presente';
                           END CASE;
                       else RAISE EXCEPTION '% tipo assemblea errato', NEW.tipo_assemblea;
                       end if;
                   end if;
               WHEN new.data in (select data from esame_ddl_e_presentazione_ddl_senato where esame_ddl_e_presentazione_ddl_senato.data=new.data)
               THEN --DATA3
                   if new.tipo_assemblea in (select tipo_assemblea from ordine_del_giorno_ass_cam_e_sen where ordine_del_giorno_ass_cam_e_sen.tipo_assemblea=new.tipo_assemblea)
                   then
                       if new.seduta_numero in (select seduta_numero from ordine_del_giorno_ass_cam_e_sen where ordine_del_giorno_ass_cam_e_sen.seduta_numero=new.seduta_numero)
                       then 
                           CASE
                               WHEN new.ddl in (select ddl from ordine_del_giorno_ass_cam_e_sen where new.ddl=ordine_del_giorno_ass_cam_e_sen.ddl 
                                                and ordine_del_giorno_ass_cam_e_sen.data=new.data )
                               THEN                            
                                   CASE
                                       WHEN new.commissione_camera in (select nome from commissioni_camera where new.commissione_camera=commissioni_camera.nome)
                                       THEN return new;
                                       WHEN new.commissione_senato in (select nome from commissioni_senato where new.commissione_senato=commissioni_senato.nome)
                                       THEN return new;  
                                       WHEN new.commissione_camera is null
                                       THEN return new;
                                       WHEN new.commissione_senato is null
                                       THEN return new;
                                       ELSE RAISE EXCEPTION 'commissione non presente';
                                   END CASE;                           
                               WHEN new.ddl in (select ddl from esame_ddl_e_presentazione_ddl_senato where new.ddl=esame_ddl_e_presentazione_ddl_senato.ddl 
                                                and esame_ddl_e_presentazione_ddl_senato.data=new.data )
                               THEN
                                   CASE
                                       WHEN new.commissione_camera in (select nome from commissioni_camera where new.commissione_camera=commissioni_camera.nome)
                                       THEN return new;
                                       WHEN new.commissione_senato in (select nome from commissioni_senato where new.commissione_senato=commissioni_senato.nome)
                                       THEN return new;
                                       WHEN new.commissione_camera is null
                                       THEN return new;
                                       WHEN new.commissione_senato is null
                                       THEN return new;  
                                       ELSE RAISE EXCEPTION 'commissione non presente';
                                   END CASE;
                               WHEN new.ddl in (select ddl from esame_ddl_e_presentazione_ddl_camera where new.ddl=esame_ddl_e_presentazione_ddl_camera.ddl 
                                                and esame_ddl_e_presentazione_ddl_camera.data=new.data)
                               THEN
                                   CASE
                                       WHEN new.commissione_camera in (select nome from commissioni_camera where new.commissione_camera=commissioni_camera.nome)
                                       THEN return new;
                                       WHEN new.commissione_senato in (select nome from commissioni_senato where new.commissione_senato=commissioni_senato.nome)
                                       THEN return new;  
                                       WHEN new.commissione_camera is null
                                       THEN return new;
                                       WHEN new.commissione_senato is null
                                       THEN return new;
                                       ELSE RAISE EXCEPTION 'commissione non presente';
                                   END CASE; 
                               ELSE RAISE EXCEPTION 'DDL non presente';       
                           END CASE;
                       else RAISE EXCEPTION '% numero della seduta errato', NEW.seduta_numero;
                       end if;
                   else 
                    if new.tipo_assemblea is null
                            then
                                CASE
                                    WHEN new.commissione_camera in (select nome from commissioni_camera where new.commissione_camera=commissioni_camera.nome)
                                    THEN return new;
                                    WHEN new.commissione_senato in (select nome from commissioni_senato where new.commissione_senato=commissioni_senato.nome)
                                    THEN return new;  
                                    WHEN new.commissione_camera is null
                                    THEN return new;
                                    WHEN new.commissione_senato is null
                                    THEN return new;
                                    ELSE RAISE EXCEPTION 'commissione non presente';
                                END CASE;
                            else RAISE EXCEPTION '% tipo assemblea errato', NEW.tipo_assemblea;
                            end if;
                    end if; 
               --ELSE DATA 3
               ELSE RAISE EXCEPTION '% data non presente nella tabella esame_ddl_e_presentazione_ddl_senato', NEW.data;
           END CASE; --DATA 
       ELSE 
	       RAISE EXCEPTION 'parlamentare assente nel array %',new.parlamentare;
           --IF not exists (select 1 from timbratura_giornaliera where new.parlamentare=timbratura_giornaliera.parlamentare)
          -- THEN RAISE EXCEPTION '% PARLAMENTARE INESISTENTE', NEW.parlamentare;
          -- ELSE RAISE EXCEPTION '% PARLAMENTARE ASSENTE IL % PER CUI NON PUò AVER EFFETTUATO NESSUNA ATTIVITà PARLAMENTARE', new.parlamentare, NEW.data;
          -- end if;
       END IF;
	   END IF;
end;$$;
 :   DROP FUNCTION public.inserimento_attivita_parlamentare();
       public          postgres    false                       1255    41007    inserimento_in_intervento()    FUNCTION       CREATE FUNCTION public.inserimento_in_intervento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin --1°IF
   IF EXISTS (select 1 from timbratura_giornaliera where new.data=timbratura_giornaliera.data
              and timbratura_giornaliera.presenza='presente' 
              and new.parlamentare=timbratura_giornaliera.parlamentare)
   THEN RETURN NEW; 
   ELSE RAISE EXCEPTION '% PARLAMENTARE ASSENTE IL % PER CUI NON PUò AVER EFFETTUATO NESSUN intervento', new.parlamentare, NEW.data;
   END IF;
end;$$;
 2   DROP FUNCTION public.inserimento_in_intervento();
       public          postgres    false                       1255    41008     inserimento_in_legge_approvata()    FUNCTION     C  CREATE FUNCTION public.inserimento_in_legge_approvata() RETURNS trigger
    LANGUAGE plpgsql COST 1000
    AS $$begin
if exists (select 1 from legge_approvata
where NEW.titolo = legge_approvata.titolo )
   THEN 
        RAISE EXCEPTION '% già ESISTENTE IN leggeapprovata', new.titolo;
   ELSE  --RETURN new;
       if new.titolo in (select titolo from ddl,promulgazione where new.titolo=ddl.titolo and ddl.promulgato='si' and ddl.titolo=promulgazione.ddl)
       then 
           if new.relatore in (select relatore from ddl where new.relatore=ddl.relatore and new.titolo=ddl.titolo)
           then
               if new.legislatura in (select numero from legislatura,promulgazione where new.legislatura=legislatura.numero and 
                                              promulgazione.data between legislatura.data_inizio and legislatura.data_fine)
               then
                   if new.testo in (select testo from ddl where new.testo=ddl.testo)
                   then
                       if new.favorevoli in (select votazione.favorevoli from votazione where votazione.data=
                                                (select MAX(votazione.data) from votazione,ddl where tipo_assemblea='senato' and
                                                       votazione.ddl=ddl.titolo))
                       then
                           if new.contrari in (select votazione.contrari  from votazione where votazione.data=
                                                (select MAX(votazione.data) from votazione,ddl where tipo_assemblea='senato' and
                                                        votazione.ddl=ddl.titolo))
                           then
                               if new.astenuti in (select votazione.astenuti  from votazione where votazione.data=
                                                    (select MAX(votazione.data) from votazione,ddl where tipo_assemblea='senato' and
                                                         votazione.ddl=ddl.titolo))
                               then
                                   if new.data_promulgazione in (select data from promulgazione,legislatura where new.data_promulgazione=promulgazione.data and 
                                                               promulgazione.data between legislatura.data_inizio and legislatura.data_fine)
                                   then
                                       if new.promulgata_da in (select presidente from promulgazione where new.promulgata_da=promulgazione.presidente)
                                       then
                                           if new.num_legge in (select votazione.codice  from votazione  where votazione.data=
                                               (select MAX(votazione.data) from votazione,ddl where tipo_assemblea='senato' and 
                                                        votazione.ddl=ddl.titolo))
                                           then
                                               if new.data_approvazione_camera in (select MAX(votazione.data) from votazione,ddl where tipo_assemblea='camera' and votazione.ddl=ddl.titolo)
                                               then 
                                                   if new.data_approvazione_senato in (select MAX(votazione.data) from votazione,ddl where tipo_assemblea='senato' and votazione.ddl=ddl.titolo)
                                                   then
                                                       if new.assenti in (select votazione.assenti from votazione where votazione.data=(select MAX(votazione.data) from votazione,ddl where tipo_assemblea='senato' and votazione.ddl=ddl.titolo))
                                                       then
                                                           if new.missione in (select votazione.missione from votazione where votazione.data=(select MAX(votazione.data) from votazione,ddl where tipo_assemblea='senato' and votazione.ddl=ddl.titolo))
														   then
														       if new.num_legge in (select votazione.codice from votazione where votazione.data=(select MAX(votazione.data) from votazione,ddl where tipo_assemblea='senato' and votazione.ddl=ddl.titolo))
															   then return new;
															   else RAISE EXCEPTION '% num_legge errato', new.num_legge;
															   end if;
                                                           else RAISE EXCEPTION '% numero dei parlamentari in missione errato', new.missione;
                                                           end if;
                                                       else RAISE EXCEPTION '% numero degli assenti errato', new.assenti;
                                                       end if;
                                                   else RAISE EXCEPTION '% data approvazione senato errata', new.data_approvazione_senato;
                                                   end if;
                                               else RAISE EXCEPTION '% data approvazione camera errata', new.data_approvazione_camera;
                                               end if;
                                           else RAISE EXCEPTION '% numero della legge errato', new.numlegge;
                                           end if;
                                       else RAISE EXCEPTION '% presidente firmatario errato', new.promulgata_da;
                                       end if;
                                   else  RAISE EXCEPTION '% data promulgazione errata', new.data_promulgazione;
                                   end if;
                               else RAISE EXCEPTION '% numero dei voti degli astenuti errato', new.astenuti;
                               end if;
                           else RAISE EXCEPTION '% numero dei voti contrari errato', new.voti_no;
                           end if;
                       else RAISE EXCEPTION '% numero dei voti favorevoli errato', new.voti_si;
                       end if;
                   else RAISE EXCEPTION '% testo errato', new.testo;
                   end if;
               else RAISE EXCEPTION '% numero legislalutra errato', new.legislatura;
               end if;
           else RAISE EXCEPTION '% relatore non presente in ddl', new.relatore;
           end if;
       else RAISE EXCEPTION '% titolo non presente in ddl', new.titolo;
       end if;
   end if;
end;

$$;
 7   DROP FUNCTION public.inserimento_in_legge_approvata();
       public          postgres    false                       1255    41009 *   inserimento_interrogazione_interpellanza()    FUNCTION       CREATE FUNCTION public.inserimento_interrogazione_interpellanza() RETURNS trigger
    LANGUAGE plpgsql COST 10
    AS $$declare x character varying;
t boolean;
begin
   --1° if
   IF EXISTS (select 1 from timbratura_giornaliera where new.data=timbratura_giornaliera.data
             -- and timbratura_giornaliera.='presente' 
              --and new.parlamentare=timbratura_giornaliera.parlamentare
              )
   --1° then
   THEN 
       foreach x in array new.parlamentare
       loop
           if x=(select parlamentare from timbratura_giornaliera where timbratura_giornaliera.parlamentare=x) and 'presente'=(select presenza from timbratura_giornaliera where timbratura_giornaliera.presenza='presente' and timbratura_giornaliera.parlamentare=x)
           then
               t=true;
           else
               t=false;
               raise exception '% parlamentare assente il %', x, new.data;
           end if; 
       end loop;

     if t=true
     then
       --2° if
       if new.tipo_assemblea is null 
       --2° then
       then
           --3° if
           if new.commissione_camera is null
           --3°then
           then
               --4°if
               if new.commissione_senato is not null
               -- 4°then
               then return new;
               -- 4° else
               else RAISE EXCEPTION 'inserire commissione o assemblea';
               -- 4° end if
               end if;
           --3° else
           else return new;
           --3° end if
           end if;
       --2°else
       else return new;
       -- 2° end if
       end if;
     else RAISE EXCEPTION 'parlamentare assente nel array %',new.parlamentare;
     end if;
   --1° else
   ELSE RAISE EXCEPTION '% data ASSENTE ', NEW.data;
   --1° end if
   END IF;
end;$$;
 A   DROP FUNCTION public.inserimento_interrogazione_interpellanza();
       public          postgres    false                       1255    41010    inserimento_modifica()    FUNCTION     �5  CREATE FUNCTION public.inserimento_modifica() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin
     if (TG_OP='UPDATE')
     then   
           insert into public.modifica(ddl, 
             data, 
             testo_modifiche, 
             commissione_camera, 
            commissione_senato,
             seduta_numero, 
             tipo_assemblea)
           values (new.titolo, --ddl
                  --data
                  (select data from attivita_parlamentare where new.titolo=attivita_parlamentare.ddl and 
                  (tipo_assemblea='camera' or tipo_assemblea='senato'or commissione_camera<>null or commissione_senato<>null)),
                  new.testo, --testo_modifiche
                  --commissione_camera
                  (select commissione_camera from attivita_parlamentare where new.titolo=attivita_parlamentare.ddl and 
                  (tipo_assemblea='camera' or tipo_assemblea='senato'or commissione_camera<>null or commissione_senato<>null)),
                  --  commissione_senato 
                  (select commissione_senato from attivita_parlamentare where new.titolo=attivita_parlamentare.ddl and 
                  (tipo_assemblea='camera' or tipo_assemblea='senato'or commissione_camera<>null or commissione_senato<>null)),
                   --seduta_numero 
                  (select seduta_numero from attivita_parlamentare where new.titolo=attivita_parlamentare.ddl and 
                   (tipo_assemblea='camera' or tipo_assemblea='senato'or commissione_camera<>null or commissione_senato<>null)),
                   --tipo_assemblea 
                  (select tipo_assemblea from attivita_parlamentare where new.titolo=attivita_parlamentare.ddl and
                  (tipo_assemblea='camera' or tipo_assemblea='senato'or commissione_camera<>null or commissione_senato<>null))
                  );
                 RETURN NEW;
     else raise notice '% non trovato', new.titolo;
     END IF;
end;

/*begin
     IF EXISTS (select data,ddl,seduta_numero,tipo_assemblea from attivita_parlamentare
                 where new.data=attivita_parlamentare.data 
                 and new.ddl=attivita_parlamentare.ddl and 
                  new.tipo_assemblea=attivita_parlamentare.tipo_assemblea 
                 and new.seduta_numero=attivita_parlamentare.seduta_numero)
     THEN
         new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
         return new;
     ELSE
         IF EXISTS (select data,ddl,seduta_numero,commissione_camera from attivita_parlamentare
                 where new.data=attivita_parlamentare.data 
                 and new.ddl=attivita_parlamentare.ddl and 
                  new.commissione_camera=attivita_parlamentare.commissione_camera 
                 and new.seduta_numero=attivita_parlamentare.seduta_numero)
         THEN
             new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
             return new;
         ELSE 
             IF EXISTS (select data,ddl,seduta_numero,commissione_senato from attivita_parlamentare
                 where new.data=attivita_parlamentare.data 
                 and new.ddl=attivita_parlamentare.ddl and 
                  new.commissione_senato=attivita_parlamentare.commissione_senato 
                 and new.seduta_numero=attivita_parlamentare.seduta_numero)
             THEN
                 new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
                 return new;
             ELSE 
                 raise exception 'NESSUNA MODIFICA PRESENTE IN % DATA PER QUEL DDL %', new.data,new.ddl;
             END IF;
         END IF;
     END IF;
end;















begin
     IF EXISTS (select 1 from attivita_parlamentare *
                 where new.data=attivita_parlamentare.data 
                 and new.ddl=attivita_parlamentare.ddl and 
                  new.tipo_assemblea=attivita_parlamentare.tipo_assemblea 
                 and new.seduta_numero=attivita_parlamentare.seduta_numero)
     THEN
         new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
         return new;
     ELSE
         IF EXISTS (select 1 from attivita_parlamentare *
                 where new.data=attivita_parlamentare.data 
                 and new.ddl=attivita_parlamentare.ddl and 
                  new.commissione_camera=attivita_parlamentare.commissione_camera 
                 and new.seduta_numero=attivita_parlamentare.seduta_numero)
         THEN
             new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
             return new;
         ELSE 
             IF EXISTS (select 1 from attivita_parlamentare *
                 where new.data=attivita_parlamentare.data 
                 and new.ddl=attivita_parlamentare.ddl and 
                  new.commissione_senato=attivita_parlamentare.commissione_senato 
                 and new.seduta_numero=attivita_parlamentare.seduta_numero)
             THEN
                 new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
                 return new;
             ELSE 
                 raise exception 'NESSUNA MODIFICA PRESENTE IN % DATA PER QUEL DDL %', new.data,new.ddl;
             END IF;
         END IF;
     END IF;
end;











































begin
     CASE WHEN (NEW.ddl in (select ddl from attivita_parlamentare))
     THEN
          IF EXISTS (select 1 from attivita_parlamentare *
                 where new.data=attivita_parlamentare.data 
                 and new.ddl=attivita_parlamentare.ddl and 
                  new.tipo_assemblea=attivita_parlamentare.tipo_assemblea 
                 and new.seduta_numero=attivita_parlamentare.seduta_numero)
           THEN 
               BEGIN
                    new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
                     return new;
               END; 
           ELSE
               IF EXISTS (select 1 from attivita_parlamentare *
                 where new.data=attivita_parlamentare.data 
                 and new.ddl=attivita_parlamentare.ddl and 
                  new.commissione_camera=attivita_parlamentare.commissione_camera 
                 and new.seduta_numero=attivita_parlamentare.seduta_numero)
               THEN begin
                    new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
                     return new;
                    end;
               ELSE 
                   IF EXISTS (select 1 from attivita_parlamentare *
                             where new.data=attivita_parlamentare.data 
                             and new.ddl=attivita_parlamentare.ddl and 
                              new.commissione_senato=attivita_parlamentare.commissione_senato 
                             and new.seduta_numero=attivita_parlamentare.seduta_numero)
                   THEN begin
                          new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
                          return new;
                        end;
                   END IF;
                END IF;
           END IF;     
     end--WHEN
     
CASE WHEN (NEW.ddl in (select ddl from interrogazione_interpellanza))
THEN
          --new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
          --return new;
          IF EXISTS (select 1 from interrogazione_interpellanza
                 where new.data=interrogazione_interpellanza.data 
                 and new.ddl=interrogazione_interpellanza.ddl and 
                  new.tipo_assemblea=interrogazione_interpellanza.tipo_assemblea 
                 and new.seduta_numero=interrogazione_interpellanza.seduta_numero)
           THEN 
               BEGIN
                    new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
                     return new;
               END; 
           ELSE
               IF EXISTS (select 1 from interrogazione_interpellanza
                 where new.data=interrogazione_interpellanza.data 
                 and new.ddl=interrogazione_interpellanza.ddl and 
                  new.commissione_camera=interrogazione_interpellanza.commissione_camera 
                 and new.seduta_numero=interrogazione_interpellanza.seduta_numero)
               THEN begin
                    new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
                     return new;
                    end;
               ELSE 
                   IF EXISTS (select 1 from interrogazione_interpellanza
                             where new.data=interrogazione_interpellanza.data 
                             and new.ddl=interrogazione_interpellanza.ddl and 
                              new.commissione_senato=interrogazione_interpellanza.commissione_senato 
                             and new.seduta_numero=interrogazione_interpellanza.seduta_numero)
                   THEN begin
                          new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
                          return new;
                        end;
                   END IF;
                END IF;
           END IF;     
     end
     
     CASE WHEN (NEW.ddl in (select ddl from intervento))
     THEN
          --new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
          --return new;
          IF EXISTS (select 1 from intervento
                 where new.data=intervento.data 
                 and new.ddl=intervento.ddl and 
                  new.tipo_assemblea=intervento.tipo_assemblea 
                 and new.seduta_numero=intervento.seduta_numero)
           THEN 
               BEGIN
                    new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
                     return new;
               END; 
           ELSE
               IF EXISTS (select 1 from intervento
                 where new.data=interrogazione_interpellanza.data 
                 and new.ddl=intervento.ddl and 
                  new.commissione_camera=intervento.commissione_camera 
                 and new.seduta_numero=intervento.seduta_numero)
               THEN begin
                    new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
                     return new;
                    end;
               ELSE 
                   IF EXISTS (select 1 from intervento
                             where new.data=intervento.data 
                             and new.ddl=intervento.ddl and 
                              new.commissione_senato=intervento.commissione_senato 
                             and new.seduta_numero=intervento.seduta_numero)
                   THEN begin
                          new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
                          return new;
                        end;
                   ELSE raise exception 'NESSUNA MODIFICA PRESENTE IN % DATA PER QUEL DDL %', new.data,new.ddl;
                   END IF;
                END IF;
           END IF;     
     end
/*(NewTuple.beer NOT IN
(SELECT name FROM Beers))*/

/*
     IF EXISTS (select 1 from attivita_parlamentare *
                 where new.data=attivita_parlamentare.data 
                 and new.ddl=attivita_parlamentare.ddl and 
                  new.tipo_assemblea=attivita_parlamentare.tipo_assemblea 
                 and new.seduta_numero=attivita_parlamentare.seduta_numero)
     THEN begin
         new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
         return new;
         end;
     ELSE
         IF EXISTS (select 1 from attivita_parlamentare *
                 where new.data=attivita_parlamentare.data 
                 and new.ddl=attivita_parlamentare.ddl and 
                  new.commissione_camera=attivita_parlamentare.commissione_camera 
                 and new.seduta_numero=attivita_parlamentare.seduta_numero)
         THEN begin
             new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
             return new;
             end;
         ELSE 
             IF EXISTS (select 1 from attivita_parlamentare *
                 where new.data=attivita_parlamentare.data 
                 and new.ddl=attivita_parlamentare.ddl and 
                  new.commissione_senato=attivita_parlamentare.commissione_senato 
                 and new.seduta_numero=attivita_parlamentare.seduta_numero)
             THEN begin
                 new.numero_modifiche=(select count(ddl)from modifica where ddl=new.ddl )+1;
                 return new;
                 end;
             ELSE 
                 raise exception 'NESSUNA MODIFICA PRESENTE IN % DATA PER QUEL DDL %', new.data,new.ddl;
             END IF;
         END IF;
     END IF;*/
end;





































/* CASE WHEN (NEW.titolo=ddl.titolo and testo<>ddl.testo)
     THEN  
           insert into public.modifica(ddl, 
            numero_modifiche,
             data, 
			 numero_modifiche,
             testo_modifiche, 
             commissione_camera, 
            commissione_senato,
             seduta_numero, 
             tipo_assemblea)
           values(NEW.titolo,    
                  modifica.data=(select...), --la data la prende da attività parlamentare
                  numero_modifiche+1,
                  new.testo, 
                  modifica.commissione_camera=(select...), --idem o ordine del giorno
                  modifica.commissione_senato=(select...),--idem
                  modifica.seduta_numero=(select...), --idem
                  modifica.tipo_assemblea=(select...));--idem
         end if;
         end case;*/

*/

$$;
 -   DROP FUNCTION public.inserimento_modifica();
       public          postgres    false                       1255    41011    inserimento_promulgazione()    FUNCTION     V  CREATE FUNCTION public.inserimento_promulgazione() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin

if exists (select 1 from ddl where NEW.ddl = ddl.titolo )
then 
       if 'approvata'=(select esito from votazione where tipo_assemblea='camera'and data=(select max(votazione.data) from votazione 
               where tipo_assemblea='camera'))
       then
           if 'approvata'=(select esito from votazione where tipo_assemblea='senato' and data=(select max(votazione.data) from votazione 
               where tipo_assemblea='senato'))
           then
               return new;
           else raise exception '% non approvato al senato', new.ddl;
           end if;
       else raise exception '% non approvato alla camera', new.ddl;
       end if;
else
    raise exception '% ddl non presente', new.ddl;
end if;
end;
$$;
 2   DROP FUNCTION public.inserimento_promulgazione();
       public          postgres    false                       1255    41012    inserimento_pubblicazione()    FUNCTION     
  CREATE FUNCTION public.inserimento_pubblicazione() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin
   if exists (select 1 from legge_approvata
              where NEW.titolo_legge = legge_approvata.titolo and  
                 ( extract(year from new.data_pubblicazione), extract(month from new.data_pubblicazione)) = 
                 ( extract(year from legge_approvata.data_promulgazione), extract(month from legge_approvata.data_promulgazione))
             )
   then
        select count(*)
        into new.leggi_legislatura  
        from legge_approvata AS la 
        where NEW.titolo_legge = la.titolo 
        and date_trunc('month', new.data_pubblicazione) = date_trunc('month', la.data_promulgazione)
        and la.legislatura = new.legislatura;
        new.tot_num_leggi=(select count(*) from legge_approvata);
        return new;
   else
       raise exception '% non è stata promulgata nello stesso mese e anno %',new.titolo_legge, legge_approvata.data_promulgazione;
   end if;
end;


$$;
 2   DROP FUNCTION public.inserimento_pubblicazione();
       public          postgres    false                       1255    41013    inserimento_votazione()    FUNCTION     �  CREATE FUNCTION public.inserimento_votazione() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin 
--CASE WHEN TG_OP = 'INSERT' THEN TRUE ELSE OLD.name <> NEW.name END
--IF(CASE WHEN TG_OP = 'INSERT' THEN TRUE ELSE TG_OP='COPY' END)
--if ( TG_OP='COPY public.voto FROM') -- TG_OP='INSERT' or
--     then   
           insert into public.votazione(
           mozione,
           ddl,
           codice,
           favorevoli,
           votanti,
           contrari,
           astenuti,
           esito,
           tipo_assemblea,
           seduta_numero,
           data,
           assenti,
           missione)    
    values (
            (select codice from mozione 
			 where codice=new.mozione and mozione.data=new.data),--mozione, 
	 (select ddl from ordine_del_giorno_ass_cam_e_sen where ordine_del_giorno_ass_cam_e_sen.data=
	  (SELECT MAX(ordine_del_giorno_ass_cam_e_sen.data) FROM ordine_del_giorno_ass_cam_e_sen)),--ddl	
     (select codice from ddl where ddl.titolo=
	  (select ddl from ordine_del_giorno_ass_cam_e_sen where ordine_del_giorno_ass_cam_e_sen.data=
	  (SELECT MAX(ordine_del_giorno_ass_cam_e_sen.data) FROM ordine_del_giorno_ass_cam_e_sen))), --codice, 
     (select count(*) from voto where data=(select max(voto.data) 
         from voto,ordine_del_giorno_ass_cam_e_sen 
         where voto.ddl=ordine_del_giorno_ass_cam_e_sen.ddl 
         and   voto.data=ordine_del_giorno_ass_cam_e_sen.data) 
     and voto_palese='Favorevole'), --favorevoli, 
     ((select count(*) from voto where data=(select max(voto.data) 
         from voto,ordine_del_giorno_ass_cam_e_sen 
         where voto.ddl=ordine_del_giorno_ass_cam_e_sen.ddl 
         and   voto.data=ordine_del_giorno_ass_cam_e_sen.data) 
     and voto_palese='Favorevole')
     +(select count(*) from voto where data=(select max(voto.data) 
         from voto,ordine_del_giorno_ass_cam_e_sen 
         where voto.ddl=ordine_del_giorno_ass_cam_e_sen.ddl 
         and   voto.data=ordine_del_giorno_ass_cam_e_sen.data) 
     and voto_palese='Contrario')), --votanti, 
     (select count(*) 
    from voto 
    where data=
              (select max(voto.data) 
              from voto,ordine_del_giorno_ass_cam_e_sen 
              where voto.ddl=ordine_del_giorno_ass_cam_e_sen.ddl 
                and   voto.data=ordine_del_giorno_ass_cam_e_sen.data) 
     and voto_palese='Contrario'), --contrari, 
     (select count(*) 
    from voto 
    where data=
              (select max(voto.data) 
              from voto,ordine_del_giorno_ass_cam_e_sen 
              where voto.ddl=ordine_del_giorno_ass_cam_e_sen.ddl 
                and   voto.data=ordine_del_giorno_ass_cam_e_sen.data) 
     and voto_palese='Astenuto'), -- astenuti, 
		-- if(
	  case when(
				 (select count(*) from voto where voto.data= --voto.data
				 (select max(voto.data) from voto,ordine_del_giorno_ass_cam_e_sen 
                  where voto.ddl=ordine_del_giorno_ass_cam_e_sen.ddl 
			      and voto.data=ordine_del_giorno_ass_cam_e_sen.data)
			and voto_palese='Favorevole') 
			 >=
			 (select 
distinct((((select count(*) from voto where voto.data=
		(select max(voto.data) from voto,ordine_del_giorno_ass_cam_e_sen 
              where voto.ddl=ordine_del_giorno_ass_cam_e_sen.ddl 
                and   voto.data=ordine_del_giorno_ass_cam_e_sen.data) 
     and voto_palese='Favorevole') 
		+
	(select count(*) from voto where voto.data= 
       (select max(voto.data) from voto,ordine_del_giorno_ass_cam_e_sen 
         where voto.ddl=ordine_del_giorno_ass_cam_e_sen.ddl 
          and voto.data=ordine_del_giorno_ass_cam_e_sen.data) 
     and voto_palese='Contrario')) /2) 
		  +1) 
		  from voto)
	 )
		 /*end boolean expression del case C2*/
         then 'approvato'
         else 'non approvato' 
         end,  --esito
		 (select distinct(ordine_del_giorno_ass_cam_e_sen.tipo_assemblea )
          from ordine_del_giorno_ass_cam_e_sen,voto 
          where ordine_del_giorno_ass_cam_e_sen.data=voto.data 
          and voto.data=(select max(voto.data) from voto)), --tipo_assemblea
     (select seduta_numero from ordine_del_giorno_ass_cam_e_sen where data=(SELECT max(ordine_del_giorno_ass_cam_e_sen.data) 
	  from ordine_del_giorno_ass_cam_e_sen,voto where  
       ordine_del_giorno_ass_cam_e_sen.data=voto.data)), --seduta_numero, 
     (SELECT max(ordine_del_giorno_ass_cam_e_sen.data) 
	  from ordine_del_giorno_ass_cam_e_sen,voto where  
       ordine_del_giorno_ass_cam_e_sen.data=voto.data), --data, 
     (select count(*) from voto where voto_palese='Assente' and voto.data=
	 (SELECT max(ordine_del_giorno_ass_cam_e_sen.data) 
	  from ordine_del_giorno_ass_cam_e_sen,voto where  
       ordine_del_giorno_ass_cam_e_sen.data=voto.data)), --assenti, 
     ( select count(*) from voto where voto_palese='In missione'
		 and data=(SELECT max(ordine_del_giorno_ass_cam_e_sen.data) 
	  from ordine_del_giorno_ass_cam_e_sen,voto where  
       ordine_del_giorno_ass_cam_e_sen.data=voto.data)
	 ) -- missione
     ); 
     RETURN new;
--
--else raise notice 'nessun voto inserito';
--
--end if;
end;
$$;
 .   DROP FUNCTION public.inserimento_votazione();
       public          postgres    false                       1255    41014    inserimento_voto()    FUNCTION     7
  CREATE FUNCTION public.inserimento_voto() RETURNS trigger
    LANGUAGE plpgsql COST 1000
    AS $$begin
   IF new.data in (select data from ordine_del_giorno_ass_cam_e_sen
				  where new.data=ordine_del_giorno_ass_cam_e_sen.data)
				  --(select data from timbratura_giornaliera 
								--  where timbratura_giornaliera.data=new.data))
   THEN --1° IF
       --2°if
       if new.ddl in (select ddl from ordine_del_giorno_ass_cam_e_sen where 
                       tipo_assemblea='camera' or tipo_assemblea='senato')
       then --2°if
           if new.parlamentare in (select nome from deputato,timbratura_giornaliera where new.parlamentare=deputato.nome
								  and new.parlamentare=timbratura_giornaliera.parlamentare) --where--, 
            --3° if                          
   /*3°if*/then  
     /*4°if*/ -- IF EXISTS (select 1 from timbratura_giornaliera where new.data=timbratura_giornaliera.data
              --            and new.parlamentare=timbratura_giornaliera.parlamentare)
            --   then/*4°if*/ 
                   return new;
            --   else/*4°if*/ 
			  -- raise notice 'non esiste in timbratura_giornaliera quella data %',new.data;
			--   end if; /*4°if*/ 
 /*3°if*/ else 
              /*5°if*/
			  if new.parlamentare in (select nome from senatore,timbratura_giornaliera where new.parlamentare=senatore.nome
									 and new.parlamentare=timbratura_giornaliera.parlamentare)
              then /*5°if*/
                   /*6°if*/ 
				 --  IF EXISTS (select 1 from timbratura_giornaliera where new.data=timbratura_giornaliera.data
                  --          and new.parlamentare=timbratura_giornaliera.parlamentare)
                        /*6°if*/
					--	then   
                            return new;
                  --      else /*6°if*/
			      --          raise notice 'data non presente in timbratura_giornaliera %', new.data;
                  --      end if;  /*6°if*/
			  else/*5°if*/
			      raise notice 'parlamentare non presente % in senatore', new.parlamentare;
              end if;/*5°if*/
		  end if; /*3° if*/
			--raise notice 'data non presente in timbratura_giornaliera %', new.data;
			--end if; /*4° if*/               
       /*3°if*/              
      -- else 
	  -- raise notice 'parlamentare non presente % in deputato', new.parlamentare;
   --    end if;/*3°if*/
	 else /*2° if*/
	   raise notice 'ddl non presente in ordine del giorno %', new.ddl;
	   end if; /*2° if*/
   else --1°if
       raise notice 'non esiste nessuna data in ordine_del_giorno_ass_cam_e_sen come %',new.data;
end if;
end;
$$;
 )   DROP FUNCTION public.inserimento_voto();
       public          postgres    false                       1255    41015    process_ddl_audit()    FUNCTION     �  CREATE FUNCTION public.process_ddl_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin
--usa la variabile TG_OP PER selezionare l'operazione
if(TG_OP='DELETE')THEN
INSERT INTO modifica3 SELECT 'D', now(), USER, OLD.*;
REtURN OLD;
ELSIF(TG_OP='UPDATE')THEN
INSERT INTO modifica3 SELECT 'U', now(), USER, NEW.*;
RETURN NEW;
ELSIF(TG_OP='INSERT')THEN
INSERT INTO modifica3 SELECT 'I', now(), USER, NEW.*;
RETURN NEW;
END IF;
RETURN NULL; --RISULTATO IGNORATO IN AFTER TRIGGER
end;$$;
 *   DROP FUNCTION public.process_ddl_audit();
       public          postgres    false            �            1259    41016    attivita_parlamentare    TABLE     u  CREATE TABLE public.attivita_parlamentare (
    data date NOT NULL,
    ora time with time zone NOT NULL,
    ddl character varying(1000) NOT NULL,
    commissione_camera character varying(100),
    commissione_senato character varying(100),
    seduta_numero integer NOT NULL,
    tipo_assemblea character varying(6),
    parlamentare character varying(200)[] NOT NULL
);
 )   DROP TABLE public.attivita_parlamentare;
       public         heap    postgres    false            ,           0    0    TABLE attivita_parlamentare    COMMENT     *  COMMENT ON TABLE public.attivita_parlamentare IS '--ci sono più attività parlamentari riguardanti lo stesso ddl che si svolgono
       --sia nelle varie commissioni (cam e sen) sia nelle assemblee (cam e sen), quindi è --legittima
       --la provenienza da tutte e 3 le tabelle (foreign key)';
          public          postgres    false    215            -           0    0    TABLE attivita_parlamentare    ACL     ;   GRANT ALL ON TABLE public.attivita_parlamentare TO PUBLIC;
          public          postgres    false    215            �            1259    41021    commissioni_camera    TABLE     w   CREATE TABLE public.commissioni_camera (
    nome character varying(100) NOT NULL,
    legislatura integer NOT NULL
);
 &   DROP TABLE public.commissioni_camera;
       public         heap    postgres    false            .           0    0    TABLE commissioni_camera    ACL     8   GRANT ALL ON TABLE public.commissioni_camera TO PUBLIC;
          public          postgres    false    216            �            1259    41024    commissioni_senato    TABLE     w   CREATE TABLE public.commissioni_senato (
    nome character varying(100) NOT NULL,
    legislatura integer NOT NULL
);
 &   DROP TABLE public.commissioni_senato;
       public         heap    postgres    false            /           0    0    TABLE commissioni_senato    ACL     8   GRANT ALL ON TABLE public.commissioni_senato TO PUBLIC;
          public          postgres    false    217            �            1259    41027    ddl    TABLE     O  CREATE TABLE public.ddl (
    titolo character varying(1000) NOT NULL,
    codice character(10) NOT NULL,
    testo character varying(1000),
    regioni character varying(200)[],
    cnel character varying(100),
    cittadini character varying[],
    promulgato character(2) NOT NULL,
    relatore character varying(100)[] NOT NULL
);
    DROP TABLE public.ddl;
       public         heap    postgres    false            0           0    0 	   TABLE ddl    ACL     )   GRANT ALL ON TABLE public.ddl TO PUBLIC;
          public          postgres    false    218            �            1259    41032    parlamentari    TABLE     S  CREATE TABLE public.parlamentari (
    nome character varying(100) NOT NULL,
    partito character varying(100) NOT NULL,
    circoscrizione text[] NOT NULL,
    data_nascita date,
    luogo character varying(100),
    titolo_studi character varying(100),
    mandati character varying(1000)[],
    commissioni character varying(200)[]
);
     DROP TABLE public.parlamentari;
       public         heap    postgres    false            1           0    0    TABLE parlamentari    ACL     2   GRANT ALL ON TABLE public.parlamentari TO PUBLIC;
          public          postgres    false    219            �            1259    41037    deputato    TABLE     )  CREATE TABLE public.deputato (
    nome character varying(100),
    partito character varying(100),
    circoscrizione text[],
    data_nascita date,
    luogo character varying(100),
    titolo_studi character varying(100),
    mandati character varying(1000)[]
)
INHERITS (public.parlamentari);
    DROP TABLE public.deputato;
       public         heap    postgres    false    219            2           0    0    TABLE deputato    ACL     .   GRANT ALL ON TABLE public.deputato TO PUBLIC;
          public          postgres    false    220            �            1259    41042 $   esame_ddl_e_presentazione_ddl_camera    TABLE     )  CREATE TABLE public.esame_ddl_e_presentazione_ddl_camera (
    ddl character varying(1000) NOT NULL,
    commissione character varying(100) NOT NULL,
    data date,
    attivita_parlamentare character varying(100) NOT NULL,
    ora time with time zone,
    stato character varying(30) NOT NULL
);
 8   DROP TABLE public.esame_ddl_e_presentazione_ddl_camera;
       public         heap    postgres    false            3           0    0 *   TABLE esame_ddl_e_presentazione_ddl_camera    ACL     J   GRANT ALL ON TABLE public.esame_ddl_e_presentazione_ddl_camera TO PUBLIC;
          public          postgres    false    221            �            1259    41047 $   esame_ddl_e_presentazione_ddl_senato    TABLE     )  CREATE TABLE public.esame_ddl_e_presentazione_ddl_senato (
    ddl character varying(1000) NOT NULL,
    commissione character varying(100) NOT NULL,
    data date,
    attivita_parlamentare character varying(100) NOT NULL,
    ora time with time zone,
    stato character varying(30) NOT NULL
);
 8   DROP TABLE public.esame_ddl_e_presentazione_ddl_senato;
       public         heap    postgres    false            4           0    0 *   TABLE esame_ddl_e_presentazione_ddl_senato    ACL     J   GRANT ALL ON TABLE public.esame_ddl_e_presentazione_ddl_senato TO PUBLIC;
          public          postgres    false    222            �            1259    41052    interrogazione_interpellanza    TABLE     �  CREATE TABLE public.interrogazione_interpellanza (
    data date,
    ora time with time zone,
    ddl character varying(1000),
    commissione_camera character varying(100),
    commissione_senato character varying(100),
    seduta_numero integer,
    tipo_assemblea character varying(6),
    parlamentare character varying(200)[],
    oggetto character varying(300) NOT NULL,
    destinatario character varying(100),
    testo text
)
INHERITS (public.attivita_parlamentare);
 0   DROP TABLE public.interrogazione_interpellanza;
       public         heap    postgres    false    215            5           0    0 "   TABLE interrogazione_interpellanza    ACL     B   GRANT ALL ON TABLE public.interrogazione_interpellanza TO PUBLIC;
          public          postgres    false    223            �            1259    41057 
   intervento    TABLE     u  CREATE TABLE public.intervento (
    data date,
    ora time with time zone,
    ddl character varying(1000),
    commissione_camera character varying(100),
    commissione_senato character varying(100),
    seduta_numero integer,
    tipo_assemblea character varying(6),
    parlamentare character varying(200)[],
    testo text
)
INHERITS (public.attivita_parlamentare);
    DROP TABLE public.intervento;
       public         heap    postgres    false    215            6           0    0    TABLE intervento    ACL     0   GRANT ALL ON TABLE public.intervento TO PUBLIC;
          public          postgres    false    224            �            1259    41062    legge_approvata    TABLE     �  CREATE TABLE public.legge_approvata (
    titolo character varying(1000) NOT NULL,
    legislatura integer NOT NULL,
    testo text,
    favorevoli integer,
    contrari integer,
    astenuti integer,
    data_promulgazione date,
    promulgata_da character varying(100),
    relatore character varying(100)[] NOT NULL,
    data_approvazione_camera date,
    data_approvazione_senato date,
    num_legge character(10) NOT NULL,
    assenti integer,
    missione integer
);
 #   DROP TABLE public.legge_approvata;
       public         heap    postgres    false            7           0    0    TABLE legge_approvata    ACL     5   GRANT ALL ON TABLE public.legge_approvata TO PUBLIC;
          public          postgres    false    225            �            1259    41067    legislatura    TABLE     k   CREATE TABLE public.legislatura (
    numero integer NOT NULL,
    data_inizio date,
    data_fine date
);
    DROP TABLE public.legislatura;
       public         heap    postgres    false            8           0    0    TABLE legislatura    ACL     1   GRANT ALL ON TABLE public.legislatura TO PUBLIC;
          public          postgres    false    226            �            1259    41070    missione    TABLE     �   CREATE TABLE public.missione (
    parlamentare character varying(100) NOT NULL,
    periodo daterange NOT NULL,
    destinazione character varying(100)
);
    DROP TABLE public.missione;
       public         heap    postgres    false            9           0    0    TABLE missione    ACL     .   GRANT ALL ON TABLE public.missione TO PUBLIC;
          public          postgres    false    227            �            1259    41075    modifica    TABLE     (  CREATE TABLE public.modifica (
    ddl character varying(1000) NOT NULL,
    data date NOT NULL,
    testo_modifiche text NOT NULL,
    commissione_camera character varying(100),
    commissione_senato character varying(100),
    seduta_numero integer,
    tipo_assemblea character varying(6)
);
    DROP TABLE public.modifica;
       public         heap    postgres    false            :           0    0    TABLE modifica    COMMENT       COMMENT ON TABLE public.modifica IS 'Ci sono più attività parlamentari riguardanti lo stesso ddl (interventi, interpellanze, 
interrogazioni), ma alla fine della discussione, del dibattito, la modifica sul ddl è unica 
nell''ambito della stessa riunione di assemblea o commissione, per cui ha senso inserire 
una FOREIGN KEY sulla tabella MODIFICA (ddl,data,tipo_assemblea,seduta_numero) 
che diventerebbe UNIQUE in ATTIVITA_PARLAMENTARE e ciò può essere perchè vi 
sono più interventi per lo stesso ddl nella stessa assemblea o commissione, per cui i 
diversi interventi si differenzierebbero per l''ora diversa in cui sono effettuati, anche se
 dovessero essere effettuati dallo stesso parlamentare, nell''ambito della stessa 
riunione e quindi nella stessa data.';
          public          postgres    false    228            ;           0    0    TABLE modifica    ACL     .   GRANT ALL ON TABLE public.modifica TO PUBLIC;
          public          postgres    false    228            �            1259    41080 	   modifica3    TABLE     �  CREATE TABLE public.modifica3 (
    azione character(1),
    dataeora date,
    utente character varying(30),
    titolo character varying(1000) NOT NULL,
    codice character(10) NOT NULL,
    testo character varying(1000),
    regioni character varying(200)[],
    cnel character varying(100),
    cittadini character varying[],
    promulgato character(2) NOT NULL,
    relatore character varying(100)[] NOT NULL
);
    DROP TABLE public.modifica3;
       public         heap    postgres    false            <           0    0    TABLE modifica3    ACL     /   GRANT ALL ON TABLE public.modifica3 TO PUBLIC;
          public          postgres    false    229            �            1259    41085    mozione    TABLE     }  CREATE TABLE public.mozione (
    oggetto character varying(300) NOT NULL,
    codice character(10) NOT NULL,
    testo text,
    voto_politico character(10),
    data date,
    commissione_camera character varying(100),
    commissione_senato character varying(100),
    seduta_numero integer,
    tipo_assemblea character varying(6),
    parlamentare character varying(100)[]
);
    DROP TABLE public.mozione;
       public         heap    postgres    false            =           0    0    TABLE mozione    ACL     -   GRANT ALL ON TABLE public.mozione TO PUBLIC;
          public          postgres    false    230            �            1259    41090    ordine_del_giorno_ass_cam_e_sen    TABLE       CREATE TABLE public.ordine_del_giorno_ass_cam_e_sen (
    attivita_parlamentare character varying(300),
    ddl character varying(500) NOT NULL,
    data date NOT NULL,
    seduta_numero integer NOT NULL,
    tipo_assemblea character varying(6) NOT NULL
);
 3   DROP TABLE public.ordine_del_giorno_ass_cam_e_sen;
       public         heap    postgres    false            >           0    0 %   TABLE ordine_del_giorno_ass_cam_e_sen    ACL     E   GRANT ALL ON TABLE public.ordine_del_giorno_ass_cam_e_sen TO PUBLIC;
          public          postgres    false    231            �            1259    41095    periodi_cariche    TABLE     �   CREATE TABLE public.periodi_cariche (
    nome character varying(255) NOT NULL,
    mandato_commissione character varying NOT NULL,
    periodo_carica daterange
);
 #   DROP TABLE public.periodi_cariche;
       public         heap    postgres    false            ?           0    0    TABLE periodi_cariche    ACL     5   GRANT ALL ON TABLE public.periodi_cariche TO PUBLIC;
          public          postgres    false    232            �            1259    41100    presidente_della_repubblica    TABLE     �   CREATE TABLE public.presidente_della_repubblica (
    presidente character varying(100) NOT NULL,
    data_inizio_mandato date,
    data_fine_mandato date,
    partito_di_provenienza character varying(100),
    senatore_a_vita_fino_al date
);
 /   DROP TABLE public.presidente_della_repubblica;
       public         heap    postgres    false            @           0    0 !   TABLE presidente_della_repubblica    ACL     A   GRANT ALL ON TABLE public.presidente_della_repubblica TO PUBLIC;
          public          postgres    false    233            �            1259    41103    promulgazione    TABLE     �   CREATE TABLE public.promulgazione (
    presidente character varying(100),
    data date,
    ddl character varying(500) NOT NULL,
    promulgato character(2) NOT NULL,
    rinviati character(2)
);
 !   DROP TABLE public.promulgazione;
       public         heap    postgres    false            A           0    0    TABLE promulgazione    ACL     3   GRANT ALL ON TABLE public.promulgazione TO PUBLIC;
          public          postgres    false    234            �            1259    41108    pubblicazione    TABLE     @  CREATE TABLE public.pubblicazione (
    titolo_legge character varying(500),
    legislatura integer,
    gazzetta_numero integer NOT NULL,
    data_pubblicazione date NOT NULL,
    leggi_legislatura integer,
    tot_num_leggi integer,
    testo text,
    relatore character varying[],
    numero_legge character(10)
);
 !   DROP TABLE public.pubblicazione;
       public         heap    postgres    false            B           0    0    TABLE pubblicazione    ACL     3   GRANT ALL ON TABLE public.pubblicazione TO PUBLIC;
          public          postgres    false    235            �            1259    41113    senatore    TABLE     k  CREATE TABLE public.senatore (
    nome character varying(100),
    partito character varying(100),
    circoscrizione text[],
    data_nascita date,
    luogo character varying(100),
    titolo_studi character varying(100),
    mandati character varying(1000)[],
    a_vita date,
    presidente_nominante character varying(100)
)
INHERITS (public.parlamentari);
    DROP TABLE public.senatore;
       public         heap    postgres    false    219            C           0    0    TABLE senatore    ACL     .   GRANT ALL ON TABLE public.senatore TO PUBLIC;
          public          postgres    false    236            �            1259    41118    stesura_ddl    TABLE     �   CREATE TABLE public.stesura_ddl (
    titolo_ddl character varying(500) NOT NULL,
    relatore character varying[],
    partito_relatore character varying[]
);
    DROP TABLE public.stesura_ddl;
       public         heap    postgres    false            D           0    0    TABLE stesura_ddl    ACL     1   GRANT ALL ON TABLE public.stesura_ddl TO PUBLIC;
          public          postgres    false    237            �            1259    41123    timbratura_giornaliera    TABLE     �   CREATE TABLE public.timbratura_giornaliera (
    data date NOT NULL,
    parlamentare character varying(100) NOT NULL,
    presenza character varying(20)
);
 *   DROP TABLE public.timbratura_giornaliera;
       public         heap    postgres    false            E           0    0    TABLE timbratura_giornaliera    ACL     <   GRANT ALL ON TABLE public.timbratura_giornaliera TO PUBLIC;
          public          postgres    false    238            �            1259    41126 	   votazione    TABLE     �  CREATE TABLE public.votazione (
    mozione character(10),
    ddl character varying(500) NOT NULL,
    codice character(10),
    favorevoli integer,
    votanti integer,
    contrari integer,
    astenuti integer,
    esito character(20) NOT NULL,
    tipo_assemblea character varying(6) NOT NULL,
    seduta_numero integer,
    data date NOT NULL,
    assenti integer,
    missione integer
);
    DROP TABLE public.votazione;
       public         heap    postgres    false            F           0    0    TABLE votazione    ACL     /   GRANT ALL ON TABLE public.votazione TO PUBLIC;
          public          postgres    false    239            �            1259    41131    voto    TABLE     �   CREATE TABLE public.voto (
    data date NOT NULL,
    parlamentare character varying(100) NOT NULL,
    voto_palese character(20) NOT NULL,
    ddl character varying(500) NOT NULL,
    mozione character varying(300)
);
    DROP TABLE public.voto;
       public         heap    postgres    false            G           0    0 
   TABLE voto    ACL     *   GRANT ALL ON TABLE public.voto TO PUBLIC;
          public          postgres    false    240            
          0    41016    attivita_parlamentare 
   TABLE DATA           �   COPY public.attivita_parlamentare (data, ora, ddl, commissione_camera, commissione_senato, seduta_numero, tipo_assemblea, parlamentare) FROM stdin;
    public          postgres    false    215   ��                0    41021    commissioni_camera 
   TABLE DATA           ?   COPY public.commissioni_camera (nome, legislatura) FROM stdin;
    public          postgres    false    216   ��                0    41024    commissioni_senato 
   TABLE DATA           ?   COPY public.commissioni_senato (nome, legislatura) FROM stdin;
    public          postgres    false    217   ��                0    41027    ddl 
   TABLE DATA           d   COPY public.ddl (titolo, codice, testo, regioni, cnel, cittadini, promulgato, relatore) FROM stdin;
    public          postgres    false    218   ��                0    41037    deputato 
   TABLE DATA           z   COPY public.deputato (nome, partito, circoscrizione, data_nascita, luogo, titolo_studi, mandati, commissioni) FROM stdin;
    public          postgres    false    220   ��                0    41042 $   esame_ddl_e_presentazione_ddl_camera 
   TABLE DATA           y   COPY public.esame_ddl_e_presentazione_ddl_camera (ddl, commissione, data, attivita_parlamentare, ora, stato) FROM stdin;
    public          postgres    false    221   ��                0    41047 $   esame_ddl_e_presentazione_ddl_senato 
   TABLE DATA           y   COPY public.esame_ddl_e_presentazione_ddl_senato (ddl, commissione, data, attivita_parlamentare, ora, stato) FROM stdin;
    public          postgres    false    222   e�                0    41052    interrogazione_interpellanza 
   TABLE DATA           �   COPY public.interrogazione_interpellanza (data, ora, ddl, commissione_camera, commissione_senato, seduta_numero, tipo_assemblea, parlamentare, oggetto, destinatario, testo) FROM stdin;
    public          postgres    false    223   <�                0    41057 
   intervento 
   TABLE DATA           �   COPY public.intervento (data, ora, ddl, commissione_camera, commissione_senato, seduta_numero, tipo_assemblea, parlamentare, testo) FROM stdin;
    public          postgres    false    224   G�                0    41062    legge_approvata 
   TABLE DATA           �   COPY public.legge_approvata (titolo, legislatura, testo, favorevoli, contrari, astenuti, data_promulgazione, promulgata_da, relatore, data_approvazione_camera, data_approvazione_senato, num_legge, assenti, missione) FROM stdin;
    public          postgres    false    225   ��                0    41067    legislatura 
   TABLE DATA           E   COPY public.legislatura (numero, data_inizio, data_fine) FROM stdin;
    public          postgres    false    226   ��                0    41070    missione 
   TABLE DATA           G   COPY public.missione (parlamentare, periodo, destinazione) FROM stdin;
    public          postgres    false    227   h�                0    41075    modifica 
   TABLE DATA           �   COPY public.modifica (ddl, data, testo_modifiche, commissione_camera, commissione_senato, seduta_numero, tipo_assemblea) FROM stdin;
    public          postgres    false    228   ��                0    41080 	   modifica3 
   TABLE DATA           �   COPY public.modifica3 (azione, dataeora, utente, titolo, codice, testo, regioni, cnel, cittadini, promulgato, relatore) FROM stdin;
    public          postgres    false    229   ��                0    41085    mozione 
   TABLE DATA           �   COPY public.mozione (oggetto, codice, testo, voto_politico, data, commissione_camera, commissione_senato, seduta_numero, tipo_assemblea, parlamentare) FROM stdin;
    public          postgres    false    230   �                0    41090    ordine_del_giorno_ass_cam_e_sen 
   TABLE DATA           z   COPY public.ordine_del_giorno_ass_cam_e_sen (attivita_parlamentare, ddl, data, seduta_numero, tipo_assemblea) FROM stdin;
    public          postgres    false    231   ��                0    41032    parlamentari 
   TABLE DATA           ~   COPY public.parlamentari (nome, partito, circoscrizione, data_nascita, luogo, titolo_studi, mandati, commissioni) FROM stdin;
    public          postgres    false    219   ��                0    41095    periodi_cariche 
   TABLE DATA           T   COPY public.periodi_cariche (nome, mandato_commissione, periodo_carica) FROM stdin;
    public          postgres    false    232   ��                0    41100    presidente_della_repubblica 
   TABLE DATA           �   COPY public.presidente_della_repubblica (presidente, data_inizio_mandato, data_fine_mandato, partito_di_provenienza, senatore_a_vita_fino_al) FROM stdin;
    public          postgres    false    233   ]                 0    41103    promulgazione 
   TABLE DATA           T   COPY public.promulgazione (presidente, data, ddl, promulgato, rinviati) FROM stdin;
    public          postgres    false    234   !                0    41108    pubblicazione 
   TABLE DATA           �   COPY public.pubblicazione (titolo_legge, legislatura, gazzetta_numero, data_pubblicazione, leggi_legislatura, tot_num_leggi, testo, relatore, numero_legge) FROM stdin;
    public          postgres    false    235   �                0    41113    senatore 
   TABLE DATA           �   COPY public.senatore (nome, partito, circoscrizione, data_nascita, luogo, titolo_studi, mandati, commissioni, a_vita, presidente_nominante) FROM stdin;
    public          postgres    false    236   �                 0    41118    stesura_ddl 
   TABLE DATA           M   COPY public.stesura_ddl (titolo_ddl, relatore, partito_relatore) FROM stdin;
    public          postgres    false    237   �      !          0    41123    timbratura_giornaliera 
   TABLE DATA           N   COPY public.timbratura_giornaliera (data, parlamentare, presenza) FROM stdin;
    public          postgres    false    238   �      "          0    41126 	   votazione 
   TABLE DATA           �   COPY public.votazione (mozione, ddl, codice, favorevoli, votanti, contrari, astenuti, esito, tipo_assemblea, seduta_numero, data, assenti, missione) FROM stdin;
    public          postgres    false    239   �=      #          0    41131    voto 
   TABLE DATA           M   COPY public.voto (data, parlamentare, voto_palese, ddl, mozione) FROM stdin;
    public          postgres    false    240   {>      �           2606    41137 0   attivita_parlamentare attivita_parlamentare_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.attivita_parlamentare
    ADD CONSTRAINT attivita_parlamentare_pkey PRIMARY KEY (ora, data, parlamentare);
 Z   ALTER TABLE ONLY public.attivita_parlamentare DROP CONSTRAINT attivita_parlamentare_pkey;
       public            postgres    false    215    215    215            �           2606    41139    commissioni_camera commisscampk 
   CONSTRAINT     l   ALTER TABLE ONLY public.commissioni_camera
    ADD CONSTRAINT commisscampk PRIMARY KEY (nome, legislatura);
 I   ALTER TABLE ONLY public.commissioni_camera DROP CONSTRAINT commisscampk;
       public            postgres    false    216    216            �           2606    41141 *   commissioni_senato commissioni_senato_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.commissioni_senato
    ADD CONSTRAINT commissioni_senato_pkey PRIMARY KEY (legislatura, nome);
 T   ALTER TABLE ONLY public.commissioni_senato DROP CONSTRAINT commissioni_senato_pkey;
       public            postgres    false    217    217            �           2606    41143 
   ddl ddl_pk 
   CONSTRAINT     j   ALTER TABLE ONLY public.ddl
    ADD CONSTRAINT ddl_pk PRIMARY KEY (titolo, codice, promulgato, relatore);
 4   ALTER TABLE ONLY public.ddl DROP CONSTRAINT ddl_pk;
       public            postgres    false    218    218    218    218                       2606    41145    ddl ddlcodicekey 
   CONSTRAINT     M   ALTER TABLE ONLY public.ddl
    ADD CONSTRAINT ddlcodicekey UNIQUE (codice);
 :   ALTER TABLE ONLY public.ddl DROP CONSTRAINT ddlcodicekey;
       public            postgres    false    218                       2606    41147    ddl ddlrelatorekey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.ddl
    ADD CONSTRAINT ddlrelatorekey UNIQUE (relatore);
 <   ALTER TABLE ONLY public.ddl DROP CONSTRAINT ddlrelatorekey;
       public            postgres    false    218                       2606    41149    ddl ddlrelatoretestokey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.ddl
    ADD CONSTRAINT ddlrelatoretestokey UNIQUE (relatore, testo);
 A   ALTER TABLE ONLY public.ddl DROP CONSTRAINT ddlrelatoretestokey;
       public            postgres    false    218    218                       2606    41151    ddl ddltitolocodicekey 
   CONSTRAINT     [   ALTER TABLE ONLY public.ddl
    ADD CONSTRAINT ddltitolocodicekey UNIQUE (titolo, codice);
 @   ALTER TABLE ONLY public.ddl DROP CONSTRAINT ddltitolocodicekey;
       public            postgres    false    218    218            	           2606    41153    ddl ddltitolokey 
   CONSTRAINT     M   ALTER TABLE ONLY public.ddl
    ADD CONSTRAINT ddltitolokey UNIQUE (titolo);
 :   ALTER TABLE ONLY public.ddl DROP CONSTRAINT ddltitolokey;
       public            postgres    false    218                       2606    41155    ddl ddltitolotestokey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.ddl
    ADD CONSTRAINT ddltitolotestokey UNIQUE (titolo, testo);
 ?   ALTER TABLE ONLY public.ddl DROP CONSTRAINT ddltitolotestokey;
       public            postgres    false    218    218                       2606    41157    deputato deputatonomekey 
   CONSTRAINT     S   ALTER TABLE ONLY public.deputato
    ADD CONSTRAINT deputatonomekey UNIQUE (nome);
 B   ALTER TABLE ONLY public.deputato DROP CONSTRAINT deputatonomekey;
       public            postgres    false    220                       2606    41159    deputato deputatopkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.deputato
    ADD CONSTRAINT deputatopkey PRIMARY KEY (nome, partito);
 ?   ALTER TABLE ONLY public.deputato DROP CONSTRAINT deputatopkey;
       public            postgres    false    220    220                       2606    41161 2   esame_ddl_e_presentazione_ddl_camera esddlcomsenpk 
   CONSTRAINT     �   ALTER TABLE ONLY public.esame_ddl_e_presentazione_ddl_camera
    ADD CONSTRAINT esddlcomsenpk PRIMARY KEY (ddl, commissione, stato);
 \   ALTER TABLE ONLY public.esame_ddl_e_presentazione_ddl_camera DROP CONSTRAINT esddlcomsenpk;
       public            postgres    false    221    221    221                       2606    41163 1   esame_ddl_e_presentazione_ddl_senato esddlprcampk 
   CONSTRAINT     �   ALTER TABLE ONLY public.esame_ddl_e_presentazione_ddl_senato
    ADD CONSTRAINT esddlprcampk PRIMARY KEY (ddl, commissione, stato);
 [   ALTER TABLE ONLY public.esame_ddl_e_presentazione_ddl_senato DROP CONSTRAINT esddlprcampk;
       public            postgres    false    222    222    222                       2606    41165 O   interrogazione_interpellanza interrogazione_interpellanza_data_parlamentare_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.interrogazione_interpellanza
    ADD CONSTRAINT interrogazione_interpellanza_data_parlamentare_key UNIQUE (data, parlamentare);
 y   ALTER TABLE ONLY public.interrogazione_interpellanza DROP CONSTRAINT interrogazione_interpellanza_data_parlamentare_key;
       public            postgres    false    223    223            !           2606    41167 >   interrogazione_interpellanza interrogazione_interpellanza_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.interrogazione_interpellanza
    ADD CONSTRAINT interrogazione_interpellanza_pkey PRIMARY KEY (parlamentare, oggetto);
 h   ALTER TABLE ONLY public.interrogazione_interpellanza DROP CONSTRAINT interrogazione_interpellanza_pkey;
       public            postgres    false    223    223            #           2606    41169 T   interrogazione_interpellanza interrogazioneinterpellanzasedutanumerotipoassembleakey 
   CONSTRAINT     �   ALTER TABLE ONLY public.interrogazione_interpellanza
    ADD CONSTRAINT interrogazioneinterpellanzasedutanumerotipoassembleakey UNIQUE (seduta_numero, tipo_assemblea);
 ~   ALTER TABLE ONLY public.interrogazione_interpellanza DROP CONSTRAINT interrogazioneinterpellanzasedutanumerotipoassembleakey;
       public            postgres    false    223    223            %           2606    41171    intervento intervento_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.intervento
    ADD CONSTRAINT intervento_pkey PRIMARY KEY (parlamentare, ddl, ora);
 D   ALTER TABLE ONLY public.intervento DROP CONSTRAINT intervento_pkey;
       public            postgres    false    224    224    224            '           2606    41173 1   legge_approvata leggeapprovata_numlegge_testo_key 
   CONSTRAINT     x   ALTER TABLE ONLY public.legge_approvata
    ADD CONSTRAINT leggeapprovata_numlegge_testo_key UNIQUE (num_legge, testo);
 [   ALTER TABLE ONLY public.legge_approvata DROP CONSTRAINT leggeapprovata_numlegge_testo_key;
       public            postgres    false    225    225            )           2606    41175 #   legge_approvata leggeapprovata_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.legge_approvata
    ADD CONSTRAINT leggeapprovata_pkey PRIMARY KEY (titolo, legislatura, num_legge, relatore);
 M   ALTER TABLE ONLY public.legge_approvata DROP CONSTRAINT leggeapprovata_pkey;
       public            postgres    false    225    225    225    225            +           2606    41177 D   legge_approvata leggeapprovata_titolo_numerolegislatura_relatore_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.legge_approvata
    ADD CONSTRAINT leggeapprovata_titolo_numerolegislatura_relatore_key UNIQUE (titolo, legislatura, relatore);
 n   ALTER TABLE ONLY public.legge_approvata DROP CONSTRAINT leggeapprovata_titolo_numerolegislatura_relatore_key;
       public            postgres    false    225    225    225            0           2606    41179    missione misspk 
   CONSTRAINT     `   ALTER TABLE ONLY public.missione
    ADD CONSTRAINT misspk PRIMARY KEY (parlamentare, periodo);
 9   ALTER TABLE ONLY public.missione DROP CONSTRAINT misspk;
       public            postgres    false    227    227            2           2606    41181    modifica modpk 
   CONSTRAINT     d   ALTER TABLE ONLY public.modifica
    ADD CONSTRAINT modpk PRIMARY KEY (ddl, data, testo_modifiche);
 8   ALTER TABLE ONLY public.modifica DROP CONSTRAINT modpk;
       public            postgres    false    228    228    228            4           2606    41183     mozione mozione_data_oggetto_key 
   CONSTRAINT     d   ALTER TABLE ONLY public.mozione
    ADD CONSTRAINT mozione_data_oggetto_key UNIQUE (data, oggetto);
 J   ALTER TABLE ONLY public.mozione DROP CONSTRAINT mozione_data_oggetto_key;
       public            postgres    false    230    230            6           2606    41185    mozione mozionecodicekey 
   CONSTRAINT     U   ALTER TABLE ONLY public.mozione
    ADD CONSTRAINT mozionecodicekey UNIQUE (codice);
 B   ALTER TABLE ONLY public.mozione DROP CONSTRAINT mozionecodicekey;
       public            postgres    false    230            8           2606    41187    mozione mozionepkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.mozione
    ADD CONSTRAINT mozionepkey PRIMARY KEY (oggetto, codice);
 =   ALTER TABLE ONLY public.mozione DROP CONSTRAINT mozionepkey;
       public            postgres    false    230    230            -           2606    41189    legislatura numero 
   CONSTRAINT     T   ALTER TABLE ONLY public.legislatura
    ADD CONSTRAINT numero PRIMARY KEY (numero);
 <   ALTER TABLE ONLY public.legislatura DROP CONSTRAINT numero;
       public            postgres    false    226            :           2606    41191 %   ordine_del_giorno_ass_cam_e_sen odkpk 
   CONSTRAINT     �   ALTER TABLE ONLY public.ordine_del_giorno_ass_cam_e_sen
    ADD CONSTRAINT odkpk PRIMARY KEY (data, seduta_numero, tipo_assemblea);
 O   ALTER TABLE ONLY public.ordine_del_giorno_ass_cam_e_sen DROP CONSTRAINT odkpk;
       public            postgres    false    231    231    231            <           2606    41193 _   ordine_del_giorno_ass_cam_e_sen ordine_del_giorno_ass_cam_e_s_data_tipo_assemblea_seduta_nu_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ordine_del_giorno_ass_cam_e_sen
    ADD CONSTRAINT ordine_del_giorno_ass_cam_e_s_data_tipo_assemblea_seduta_nu_key UNIQUE (data, tipo_assemblea, seduta_numero);
 �   ALTER TABLE ONLY public.ordine_del_giorno_ass_cam_e_sen DROP CONSTRAINT ordine_del_giorno_ass_cam_e_s_data_tipo_assemblea_seduta_nu_key;
       public            postgres    false    231    231    231            >           2606    41195 L   ordine_del_giorno_ass_cam_e_sen ordine_del_giorno_ass_cam_e_sen_data_ddl_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.ordine_del_giorno_ass_cam_e_sen
    ADD CONSTRAINT ordine_del_giorno_ass_cam_e_sen_data_ddl_key UNIQUE (data, ddl);
 v   ALTER TABLE ONLY public.ordine_del_giorno_ass_cam_e_sen DROP CONSTRAINT ordine_del_giorno_ass_cam_e_sen_data_ddl_key;
       public            postgres    false    231    231                       2606    41197    parlamentari parlamentari_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.parlamentari
    ADD CONSTRAINT parlamentari_pkey PRIMARY KEY (nome, partito, circoscrizione);
 H   ALTER TABLE ONLY public.parlamentari DROP CONSTRAINT parlamentari_pkey;
       public            postgres    false    219    219    219                       2606    41199     parlamentari parlamentarinomekey 
   CONSTRAINT     [   ALTER TABLE ONLY public.parlamentari
    ADD CONSTRAINT parlamentarinomekey UNIQUE (nome);
 J   ALTER TABLE ONLY public.parlamentari DROP CONSTRAINT parlamentarinomekey;
       public            postgres    false    219                       2606    41201 '   parlamentari parlamentaripartitonomekey 
   CONSTRAINT     k   ALTER TABLE ONLY public.parlamentari
    ADD CONSTRAINT parlamentaripartitonomekey UNIQUE (partito, nome);
 Q   ALTER TABLE ONLY public.parlamentari DROP CONSTRAINT parlamentaripartitonomekey;
       public            postgres    false    219    219            @           2606    41203    periodi_cariche pk_pc 
   CONSTRAINT     j   ALTER TABLE ONLY public.periodi_cariche
    ADD CONSTRAINT pk_pc PRIMARY KEY (nome, mandato_commissione);
 ?   ALTER TABLE ONLY public.periodi_cariche DROP CONSTRAINT pk_pc;
       public            postgres    false    232    232            X           2606    41205    votazione pkvotazione 
   CONSTRAINT     q   ALTER TABLE ONLY public.votazione
    ADD CONSTRAINT pkvotazione PRIMARY KEY (ddl, esito, tipo_assemblea, data);
 ?   ALTER TABLE ONLY public.votazione DROP CONSTRAINT pkvotazione;
       public            postgres    false    239    239    239    239            B           2606    41207 9   presidente_della_repubblica presidentedellarepubblicapkey 
   CONSTRAINT        ALTER TABLE ONLY public.presidente_della_repubblica
    ADD CONSTRAINT presidentedellarepubblicapkey PRIMARY KEY (presidente);
 c   ALTER TABLE ONLY public.presidente_della_repubblica DROP CONSTRAINT presidentedellarepubblicapkey;
       public            postgres    false    233            D           2606    41209 3   promulgazione promulgazione_presidente_ddl_data_key 
   CONSTRAINT        ALTER TABLE ONLY public.promulgazione
    ADD CONSTRAINT promulgazione_presidente_ddl_data_key UNIQUE (presidente, ddl, data);
 ]   ALTER TABLE ONLY public.promulgazione DROP CONSTRAINT promulgazione_presidente_ddl_data_key;
       public            postgres    false    234    234    234            F           2606    41211 %   promulgazione promulgazioneddldatakey 
   CONSTRAINT     e   ALTER TABLE ONLY public.promulgazione
    ADD CONSTRAINT promulgazioneddldatakey UNIQUE (ddl, data);
 O   ALTER TABLE ONLY public.promulgazione DROP CONSTRAINT promulgazioneddldatakey;
       public            postgres    false    234    234            H           2606    41213 +   promulgazione promulgazioneddlpromulgatokey 
   CONSTRAINT     q   ALTER TABLE ONLY public.promulgazione
    ADD CONSTRAINT promulgazioneddlpromulgatokey UNIQUE (ddl, promulgato);
 U   ALTER TABLE ONLY public.promulgazione DROP CONSTRAINT promulgazioneddlpromulgatokey;
       public            postgres    false    234    234            J           2606    41215    promulgazione promulgazionepkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.promulgazione
    ADD CONSTRAINT promulgazionepkey PRIMARY KEY (ddl, promulgato);
 I   ALTER TABLE ONLY public.promulgazione DROP CONSTRAINT promulgazionepkey;
       public            postgres    false    234    234            L           2606    41217    pubblicazione pubblicazionepkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.pubblicazione
    ADD CONSTRAINT pubblicazionepkey PRIMARY KEY (gazzetta_numero, data_pubblicazione);
 I   ALTER TABLE ONLY public.pubblicazione DROP CONSTRAINT pubblicazionepkey;
       public            postgres    false    235    235            N           2606    41219    senatore senatore_nome_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.senatore
    ADD CONSTRAINT senatore_nome_key UNIQUE (nome);
 D   ALTER TABLE ONLY public.senatore DROP CONSTRAINT senatore_nome_key;
       public            postgres    false    236            P           2606    41221    senatore senatore_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.senatore
    ADD CONSTRAINT senatore_pkey PRIMARY KEY (nome, partito);
 @   ALTER TABLE ONLY public.senatore DROP CONSTRAINT senatore_pkey;
       public            postgres    false    236    236            R           2606    41223    stesura_ddl stesuraddlpkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.stesura_ddl
    ADD CONSTRAINT stesuraddlpkey PRIMARY KEY (titolo_ddl);
 D   ALTER TABLE ONLY public.stesura_ddl DROP CONSTRAINT stesuraddlpkey;
       public            postgres    false    237            T           2606    41225 -   stesura_ddl stesuraddltitoloddlrelatoreddlkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.stesura_ddl
    ADD CONSTRAINT stesuraddltitoloddlrelatoreddlkey UNIQUE (titolo_ddl, relatore);
 W   ALTER TABLE ONLY public.stesura_ddl DROP CONSTRAINT stesuraddltitoloddlrelatoreddlkey;
       public            postgres    false    237    237            V           2606    41227 2   timbratura_giornaliera timbratura_giornaliera_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.timbratura_giornaliera
    ADD CONSTRAINT timbratura_giornaliera_pkey PRIMARY KEY (data, parlamentare);
 \   ALTER TABLE ONLY public.timbratura_giornaliera DROP CONSTRAINT timbratura_giornaliera_pkey;
       public            postgres    false    238    238            Z           2606    41229 I   votazione votazione_favorevoli_contrari_assenti_missione_astenuti_ddl_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.votazione
    ADD CONSTRAINT votazione_favorevoli_contrari_assenti_missione_astenuti_ddl_key UNIQUE (favorevoli, contrari, assenti, missione, astenuti, ddl);
 s   ALTER TABLE ONLY public.votazione DROP CONSTRAINT votazione_favorevoli_contrari_assenti_missione_astenuti_ddl_key;
       public            postgres    false    239    239    239    239    239    239            \           2606    41231 I   votazione votazione_favorevoli_contrari_astenuti_codice_assenti_missi_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.votazione
    ADD CONSTRAINT votazione_favorevoli_contrari_astenuti_codice_assenti_missi_key UNIQUE (favorevoli, contrari, astenuti, codice, assenti, missione);
 s   ALTER TABLE ONLY public.votazione DROP CONSTRAINT votazione_favorevoli_contrari_astenuti_codice_assenti_missi_key;
       public            postgres    false    239    239    239    239    239    239            ^           2606    41233     votazione votazionedatacodicekey 
   CONSTRAINT     c   ALTER TABLE ONLY public.votazione
    ADD CONSTRAINT votazionedatacodicekey UNIQUE (data, codice);
 J   ALTER TABLE ONLY public.votazione DROP CONSTRAINT votazionedatacodicekey;
       public            postgres    false    239    239            `           2606    41235    votazione votazionedataddlkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.votazione
    ADD CONSTRAINT votazionedataddlkey UNIQUE (data, ddl);
 G   ALTER TABLE ONLY public.votazione DROP CONSTRAINT votazionedataddlkey;
       public            postgres    false    239    239            b           2606    41237 !   votazione votazionedatamozionekey 
   CONSTRAINT     e   ALTER TABLE ONLY public.votazione
    ADD CONSTRAINT votazionedatamozionekey UNIQUE (data, mozione);
 K   ALTER TABLE ONLY public.votazione DROP CONSTRAINT votazionedatamozionekey;
       public            postgres    false    239    239            d           2606    41239 /   voto voto_data_parlamentare_voto_palese_ddl_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.voto
    ADD CONSTRAINT voto_data_parlamentare_voto_palese_ddl_key UNIQUE (data, parlamentare, voto_palese, ddl);
 Y   ALTER TABLE ONLY public.voto DROP CONSTRAINT voto_data_parlamentare_voto_palese_ddl_key;
       public            postgres    false    240    240    240    240            f           2606    41241 3   voto voto_mozione_data_parlamentare_voto_palese_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.voto
    ADD CONSTRAINT voto_mozione_data_parlamentare_voto_palese_key UNIQUE (mozione, data, parlamentare, voto_palese);
 ]   ALTER TABLE ONLY public.voto DROP CONSTRAINT voto_mozione_data_parlamentare_voto_palese_key;
       public            postgres    false    240    240    240    240            h           2606    41243    voto votopk 
   CONSTRAINT     k   ALTER TABLE ONLY public.voto
    ADD CONSTRAINT votopk PRIMARY KEY (data, parlamentare, voto_palese, ddl);
 5   ALTER TABLE ONLY public.voto DROP CONSTRAINT votopk;
       public            postgres    false    240    240    240    240            �           1259    41244 -   fki_attivitaparlamentarecommissionecamerafkey    INDEX     }   CREATE INDEX fki_attivitaparlamentarecommissionecamerafkey ON public.attivita_parlamentare USING btree (commissione_camera);
 A   DROP INDEX public.fki_attivitaparlamentarecommissionecamerafkey;
       public            postgres    false    215            �           1259    41245 -   fki_attivitaparlamentarecommissionesenatofkey    INDEX     }   CREATE INDEX fki_attivitaparlamentarecommissionesenatofkey ON public.attivita_parlamentare USING btree (commissione_senato);
 A   DROP INDEX public.fki_attivitaparlamentarecommissionesenatofkey;
       public            postgres    false    215                       1259    41246 2   fki_esameddlepresentazioneddlcameracommissionefkey    INDEX     �   CREATE INDEX fki_esameddlepresentazioneddlcameracommissionefkey ON public.esame_ddl_e_presentazione_ddl_camera USING btree (commissione);
 F   DROP INDEX public.fki_esameddlepresentazioneddlcameracommissionefkey;
       public            postgres    false    221                       1259    41247 2   fki_esameddlepresentazioneddlsenatocommissionefkey    INDEX     �   CREATE INDEX fki_esameddlepresentazioneddlsenatocommissionefkey ON public.esame_ddl_e_presentazione_ddl_senato USING btree (commissione);
 F   DROP INDEX public.fki_esameddlepresentazioneddlsenatocommissionefkey;
       public            postgres    false    222                       1259    41248     fki_esameddlpresentazddlsenddlfk    INDEX     p   CREATE INDEX fki_esameddlpresentazddlsenddlfk ON public.esame_ddl_e_presentazione_ddl_senato USING btree (ddl);
 4   DROP INDEX public.fki_esameddlpresentazddlsenddlfk;
       public            postgres    false    222                       1259    41249    fki_fk    INDEX     V   CREATE INDEX fki_fk ON public.esame_ddl_e_presentazione_ddl_senato USING btree (ddl);
    DROP INDEX public.fki_fk;
       public            postgres    false    222            .           1259    41345    fki_fkmissione    INDEX     K   CREATE INDEX fki_fkmissione ON public.missione USING btree (parlamentare);
 "   DROP INDEX public.fki_fkmissione;
       public            postgres    false    227            v           2620    41250    ddl ddl_audit    TRIGGER     �   CREATE TRIGGER ddl_audit AFTER INSERT OR DELETE OR UPDATE ON public.ddl FOR EACH ROW EXECUTE FUNCTION public.process_ddl_audit();
 &   DROP TRIGGER ddl_audit ON public.ddl;
       public          postgres    false    218    261            u           2620    41251 7   attivita_parlamentare inserimento_attivita_parlamentare    TRIGGER     �   CREATE TRIGGER inserimento_attivita_parlamentare BEFORE INSERT ON public.attivita_parlamentare FOR EACH ROW EXECUTE FUNCTION public.inserimento_attivita_parlamentare();
 P   DROP TRIGGER inserimento_attivita_parlamentare ON public.attivita_parlamentare;
       public          postgres    false    276    215            x           2620    41252 E   interrogazione_interpellanza inserimento_interrogazione_interpellanza    TRIGGER     �   CREATE TRIGGER inserimento_interrogazione_interpellanza BEFORE INSERT ON public.interrogazione_interpellanza FOR EACH ROW EXECUTE FUNCTION public.inserimento_interrogazione_interpellanza();
 ^   DROP TRIGGER inserimento_interrogazione_interpellanza ON public.interrogazione_interpellanza;
       public          postgres    false    223    278            y           2620    41253 !   intervento inserimento_intervento    TRIGGER     �   CREATE TRIGGER inserimento_intervento BEFORE INSERT ON public.intervento FOR EACH ROW EXECUTE FUNCTION public.inserimento_in_intervento();
 :   DROP TRIGGER inserimento_intervento ON public.intervento;
       public          postgres    false    277    224            z           2620    41254 +   legge_approvata inserimento_legge_approvata    TRIGGER     �   CREATE TRIGGER inserimento_legge_approvata BEFORE INSERT ON public.legge_approvata FOR EACH ROW EXECUTE FUNCTION public.inserimento_in_legge_approvata();
 D   DROP TRIGGER inserimento_legge_approvata ON public.legge_approvata;
       public          postgres    false    284    225            {           2620    41255 '   promulgazione inserimento_promulgazione    TRIGGER     �   CREATE TRIGGER inserimento_promulgazione BEFORE INSERT ON public.promulgazione FOR EACH ROW EXECUTE FUNCTION public.inserimento_promulgazione();
 @   DROP TRIGGER inserimento_promulgazione ON public.promulgazione;
       public          postgres    false    234    280            |           2620    41256 '   pubblicazione inserimento_pubblicazione    TRIGGER     �   CREATE TRIGGER inserimento_pubblicazione BEFORE INSERT ON public.pubblicazione FOR EACH ROW EXECUTE FUNCTION public.inserimento_pubblicazione();
 @   DROP TRIGGER inserimento_pubblicazione ON public.pubblicazione;
       public          postgres    false    281    235            }           2620    41257    votazione inserimento_votazione    TRIGGER     �   CREATE TRIGGER inserimento_votazione BEFORE INSERT ON public.votazione FOR EACH STATEMENT EXECUTE FUNCTION public.inserimento_votazione();
 8   DROP TRIGGER inserimento_votazione ON public.votazione;
       public          postgres    false    282    239            ~           2620    41258    voto inserimento_voto    TRIGGER     v   CREATE TRIGGER inserimento_voto BEFORE INSERT ON public.voto FOR EACH ROW EXECUTE FUNCTION public.inserimento_voto();
 .   DROP TRIGGER inserimento_voto ON public.voto;
       public          postgres    false    240    283            w           2620    41259    ddl update_ddl    TRIGGER     r   CREATE TRIGGER update_ddl AFTER UPDATE ON public.ddl FOR EACH ROW EXECUTE FUNCTION public.inserimento_modifica();
 '   DROP TRIGGER update_ddl ON public.ddl;
       public          postgres    false    279    218            r           2606    41260 +   votazione approvazionevotoasscamesenddlfkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.votazione
    ADD CONSTRAINT approvazionevotoasscamesenddlfkey FOREIGN KEY (ddl, codice) REFERENCES public.ddl(titolo, codice);
 U   ALTER TABLE ONLY public.votazione DROP CONSTRAINT approvazionevotoasscamesenddlfkey;
       public          postgres    false    3335    239    239    218    218            s           2606    41265 /   votazione approvazionevotoasscamesenmozionefkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.votazione
    ADD CONSTRAINT approvazionevotoasscamesenmozionefkey FOREIGN KEY (mozione) REFERENCES public.mozione(codice);
 Y   ALTER TABLE ONLY public.votazione DROP CONSTRAINT approvazionevotoasscamesenmozionefkey;
       public          postgres    false    230    3382    239            i           2606    41270 5   attivita_parlamentare attivita_parlamentare_data_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attivita_parlamentare
    ADD CONSTRAINT attivita_parlamentare_data_fkey FOREIGN KEY (data, tipo_assemblea, seduta_numero) REFERENCES public.ordine_del_giorno_ass_cam_e_sen(data, tipo_assemblea, seduta_numero);
 _   ALTER TABLE ONLY public.attivita_parlamentare DROP CONSTRAINT attivita_parlamentare_data_fkey;
       public          postgres    false    215    215    215    231    231    231    3386            k           2606    41275 6   commissioni_senato commissioni_senato_legislatura_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.commissioni_senato
    ADD CONSTRAINT commissioni_senato_legislatura_fkey FOREIGN KEY (legislatura) REFERENCES public.legislatura(numero);
 `   ALTER TABLE ONLY public.commissioni_senato DROP CONSTRAINT commissioni_senato_legislatura_fkey;
       public          postgres    false    217    3373    226            j           2606    41280 3   commissioni_camera commissionicameralegislaturafkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.commissioni_camera
    ADD CONSTRAINT commissionicameralegislaturafkey FOREIGN KEY (legislatura) REFERENCES public.legislatura(numero);
 ]   ALTER TABLE ONLY public.commissioni_camera DROP CONSTRAINT commissionicameralegislaturafkey;
       public          postgres    false    216    226    3373            l           2606    41285 L   esame_ddl_e_presentazione_ddl_camera esameddlepresentazioneddlcameraddlfkey2    FK CONSTRAINT     �   ALTER TABLE ONLY public.esame_ddl_e_presentazione_ddl_camera
    ADD CONSTRAINT esameddlepresentazioneddlcameraddlfkey2 FOREIGN KEY (ddl) REFERENCES public.ddl(titolo);
 v   ALTER TABLE ONLY public.esame_ddl_e_presentazione_ddl_camera DROP CONSTRAINT esameddlepresentazioneddlcameraddlfkey2;
       public          postgres    false    218    3337    221            m           2606    41290 *   legge_approvata leggeapprovata_titolo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.legge_approvata
    ADD CONSTRAINT leggeapprovata_titolo_fkey FOREIGN KEY (titolo, data_promulgazione, promulgata_da) REFERENCES public.promulgazione(ddl, data, presidente);
 T   ALTER TABLE ONLY public.legge_approvata DROP CONSTRAINT leggeapprovata_titolo_fkey;
       public          postgres    false    225    234    234    3396    234    225    225            n           2606    41295 *   legge_approvata leggeapprovata_votisi_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.legge_approvata
    ADD CONSTRAINT leggeapprovata_votisi_fkey FOREIGN KEY (favorevoli, contrari, astenuti, num_legge, assenti, missione) REFERENCES public.votazione(favorevoli, contrari, astenuti, codice, assenti, missione);
 T   ALTER TABLE ONLY public.legge_approvata DROP CONSTRAINT leggeapprovata_votisi_fkey;
       public          postgres    false    239    239    239    239    239    239    3420    225    225    225    225    225    225            o           2606    41300 3   legge_approvata leggeapprovatanumerolegislaturafkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.legge_approvata
    ADD CONSTRAINT leggeapprovatanumerolegislaturafkey FOREIGN KEY (legislatura) REFERENCES public.legislatura(numero);
 ]   ALTER TABLE ONLY public.legge_approvata DROP CONSTRAINT leggeapprovatanumerolegislaturafkey;
       public          postgres    false    226    3373    225            p           2606    41315 "   promulgazione promulgazioneddlfkey    FK CONSTRAINT        ALTER TABLE ONLY public.promulgazione
    ADD CONSTRAINT promulgazioneddlfkey FOREIGN KEY (ddl) REFERENCES public.ddl(titolo);
 L   ALTER TABLE ONLY public.promulgazione DROP CONSTRAINT promulgazioneddlfkey;
       public          postgres    false    3337    218    234            q           2606    41320 )   promulgazione promulgazionepresidentefkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.promulgazione
    ADD CONSTRAINT promulgazionepresidentefkey FOREIGN KEY (presidente) REFERENCES public.presidente_della_repubblica(presidente);
 S   ALTER TABLE ONLY public.promulgazione DROP CONSTRAINT promulgazionepresidentefkey;
       public          postgres    false    234    233    3394            t           2606    41330    votazione votazione_data_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.votazione
    ADD CONSTRAINT votazione_data_fkey FOREIGN KEY (data, tipo_assemblea, seduta_numero) REFERENCES public.ordine_del_giorno_ass_cam_e_sen(data, tipo_assemblea, seduta_numero);
 G   ALTER TABLE ONLY public.votazione DROP CONSTRAINT votazione_data_fkey;
       public          postgres    false    239    231    231    239    239    3386    231            �           826    41335    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     K   ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO PUBLIC;
                   postgres    false            
   �   x�͐=O�@��˯�����m��2D�	)08��,9w�����-A��6����޺����^w�����֙����ZG���_��'�֐��#ǠB��1G(� �a��;c��~��OL!��i��0iKo�5M]װ�[md2f�+�aO	�Ǭ��M�����$����lxK#��9'��6��7Ǣt���8�ǆ�D�i-ܣ��w37#���V�R�k�5zT�zdĖr>~��(�/�g�B         �   x�}�;1Dkr
wtHT��W$
$>JA�,�b�8{��ŀ,PR��<~�Fum#h�I �����ִ@~M�6�/<K�b�h�ڥB�4�lh\�4M��?���� �쵡M���QJ���n�ǝV����
i4-�#�᧱�
YS�O�>��܊=����y��Ί
��m���H\��<T��R�	N�Z�         �   x�u��n1D��+���DZ �h%
� r��9|a$��5�}�|�$����vv�L�s	�����C�x��fzG�N{�A��d�i�v���J��]�����%hIw����Z}��I.�H�ei���r�u�}��JZ��;I�A�5>�Ž����	�����Z���އ0�6�
-\lQ������|6���F^1         M  x�E��n�0���S�r��8
?�*�B+$n-Z�%]�ؖ�Ļ�$��,�����ےꚠbرDU��,�w�������k�$���C���	���=+T'F{�����2)�����:��fi��8+��p|8g��$1h%H9-&�6�����쒆U��ޢs:)�"˃��m6��g�eG�Ԣ�Pq4�Z]!�TM����{���I�
+�*���TZ��!�d��1.=��+���I*]�WZ<];թ�����(�F��?l�8-�tZ���'�?��%�`�%w+ڊj��������.}����˻�n��|��߻��>�&��P�            x��]ۮ㸕}��
�_��	ҝ���F˲�]ܔ���Ee�N	���.`N�@>dȷd�$_2{o�B�$E���HW��(�����,ڈ����s]���w��������_����|���;^���۟��1Q��͊��O7<���/eu,�)��=D�A�1/����X�u�ٮ�����{y[n�RG�K	���˱.�WL�:�W��հ����z>���]��W�}���L�֩HX�z��=���|�b�'<%����qY������=I3?���ڜ��&ga��<	��{��\^��<��q�§�����p�1~�bњ���S���ћH�e>��F��4	�UU^�z_���߾��SDO���KD�j��k�?��)^o��������+p�~�KR8������8B���V__~U�9#��.��������Nd�z��~y,?�:gbŒ��T^�x��Q�3xC歫S��Pw�릅w�5�v�B���8/���n����������Wc\�bM޾�o��ٷۺ�Vfa��X�ͻg�"��V�T|�v�S`v���^О+������8���Usn�r�Xv�������7u�Ӏ��%�$L�~P`?h��t���˚�u9���b ON��2U!r28����\{�P������ZQ��W�`iؗ��IE�mԜ>���z�$�C����O+�
􃗗(���+����f��mu�|�(Oddq���!�)�^4pET�S=�@*A�uB�@r��a='*�vl[6G���ĿԾ+�ML���Vj���u�V�����5���:i���}u~SXt�
��Ce]�(�J�Q\$;]�}����7�=�$hs��r�O(.��z�4с�	���܁�%W��/�e�<���{n 	h�'ќʗ��LD)�U/��&����b��U~��3U B�=؎u�	�엉l;��3	۾q��~���G��D�Fkѓ�����U{�G<*��h���z~`�D�T�I7���|�-��#�Պ�K�J��{.�ƕ���38��$E��_�R톍wܵ��Ǫ<+�QJ��v3���t�w'�:B�!Pd�u��$�}�.r�z�����/M���v�@��v�nt�E�M��H���a�F�׺j�ş3�I�!��4���U��W�u�� ���r�Ǵ��q��~���nr�ގgh$�,#���g�N��H$���=��*N�Cw���E�]�-��O��m�b�L��P�	�\Zý*�"Q؀�z}�ص�(�t[4,#蠄�{���`��t�*1Ԡ�,^�VFDDg�*x��̏{�@݅^	�Q9�(*�Y�@�%��S�*�i�۱~�=zC-�*�܀~
�LQ�������#��잙ةUVz���9�G�T��TN�'j4=���Ξ|wp�g[00� ��.�M>]��+��
� tt@�$>,��<{{���*�L	?d�a-�9��(�y�� ��'T��HPK�:�����7�rp[a��E�M��Ch|X���������xd�m�����v�n�)[� 8�\�Sw~ם���2В��͙�
�j����`E�ڗJ2������鎾IƆ�^)�����9���N��c[QP�%�Vΰ	�?�L�*iV��<�A2`�c���,'.6���c�#Y��(;;����2�CL���*�b�"�#�3x�|!��(a!D��˛ө��a6��Ŏ�4����"�1t�@t�`:A7g��#B�ο���m%Kc�m :��\�2D�ĩ����B���%�\�GWL	u&��u+Lz|�$I;�ҕxSpYSA٬ �$]��n6��������`��d$	"/)���JY^-0h!�{��TV��8��&��z5i��^��=���G����ￔ������1�*)hJ�"���&�ìai��0�	(Y�+
���pAJ�����A��+~��\N/Jf@	�5~�^�-�nY��tK��k�M�iF[b�![�>��!?p2���4���`J1�ܠ�t��5> %�n��Z~^lA���&8��!j�6Ձ"UW��iKFH��
�� ��{�{pDͤFfT���Dau(�'��Gp*Ϸ	�Z�H{���.4nD��q�"]&I�����jݶAt���f�M��1�ߕ���f<�giҥ�g0��ܤ�'�hG-4�%�� �݇�)��}���� ��Q�&ϩ&9a�b��"���k�DG�B���?q����C�X�@�d�>��mf��A��#�����|��N�
�C㲃���)jUK��d�~�"@���a��FUx���l�I�~����,�-&̆��C(�K��#տ_pk�W�bE�w~�Ճ�棚�D���G���	`
��Gp�%�U=^��JDhPz�T�2n����l���+0�u!��dR�4�5-lX�r�$*�9	qM��j_����4m�@��ר�{�|�(��Zc��`��լ�i���;`��/u�
���c=��X�6L0	x�~�"�2�d�f���3t�Sg{gq���^�n[�N��AC���>a*�qEM; V��oH�a�Wy!�Yu<�AQۃ6���,ۤ"�,9����؞ Oj ��\�e烣:n�2�%d���"F��4K� `�8T�S�l��i@�nX4��3;eE�� Iw�x�����F-?���eu��z#��}� ��-�A`��X�K!��^k�?�3Vi�c����,�J��`r��v���l��ыQ�9F[��
o��u�M �T�ws���m��3:�p�F"8��9�]�ώ��<�'�,?�(&�T���P!��.���DE�`���Q�)4�ELWQp��`1���͊6l�J�ZV���GM���n����RyJ�Nr�F����Z(��Z{��Zu^���;p`��G7��q��'�p��,�Y�)�Z��j�V���p�/���*0��F��p������Xs����UT��?��������(C�<��_9�4����T7<�ժW�J%d>:Z�"�d��iE��s�mE��e Tc���8��4��~�6�'����0Sä���P�%]�D�*��kժ�fb�R
������$3%g`WP�*����	^�R�9��w,CrL��|��_V�+���y�Y��'���d$��Y��i��	��P�W�8@��k�Q�%��U�i:>N��|4d��Q���r����x����6αSs� Î �Ԏt�S�f�*R��J;2	����S�HD�>1�?E� �<Q~�\:Af�`-x��j���a��+���8>�c%|�bA��>�#�/����r^��.`��g>��}���;_��Z�e~^Ҋ��@�imH�oE��?ay0�YF��/'rm"J3,��U��
-��ؐ����:��4Eg!�e�j��i񜍌g�`>��=TR��.��r�S*9�@І�*��g�q`���ΈN����TPq2z/��~��m�>G����.K}�J��	���F�H��7B
�T�,�
A�u
��X_dD2��29	�Q����rL����Y�
�<c���T,Fߓ0�YˇGg���i�שF,,:�> �χ���	<�X!�O��}Ph����D�YG��LXO������&`*L�b�z�g�()��x��N�gm�iR����"��X��ȃ��ѿ064Q���e9�N�5�lhvȅ*��`H�8פ�_c�K��~w4�b 2b���p.Ԑ�%jA��j��}����� Z{�������M�T��0%D����9o%��
d�|b�l��@��߬uF�:\����?�JY=� �f2)ZX||hNչ6u!���ܵ�����$w�|��&�h�]���7�.���Q�8�d\��,�y'IdmA��7�1(�����J�]�h�:�+]ib`�"+��m�-w,�0o��Dع+���n14�i�0���j����b�i�n#�P�[V�W=��w5�f� g}��mN�����b5�r5��樃�#s�I1�\�j
q�$b �  �+S��f����_j��_sk�^EA�"CI*o%�ɹ���,$iH@�R6y�	mԂ�٤�����I�Hq��&�)FGA����^>*?š&.8.Y��=e@ӏ᧡�"��E�\$����bxKg!��S�����PKF݁}�˗���N�vX5Z�@
��ti�kzy���_�1�+��'1��ԧ�eE)²b�69I�h�m�d������h}i�O�m��WgP���_ ���-X�S�$9h�7>�!���d^��X�+�j����RA�i{�����
����s�^���O��;	��+=��X_���ѣ|���Pw��_tWa��{�\��]EwM�Ḃe�Ag(�+��8UN�[Pa���j���O<�EX�q�!`�ն຃O�L����R^�%8��Ja�9��Ȋ���b�Ȩ�u�٥�.)0磖:�w[&8�P`�h�"�"P=my9i�h6j�2j˫v2m�Bӧ53lTi<�ʪ)8}�����\L�m� >�Ȩ��ԗ��8j�]W����MurX'S�*+���d��;�y|XZ�������e��SmὙ*�tM	h9@��%��[	*�Q�2�E�}��Kn!X�dB�C3��mH�69�І�Ss%�h�-�z�Y�e]�q��P�h!�	�܊ �Fe�yh�uF>�1�۔7յRpPP���e0ň�^i�K+Ɔ��Lp�p�Ą}y�i��k;�`;�\��9���<�:�SuuE+1��y�>�v���	�STUK�_G*^Cp&��d/mT�A2�{1���Q��ｬ�q.x�Y��"�~��ד���`]q��'�K-�Ad��]�q�J�I��# I�3Nd<�.tUD>]z O�E��W�@�P��g�gC�[�>�z6��HO�T����
��HS��8@:[����J'�|ϝ,�8��˞����Z���Up{��j���8)A��Tt��+N5��Z�П-�
�K����X�ñ	�`���C
j'��� �TD���`c��ˏC��kA'�k"�����P��RmB�M���R�݉"�T�/�`0�F��/��-@�ǂç�W��,tZ�����{���b�!�P��I>-N����@��TY������l^GI�=���J�|�SG_�mA��-��8O�B��5(�b*@�@��a*ģ	3�e��mGn��i��烯���ϓ��FX~,���x1�o��I�
�����a�3]���֗�Zt�G��/���S����4C��MWc���N�ޖ����K�>�%l	�h
S�8*k�Aꥷ��/�H��Y��I �����e_jGw���	��(p�;���a�g�$�?�Rb}*�[z�˰���%�-���u�Ͱ��ͯ�,2����1Ն[��$�09����c�vA��r��8��`\�#��Fa���5:1'k��gl� �q�I�7��� I�p\oħ�_����4��G�����)����o�~�˧�u)��;�k�ҫ��K��嵽���{��������������O�)
�2�-neq`e)��^o�㝜r~����[3���r4��-v���WG�n�5�O���e;�-�䤌ԺI}yӿ5��F4���jA��C�������z�) #�.�x������\�4]��ڑo!{f�m1��{��66d�׊��i��S��d"�������&�TAB���9�./	~9��y�/*������T�S��y�f[�v�n�1Y�8�]��~�Ø��t�)O���P�w���َf��M����<�L��F��U���q@0K��>����>MrطJ�ă���f)�."k��(�d�)��@<t\R�ag0:���+�5�G�񨛶���+�ٰ�F����q��ND�Wn�qه(gq��)�P�i�'sls˔�@�V�l��<35��@#i�D�����l�s��Q&��j�i���b�n �<��gd&l;>39Y�N�-}"��Dm�Sӳ6H���t����X��Dl��c�=���ȀS�`��>�|5�6����:���a��IF�R2*س�~Ϩ�B�ZA�5ڪk�����h��"H��]1��u��b�~,���Y�Z䪩��v�u~�P��8|M��<�}��ֱ�o�hh&χ����!ժ�"o�0�1��m�q�73k	����
X5Ҷ1Z�ȇX�*D,y����'@�^;��p&B��4���qrُ8�b��g�Ax����ͯ��!ؠ�<���$�+�0��gI1̸kV�ѭ`>S��,�:�1��e�H�󧉔-�N��h�ƣq-��A�j����nr���F˩G�v�=��nY����[�y��b�ǂ�* �O���d,�t���ez zy�4a�`M�Λ�EqC��8 .�H�"8�9.m�HF� ��e��DfL��I�l>�����W+�M?D<��^|��~���4��1�v����gy)�#L�"s�u7x�d�et7����8Z`��l��� �ϻ�~�,�!��%gy/�]]�:_��S�����(3��oGfPb&"9U=Ǝs�M��N��Z��C�����g��'Њa`��	N/���:U�J�.�2��r���
T.����Y@o����_�_p~<�����j�2���� �i���K}�u��H�`���LW0,Y(��r��Pl��c-�{�r����N���Y�oU����e�i���2�x��4���� c>�^�c�lP���Z;q6�Cha��}C���!�w�3��Ѝe���)��-����|u�	���l��Wz����jo������<������<��O?��]\�+��DP�o��	�K啧S}�-AE�;��קW�&�������Ǯ��k}���y�ms�៪��t��}�|�bj��|�����sy~��>��Fo�E`�T���{�Z�Xy��$8Y��^(u[��74���	+px�8�^���V!����xH{.1ߕj�l�[/N���[�*��+�u���8FU�/dH���B������5��/ï`�|e��y����v�Bfږ��rLn������
�ǱS�I�n�8�u�?]�p������M����y�����9�$�3�^[�Z8M���)l�Ko8�톎!��aքh���b�+�S�5_���n-�¿{ ���.҈��'���#����'�k��^<�<y9&<��w��6�U�!y��Fa�W�b	َ2\�3�䥱���Ǎ�9������ntB:�*��D�F�R�X:�Cc�y~>�d�.��hLo�٬�v�6t+�j�^$�Y2yV[�"�0��C�em�o�jm���y����N�Ą8>[L@���>ߩS�5���RAWE)#Bݺ��t�̚To�����┪d��`��C-�s@�� �T�Rs[/�	MsFY ���gܵ��F���i
������-BW��{j��qc�e�����Ra���y��/�
K�����+�Wp�S�c��>�9�?�y՗�
?v���	����u�潗�k՞�3_~�D��hk����<��o����gҏW����9����is0�Xt��
��<���A�W�P!3�^c�'!�b��Ā*�q����o����<�A��#6�\���A����0MNũ�os�l��:� <6*f�8�X���̓o������O��>bo���L�;Y�5�Z>m3�r4�����_�󉝽�Z��8�)oX��!x�y Q��XB�Xbe���vc�k}��;"�G�D��>�^_�>f��VCXj{�/3��&�R�˃x1��c-#����������`oi1�-؟��n˗/��|�K��V��9�:�wkL� |ɇuj"��k���t��S�	l%�x�\��E��ft��84���&���*��'�}6��~���8E��	����Kk8��:���<J(u�w>H�& �7^��#f�x�B��x.x�>'��W���P����y�5���7��7�|�W�         �   x�EN�
�0����]*I@���n��:��Zλ��>��T:~����À�^�Q:RΟ�p��Y3~���lDf�k�Ua�QD�'���<��7�	E"�!����	.8s�*�jf���Є`ޚ��.BJl�k��un�IT��,��co��K}C�         �   x���=o1���WxG��Ԗ���I�*����sN���_���VH,�~��y�|�ݎa#�%[K���^Ǻ�3�e�d�Ȫ	>
�=gP �[1��P����z���f�|:�r
.�&�����j��`h�U��V�p�o�!�p:a��@�7^g���U:r��m�[UA�#�����5�a��;1�Dt�tQ��?����~hA         �   x�%P�N�0=�_�J֦�c�u�va�\��KY\%�v@�;�8Xz~~��v����?-W޴��m��0d���0�NUƘnm
&6?=����N���E�3] ��9�� p=	��H	�bo��̩�B��0wSP�Le���� 8�y��)T	D�%{RW�L�v�m�R�Ƒ-N��Gh)�3�t�2�i����Y�|������n��i5IS0_)`�?���-�?~4��W<��p�>몪� ��j�         T  x�͑Ak1�ϻ�B8�K�4�k�B ��J.�\�d���j�l��b�i�\h4��������͝k,��5������Qu��}
�ʁ��S��=i���F�T�#�{��j����)��Q��7�|�W��7�)��#��PT��8y�4����`��c����{.8V��ٟ�IdXs8�ѦILĽ]��n���n%�Rh��Q0�>��������� ��i[
�R�8h�;he�g��nD%8rfu�Wa.Vu�d�a�1	}��KZ࢘�}Oc}	�-ǈ"T�'飩��u�9��]��΋�U��9]X��4��x�}��n���m_ ~o�         �   x�E�;O�0�g�S�2����FX�T)�kc�Iǝ� �;VT��������y�`&8�I����+l��l��h!�t�
S¤\Qx'A�&��>��^�S$'���
1�U8g+���t��H),�M02~:I��'A���R��xe}Ô��h{���{Ӛ<5T���`&}������a<��'��ʫ���N�c�']�=e��̠��YQ��˸���f���i�-����(^�(� ��h�         �   x�E��!�7�x�
�\�q�V-��u�q����=l����b��"k肷l⍈c��1b-�H�*�������=��~�[!���d�zf{ƹ�
�6d��a�6>2����ڸ:��:��c"zk'�_�B��փ�-�� ꟽƫ��ϻ��qX�Ⱥ�6M��6~_ >IN�         V   x�s��
�Wp+J�KN-N�W�M,�L�6204�54�56Ё0�tL49�PH�KI,�WHT()�/K,JU�IT����K����� ���           x�͐MN�0���)��c��1�Ϧb�Ć�j�N�Ƕ�J==N)�cYU��x���7~}��`Ͱb��c�V����U���{��d����C��9v������v��CKG[H��I[�Z�"w�R�Rk�R��-��W��r�[*Nr`���/1%/�6����L}%��X<P)S�[�q�7�R�V������֎��z� ׾ۍO�a\�8�a��J�I�'U�o�jZն�nT3���\B���s��Wy�DBM[1���t>���_ � ����bQE� F��         �   x�ݒAK�@�ϓ_���f���ċH{T
�[�L����$v���MӫGEpx0��1���A�f٭��Cg}Ў<l�t,[צAB��@B�8��>)�!��	<Pc��Җ��ڀgc[�]�IŅ(V�l�L��Aܥ���"]��=+Z�']\�����$��0į�L�l���xo&{�!|�����ŋx���lJ�k���O��%�����-�V�TZB啮�D�bU��Y�����Jd�m~��>���Q\�I         �   x��M�(NT���KTp�����4�50006SPP��())(���O�L�KN�M-J��,��3RS�2Jrs��J�2��P}jE�����j9�鶆��1~�FFF��@d�L9!�qV+�9:;{x:�y*��&�%*�r��qqq �,S         �   x�͒=n�0�g����F�xm:v��f`&  S��z��K'Nzo�y����!�$=��>��?�H{ɀ!������Xx��d5!���R�0r����$Jz*K=��1�aUJ|+��v�h��^����B�z��7�k��l�6�ش�u�!���r�7O�C�\[��U�r�,ټ>��b��`�.�羰��4��y]�����x�� �9��         E  x��XAn�J]ӧ(x3	 ْ�ɟ-Q�(Qi�0�i�m���i�Z(�]��3�WMɒ)v�`AH����իW��E*�/*��(Sho������MQ�^���U�s��~�cua��#����T��B���j+)V����|>�jK=i3Cc�Y8��)粐�e���ˉɥ��*�uw"��~�S��$j��ic�P�7Q�&Vbj�Ye�O�B�:�_���9�0�=�̔�I�vM�VQ�2�AL)ܝ������ś/-~ �)��Ls�N���aj讖Y*�9���δ���ٸ�xc�)�oґʌ��ϻ��N����{������3���J�c��R㕖X/��wA|�_��<^�w��ǥ�xy���oW���h�M�+=�֜�o��3R�5K%�7���o�;�{6�>}��J�Ф'+�J�үyws��|i_�x�ՆzL�\� �V�q`���/r�#��S�@�h8q,�Q@�`2�G�(	�7�(t,ƗIԿtF����̟A�}q2�I_����١ b�~������(����6J�0&���o��|�0j�?JDE¯�_ĉ��7�!E}�?�ѧ��� �_E2�'�������q8�@�W�Z���Cq�u��~��{=����$�㈝���H$���DFc+����J���J$��D�T�d{�%q��mI��B	��&�?$biQ�ճ��e�'s������U>���Lw�.*�$$��D-L[{f\�4?L��H��Z�DY�^���.s��ԇ��ݤu.)}���!�G�Pd�e+��^K��T*��kMV��T*S+]��^�@�g��` "A`O���rl�-��6����QOD?�� �K��N �����5�+g��9z��ee O�0 N���@�e�zͰ�$�I�r� �.+��k���22 ��#ck2HT�$�;� K�iN��gҦ�^��틎�SE]��uF#P|�i��|�Ղ;��1o)��Z�}���5�J4��0��WC	�F7e>����J�7�dÇc4�m���:D���	z9F��*�u����e����Io��jiU	�p���7?�&	�ߴ*Qɜ��V�|N5Ai~F�Ţ���� 7~<L[���|�vr:ݎN��nǻ�V�P�Q� l�Ѧi7�2�\�p�$̋c����5vGS�*h�c�Ĺ�k>�{֪Q�l�<��́��,�T��QA�6Yj]�H[�t��s+1@p9<�u�ט�>�/>{C9GW��.4����)�𛒿���;���� ��qc���}�c(Ȧ�ݬ�yt��gݣ�vz�A��K��� �@CLD@��rThnE�b�� �Y��H6j�!�ZXUJC���rL�7bS�aU#3z�w���DE b����*=Y��]�Z�0��[7*qt��0����$AM\����S����6�4�11ō����T�y�8�	?\
k�Z�z�gO@��sfk4WǺ+������ݢ0�%��ޠ.�����e
��B�o�x0�E���|��{���+_���V��\��"z�V}H%b�tH�AT���9 �IM��~����п{�6�?v������-�?w�!��3^����P�?ݦ�q��yr�r�yV����E�l7�bzt��f �|T�L�J��#��\���6Il���<ٺ����[�+�Rϡ�kyV��7M�z6�@bł��~gj�[��-����ǉ�͔�����^Ÿ�@�բ�X~��nԽ�F5�kE�cLO��(�\��_�i�6dTU�=[���6�mt7���^�zxչ�4������մ�^���V�~����H���,:��-�0�zvrr�_�I         l
  x��Z�n��}N����I$���3oLNKG���̼t�a�d܌mx�hK�!�H�/�'�%gU��16I��H[Jp�U�U�V]ؖ�*�X��������������}?���ji�v��괛�N�uu>��`V���`/"Ё:���8��JE����`�X_|?�u|��d��"�5{-��c?�cM�=�M�5u��J�+���!~�zʇ�J�n��V��m$v��չ�����s�W�xÛ�]�(�P��o��vpt��V��WlB���8L�x��xONh�8���zz>W��b�Y_��*����P"x�W$�#?v�~�V�(g�F�/�����XK�PLı��+��a�3�n��v#�W�}�́}b��b2�%�`s��*Ƴ���n"45��Bh͝��V�� o5rYUV�X���d�ݱ�.{ܱ�}�6�Ԟ���l�乏�5Y/��U���v�7��,ϱF�xjy6 "��?���{v؄O��z�ly�t9�������lA�q�C- F j��E2xl��X,���)����>�%:>��Xz�d��nR�u�m e*C ����$�;q�uƜB���P��b�=� V>2�g�Ss��[�<��)��h&�F�<�=.�l�� j�+��S��:�%���T�ȭXͿ᮫
�ҾZ�L����j��8� ZEk]p�m�Xx[mV�]Y��A(V���HǱ��*��YS"Aq�DV�`
��!F��b<�X�,+:��m�V��j�����7����������muR�nk#X2.��
�T�O�cB�����*r���F��i_���y2���0o�^�����r�'��T��p]�v9�=�O]�D[���ֳQ8ҏ�ï���ܜ��{4�s��ct��v���!�A6�>Y�g����sCu���G "��P�+ߠ�ٞ��LT��*�������D �
Y�-G�Wf%yJ i��P/�o�,��SWR��8_�cO(�"}=��o[�;�Z`¤�o#��H�l�J����������"��Uh��)wB^�� ���å7�0�p\y-�k]���(+{��L�5{UsC.p+�ȧ�a�3NU�o8=�L���䆀+>e��=�I>��N�^g1��z�%�#�vh�b3�����&PĤ/�Mg�Ȅw[?�"N��*�ST�X��Y(6�(��}�%��h�4�:�gSL~���.�S� *�Fth�_�2����C8�&��3 ch��b���.p�n�MN�_	j�㸦])Pl7ﬨfUI���<�F�-Y�"o�e�Ⱦ,��K]]�,�GM�q���7�ڢ�n�4l�������@UFCRGt����Kb��R-J���V'Vehf'�-G�z~I?�z�[i��?;4���6�\^�:w��J�lw�X3��Lo���1������i�h����R��yQ�D��5�J[핈�����=�c~�p9��G��^,t#�7C�a�5���v�����	t��3�Ka�����N�X�U'%,�ڪ����WJ�dF"��Τ�<�Iaؽ(I�b �h@KY ��iP(/s��r��E��s��j�7��q`��R�nyUq�)M�X����P�J+�\R��D
%�w��F$Ý"EF������A��i�֥f��]U�<������C���M?X��Hn��H���>�
���OU���f!��nԈ#)��uњ���OM��妆ڊ�6����d$ׯ�$��bL�,�q�QVlM/���#�;@�ǛH��z���C6�N���Zt[aS�60jeu(�F�o;ryݨ���t���3t�7<���&N3Ӑc'A��4<�d�KD����Ҩ�٣L)9�����de�>�^H��j�ޮ�׎Z)�����'f��WJ�w�\&Q7��\H��8C�'^�u��@��:��d���YN�k�����n�V
�]�ݣˏ�zQj�#�r-�+m����fe���j���\n������5�0Y�%l�	��}
܅�|���]_�~��F��\t�s1o&JSG��u1V<w�\e�9M2��)j����Kj�����9Z�7���իo�m���>P�76�Bw��K��T��>��b\���,���^���I�}���OɊG���ճ�GE�`z���L�� k����ڙ��r��~:�TTC1��;=n�RθcRϚL]f�n�������pn�G~y��"mצ|b���>�F-��J�t�̷���mסt(����=���;�ѓÇ�b�R���v�����l{����@�d�ⴣ��O�}6�eF����cC
 �Tx�i�Q�k���͇S��đ���)�yr�����}YH���:[���?��J7��$�ާ��yOuJYm�nj2�w�B����
����lXh�Re�;����NEj���������Ƞ����d7{�9��b�$tVX������W�B'#oމ�~(Ld^_b���K�r� ��(h�k	�}V�EE��M
ET1Z��ڄi)��*C�1F]!l����A�"�F�}Ävl%�.J�>�C��7�>od��:��k�����������鱘:/��ǣk^aK��c%� �kυ*�(T�~U��+���Z�*h��nV����(��b�BZ�`�TXrO,#42W��X�i��e������Q�������,U�m         �  x�}��n�0���)��l��Uʦ���2����v�Ч�B*5������gƭz�R�`�2�t�+����xȞ\��u�u�ҳxt;/�<Н�)�\i���̵�^ $L^����|J0"8O��ɵ"�؟p@��N=��ISΡ�Ti�)�C��C��uQ�ѭ)�5K�`�}�An�D,6����7��%�#��tɦ��{��� C��O�N��- ]XL�Z���.[�!ً	�O���zTQW�{���_��#V��j͌�4��/_,�p������,��}����kc
�;��l�·>F`A2g�{EZjQ���Vq� 5��9v�yS��7�R^3O� 6�n��GB������F��}�k~�}�ԗ�'��ͭ���9��GLd�\�*�|���Ev�#�e�������?��         �   x�E���0D��+�Ai�23KG�`�D�,'r_OT1�ݻ7�e.p���H]�����.Gʙ��pcA�w���+~�O����`���P�����h����2&UZ/,��bcC�)���|���{�s�9h         �   x�E�OK�0����z��6��zS^���0ۤq LJ�Z�����o�{����p�@�s�vWop���iL�'��BB��L9�� ��ʔN~p�yc�;
n�p�����6�i�nW���P��;S�}���<N׈˲4����L�0pϚ�pF��?6��=j
N/��8ڡ��)�[����%��L��7�] x&�=������HR}i��}�kS��7HM_�            x��\ێ�ȵ}����_<X���LN�V�(�&��e 䅖�6��PR����|�������U��R,u�1�V����k���.�ʯE�����~�x�W\l�]����w����e}~��٧��ZTR�8�I��k�׌�ǪTrK1������V��>��R.\L�Xv��E��x<����͗��Q�r�w���X����*����o	��w�ᐕ�:{���ݹ$�a��7����d��Tg���2� I��ȴkԋ��:p]��+7���Σ�`^����wHF)&\�Y�������,]X���$��S΂��w;c-��v݀�Ҏ��'gVh�|k��V�#� ������ϳ�=�z[�����g�(4�{�ׯ+!~�M��D��z�ʲ`�>+O�ٸߋ�,t߰�?�f���Xt���c�9+�G�51
�+�HyWN��Z1h:�[T��,p��S�~n�/U��x̘]~Uj-o��O_�V7�ý����i3��	����8�j{�%z�t�(s��^��j/h���ʳɎ77���.g�?{zRT߾�y�p���v�+k���Md#��������g����bJ�%y�za6�t�C�rq�f�D��
�,XǶ��[<(GP��R��lZ0{W:�g:�B��=l���PR���ӽF��;�ПEUf���H)�x<�lٵ���P�n�)�8��^T��C���6���t��o5Tu�,�A�!pz_�g�6ל(E��R����sH�+0N�ϭ�ղ.N�b����֋��W����y]f���#��o �5,���!7.wn(n���=�>�(�g�U;�?7��8��i�.��|F&S΅�s��1)�\�I�֫~ar��@|�j�]?2ҫ��ŭ�\�N� 1�l6�O���t�#�D˳��Z'T���j,|dkI�R����o�3+��)"���5� 6ك�&#A(=�B��4�l���gr)�����%g���h �johN	(\]Ջ��D�\��z3%x!�=����o 1�h�����)��<0�C`r�Ʋ6�9@��*C�{hГg�('u[Y�Ǽ�P�����3!<�)e�?g�n���z�7�-�,�]3A�B%��:Rzǜ���S*I��*���BK���@B,��h�uc^JA'�8�a���5L���� ���J/8ܥJ
^:�:��M��	V�#�,A_F��"��J"�-l�����Y^5�H)� �5���Q� g�r����}�
g�j��Y&?���+v��#y��|i��#�]�\܁>���ͪ�:�s���aBʣ����*CBq��X�����_-}�H����������ꦞ�#�k��,S�/�b,F��Qv�]��-2�#I(�k�t��tW�#d��oـ�Y���PL��+�Pve(�
o�I��x�щ1.dn����z�\.���$Y�aVVjYb��&��D����T��ҋ쎍��¢^r!V�8I�a�*�v"E�f�b|[<�r�e�W6����x�Z�}��3�"�)����!��e��/����!j�D��H*n����.W��G|�N���B�@�b�-WH���
��I�A����6`GMHJG�1T-X������֌����UZ�m#:�v-o v-U�8�aȺ8\3�	yv��a68��S�H�D���.U��/��@���Bϰb
��ų8�=g�ʜ%��Rm&��%��3����{힔s�7��m��&#.�Imڷ�+�:v���4��/�1�>:�@�H²y���VA�佌���+N���d1�Z�7����&�ظ��V���Ef�ΐ�t��G��k��v����!W���
�b�E��a�&��_(i��a�!��ɐu2�G�n@ĉ<�3/�g]N�`�8PU��=�S�^˚�Jf"��1�MpVɻ���
��ՋApp�D{��dΩ�}���45 ��e������J`ћ +8yB��^�����n��і!좞�Cĵ���G	)�01��6069����b����X�+���;��g���	~L�� ��.g�׼:o^�2�<E#7���Y�Kw"��'Ц�\�I.��о1!,Tg@��mOH����ѓ}�36a��֛]j��%��}{�w�t9��!���Xa&)��W���GD�Ԅ2���hKtae�Ό�x���8���K88�3jN?B��2F���A+�D^J8�:9;�X$��*0dK;Y*���K�-���*�S�I���B�����;�f�iU�����<!$qf.�Ө/�_4/�e�<�vl�v�"�ߣ���o�2�4�0'�$j�ɬV��h/Ȫ�6 o�^��Q/)��%�ĩ�"%�m�����
EԺ���O�#������� ���� �֧�Q�
�����u$R��6b�E�w�ȟ��3�9 X;�&��V��DS�XȔ�%t�JP���*_�	�M�Y�D���t-�$|eG��f�	24�C[Q���*Äd���jt���PD����9��j�s��n<b��lv�l���}\�ҋF�:�)�qM�-��[:E�X,2���U�oD+���z��
�8	$�'?b�bM%���~�[��-y�.M4g��^ʪ�yQF+���)�B!�����I\&кX⭎�2#X��z�����������ݴ>)�s"�զq(�(���Z�/�4�eU;9}�ah����*��n��_S�<"U�w�����{a��D��е�ީ�'Q`Iu����&�H�.[���S����2*�0+�N�WC��^��8��*�H��9�Oa$��c ��#(�$�u�Xw�F�Q��w��&\���Ly��W+�;��3�nTS��j��:Wp�)y�UÛL��2n�9z6.n�n	?�zC�	"��>�W��:t���%�y!�s�m�����nYk��L�q�2�X���d��>�r;��#��j0����7J>��T�Бr��C�=�5�SS�R@��\���oA4'55�j+Sn��ީ9�/ܛ7|�<���R	v?j0�q%�{�>��H���K��
	ϖ-��w�8ơp9�i�Ϛ&�BA,3��ь�J80����>�&���kF�� γ�#X��w@�����6�gV�^MC:s��?�n��i�G�R �Y�S"�q]��x*��\hD��*�U߶߉�b�8DO�����)�X̅|6Q��¦�	Sv��)S��&�<W4f�9g?u|;V&bx�k��&��J�ߗ����ͻ�Qﺖ�
�e��3���4iʮW~��Gu��_�#(�>G�z!�
f��?��5�CZ�$�G!�Df��ި�Ռ��>R�Ŋ�⧺����T��x#w��L��"A��|d�eKF�H�A��Dn�%)&�E�!��P@Ю:e$ DQ�H=~���&�p�0�nңچ�#�yR��qL�3l�6�0JTͧ�Q��m�?� �Z��t�%��K��f�Sz�4|�h2W٪�V��+<�^�Y���m�Nﭦ�G �l�r�� �%s�˧nS��TJ=c�iHq��˷
Ϟ��Av�K��Gqyߊɛ��3�Jۈ��� ��~����=�P��K]>H�}�ʃ锋ׁ�|$�YjǙ���)q���E$M�9�Q�>���a��������H�;��~�Ʒ����@�-L�Qr�J��w{�����������W��~����&�i�篓�������>
��L|P�3�#� d�Tֹ-I���6�V&�\�j�o����������������.Hˊ�ϫ�{������>msz�.��`��W�)���{@u�=}�ԛ~_e�b�S�P���+����/}­d�G�)�p�?O��OV珒�(ZGB��!I�awvBʴ&�9��aG+�_�C/��"0��`����m�0;�Pu��������������	�7ՙǝƊ�?�G��t��9�ˠy�y7�d����C��w\@y�#e*t˓o���1uͶ_Pq�t2�D�ai�T�,VL	OU7���YK���/UY��O�cN� 7N
��V���>��ɭ�s"����άL�uٜGs�}�{�2���<V��D�r<�u�}A��g��B�C����T   �z��7��nó�.E��u��SVD|.S����Yk$��c�Dq�}S,���P�(�'���z�t�vE�iջ�TI����eS� U��o\�6^=�Q�T�N�-䘋we�I�ʉ�m�x�=�4;3���2�e&�|m��@S��
ܰ�����/�J�o������0/g�"��8f��V�sF�vX�{����8{�G�f�9��C��\m lG h�8�2Bw,�XHN¿k$�{���f���d��[&��X�@��_�e����9��)�?1n<r��؎����Oq�TQ_�%�j���<���H�|Y����t�m#��Ś�|��+>c"��x!8M S�����hOC�-��7_
�،N;VgO�V,��w�W�Q�!5���Ս؎�,�ϟ!|8��w��U�t�8��ci��hN@~Մ�#��"�'-��u&�}<��t�G�D��w�}��!��2	H�˼�߰m��K����P�q���Ē����������������>�����?ֹ���u����q���X��&��숟�p��F1�`Dbi�S�
���/��cRѱ���B)�d���p}�mf�Ď�(����n���/L����|NY�6���<u��LCq6��*�w������e�c(X��z!?XCB�?xý��_��Kh~j�psz2J���n����.��3ጾk �c�"�Ab��
	�J�J��\�nG����e����r�����5rS��Rʗ;�_�K<@_d�YY��{�Z��<�/��>����������          �   x�E��j�@��٧����P�5M�����0�U#P�f�	���^�M)��|3z��82B�(��Hu�~x�ǿ�OS�%�Y5�!#G�8��"��������MzJ�fP^Qʋp���U]�.E��/�O'� ��tm@YAϰ���x�ɽ-�+�եݕ��a�}b�o��n��'�o6]�����ޗ�O~���P6r�q�w!�o�\�      !      x���͒븎��u�»3����b�{��,+�%�.J��8f����N�ڙy"�y�~�y��k $e�	��k�L}�� �����ן����ز��bs<�]/���?�������_��w�Y�����Mb�i�bu9�����?�+}o[���_�����7fӛ���~��ט�.�����,^����.�{������_���/?��������X^��Y[��׿�3�����5������^yx\���յm��ض�9�����k�v��um�qm��Vy��z�:���p#��u}/�j[w���s���Uw������ㅧVη�w����t<��O�u�y�r|}=^�s�rt:��V�S�.�w���T�_pT����5�I��fX�Eu�\��BG�1��������p�ͯ�s��A��z��ڜ����"�ހ�����wV�}	C�/V�3�}�j�Y�����Z�/��è~�m��ɮ�?�^��i��4��Q|��lW8�m�0C����&�ëܐ[��[t�?�旑h���Qm�m�]�bh�r�3ᮅ�v�^�Es|���+������U��*[��{:��*05�nx���0	�}��^�"=SW�h7gn"L#�`�2tE���^y=^�E��%��u����#��H�T��-��gi<�F\�_��oG��W���{]Vn�*�[�#4'����.���(>��k���ߏO�ct�������v�[ԗ�2���j���G���s��������$ %�a��%Q�[����|��]y\�a*��A,�t˲�G/���(���-We-a�d�Q�
��V��p�߄^�kwV�ҥK�z�Y��K����΋�W�ʽ���}<��?����:����S쬥�p���k��Qx#̒\��Iŏ��I�D�4�� ��g�u��J�m|���w4�v�x_��j�Z������.�o^�!��"�KX׆	�,�}X|��3�?�فi����*Bn�4�w����z���1\<q\�	�C1	4���W�v��z�c���߲�]Ֆ�mp�58͖6m���ZS�wiړ�ٚ5LB8�^ί���v�j�>�7׺ƍ�0d���פ	&(2S=����0	�UME�l\'��4T���qxړh_-]�3B���b.�f��.��!��]/Jw�2���Qe���{{;\�+� �#{�,-�@��ۃe��v	��k�A#�ɸ�Z.;�� ���0<�ߟ�Zw�}$�v��̑G�^�����օT�~hi�����ԫ��/��q�38'Z��6�"�����Y��M�'�u�xx.-�,���`cw�*��X�{ld�-`|�'��p>2�3p�9?��8�aM܋+��y:l@���g�(�3NL1�@�����S�N��`�O�C=ҟj<D=�Z��?t�M�׿�m�4F8ަ�<
�`aj���s=�:.p�Zl����� mLK3�b����ރ������ze�0m˗��=�,���t�nchEV�=@�I�ZF3b�U�m�?� �V�0��T��7���@�ʍ9ȯ�UV��ۋ^�YAת��+m�[�+�;`֦j��O�qpt|e�,�_����]t(���rk�)Z������x3�+܇<�;�u��&.�9tN3w���R�j��\�;�o�ï���.͂���w����?�R��U�G�͘| �=�~��i����n��&���{(�my�9�#`aaz��AST��Ҙ��k[�_a֗���fp��[��ʢ��]�#�ѽ�Ml��d$�/�5i��W�F��e���a�fR6�Ńq�ov�۷���$��Ks[��A]�o�6�lG��pI�m�R\���C�>�,Ë"ǓtvCkU���x��� ��s�O/���^�6��¨��
;d��9(�m]�S�X�X��S�\��fo{x�^=��p9[��Ϸ������E�6t���a�L�D�[��G�+�Gh��b���Bq��[3�(� I�a�j[��� �	6엥u���\2�x�È	6�t5$�$�WB6-5��{3a�:��k��7��$����%`ؔ��m%x��/����]+�/1H�nӡ�ո�mW4�=
_1kf.�5�xp��_�i��ey ��?�.y��ma��b�&׭�{ `�I�� �d�e��y0���o!��Wf�&��x���p2S/�}���B@�/���4*BƎK!��7�ꈮ0���&�������0V���i-�k���N��a���K Re[0�<�"c����}T��c	��(1zhrU֋��zW���9�nQ�6|v����n=��5����T�IQC/)˕(������9�K�9��
�\.�l���at ��㏽�R��hu��^�66�Z���i�3�ց���&)�������q��|�6o3L��m�'�dXY��YH@�vN�|���z?�� �T5ôTn�\78����	��lݗ�=4�u�f���Je3�6%�=�پ�6u1���w��Yv�d�j��̰�ʠ��o �q�O��U]GV�{�����d���R#Z+k��Ja���b|q�ۂ�6��lC�JD���V&6^��c�A?� ���Eq||�l����!>,���YUB�K�h���4y�����u���|#��!��nL����vm�>����Ihu��Yޤ["�C�g��E�y��3����u���3��:�<"=��M��N@�z�  �`�#{��҇�e��e���o�:�5jYw���gy8� ���v�v���Tg��DѹTf���o�BǱ��T��:&�Q PE�)�5y/DV��3<�˟�柘 �L�W�%����&�P�^iɕ��-1@lH�Y��MVEյ���`Rܒ:J��V�1��c�G�K�%�	��������v�\t���_Z�n��h1��\>�
�9i��O,a 5!����y��m�)T/�!EjI�Q���b�+}a^�,F��Se|�J�xRn�,5%1��8���F,=9���hM��o����C�*L��?��Qϭx�)aN�]������_�2~ܫ�9ufF�
~NE�s��I�W�[��RSq��o~�-�İ��[��K�":�x6�7��Vx��tM(!y�(��/���|Y��G����k��%֏[�-�$~\���ﰗ�~9�S1D%��0�¡[Q{UCI�^�K�0M��,���4�ڻ��D�zÛ�秠'bo��	t��o?���������d�i����h��.h��g�����6������.\ŕ����M�⍵[���o��v/O���E���C]����lyM_��;z0�/�L)�|%���J94�(��I�d^`�^�E&���M����%�M�5�L�!�,Q8	�]��	{�Jăq��#�hqy�c��C��a�դp"�0󡶦
�#���wA�[�m�۰�׉ڒ�.ܬ-��xU�<�~ؠ�h:�����&D�7Ⱞ��ln�[��կ�*��][QG���%l��Pt¤-�r�nG=��8ծC��$�o0x���z=lnjo�V*�,�� DcV)��>��Ɣ�{Ѝ�m���B�c�n�1���lHuٿ����wV7����'��|�uW1gS�^������ �f�>����vc$��[�K?	~�O���º-��ōa0�N>�m_�8�������	�_��(>�/H��`��6X@Jg��O0L�C��dIW%C5��I*p��5ӀP$8mÅf�+�]��K@�K���i�0�G�	��5���+��*��@9�	��S�n"]�v����I*�Bc$�1oL�Һq���t�����hE�T5h����mp��t�
���\��b[&��>�`L(� E���/ZA�mH��4e�|xc��AB	�z���O������he6���G�?[�,��I ���>���v����h�%�:�����b�'.1bk�p�$���`\����v�ܤ�3x����p7�*zV-=6����@���������*0-1+��
#��b_�����[R%��    ���C��OB3F1�NN�i\�٪���c��1À���-P3��f�Cǀ'x���@`R�!�4����v���1�"-�Y�oe'� �C׏|O�.�jiI�}?��P���t�<���#�aGח�	��� w�s�Z�u�8�*l��S�L��G�C�	Z ��m�S]�pq����+ BW��A�tx�,���{�"������e&25F/��fKJ��v~LY��=Aw]�o+���9H����qi��^^����s���RGnPԵ��Z���G�(�[["�Y��/�϶0 M�
'��o�GQx�O1��-��'<+C��L��f�����
f����g1V8���rc`v!�mr`�"M_U1ߨ����*�5��d;J��Mٍ9�P�4h����tfo1� U�Lm�l���!ք�W�)"�U�fG���w
�5Hm���J��EPX�q"&*g{nl��+ߖ%�!j�No�Ƽ�쬻��,N�6"O�7q��5��rc��,m셺T�B3���b��F�� �F�7D�хr+�]�6�]��@�Uf�'���7���B���$`��d��T|�$y n�;1甇<l���v����E_�>3[�:���׽���1a@x���e������j9[v�݊�u0����g&#vF��4�r�n��Q��>Xh1,�NΛ�MA-��������2<�}8yӄ,U��#d3;o��CI)=�q�K�nh�z}9�g���$f�[C.ryc����/1u]Kq�0����	F�b0a�4M�J~����p��߸˺I@\-���R���e�K����Q>l�-�a�~�"7^�e�6ە�x�P^�f�Rz�p��4H�-Hs��}�h[xJ��8*�ٳ��nһy�M��^��2�_B�1y��C��bF����,���0B�T��3uo�X�M[�:�a��$�scR��t��t��nazD�2�&�l���q�%iu)R�i�&����(օ��s᳈w�Rvzt(��m����҈�p�f�֗�q�-}�ҡk��ϘМ�* ��&[��*�c���E.f�UB�~�� {엇'�A�8��K!�W���o{}{BG]1lѾR��徭d�+i���/r��l�Σ�Zؕ�l3ߺ�4K�{����$H�;��� IW��q�T�(]Ӓ��T��R'�5N��;0�M�����kf�uբ=D0�G�`>�X��� ��|�vgT�@]����~Gŗ��������:z�$#.�j��M�@+���BI�ڐ�W{E��"b��kKJO��˕}7�qW#E�{��c!x�gq��˖
)ma:9˫z���$n���POiNp��
PcR�t�)B�l�
�����\�_�
3<Ѧ*�I6�ݔ����7
���_R���GŠ���z�0��z[���mL��:�xs(J�lk��)�e��Q�Y*�fvU�1�!P�N��l�b�@+����5��Uk�l��]Q�E;m��T�������ʺ ��Pe�T��n߶X���Y?�e~���廼��b����8�6R�$�JRf9%ǹT|a ��f�Eo7Y��bk��~���hg�b�A��*]�=�+)���w�`EB2S��Ù�zg6�!���a�1&��+���a�e$v��(����դNCO�0]̤N�m��v}�k��$�ɢ�SX?�'���X���t_�"ﭞ���0��ׅ��6��zfs�G.�P��\p���䊒�	��Dp��'�lM��1�.V��x3�ą?p������:�,��m��������_h
����p�l;�L�b��C/yS��J'`�m�o
]($�J �VoG9Ri2��rw��j�2@��LI��\�B!��F�H�񒊗o�l�"����`��DX|�V^��R�N�ųRT�o7�4GٕQ��Qg�"V��$Vg$�
T
5I���j#]ǭؠF��z`J�$ʮ�(z�i19<w����n�R�S6U5���!�](!�����	P{�F[��I��'�'/�_�X���H�b��[�8�dx��Ll�喤��#�K���3(�/�`�6�zry�D�!�����rA�o�wg�e�,�1,���}ث��BK�s4�$8$��!5�(ۋT���&�{:�e�n(�4e��#�v�����&,�����ӵ=���N9� 2�(� K��.Ÿn���������!��;�Up�;Z}���R��TO�K������7%~H�������3ube9�����XYR|&�h/���j7��XO-´�Ɨ<�W�OmH���P��s`��ж�{Q�d5��4����1B���Jax!�f
|�l8�-|9��X@�/���Da�(WX�p�^!��t��'�JP�.`l�
SD�M�+}#���Tx�Q������x@G�h�$�҄N����a��[��A���*V9
X��q���jXͧ��!Q��s8n��8����,�d���31��Ei�f{������N�]|��٢`���_7b�r�:��7�Tj)�8
[Ϙ0������f#��L+��"���3��U�����P;��h
����T.)a-�b�Q�P�CG.����ΤC�r�eenEĸ۪`�m��|��r�6��Hjd:���v��S���(THELJ!�' %�Р�'		G��$�NXQe�qW)����U�[u�Tvimv����H�I�,F��0����)Cuz��{wK��G����� ��h��<�[��#i�P{40��5<|T/r��y:<Ya�%��u����z�vU6`�B����dHQ3,��/���o�W��cLC�\M�0�F�)�}]e����7������ȅºR.U�ʍ���6���J��b��v�/����z鼭�Q�[<c�jF�����S��A'��IN�ח>���C��^���kS�z�A�$����O��N'��'0����_#�'?(������S�y�1ے�DyV��Hyb���� >�BJ�������9UkW:%`J��#�TeJyG�:��}Fʵ� #R]�i��
��:z�.�2�!���+�q��a�;�����"���Fr���J�גE �L�-�J_�d7i�ʵW����z�D��]���C�5�hP�`�$D����z�Bp�a���K�Fƛ���E�j�۬�E�]���ר��^y��	'R�u�J_I��w�P���E�����]��w2�&�$%�#�Ж����v`/:t�X!���[��bȷ])}<�;�.`1��;"[<��ӆD�ؔ���`V�Ǿf"��u�/p���ܘ�`[���9��;�^)�t�H)8����&�С:��P���C�!��=�"<�(�3B���P�$m�_�i�%�J?n?x���
i[ٔh�a�<S�&BX��VRJ���M�.`.| �w�,z"	yәd�LD��!ܥ	S.���m,1�]����H��LQFJ8�P6�7�R!�tvV�oj�1)ɇ%~�8�V�s�����\�?b�r�����9Yۯ�C#��٠��ѡ!A�k���#���1eF;y2����	�w���#]ǘ8{O���Ĵգ�A�kG
�9����D��uuε�Eűx�u��
�
���+�$I%��92�7��:��~A_�0�A/K����ȹ�§v[�e�������,��å�/�CяH����̡�F}s l��:�$En�~,���u�g�G��b;�T*�`SR��w�Jl@΋c�:����
�ԥ��X��	[1��o\G���̛
����<�]��x�[!CH�R y6膮�����c���Sc���H�$��C�8NI������Y?	�s�m��bc�}��Eey�}�Ic<�l��[���;�
��0�^_G�R^+�����[��.,JRO���������S�V�B7	�\�~^����\�"�e�K�ґ2S}�D��/��%�'�C�o�`��'�ٙv�
b��-��O��x`oik�z�ѩˤ曰����~f �a�6+җi��d�թ����<����^فv0aep������Y�6��0��G�� �  @P��m�%P�N���᜿� �N����x��;'^�fGų���x�����0�ų�友'N?.>!�����|_�>(�y�^�/��*~	�j��k�G*���Oh��k�'�,��D�/2���G����2:~�Ӆ�7f.䗚�W��*�O�jr���g���e��;���DN����_xΜ�?R��"���#2���5�И*�O�L�/6�MD?h�L�G���D~���\��}��~��Ϩ�;W��fd��bd�r�Se�B���
8�����GL��'&�����;}?�����3�Dj��0��(�Ŷf"�� ����_�����>�����$�<����Ϥ�
��#���#3/Y�u�?r7�t5F�/���?!s?sS��_��~����_�ӽ���~N�?����4�c5�2|����:����o\+��Fb���7�K�e$�����?�	�2����'�����$�"5U�3ս��k���\V�?������?B7���+�J��GF��OQ����?b�R~��h�#�j�gLV�h]�?e-�rZ��M��<q��gF�/����?`y9��r~�r~�(�#�*�#s�����?�sA�pg9I�>!�O`Nҟ�OI�#���Gj"�/;���|��KWTE��QE�ɋ������G�3���)Q?�Q`4Q f�~���?�Y�TY�r����� ���h��������e���d������Kq�~����_���~ҥ�M��"��'P���T�/�o�b��<6W�K���OԽ�_�Fu���S���v`����_¦�~��~T���j&�篦(��?|B��ȼj?�Sվ�h��j?`�P�G�^��6���G./ۏ�&ۏ�\����T�/4������r�}����;���܉�h���O�����G�I>B�׏�~�zsm?����ʉ��Q�ϝ,��L�϶����s���j�~BtyDf�~���E�7L�'��"���;��̱:��
�E(+��.���&��Ƚԟ��Z��(�����_�^��Rk��>*���>H�yl�����?R9��T���*���&z�b�⟿h^����er��@}B�A]����_�di�.���T�� �(�T�bw���4���h�#�i�#�k�	b4��}�u����?�Y�����@}�������/��w��'N�'$'���.��'��	���ٖt�d���j���̤�R;9��������� ܉���0M ��5O��$ ���� ����|" �z@�� ���`[ʤDh�9c����< B�� �ޙ�<�'$(�95 0j2���x� |��f>@�O& P�| ��gpWb�Dr��2rF@�]�����\F����O%��(I��u{8]����7����OhX�9�p��ckF&� ,
�=�7#��W��_����������_��_�L��      "   �   x�͑1n�0Eg������x�\t�XwPS6�H��f��.��n�����gxy��Y�=�[L!�bA6��ï������n��
����0aȹ�G�!���<ʶ���%���	�{c�j6l���}@��{��Z[����
��{&b�FM����hP�cR�h�9���N�"-�d�Ś{�'�Q��`�`r�=�y���]Wj�)���R��      #      x��}��㸕������vy1�I��H��r��{���_2LQٔ������������b�_��^�;?� � ��9?���������?���J�)��&1�S�1�~R�G?=�d����������2$������-��O��������׷��>܇�D���[}η~NƤ��[�e���c������y���<��ԍ���0&�?,���?���?����?����[ո����������'3%����ӯ�p�1V��I���=�k;ZCv��|���`��y���C��F8nc��>��n���N �����%�p��F���~z��3�/SŧW������-@���h?`����p�<(�5���0ݰ�����lw>�����ɵO�n���K��/�Ѓf�����m��YLc��{f��ע�5{�}^�vR+msG��q����w�T&3I��x��ܸ$ܾr[��h����Mx>�m���q���*s�T��k?�X�}�f�t~����Ж��Č}7�ً/]C�G3| &������+�%2��)�+�moU���1t����&=O���=��]�����8��.JF/y�@�΃O�O�1`W�sw�u	uj	��������`�N��wI6��p�&�w��*��<��_�&ɻ�å���`J�����.Z�������xx*�BiT��מ�9���s��pN������_�,���KY3�=�7=���6wXF��4�*i�9&ΐj#���n5IA7��<�y
��\sX����f;�`������&�?Ӊ��~gOf	���4�x��']�{���9Wx�?�\��J��V�\��<`�ch^�{��\h�}�T�d���>�]�FY�=�7�z�|��η�SX�������;Ǚ������F�����,�S�x��2�=W����z�;�mc%.�W���Գ��#����X:9��)]�LH�����'JKu2V%Mw�f8�.M���@]�e*o��1�v���8���L�)A�����g��oO�}?�2�kt�w售�:�b[('�U\��\����Ĕ�*˜k�x�:�\s�6��2#��]���ĺ�����90u���x�#���wf}�tx�������fi����Rb�5gu�(��X�e��`n�أ�b	�[\�	���gh�h�I�kt/���
�d_�DC�K����߰L�2$��JϼG�K���q���P7�W<[h�J> �3��Y�]����|�sJ�<v�� \1s��:I��������ڻ&����Z�Z��=�l��.���Ï���[le8�&�b5p��uCo�w��!�I����~��=���$v�]�ˬ�=�m�{�����Mc���I�3�S�Jf�S2w�.�s0�������1Z�ZY�Z�~),�6�e�=����9�X��L��k7=cJ��; �uS+�<o3�`��h�y$���N�HE�1���л�d*��c�ּ���7�h8�O�C�e�>vfʧ�����|�r=��{/d�pP��Ta�+�N�bJ����em��ZJh�K����|����^��x�Wzdi��ݫ-��<րx��}#�F[����j4�
�� ۥ��o���Sϑ�k��;, 1r�����{�9��[2�!/������,&r���Յ�G�xiX�h�d	K�a�uvro2^�0M���@���Mp�m����Z^��;����>�ޝ���"�-���ܣ��e:�b8����xm	zx޻Ȑ���603D$3��g�mt�N����0I�3���
�l]�#��doʵ���ׯ�8\���7#��8�E�)��7��v�9D3��
�{��U�����Ti�煡ͣ4�4VD�
<�^e�"mA7r����6]�+s�İ1w���CDOho�+)��-�bx��l�Ha�M���c��ʺ�[�s�dی��WK5�桻��}]���Xd�|��nW<��RE2^0��I9Q蒠7
Q�E��4�K�~�Wq,�9*H�x.%�Hw���$m�l7�\ ��{S�8���0�O����xS�j�g@�t>�ʛ$�w���e�N~Z�/pOk�,h����^�&��/|�ݧ��]��m��O� �_�����d��K���1~�~`��~Nq3�h���mO?4���M�X�v�����O�f�\������{@6~(0�a��H�w%w�B��R��cd����U�ݕ��3`a0gF����^&��N���y�y�,?��B����l�8X�N�Z���o0~�$�z���N
�]�(B�O�d� E'���$��%v���N*)���2��T���-��~��n�7]b��
|\�H�O��Z˜p�N����Kh<z���*
/�B�wy��ƌ	L���#V;��w>ۤ*Ў �G�:5�0��_�}�NC�O�nYP#s�&��E,Z�n%�� C��#��w_�txJ3����D�_)�� ���ʣK����2�F�|`��@�/W�U7�pl'?�_G���|�@��xk��Eˍ�f�,�A'/'��G���Y9���[�}�I~��}%ZfP�� ��\����>R�6_�}�CY�A���jn�lz�夢��T��e*��AUL�#�V�������+�\d������!�/�n�`�2ʫ��-��Hw��3�
4���?\w�A��Y��`%+��h�ڜ��G��ub����k�u�M���a�����c@�����+0�{�M�l8��rQq)�������L�F�\���[�E��K��N�|�V)���8o^�X��<sn�-P��t-(Q��ن�ڲ�?r�]B1���
�M+qyp�2���8���?9�K#
�W���y�-%���p�^�7i��ǳ^d��b����q�|@���ׅ+�m^�X��Nf.C�P;/䴟��X�r�m
ז:0�����c�$�/T��,��i��H��P�,�%�8���A��MFz��p�Ms�G(ح���Lh[O�~8��?�z�k��Z�B?ؕYkϗ�s��E't]�<HҽByu�*�p�A���gv�7�i:;��T�Cj��7��ح����
U�P+�jمNߔ�Y-�{�Ճ
�{A७T����ұ. mݑ9�� w������^6E�G�_�1R��x3��SB$�.��W��M��.�1&�.M�(��]A���KT�V,˗���m��*rB]R�4��O���b-!��'�^܂X���W[el�]ZjPR�°���4kg��m����2�u�8_D5�1:�����0ٲ
#[�t#��ڶ4�2���x[�.SeR�`:k,�V���R%w���t'r�W�(?�+�\k���{�<8%w{�u�c/����i܁�b,�1�jsم�M)r�$��re�JB�{��JG��_��P������O���F�b6v&^�)4�eʁ,�<�
�;��� ��d�QI:?'8˩�ߎ3 ܰe4�ɵIRr�鑺�0a��qk����5��$q�0\x0�S��4��7{�,��sPؽ���o���7�M�&�������X��m	K�mo���8�~�p�,Kܖ���ABB��҅�Q��w�tw:� �Ȗ,�kL�/�f��F�wRm39�� L{���'�ܾ��'�v�ur���ʜ^s�P�&����_rR`�Cގ�=�y�b^�ОNk�������I��F�k��^��NH��/����(�7��
��;{�#�u�e<��k�jeksfk���G���̐\��$������������"j���4"��[e�������6�G�ك7�v�#g���,q�:L�/}h������]Q���i�EM��m�2�#�ׂ��[�ڟQ�k�59�z�\���l=��!i�3U���}�N����p��+r�9:)��|��m{U��9e�����L���5��`&�"���L�J��Vsl�Aʮ+���e�`{��̇"s�G��E�}���39ҟ���َ7�V���~�6�8�A��6������_���|᏿�����gt�а��ƍ�1��,�8�{�~G�ި2���k�	��%�9�S<��;�q�    �#��h��3nc�{��(`��:��U#�Q����Gߌ:*ɓ���h1˛i�c�4�e�2����^h�/����w8�U�	�7֪O��*�ո�`L�������J	�]��_� ,�U���,4g�U5�У�a��G��m�k�m`F��ϟh�/��F��v+��\�p�}L�,-;P�۳gB��7���vMXp�n�_n��w,�ܳ�]��r�O�U��A�^�O��p�J��K�Y��� �?��B��<{Ș�cE����P���l�f��w(���^qF�<�@�������Y��[đ;c�;t���Ԩ`}FfZ����:-���и��kш��OuR�V SƗ�t ����
\���շdVb/��Cw�� }0�?k��̦LR���v�pI�Q��^b�h�0�|�kCHl+�EA"iG:�h�B��\��ʹ����*�~B7~�/���p^��rz�l?�Gc��(��~~�[ɝ�k^C®m��3�2��P�`(X�#~�uB�57�f$�����)�K�T�l��l ��>(���A/�z�X�p��a�\�7��]�[NP]�6��R��ۑiH�೮�-�4E�ۜ��k�QۑE��B�C�S��6[�8�/�[��'<2Vx8���༎gy�!� ����*R[/�Hx���U��ġ�KO�����qëE���`$կ|�H�_(�H��)Ti*!��++T��;u�<wH6_�P� ��5)o\07��']hG�K��n���M��ShK���ک�[�����k����o	��-��K��IZ��ܜ&+��j�X�Wa�QY���X�l��?�O�-�i�<=\�p�.;�?��a��y��I���"މT�s.b9����;�i���̕��@�J�����.g�y���}-A�=j�~lv#�/a"��v
���J~����DC��R��eۡ����6�_�[e,.��QL��	�љ^�����;����a����RE�G��Á׵߳�ba�l~�͟��i�4"=��^R\e��Ѕ[b���%��<�1w0�t�p��w��C�����a����k	m����+&t��3�/&�o�VF����v��f�(�u�Tʪ�7p'�����B3���.
���V���'f�)��4��b�1�E�3a��4���FB�mJ��������5e����!q��q�.��K�l�y��{��h��%0���c��n��Ƈ�K�8�y�W���X�j-,㣇�H	z!��oS���f&i�����p3�j��f��̇���dX�y��JY(�Ѿtvm�]ɍ�~ �z;�y���ҷ2ٛ�_ �s`&kuTLԺu�C%kFl�XX{�r;�m���=`�n�i��I�]�*�(e#@���X4�خ���珚g?��p�K8����
��/V_��:�:9��\�)s�m��X�5�t0���.���Dī�j���klǲ�6��&`�o�#��GX���b�b*��p�!���63V�Ŷ=V1�N6#\F��C��8�bݗ>^�׊<���O��Vy��c?�p�i�*�M˟PG���������z�x��Q�.߸�/�oE$��A+_��U�~���������k֜NjIH���,&�^W�f�Z�8�ر ��^�R����Z��Ƀb�kw^��|d��Ј���s���˒�`�O'G���]��JQq�	
R�6Y&M�&��B�e8�ߕ�<��)��ye߁�e��ľ�o���+���7�Z��Rm3�PF��ëNf�m]s�[����.)������{(������|��'���WK��S\��+����h�u?�xl��V�6�O4��QK��G�R���М�B0¯7>���}�)���2��+�
?^1�%+ߦ)9�k�)��lQ;/}ۨ�p��+au ��2�s��7_���3�WXJ�,�S�];`+hdD���W`,j�B���P�}��r��'���9�(�=p�����
�=Ȍ����.��:��v0쥩]Ó��~�+��b^�^���:ħ�>��",�x�����߱�ƃhvcʣ͢8w���T�� 󽃣�
�k)uw��'�ֶ��S���]n���BmJ���ј�Z��S�w�4ah���z�wX�Kr�1�д2L���v��mhԖ�;����-��ƣriX���D��q���sG��#Az���,�
,nr���ψ7�ĺ�:b�xy ��'�Mqԋ��ڙ��m��gό�`'��@2�(�%w���zU��b��I�u, ��4�5�UӴ\B�4�ڋ�s�O��e�]ZaQKoG���z��#%�:c�.V��ܖ�$�z��<��)K�!@E���_��P�O��
rR��Ǧ��K{_��4O��#W��3']��'�v����Ҡv\�̣���;���ʹ���x~���?�D��H��t�k�ag� lӹ�I�VLE��YV��������-�����B�Q�\:����Z�����	��7�T�,b�j]�OO�[�o3�e8����X�s�������H���zgS���S|�C�&07����Tq2a;B�'M���v��.�xxI%�}�>p����2�ڀ��_z�.��7�T�����>��U�� ��Y���l��W����>�2cU�]���R��ܫkk󛦥gKO0��x�Ӽ�d����6�Za!���� ���G%�e����ܤ�B�q&�K$��z����a^bZ��w�H�d�ǳ��(�[���JǤ��f�M����*U>��������x.���@�A���Hwh=��6I������AY����Ƃ~a��ж��w�?��w] ����%�@"��J�F-%C3�H[_)��5/m����k�-?���J�S0�穿�]��2�z���|�J�&��n ��C�3~m Mc���mfZ�P�݃��u��G#���2!�-��@�����I%dO'�����V�������ks�p�C�i�����3���,�a�=Ǻh�}�b�%�`��<%��UM���|�@~ #�tq@��+��d�U3~'�!��m߽�Z��g@�d��U�h��+����oRPx���)���͢!F{���{;�./�N0�?)�ЄMv�)
�_�f����z�/�"�����V���*��e;��� �[A�����p�K���,	40৓�Jmn�L���zl��a+���hpw�.M�ä��N��7�o��FK�4D𫫌����x����Q�x?�	�ǯ���}R߮�z8#Z$�!���?��f���N
��.'nJ
��)���1V�|M4Lpyc���^��pg�|�(��w��W
{�d˗E)�@&�Mh�� �}�\!����b]>��*I�'޹ue���-��p34��*�	c������-5��tl3T�m�]?����ʐ-j����Vq~�9����6x��+|��N��D^��L5��OƂO�.Y�xgFaUD�޸���Z�W#W���u�kmo��Iޏx��V�8V'�\����s[��2pK��g�]t�G8W�*��*���"H��ꐱ�9H�P+t�����<B7Y��cc)�Ř̕�?&BЎ�	A���\�H�u��>]rx��p�m��?r�Ǡ�gwm|�_�W�h��?jo���.�����㣛{���y���Fᰰ����r���C;�\�"��;�w�
����.��d��*�s��kz��W�B�M��v�k'�b�7�z-�R�4�F�W��t*s22�w[(���Z���JÈ8��k��W��-z�#���a�fg�Xo��Q#s�y�Uh\Sqs��J"~~rV8,�i�q�W�j�E��o��ԅXN�Y��e{88�%�hW�I�=X��Q��gn��e0�W���>�MI�-~�M�𳃰��P�g��ϯ�����>ұ�3|�oX���Gꎸ�|�p�\|�H���SA������v���5[Ыw�����`J�쥨%��,ı#`T�?/��hK�m̞�!�*�F�,&():̴�.N�Y� /��Vq@<߀�-�    /�S �H���2�ͫ��>�|Qh�%��?}�Y>�e9��f�������Km�͟yv l�5�yK{{��|�(HVAح<߮7��ګF��j��e>^��Fe����������d7�C��t�(؁�ڻ\Z���f������Gsy~���Я�����,�[k��%��g��{�J��)t�p���o��wkzU��"�{���j����2��6���^eP��3Z�׊bt�d��=\o�7�js��x�*Q̌$PG�lJ:p������ys:�}��n|�3�՜Nn_���L�-�󽧠v�����wI1wp���U�ܽ����b�������MB���ᴱ�eH�W䅻}���*Ma��`���ّXca����:�=�=�6x�MF�WN�V�s�}o�݉Ԁ�V%�[0��o��,�i�"
�p���B�8�65B�+2�=^×o��Y���R�� �N>�jPe��,ܫ�k����.L0��94����[��DC��z9�sу�B0x��g��5����J��ب���l(إU��l�3�Xr�G��v���J���hD���0�%��9���=�~������;�7�G*c����1�2i�Ay�3�&���mş�j�(6doƻOIу=��[KǖSI��k's��ܶ�;�s�Eű����ج=r{�u@��SN� �{�t�����k_ڪ2ߥ)�L��X���u��R�pg�uG��jR�D�k���YIͿ�^���o��G2���XK��y�J�)��'�+�VRg�
�a�Z���%���j���IA�'��xX�{(���L�\�������� vi6*�q�Ua�i���0�\�F�K%�����_f��Ve^�4��'S��wxGL �L��L�Sd���b��H��s�k"j�e���Ϸ	������0�Z�N  �uG��n�1��n2`]c,���������:��X��A�nɫa=�d�18�!\�޸������0�=��{Svt���p��
��R%�:�-w-6�s�l���Ǩc��NꞂ��#PZ�A��,�7�sc�*�h<F�`=X�f*`���/L+=-�8� f9,�vX'�����|��F#��%���FV@J?�5M���0[���g�0��ց��t�ol'X{:��
��w4'�/��x��GSX�{�}���W�9����7�D1M�Z�º�	�� fd?,{)ݣ��5Q��S8qH^ɏ��<�H��IU�z͙ ��I�����KK���l�w�Zd;1'׮{]�U�lJ`��D�@�=^�&�|������QK�����J�
bj�k>��O�h.��C� {�;9�
u�˔�����=��^)��#�I�}�Y'��2|��Fm��P�S)z�8��A�0ri`I;:����#=����6���hki�0�q�>u`&�7�@'��P3V�ݫ����e�~�����k=��x�z,�i�� �k�/j��,�� ��D�ſ��r�����]��U�E�u�o����1��SҞOXfʗN�|����͌�7�c��������+}|�k7�h�c���l���ˀX�R�Czu��D�n����ZΧ�iট�;Zr$5ʒ�k��^�n�&Å���Z����Sr�~�w�iP���5Q�+��lY]���<c���̐O��<u���?Ѭ���1xIG���G-Ή�E��*�6�� >7�S+�C�ބ,J�$�0ޚ�W���}Rt��˶��5��y����{^�=����8ԥӦ)��r�ȷop�}�ϭxk=�X`�u����}[����A�{��\KS5ߕ��<�|�W����5G'��m۫Z��p/��r1����������N�j%�D�e� m�@V�$ڻ�j8��\��qV�Q�v�!#��o�Z��Ex��8�i/2��J���֡��|��|r�����	�;fW��z�B���1��,�8��
��B��~�p�}Nh�u�y�yt���m��Li�����:�<�r}�H�<StDu{����f�1��9�`������aˌ�j�{i��ܦ;أk��`��_0��X�>-�2�ո�`L��yjX���T���9�_� ���U�H�B{�\U��,g�5�o�ab��K&��QsL�eFР��9���|�sќ��88ƾӼ�
��ȭ�[^-Xp�n�_n��w,�i#�pd爗=���Ry�L��|��!Y<���h�R�Kl=`����nr0y*�|B�|+��;MW�-���ͨ(����̙-9i���_џZ9
����H�c-B85c�8[8��IjT0��2�lR��XM��@~\`Y�Zؾ��Nj��
dF������%�<�V\�_�X���s����٧�k��$U>�M�p�t@u�<�5����[���`����0*s�K�q �G�{��,��,�R�O����es�4�_΅���0����`؏R(�f*�;�O�L���l���0�(���̅�����?�"�ݚ�W�/��JSo��������Je�d�t�AI��4�o�q��Y9�F�*��G�{r�n9Au�����.�؎pB��t�1�Wi��j�p�%���YD�*�:by0��k�u[C����|�3 c��FĶ�༎gy�!� ���|���F$��5�oe(16��m�WGQ9���}h�_��4T��U"��d�;v�`/M%�d_��Ry�.�%��j�����)D"+��Ʈ�#�c}�^K�Xf��E�B[�mo��N-���T��@]���[�,\|K��o�O^���&������Ă�)mwk�*�;*+�Y7�`w�����������R8��]vx�#���� I"Sr�9<��;^���߇�X�y<g��Z�*sec>����m9+���Y�f_4��%ȼG�ĉ�.bD�%Ld�:5���_nw�9ѐ����p�v(�b���W�V�K�q�B�b@4zBot�y_<�'fa�r�.h�TQ3Qj�p�u���X�9��v��nFk)�7m�v��L��pbK,�ݸ�r�':���a��.����]p�睾�x��~��Xf�foZ��bB;��brq�meԾ�i�+n��²P�^)�B����8��/�|I�6�(��%B�sa�d�#�)����S�*�/1_�'��g�i�)���/���۔~cc')��Y�k���u+<C��+�%�e�|���o��«�2t	L�1,��7�n���/����E_QP`�cU�i��;淩{�xS����s�sy���J��m��`���W�/,�<A�)+��h_:�6�"�U��^���=)ne�7-� ��l�\�ꨘ��Ǻ2�Y�QKa�=˽d�y�.�9`�Zc�i��C�]�*?����X��ؾ���ۏ��'��j�4������g9_��ؙu�Ytr�+��p[���=�h̊`�7-]4:�a�XWma��PaYNk�W�K�56�����Qؙ�����#�Z�\��0�M�����63��K��1� e�d3�cY;t�;����}��E��q�Od8�.q\��Uɱ�z8ڴZ񦌥O�h��������z�[x��,^�l&^}�_�ߊH"�CV��M����8.|<p)�je���k��f!A��6�Ժ ���n4�ѥvx)�ZךgN[]{����I�T.e�b�#\`��]|uY��eЧ���^ol.Xw�(��� �K6Y&�&� ��w%,�m
�s^@�w`T�5=�/�[8���ʅ/�<�֭ͦ�T�|$�e��ë�f�m]s�[h���.)�������+�++#����c��g�1u�<�%�̹�.A���~�6^�s�ǔ�JEnc�D�����AYN�.�N�M��Jh΍w!���`�A�������z�ow���2�?^1���{Ӧ)9�k�)��lQ{F}ۨ�h��+a5 ��2�s��>���Q5���pF���e|j�kl��G�2P�
�E�R��4�O��\�ZB���}^c�PfD���O�U�� �B͌���X.�~�:��v0쥩]�3��~ @1�� �  z��!>�!�]a�׎��P[oR��Xv�4�1�Q�fQ
�;�j*�A������ǵ�������k���)\R�.��x��P�R��i4$��K=�}�J�F�����o�w)�]�������frη+�XphC��l>�9m���%�l)�����qѰ
;E%�����_����h�C�H�޺}8�����b��3��G�,7.�Gl��ב���#�U�w�P���tn��={f�|ZB m�����	v�à'�}sTen���h�%�ױ �wӀ�XwTM�r	�GNаk/
�y?�N�M�إ��v4���	-�@�u�4c�4s�-�I���y�GS��C�E�΁+�W?8�����$b'�i������&͓:�����I���ɯ�<b�6vG�uN����<
x��S{8���)1B"�_�������d|     