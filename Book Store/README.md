# Smart Librarian – RAG Chatbot

## Overview

Smart Librarian is an AI chatbot that recommends books based on user interests.  
It uses a Retrieval-Augmented Generation approach combined with a vector database and OpenAI models.

The goal is to return relevant book suggestions and provide clear explanations together with full summaries.

---

## Data

The project uses:
- A text file `books.txt` with short summaries  
- A Python dictionary with detailed summaries  

All data is processed and converted into embeddings for semantic search.

---

## Architecture

Main components:
- ChromaDB for vector storage  
- OpenAI embeddings for similarity search  
- GPT model for response generation  
- Custom tool for retrieving full summaries  
- Streamlit for the UI  

---

## How It Works

1. User sends a query  
2. Query is transformed into embeddings  
3. ChromaDB returns relevant books  
4. Context is sent to the GPT model  
5. Model selects the best match  
6. Tool is called to get the full summary  
7. Final response is returned  

---

## Tool

`get_summary_by_title(title: str)`  
Returns the full summary of a book using the exact title.

---

## Features

- Semantic recommendations  
- Tool calling for detailed summaries  
- Basic offensive language filtering  
- Optional text-to-speech  
- Simple Streamlit interface  


---

## Run the Project

Start backend:
uvicorn api:app --reload

Start frontend:
streamlit run app.py

Open:
http://localhost:8501


---

## Example Queries

- "Recommend a book about friendship"  
- "What is 1984?"  
- "Give me a fantasy story"  