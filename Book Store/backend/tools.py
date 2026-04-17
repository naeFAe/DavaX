book_summaries_dict = {
    "1984": (
        "George Orwell's novel depicts a dystopian society under total state control. "
        "People are constantly monitored by Big Brother, and independent thinking is considered a crime. "
        "Winston Smith, the main character, tries to resist this oppressive regime. "
        "It is a story about freedom, truth, and ideological manipulation."
    ),
    "The Hobbit": (
        "Bilbo Baggins, a quiet and comfort-loving hobbit, is drawn into an unexpected adventure with a group of dwarves. "
        "Their mission is to recover a treasure guarded by the dragon Smaug. "
        "Along the journey, Bilbo discovers his courage, intelligence, and ability to face danger. "
        "The story emphasizes adventure, friendship, and personal growth."
    ),
    "To Kill a Mockingbird": (
        "The novel follows the childhood of Scout Finch in the southern United States during a time of racial discrimination. "
        "Her father, Atticus Finch, defends a Black man wrongly accused of a crime. "
        "The book explores justice, prejudice, and the loss of innocence. "
        "It is a powerful story about morality and empathy."
    ),
    "Pride and Prejudice": (
        "Elizabeth Bennet navigates social norms and the pressures of marriage in 19th-century England. "
        "Her relationship with Mr. Darcy evolves from misunderstanding and pride to mutual respect and love. "
        "The novel examines class differences, pride, and prejudice. "
        "It is a classic story about love and personal growth."
    ),
    "The Great Gatsby": (
        "Jay Gatsby, a mysterious millionaire, throws extravagant parties in hopes of winning back his lost love, Daisy. "
        "The novel captures the fascination with wealth and the illusion of the American Dream. "
        "Through the relationships between characters, the story highlights the contrast between appearance and reality. "
        "It is a tale of ambition, love, and disillusionment."
    ),
    "Harry Potter and the Sorcerer's Stone": (
        "Harry Potter discovers he is a wizard and begins his studies at Hogwarts, where he makes friends and learns about his past. "
        "At the same time, he faces his first challenges in the magical world. "
        "The novel combines adventure, friendship, and the battle between good and evil. "
        "It marks the beginning of a magical coming-of-age journey."
    ),
    "The Catcher in the Rye": (
        "Holden Caulfield, a rebellious teenager, wanders through New York after being expelled from school. "
        "As he reflects on the world around him, he expresses his frustration with the hypocrisy of society. "
        "The novel captures alienation, confusion, and the difficulty of growing up. "
        "It is an intense exploration of identity crisis."
    ),
    "The Alchemist": (
        "Santiago, a young shepherd, embarks on a journey to find a treasure and fulfill his personal destiny. "
        "Along the way, he learns to follow his dreams and interpret the signs of life. "
        "The novel blends adventure with spirituality and self-discovery. "
        "It is a story about having the courage to follow one's path."
    ),
    "Brave New World": (
        "The novel presents a futuristic society where people are controlled through pleasure, conditioning, and genetic engineering. "
        "Behind the appearance of stability lies the loss of freedom and individuality. "
        "Characters who question the system reveal the human cost of absolute comfort. "
        "The book explores social control, technology, and individual freedom."
    ),
    "The Lord of the Rings: The Fellowship of the Ring": (
        "Frodo Baggins is entrusted with the mission of destroying a powerful ring that threatens the entire world. "
        "Together with a fellowship of friends and allies, he embarks on a dangerous journey. "
        "The novel highlights sacrifice, friendship, and the battle between good and evil. "
        "It is an epic adventure about responsibility and courage."
    ),
}

def normalize_title(title: str) -> str:
    return (
        title.strip()
        .strip('"')
        .strip("'")
        .strip("“”")
        .strip("‘’")
        .rstrip(".")
        .replace("’", "'")
        .replace("‘", "'")
        .replace("“", '"')
        .replace("”", '"')
    )


def get_summary_by_title(title: str) -> str:
    normalized_title = normalize_title(title)

    for key, summary in book_summaries_dict.items():
        if normalize_title(key).lower() == normalized_title.lower():
            return summary

    return f"No detailed summary found for the title: {title}"