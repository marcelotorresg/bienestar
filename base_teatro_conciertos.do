* BASE DE DATOS PARA 9 DE FEBRERO DE 2020
set more off
clear

* directorio con bases de la ENIGH 2018
global directorio "C:\Users\rsf94\Google Drive\MAESTRÍA ITAM\2do semestre\Bienestar y política social\Bienestar_equipo\data"

* Cargo base gastoshogar
use "$directorio/gastoshogar"

desc
summarize


* Merge con base viviendas
merge m:1 folioviv using "$directorio/viviendas"


*rural o urbano
gen rural_urb = substr(folioviv,3,1)
gen rural = 1 if rural_urb == "6"
replace rural = 0 if rural_urb != "6"
drop rural_urb

*entidad federativa
gen entidad_federativa = substr(folioviv,1,2)

*municipio
gen municipio = substr(ubica_geo,3,3)

*número de integrantes del hogar
gen counter2 = 1
bysort folioviv: egen counter = count(foliohog)


* generamos precio de los bienes
gen precio = gasto/cantidad

* Nos quedamos con bienes y servicios que queremos:
* A004 = Tortilla de maíz (de todo tipo y color)
* A008 = Tortilla de harina
* A012 = Pan blanco
* A015 = Pan para sándwich, hamburguesa, hotdog
* A224 = Cerveza
* A233 = Tequila
* A237 = Bebida alcohólica preparada
* 

keep if inlist(clave,"A004","A008","A012","A015","A224","A233","A237")

* Variables que nos interesan
* keep folioviv foliohog clave tipo_gasto cantidad gasto



* Guardar base final
save "$directorio/base_final"

