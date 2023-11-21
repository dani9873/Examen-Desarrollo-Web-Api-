//dependencias
const express = require('express');
const app = express();
const dotenv = require('dotenv');
const { default: helmet } = require('helmet');
const morgan = require('morgan');
const mysql = require('mysql');
dotenv.config();
var connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASWORD,
    database: process.env.DB
});
//conexion
connection.connect(() => { console.log('Conexion exitosa a MySQL') })
app.use(express.json()); 
app.use(helmet());
app.use(morgan('common'));
//ruta
app.listen(8800, () => { console.log('API FUNCIONANDO, PID =' + process.pid) });
app.get("/apiumg/v1/estudiante/:nombre", (req, res) => {
    const nombre = req.params.nombre;
    const query = `
        SELECT e.idestudiante, e.nombre, e.direccion, c.nombre_carrera as nombre_carrera, s.nombre_sede as nombre_sede
        FROM estudiante e
        INNER JOIN carrera c ON e.idcarrera = c.idcarrera
        INNER JOIN sede s ON e.idsede = s.idsede
        WHERE e.nombre LIKE ?
    `;
    connection.query(query, `%${nombre}%`, function(error, rows, fields) {
        if (error) {
            res.status(500).json({ error: "Error al buscar al estudiante por nombre" });
        } else {
            res.status(200).json(rows);
        }
    });
});
app.post("/apiumg/v1/estudiante", (req, res) => {
    const { nombre, carne, fecha_nacimiento, cursos_aprobados, direccion, idcarrera, idsede } = req.body;
    const query = 'INSERT INTO estudiante (nombre, carne, fecha_nacimiento, cursos_aprobados, direccion, idcarrera, idsede) VALUES (?, ?, ?, ?, ?, ?, ?)';
    connection.query(query, [nombre, carne, fecha_nacimiento, cursos_aprobados, direccion, idcarrera, idsede], function(error, rows, fields) {
        if (error) {
            res.status(500).json({ error: "Error al crear al estudiante" });
        } else {
            res.status(201).json({ message: "Estudiante creado con éxito" });
        }
    });
});
app.delete("/apiumg/v1/estudiante/:id", (req, res) => {
    const id = req.params.id;
    const query = 'DELETE FROM estudiante WHERE idestudiante = ?';
    connection.query(query, id, function(error, result) {
        if (error) {
            res.status(500).json({ error: "Error al eliminar al estudiante" });
        } else {
            if (result.affectedRows === 0) {
                res.status(404).json({ message: "No se encontró al estudiante para eliminar" });
            } else {
                res.status(200).json({ message: "Estudiante eliminado exitosamente" });
            }
        }
    });
});
app.put("/apiumg/v1/estudiante/:id", (req, res) => {
    const id = req.params.id;
    const estudiante = req.body;

    const query = 'UPDATE estudiante SET nombre = ?, carne = ?, fecha_nacimiento = ?, cursos_aprobados = ?, direccion = ?, idcarrera = ?, idsede = ? WHERE idestudiante = ?';
    connection.query(query, [estudiante.nombre, estudiante.carne, estudiante.fecha_nacimiento, estudiante.cursos_aprobados, estudiante.direccion, estudiante.idcarrera, estudiante.idsede, id], function(error, result) {
        if (error) {
            res.status(500).json({ error: "Error al actualizar al estudiante" });
        } else {
            if (result.affectedRows === 0) {
                res.status(404).json({ message: "No se encontró al estudiante para actualizar" });
            } else {
                res.status(200).json({ message: "Estudiante actualizado exitosamente" });
            }
        }
    });
});
