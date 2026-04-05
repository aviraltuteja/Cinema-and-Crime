"""
Cinema & Crime India — pipeline entry point.
Run `uv run main.py` to verify the environment is set up correctly.
"""

import sys


def check_imports() -> None:
    packages = [
        ("dspy", "DSPy"),
        ("litellm", "LiteLLM"),
        ("openai", "OpenAI"),
        ("anthropic", "Anthropic"),
        ("sentence_transformers", "Sentence Transformers"),
        ("requests", "requests"),
        ("aiohttp", "aiohttp"),
        ("bs4", "BeautifulSoup4"),
        ("playwright", "Playwright"),
        ("pandas", "pandas"),
        ("numpy", "numpy"),
        ("psycopg2", "psycopg2"),
        ("pgvector", "pgvector"),
        ("tmdbsimple", "tmdbsimple"),
        ("imdb", "cinemagoer"),
        ("statsmodels", "statsmodels"),
        ("scipy", "scipy"),
        ("sklearn", "scikit-learn"),
        ("linearmodels", "linearmodels"),
        ("matplotlib", "matplotlib"),
        ("seaborn", "seaborn"),
        ("plotly", "plotly"),
    ]

    all_ok = True
    for module, name in packages:
        try:
            __import__(module)
            print(f"  ✓ {name}")
        except ImportError as e:
            print(f"  ✗ {name}: {e}")
            all_ok = False

    if all_ok:
        print("\nAll packages imported successfully.")
    else:
        print("\nSome packages failed to import.")
        sys.exit(1)


if __name__ == "__main__":
    print(f"Python {sys.version}\n")
    check_imports()
