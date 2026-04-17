import streamlit as st
import requests

API_URL = "http://127.0.0.1:8000/chat"
TTS_URL = "http://127.0.0.1:8000/tts"

st.set_page_config(page_title="Smart Librarian", page_icon="📚")

st.title("Smart Librarian")
st.write("Tell me what kind of book you're looking for and I’ll recommend one!")

if "messages" not in st.session_state:
    st.session_state.messages = []

user_input = st.text_input("You:", "")

if st.button("Send") and user_input:
    st.session_state.messages.append(("user", user_input))

    with st.spinner("Searching for the best recommendation..."):
        response = requests.post(API_URL, json={"message": user_input})

        if response.status_code == 200:
            answer = response.json()["answer"]
        else:
            answer = "Server error."

    st.session_state.messages.append(("bot", answer))

for role, msg in st.session_state.messages:
    if role == "user":
        st.markdown(f"**You:** {msg}")
    else:
        st.markdown(f"**Bot:** {msg}")

        if st.button("Listen", key=msg):
            tts_response = requests.post(TTS_URL, json={"text": msg})
            if tts_response.status_code == 200:
                audio_bytes = tts_response.content
                st.audio(audio_bytes, format="audio/mp3")