import json
import os
from pathlib import Path

from dotenv import load_dotenv
from openai import OpenAI

from semantic_search import index_books, search_books
from tools import get_summary_by_title

load_dotenv()

api_key = os.getenv("OPENAI_API_KEY")
if not api_key:
    print("API key not found in .env")
    raise SystemExit(1)

client = OpenAI(api_key=api_key)

SYSTEM_PROMPT = """
You are a smart librarian assistant.

Your tasks:
1. Use the retrieved context from the vector store to recommend the best matching book.
2. After choosing a book title, call the function get_summary_by_title with the exact title.
3. After the tool returns the detailed summary, answer in English.
4. Keep the response conversational and helpful.

Rules:
- Recommend one main book.
- Use the exact title from the retrieved context when calling the tool.
- Mention briefly why the book matches the user's interests.
- Then include the detailed summary returned by the tool.
"""

TOOLS = [
    {
        "type": "function",
        "name": "get_summary_by_title",
        "description": "Returns the full summary for an exact book title.",
        "parameters": {
            "type": "object",
            "properties": {
                "title": {
                    "type": "string",
                    "description": "The exact title of the recommended book, for example 1984 or The Hobbit"
                }
            },
            "required": ["title"],
            "additionalProperties": False
        },
        "strict": True
    }
]

BAD_WORDS = {
    "stupid",
    "idiot",
    "dumb",
    "fool",
    "damn",
    "hell"
}


def contains_offensive_language(text: str) -> bool:
    text = text.lower()
    return any(word in text for word in BAD_WORDS)


def build_context(retrieved_docs: list[str]) -> str:
    if not retrieved_docs:
        return "No relevant documents found."

    return "\n\n".join(
        f"[Document {idx}]\n{doc}" for idx, doc in enumerate(retrieved_docs, start=1)
    )


def run_tool(tool_name: str, arguments_json: str) -> str:
    args = json.loads(arguments_json)

    if tool_name == "get_summary_by_title":
        title = args.get("title")
        if not title:
            return "No valid book title was provided."
        return get_summary_by_title(title)

    return f"Unknown tool: {tool_name}"


def ask_chatbot(user_query: str) -> str:
    if contains_offensive_language(user_query):
        return (
            "Please use respectful language. "
            "I can help you with book recommendations if you rephrase your message."
        )

    retrieved_docs = search_books(user_query, n_results=3)
    context = build_context(retrieved_docs)

    first_response = client.responses.create(
        model="gpt-4.1",
        tools=TOOLS,
        tool_choice="required",
        input=[
            {
                "role": "system",
                "content": SYSTEM_PROMPT
            },
            {
                "role": "user",
                "content": (
                    f"User question: {user_query}\n\n"
                    f"Context retrieved from vector store:\n{context}\n\n"
                    "Do not answer the user yet. "
                    "First, choose a single suitable book from the context and "
                    "call the tool get_summary_by_title with the exact title."
                )
            }
        ]
    )

    function_calls = [
        item for item in first_response.output
        if item.type == "function_call"
    ]

    if not function_calls:
        return first_response.output_text

    tool_outputs = []
    for call in function_calls:
        result = run_tool(call.name, call.arguments)
        tool_outputs.append(
            {
                "type": "function_call_output",
                "call_id": call.call_id,
                "output": result
            }
        )

    second_response = client.responses.create(
        model="gpt-4.1",
        tools=TOOLS,
        input=tool_outputs,
        previous_response_id=first_response.id
    )

    return second_response.output_text


def text_to_speech(text: str, output_file: str = "recommendation.mp3") -> str:
    """
    Generates an MP3 audio file from text using OpenAI TTS.
    """
    speech_file_path = Path(output_file)

    with client.audio.speech.with_streaming_response.create(
        model="gpt-4o-mini-tts",
        voice="coral",
        input=text,
        instructions="Speak clearly, warm, and friendly in English."
    ) as response:
        response.stream_to_file(speech_file_path)

    return str(speech_file_path.resolve())


def main():
    print("Smart Librarian started.")
    print("Type 'exit' to quit.")
    print("Note: the generated voice is AI, not a human voice.\n")

    index_books("books.txt")

    while True:
        user_query = input("You: ").strip()

        if user_query.lower() in {"exit", "quit"}:
            print("Goodbye!")
            break

        if not user_query:
            continue

        try:
            answer = ask_chatbot(user_query)
            print(f"\nBot: {answer}\n")

            want_audio = input("Do you want the audio version? (yes/no): ").strip().lower()

            if want_audio in {"yes", "y"}:
                audio_path = text_to_speech(answer, "recommendation.mp3")
                print(f"Audio saved at: {audio_path}")

                # Windows: open with default player
                os.startfile(audio_path)

        except Exception as exc:
            print(f"\nError: {exc}\n")


if __name__ == "__main__":
    main()