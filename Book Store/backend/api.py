from pathlib import Path

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse
from pydantic import BaseModel

from chatbot import ask_chatbot, text_to_speech
from semantic_search import index_books

app = FastAPI(title="Smart Librarian API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # pentru dev; în producție pui doar frontend-ul tău
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

indexed = False


class ChatRequest(BaseModel):
    message: str


class ChatResponse(BaseModel):
    answer: str


class TTSRequest(BaseModel):
    text: str


@app.on_event("startup")
def startup_event():
    global indexed
    if not indexed:
        index_books("books.txt")
        indexed = True


@app.get("/")
def root():
    return {"message": "Smart Librarian API is running"}


@app.post("/chat", response_model=ChatResponse)
def chat(request: ChatRequest):
    message = request.message.strip()
    if not message:
        raise HTTPException(status_code=400, detail="Mesajul nu poate fi gol.")

    try:
        answer = ask_chatbot(message)
        return ChatResponse(answer=answer)
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc))


@app.post("/tts")
def tts(request: TTSRequest):
    text = request.text.strip()
    if not text:
        raise HTTPException(status_code=400, detail="Textul nu poate fi gol.")

    try:
        output_file = "recommendation.mp3"
        audio_path = text_to_speech(text, output_file)
        return FileResponse(
            path=audio_path,
            media_type="audio/mpeg",
            filename=Path(audio_path).name
        )
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc))