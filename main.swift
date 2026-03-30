import Foundation

// Clase Estudiante
class Estudiante {
    let id: Int
    var nombre: String
    var edad: Int
    var materias: Set<String>
    var calificaciones: [String: Double]

    init(id: Int, nombre: String, edad: Int) {
        self.id = id
        self.nombre = nombre
        self.edad = edad
        self.materias = []
        self.calificaciones = [:]
    }

    // Asignar materia
    func asignarMateria(_ materia: String) {
        materias.insert(materia)
    }

    // Registrar calificación
    func registrarCalificacion(materia: String, nota: Double) {
        if materias.contains(materia) {
            calificaciones[materia] = nota
        } else {
            print("⚠️ El estudiante no tiene asignada la materia \(materia).")
        }
    }

    // Calcular promedio
    func calcularPromedio() -> Double {
        if calificaciones.isEmpty {
            return 0.0
        }

        var suma: Double = 0.0

        for nota in calificaciones.values {
            suma += nota
        }

        return suma / Double(calificaciones.count)
    }

    // Mostrar información
    func mostrarInformacion() {
        print("\n===== INFORMACIÓN DEL ESTUDIANTE =====")
        print("ID: \(id)")
        print("Nombre: \(nombre)")
        print("Edad: \(edad)")

        print("Materias asignadas:")
        if materias.isEmpty {
            print("  No tiene materias registradas.")
        } else {
            for materia in materias {
                print("  - \(materia)")
            }
        }

        print("Calificaciones:")
        if calificaciones.isEmpty {
            print("  No tiene calificaciones registradas.")
        } else {
            for (materia, nota) in calificaciones {
                print("  - \(materia): \(nota)")
            }
        }

        print(String(format: "Promedio: %.2f", calcularPromedio()))
        print("=====================================\n")
    }
}

// Clase Sistema
class SistemaGestionEstudiantes {
    var estudiantes: [Estudiante] = []

    // Registrar estudiante
    func registrarEstudiante(id: Int, nombre: String, edad: Int) {
        for estudiante in estudiantes {
            if estudiante.id == id {
                print("⚠️ Ya existe un estudiante con ese ID.")
                return
            }
        }

        let nuevoEstudiante = Estudiante(id: id, nombre: nombre, edad: edad)
        estudiantes.append(nuevoEstudiante)
        print("✅ Estudiante registrado correctamente.")
    }

    // Buscar estudiante por ID
    func buscarEstudiantePorID(_ id: Int) -> Estudiante? {
        for estudiante in estudiantes {
            if estudiante.id == id {
                return estudiante
            }
        }
        return nil
    }

    // Mostrar todos los estudiantes
    func mostrarTodosLosEstudiantes() {
        if estudiantes.isEmpty {
            print("No hay estudiantes registrados.")
            return
        }

        print("\n===== LISTA DE ESTUDIANTES =====")
        for estudiante in estudiantes {
            print("ID: \(estudiante.id) | Nombre: \(estudiante.nombre) | Edad: \(estudiante.edad)")
        }
        print("================================\n")
    }
}

// Función para leer entero
func leerEntero(mensaje: String) -> Int {
    while true {
        print(mensaje, terminator: "")
        if let entrada = readLine(), let numero = Int(entrada) {
            return numero
        }
        print("⚠️ Debes ingresar un número entero válido.")
    }
}

// Función para leer decimal
func leerDouble(mensaje: String) -> Double {
    while true {
        print(mensaje, terminator: "")
        if let entrada = readLine(), let numero = Double(entrada) {
            return numero
        }
        print("⚠️ Debes ingresar un número válido.")
    }
}

// Función para leer texto
func leerTexto(mensaje: String) -> String {
    while true {
        print(mensaje, terminator: "")
        if let entrada = readLine(), !entrada.trimmingCharacters(in: .whitespaces).isEmpty {
            return entrada
        }
        print("⚠️ No puedes dejar este campo vacío.")
    }
}

// Programa principal
let sistema = SistemaGestionEstudiantes()
var opcion = 0

while opcion != 7 {
    print("""
    ===== SISTEMA DE GESTIÓN DE ESTUDIANTES =====
    1. Registrar estudiante
    2. Asignar materia
    3. Registrar calificación
    4. Calcular promedio de un estudiante
    5. Mostrar información de un estudiante
    6. Mostrar todos los estudiantes
    7. Salir
    =============================================
    """)

    opcion = leerEntero(mensaje: "Seleccione una opción: ")

    switch opcion {
    case 1:
        let id = leerEntero(mensaje: "Ingrese ID del estudiante: ")
        let nombre = leerTexto(mensaje: "Ingrese nombre del estudiante: ")
        let edad = leerEntero(mensaje: "Ingrese edad del estudiante: ")
        sistema.registrarEstudiante(id: id, nombre: nombre, edad: edad)

    case 2:
        let id = leerEntero(mensaje: "Ingrese ID del estudiante: ")
        if let estudiante = sistema.buscarEstudiantePorID(id) {
            let materia = leerTexto(mensaje: "Ingrese nombre de la materia: ")
            estudiante.asignarMateria(materia)
            print("✅ Materia asignada correctamente.")
        } else {
            print("⚠️ Estudiante no encontrado.")
        }

    case 3:
        let id = leerEntero(mensaje: "Ingrese ID del estudiante: ")
        if let estudiante = sistema.buscarEstudiantePorID(id) {
            let materia = leerTexto(mensaje: "Ingrese nombre de la materia: ")
            let nota = leerDouble(mensaje: "Ingrese la calificación: ")

            if nota >= 0 && nota <= 100 {
                estudiante.registrarCalificacion(materia: materia, nota: nota)
                print("✅ Calificación registrada correctamente.")
            } else {
                print("⚠️ La nota debe estar entre 0 y 100.")
            }
        } else {
            print("⚠️ Estudiante no encontrado.")
        }

    case 4:
        let id = leerEntero(mensaje: "Ingrese ID del estudiante: ")
        if let estudiante = sistema.buscarEstudiantePorID(id) {
            let promedio = estudiante.calcularPromedio()
            print(String(format: "✅ El promedio de %@ es: %.2f", estudiante.nombre, promedio))
        } else {
            print("⚠️ Estudiante no encontrado.")
        }

    case 5:
        let id = leerEntero(mensaje: "Ingrese ID del estudiante: ")
        if let estudiante = sistema.buscarEstudiantePorID(id) {
            estudiante.mostrarInformacion()
        } else {
            print("⚠️ Estudiante no encontrado.")
        }

    case 6:
        sistema.mostrarTodosLosEstudiantes()

    case 7:
        print("👋 Saliendo del sistema...")

    default:
        print("⚠️ Opción inválida. Intente nuevamente.")
    }
}