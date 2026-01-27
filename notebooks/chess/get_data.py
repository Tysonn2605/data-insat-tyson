import requests
import json
import time

# --- CONFIGURATION ---
TARGET_PLAYER = "Tyson2605"  # <--- ENTER PLAYER NAME HERE
OUTPUT_FILE = f"{TARGET_PLAYER}_raw.pgn"
USER_AGENT = "ChessPersonalityResearcher_v1.0 (contact: email@example.com)"

def get_archives(username):
    """Fetch list of monthly archives from Chess.com API"""
    headers = {'User-Agent': USER_AGENT}
    url = f"https://api.chess.com/pub/player/{username}/games/archives"
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        return response.json().get("archives", [])
    except Exception as e:
        print(f"Error fetching archives: {e}")
        return []

def download_games():
    print(f"--- INITIALIZING DATA COLLECTION FOR: {TARGET_PLAYER} ---")
    archives = get_archives(TARGET_PLAYER)
    
    if not archives:
        print("No archives found. Check username.")
        return

    print(f"Found {len(archives)} months of history. Downloading...")
    
    total_games = 0
    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        for url in archives:
            try:
                # Politeness delay to prevent API rate limiting
                # time.sleep(0.5) 
                
                headers = {'User-Agent': USER_AGENT}
                response = requests.get(url, headers=headers)
                data = response.json()
                games = data.get("games", [])
                
                for game in games:
                    # We only want the PGN data
                    if "pgn" in game:
                        f.write(game["pgn"] + "\n\n")
                        total_games += 1
                
                print(f"Processed: {url.split('/')[-2]}/{url.split('/')[-1]} ({len(games)} games)")
                
            except Exception as e:
                print(f"Failed to download {url}: {e}")

    print(f"\n--- SUCCESS ---")
    print(f"Total Games Downloaded: {total_games}")
    print(f"Saved to: {OUTPUT_FILE}")

if __name__ == "__main__":
    download_games()