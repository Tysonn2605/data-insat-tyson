import chess.pgn
import pandas as pd
import io
import numpy as np

# --- CONFIGURATION ---
TARGET_PLAYER = "Tyson2605" # <--- SAME NAME AS STEP 1
INPUT_FILE = f"{TARGET_PLAYER}_raw.pgn"

def parse_time_control(tc_string):
    """Classifies time control into Bullet, Blitz, Rapid, Classical"""
    try:
        seconds = int(tc_string.split('+')[0])
        if seconds < 180: return "Bullet"
        elif seconds < 600: return "Blitz"
        elif seconds < 3600: return "Rapid"
        else: return "Classical"
    except:
        return "Unknown"

def process_data():
    print(f"--- PARSING DATA FOR: {TARGET_PLAYER} ---")
    
    games_list = []
    
    with open(INPUT_FILE, "r") as f:
        while True:
            game = chess.pgn.read_game(f)
            if game is None:
                break
            
            headers = game.headers
            
            # Identify User's Color and Elo
            if headers["White"].lower() == TARGET_PLAYER.lower():
                user_color = "White"
                user_elo = headers.get("WhiteElo", "0")
                opp_elo = headers.get("BlackElo", "0")
                result = headers["Result"] # 1-0 means White (User) won
                if result == "1-0": user_score = 1.0
                elif result == "0-1": user_score = 0.0
                else: user_score = 0.5
            else:
                user_color = "Black"
                user_elo = headers.get("BlackElo", "0")
                opp_elo = headers.get("WhiteElo", "0")
                result = headers["Result"]
                if result == "0-1": user_score = 1.0
                elif result == "1-0": user_score = 0.0
                else: user_score = 0.5

            # Clean Elo Data (Remove '?' or non-numeric)
            try: user_elo = int(user_elo)
            except: user_elo = np.nan
            try: opp_elo = int(opp_elo)
            except: opp_elo = np.nan

            games_list.append({
                "Date": headers["Date"],
                "Time_Control": parse_time_control(headers.get("TimeControl", "")),
                "User_Elo": user_elo,
                "Opp_Elo": opp_elo,
                "User_Score": user_score,
                "User_Color": user_color,
                "Termination": headers.get("Termination", ""),
                "PGN": str(game) # Keeping raw game for engine analysis later
            })

    df = pd.DataFrame(games_list)
    
    # --- CLEANING ---
    # Drop games with no Elo data (unrated games)
    df = df.dropna(subset=["User_Elo", "Opp_Elo"])
    
    # Filter for Rapid/Blitz only (ignoring Bullet/Daily for personality profiling)
    # We focus on Rapid usually as it balances intuition and calculation best.
    rapid_df = df[df["Time_Control"] == "Rapid"]
    
    # --- REPORT GENERATION ---
    print("\n=== PRELIMINARY DATA REPORT ===")
    print(f"Total Valid Games: {len(df)}")
    print(f"Rapid Games: {len(rapid_df)}")
    
    if len(rapid_df) > 0:
        current_elo = rapid_df.iloc[-1]["User_Elo"]
        peak_elo = rapid_df["User_Elo"].max()
        
        # Calculate 'Performance' in Wins
        # Average Elo of opponents defeated
        wins = rapid_df[rapid_df["User_Score"] == 1.0]
        avg_opp_elo_defeated = wins["Opp_Elo"].mean()
        
        print(f"Current Listed Elo: {current_elo}")
        print(f"Peak Listed Elo: {peak_elo}")
        print(f"Avg Elo of Opponents Defeated: {avg_opp_elo_defeated:.0f}")
        
        # Win Rate vs Higher Rated Players
        # This is a key indicator of 'Underrated' status
        upsets = rapid_df[(rapid_df["Opp_Elo"] > rapid_df["User_Elo"]) & (rapid_df["User_Score"] == 1.0)]
        total_higher = rapid_df[rapid_df["Opp_Elo"] > rapid_df["User_Elo"]]
        
        if len(total_higher) > 0:
            upset_rate = (len(upsets) / len(total_higher)) * 100
            print(f"Win Rate vs Higher Rated Players: {upset_rate:.1f}%")
        
    else:
        print("No Rapid games found. We might need to look at Blitz.")

    # Save cleaned data for Step 3
    df.to_csv(f"{TARGET_PLAYER}_cleaned.csv", index=False)
    print(f"\nCleaned data saved to {TARGET_PLAYER}_cleaned.csv")

if __name__ == "__main__":
    process_data()