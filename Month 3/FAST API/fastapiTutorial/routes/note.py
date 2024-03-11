from fastapi import APIRouter, Request
from models.note import Note
from config.db import conn
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates


note = APIRouter()
templates = Jinja2Templates(directory="templates")


@note.get("/", response_class=HTMLResponse)
async def read_item(request: Request):
    notes = conn.notes.notes.find({})
    notesList = []
    for note in notes:
        notesList.append({
            "_id": note["_id"],
            "title": note["title"],
            "desc": note["desc"]
        })
    return templates.TemplateResponse(
        "index.html",
        {"request": request, "notes": notesList}
    )
