class Actividad {
    const property idiomas = #{}

    method esInteresante() = idiomas.size() > 1
    method sirveParaBroncearse() = true
    method dias()
    method implicaEsfuerzo() = true
}

class ViajeDePlaya inherits Actividad {
    const largo

    override method dias() = largo / 500
    override method implicaEsfuerzo() = largo > 1200
}

class ExcursionACiudad inherits Actividad {
    const property cantidadActracciones

    override method dias() = cantidadActracciones / 2
    override method sirveParaBroncearse() = false
    override method implicaEsfuerzo() = cantidadActracciones.between(5, 8)
    override method esInteresante() = super() || cantidadActracciones == 5
}

class ExcursionTropical inherits ExcursionACiudad {
    override method dias() = super() + 1
    override method sirveParaBroncearse() = true
}

class SalidaDeTrekking inherits Actividad {
    const kilometros
    const diasDeSol

    override method dias() = kilometros / 50
    override method implicaEsfuerzo() = kilometros > 80
    override method sirveParaBroncearse() {
        return diasDeSol > 200 || (diasDeSol.between(100, 200) && kilometros > 120)
    }
    override method esInteresante() = super() && diasDeSol > 140
}

class ClaseDeGimnasia inherits Actividad {
    method initialize() {
        idiomas.clear()
        idiomas.add("español")
    }
    method validador() {
        if (!idiomas == #{"español"}) {
            self.error("El único idioma disponible es Español")
        }
    }
    override method dias() = 1
    override method sirveParaBroncearse() = false
}

class Socio {
    const property actividades = []
    const maximoActividades
    var edad
    const idiomasQueHabla = #{}

    method initialize() {
        actividades.clear()
    }
    method registrarActividad(unaActividad) {
        if (maximoActividades == actividades.size()) {
            self.error("El socio alcanzó el máximo de actividades")
        }
        actividades.add(unaActividad)
    }
    method esAdoradorDelSol() = actividades.all({a => a.sirveParaBroncearse()})
    method actividadesEsforzadas() = actividades.filter({a => a.implicaEsfuerzo()})
    method leAtrae(unaActividad)
}

class SocioTranquilo inherits Socio {
    override method leAtrae(unaActividad) = unaActividad.dias() >= 4
}

class SocioCoherente inherits Socio {
    override method leAtrae(unaActividad) {
        return 
            if (self.esAdoradorDelSol()) {
                unaActividad.sirveParaBroncearse()
            } else {
                unaActividad.implicaEsfuerzo()
            }
    }
}

class SocioRelajado inherits Socio {
    override method leAtrae(unaActividad) {
        return
            not idiomasQueHabla.intersection(unaActividad.idiomas()).isEmpty()
    }
}