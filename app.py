from flask import Flask, request, render_template, send_file
import FreeCAD, Part, Mesh
import os

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/create_cube", methods=["POST"])
def create_cube():
    width = float(request.form.get("width", 10.0))
    height = float(request.form.get("height", 5.0))
    depth = float(request.form.get("depth", 2.5))

    # Создаём новый документ
    doc = FreeCAD.newDocument("CubeDoc")
    box = Part.makeBox(width, height, depth)
    obj = doc.addObject("Part::Feature", "MyBox")
    obj.Shape = box
    doc.recompute()

    # Экспортируем в STL
    output_file = "cube_output.stl"
    Mesh.export([obj], output_file)

    FreeCAD.closeDocument("CubeDoc")

    return send_file(output_file, as_attachment=True)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
