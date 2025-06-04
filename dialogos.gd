extends Node


# --- MISIÓN INICIAL ---
var mision_inicial_dialogs1 = [
	"¡Excelente! Ya te encuentras en el directorio donde está el archivo.\n" +
	"Ahora vamos a listarlo para asegurarnos que el archivo realmente está ahí.\n" +
	"Para eso, usaremos el comando 'ls'. Solo tienes que escribir: `ls` y pulsar la tecla intro."
]

var mision_inicial_dialogs2 = [
	"¡Perfecto! Has encontrado el archivo 'IPS_Departamentos.txt'.\n" +
	"Ahora queda un paso más: ver el contenido de dicho fichero.\n" +
	"Para ello, vas a usar el comando 'cat' seguido del nombre del fichero.\n" +
	"Por ejemplo,escribe: 'cat IPS_Departamentos.txt'.\n" +
	"¡Vamos, usa ese 'gatito'!"
]

var mision_inicial_dialogs3 = [
	"Puedes ver que la IP del departamento de ventas es 192.168.10.10 y su puerta de enlace es 192.168.10.1.\n" +
	"La puerta de enlace es el router, es decir, desde donde le llega la conexión a internet.\n" +
	"Ahora, usa el comando 'ping 192.168.10.10' para comprobar si el ordenador de ventas responde.\n" +
	"Recuerda: si quieres detener el comando, pulsa Ctrl + C."
]

var mision_inicial_dialogs4 = [
	"¡El ping ha sido un éxito! Eso significa que el problema no está con su equipo.\n" +
	"Ahora prueba hacer ping a la puerta de enlace para comprobar si hay conexión con el router.\n" +
	"Escribe: 'ping 192.168.10.1', y recuerda: puedes detener el el comando pulsando Ctrl + C."
]
#Mensaje que sale si haces ping a una ip diferente a 192.168.10.10
var mision_inicial_dialogs5 = [
	"Esa no es la IP que estás buscando... Prueba con 192.168.10.10"
]
var mision_inicial_dialogs6 = [
	"¡Por todos los nodos! Al router le pasa algo,\n" +
	"Ahora mismo les envio un mensaje para apliquen la técnica ancestral de todo buen informático...\n" +
	"¡Reiniciar el router!.\n" +
	"Inténtalo de nuevo."
]

var mision_inicial_dialogs7 = [
	"Enhorabuena por este gran éxito, ¡aquí te dejo tu pin!",
	"Pam:\nSaludos, soy Pam. Me han llegado muchos email de clientes que nuestra web no funciona.",
	"Viejo:\n¡OMG! ¡Repámpanos y retuécanos! ¡¿Es que nadie va a hacer nada?! Ah bueno... nosotros.\n" +
	"Informáticos al rescate. Nuestra web funciona con el servicio apache (¡el servidor web, no el indio apache!)\n" +
	"Hoy vas a revisar el estado del servicio y, si esta mal, lo vas a reiniciar.\n" +
	"Empecemos mirando su estado. Solo tienes que escribir: 'sudo systemctl status apache'."
]

# --- MISION APACHE ---
var apache_dialogs1 = [
	"¡Vaya!Tenemos un error en rojo... ¡los peores de todos!\n" +
	"Vamos a reiniciar el servicio Apache. Escribe 'sudo systemctl restart apache'."
]
var apache_dialogs2 = [
	"Ahora puedes volver a comprobar el estado del servicio."
]
var apache_dialogs3 = [
	"Viejo: ¡Muy bien! Luego me acercaré a hablar con Pam para decirle que lo hemos solucionado.\n",
	"Departamento de Contabilidad: Hola, soy Miguel. Quería pediros si podríais hacer una copia a la carpeta llamada\n"+
	"Privado. Está situada en Documentos. Es importante para mí, ¡y nada de cotilleos!",
	"Viejo: Ya sabes que tienes que hacer. Conéctate al equipo de contabilidad usando SSH.\n"+
	"Es muy sencillo: escribe ssh contabilidad@<Ip Contabilidad>.\n" +
	"Recuerda dónde tienes guardadas las IPs."
]

