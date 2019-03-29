# MiPruabaUno
Reposotirio exclusio para realizar pruebas

/********************************************************************************************************************************************************
/********************************************************************************************************************************************************
/********************************************************************************************************************************************************
                                              NOTAS DE CURSO GIT
/********************************************************************************************************************************************************
/********************************************************************************************************************************************************
/********************************************************************************************************************************************************

Comando chido para ver el log
-->  git log --oneline --decorate --all --graph

Visualizando estatus Archivos
 #Resumen de cambios 
-> git status -s
 #Resumen de cambios y rama en la que se esta trabajando 
-> git status -s -b

Agregar alias 
-> git config --global alias.lg "log --oneline --decorate --all --graph"
   git config --global alias.nombreCorto "Comando de alias"   

Visualizar Configuraciones 
 #Abre el archivo de configuraciones
-> git config --global -e
 #En forma de listado
-> git config --global -l

Visualizar cambios realizados
 #Cambios que se realizaron en los archivos 
-> git diff
 #para ver los cambios en el STAGED
->git diff --staged

Sacando archivos del Stage
-> git reset HEAD nombreArchivo

GIT COMMIT
#Agregar staged y hacer commit 
-> git commit -am "readme actualizado"
#Modificar el mensaje del ultimo commit 
-> git commit --amend -m "Se actualizo el readme"

HEAD apunto al ultimo commit -> HEAD^ antes del ultimo commit 
-> git reset -- soft HEAD^

Comando para remover advertencia molesta "warning:LF will be replace by CRFL in history.md"
-> git config core.autocrlf true

Salir de edito de linux 
-> presionar la letra "a"  --> para escribir 
-> para salir del modo escritura presionar "ESC"
-> para guardar los cambios presionar ":wq"

Recuperar datos 
-> git reflog
 #Regresa los datos pregunta que archivos seran borrados o modificados
-> git reset --mixed (id)
 #Se destruye todo lo anterior a ese punto 
-> git reset --hard 

Cambiar nombre y eliminar archivos
#Renombrado archivos
-> git mv noombreArchivo nuevoNombre 
#Eliminado archivos
-> git rm nombrearchivo 

Renombrado archivo (No comandos)
 1.Actualizando archivos 
-> git add -u
 2.Agregamos los archivos
-> git add -A
 3.Agergamos el mensaje 
-> git commit -m "mi mensaje" 

Borrando archivos (No comandos)
 1. Elimnar archivo
 -> git add -u 
 -> git commit -m ""
 
 /**************************************RAMAS******************************************************************************
 Rama -> linea de tiempo de commits, nuevas funciones. 
  
 Tipos de merge 
-> FAST-FORWARD 		#se dispara cuando no hay cambios en la rama principal, hace merge tranparente 
-> Uniones automaticas 	#No existen conflictos y lo realiza de forma automatica
-> Manual 				#Solucionar conflicto de manera manual

Crear ramas 
-> git branch nombreRama
Mostrar Ramas
-> git branch
Cambiar de rama
-> git checkout nombreRama
Revisar Diferencias entre ramas
-> git diff nombreRama master

/********************************Funcionar Ramas*********************************************************************************************
#Posionarse en la rama a fusionar
-> git checkout nomgit breRama[master]
-> git merge nombreRama[rama-trabajada]

#Eliminar Ramas recomendable borrarla
-> git branch -d ramaABorrar

#Crear rama y posiocionarse inmediantamente 
-> git checkout -b nombre-rama

al realizar un merge automatico envia la siguiente leyenda. 
-> Merge made by the 'recursive' strategy.

Creando Tags
-> git tag nombreTag
Borrando Tags
-> git tag -d nombreTag
Mostrando info de los tag
-> git show nombreTag
Creando tag de los id
-> git tag -a nombreTag -m "mensaje del tag"


/***************************************Stash 


/****************************************Git Remote, push pull ********************************************************************************************

git remote       add                  origin               https://github.com/algo
    Comando   Nuevo Remoto    Nombre de nuestro remoto      direccion de github
	
#revisar repositorios remotos 
git remote -v 

git push -u origin      master 
            nombre  nombre de rama
			
#Subiendo tags al repositorio 
git push --tags

#Bajar cambios 
git pull 
# En caso de no haber agregado (git push -u origin master)
git pull origin remote 

#Clonando un repositorio 
git clone url 
#Renombrando al clonar 
git clone url nombreNuevo

#Actualiza localmente los cambios que hay en el reposotorio remoto 
git fech 


# eliminar archivo fuera de stage (simulacion)
git clean -n 

#Eliminar archivos definitivamente
git clean -f 

 # ver ramas remotas 
git branch -r 

#Ver todas las ramas remotas y locales 
git branch -a 
