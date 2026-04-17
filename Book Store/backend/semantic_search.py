import os
from dotenv import load_dotenv
from openai import OpenAI
import chromadb

load_dotenv()

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

# Local persistent ChromaDB
chroma_client = chromadb.PersistentClient(path="chroma_db")
collection = chroma_client.get_or_create_collection(name="books_collection")


def read_text_file(path: str) -> str:
    with open(path, "r", encoding="utf-8") as file:
        return file.read()


def split_by_title(text: str) -> list[str]:
    parts = text.split("## Title:")
    documents = []

    for part in parts:
        part = part.strip()
        if part:
            documents.append("## Title: " + part)

    return documents


def index_books(file_path: str = "books.txt") -> None:
    text = read_text_file(file_path)
    documents = split_by_title(text)

    if not documents:
        raise ValueError("No books found in books.txt")

    response = client.embeddings.create(
        model="text-embedding-3-small",
        input=documents
    )

    embeddings = [item.embedding for item in response.data]

    existing = collection.get()
    if existing["ids"]:
        collection.delete(ids=existing["ids"])

    for i, doc in enumerate(documents):
        collection.add(
            ids=[str(i)],
            documents=[doc],
            embeddings=[embeddings[i]]
        )

    print("Data successfully stored in ChromaDB")


def search_books(query: str, n_results: int = 3) -> list[str]:
    query_embedding = client.embeddings.create(
        model="text-embedding-3-small",
        input=query
    ).data[0].embedding

    results = collection.query(
        query_embeddings=[query_embedding],
        n_results=n_results
    )

    docs = results.get("documents", [])
    if not docs or not docs[0]:
        return []

    return docs[0]


if __name__ == "__main__":
    index_books()
    sample_results = search_books("a book about freedom and social control")
    print("\nSearch results:")
    for doc in sample_results:
        print("\n-------------------")
        print(doc)