# --- MISION SSH ---
#El jugador se conecta por ssh a contabilidad@192.16.10.100 salta este dialogo:
var ssh_cp_dialogs1 =[
	"Viejo: Muy bien, ¡ya estás dentro! Ahora busca el fichero y realiza la copia.\n"+
	"Usa el comando 'cp' cuando estés dentro de la carpeta Documentos, escribe: cp Privado Privado.old"
]
#El jugador tiene que usar ls si no le salta el dialogo ssh_cp_dialogs3: 
var ssh_cp_dialogs2 = [
	"Viejo: Marcial, no te olvides de listar para asegurarte de que la copia se realizó correctamente."
]
#Si el jugador ha realizado el comando ls en la ruta contabilidad\Documentos y a hecho cp en el directorio carpeta:
var ssh_cp_dialogs3 = [
	"Viejo: Muy bien, ahora sal del ordenador del empleado escribiendo 'exit'."
]
#Si el jugador  déspùes de empezar el apache_dialogs5 usa el cat en el fichero Para_Pam le salta este dialogo:
var ssh_cp_dialogs4 =[
	"Viejo: ¡¡Pero serás cotilla!!...\n "+
	"¡Cuenta cuenta!"
]
var ssh_cp_dialogs5 = [
	"Departamento de Contabilidad: Hola, le hablamos desde el departamento de contabilidad.\n" +
	"No podemos guardar nada más en el ordenador. Un saludo",
	"Viejo: Me da mucha pereza ir hasta allí, así que te conectarás al equipo usando el servicio SSH. \n" + 
	"Solo tienes que ir a la terminal y escribir: ssh contabilidad@192.168.10.100. Recuerda dónde están guardas las IPs."
] 


# --- MISION SSH LIMPIAR ---
var ssh_clean_dialogs1 = [
	"Viejo: Ahora ya estás dentro, creo que el problema es de almacenamiento.\n" +
	"Para ver el uso del disco, utiliza el comando:\ndf -h /contabilidad\n" +
	"En la columna 'Use%' podrás ver el porcentaje utilizado."
]

var ssh_clean_dialogs2 = [
	"Viejo: ¡Un 98%! Madre mía, ¿quién ha descuidado tanto ese ordenador? Mmm... vaya, creo que ese soy yo. Je je.\n" +
	"Pero no te preocupes, hay solución.\nEscribe: sudo apt-get clean\nCuando te pida contraseña, introduce: 1234",
	"Este comando eliminará los paquetes descargados que ya no son necesarios,\n"+
	"liberando espacio en el disco. ¡Es como barrer debajo de la alfombra digital!\n"+
	"Pero cuidado, no borra programas instalados, solo limpia archivos temporales."
]

var ssh_clean_dialogs3 = [
	"Viejo: Buen trabajo. Ahora continúa con este comando: sudo apt-get autoclean",
	"Este comando elimina paquetes antiguos que ya no sirven de nada."
]

var ssh_clean_dialogs4 = [
	"Viejo: Bien hecho. Siguiente paso: sudo apt-get autoremove",
	"¡Vamos bien! Este comando eliminará los paquetes que ya no hacen falta\n" +
	"Poco a poco, tu disco dejará de parece un Grimer y se volverá más como un Jigglypuff."
]

var ssh_clean_dialogs5 = [
	"Viejo: Excelente. Ahora dejamos esto limpio como recién estrenado. Ejecuta:\nrm -r /tmp/*",
	"Ahora sí, esto va a quedar tan limpio como si Shenron hubiera concedido un deseo de restauración total.\n"+
	"Este comando borra todos los archivos temporales"
]

var ssh_clean_dialogs6 = [
	"Viejo: Perfecto. Ahora ejecuta:\n rm -r /var/tmp/*",
	"Este comando elimina archivos temporales de /var/tmp/, asegurando que el sistema quede limpio.\n"+
	"Es como usar la definitiva de Janna:\n"+
	"todo el desorden se esparce, los problemas desaparecen, y el sistema vuelve a respirar tranquilamente."
]

var ssh_clean_dialogs7 = [
	"Viejo: ¡Muy bien! Ahora vamos a borrar las descargas del usuario con este comando:\nrm -rf /contabilidad/Descargas/*"
]

var ssh_clean_dialogs8 = [
	"Viejo: ¡Perfecto! Ahora vamos a limpiar la papelera. Empecemos con este comando:\nrm -r /contabilidad/.local/share/Trash/files/*"
]

var ssh_clean_dialogs12 = [
	"Viejo: Y ahora, limpia también esta carpeta:\n rm -r /contabilidad/.local/share/Trash/info/*"
]

var ssh_clean_dialogs9 = [
	"Viejo: ¡Perfecto! Verifica el uso del disco nuevamente con:\ndf -h"
]

var ssh_clean_dialogs10 = [
	"Viejo: ¡Un 70%! Eso ya es otra cosa. Ya podrán volver a descargarse películas... jeje, guiño guiño.\nAhora, puedes salir del servidor con:\nexit"
]

var ssh_clean_dialogs11 = [
	"Viejo: ¡Ya hemos terminado esta increíble aventura.!\n" +
	"¡Ni WALL-E limpiaba tan bien!"
]
