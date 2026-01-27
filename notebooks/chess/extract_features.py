import chess.pgn
import pandas as pd
import statistics
from collections import Counter

# --- CONFIGURATION ---
PGN_FILE = "betapdanhcovua_raw.pgn" # Update this to your file from Step 1
TARGET_PLAYER = "betapdanhcovua"

def analyze_style():
    print(f"--- EXTRACTING BEHAVIORAL FEATURES FOR: {TARGET_PLAYER} ---")
    
    games_data = []
    
    with open(PGN_FILE, "r") as f:
        while True:
            game = chess.pgn.read_game(f)
            if game is None:
                break
            
            headers = game.headers
            board = game.board()
            
            # Determine Color
            if headers["White"].lower() == TARGET_PLAYER.lower():
                color = chess.WHITE
            elif headers["Black"].lower() == TARGET_PLAYER.lower():
                color = chess.BLACK
            else:
                continue # Skip games not involving target

            # -- Feature Containers --
            move_count = 0
            queen_trade_move = 100 # Default high number if never traded
            h_pawn_push = False
            g_pawn_push = False
            early_queen_move = False
            first_moves = []
            
            # Replay the game
            for move in game.mainline_moves():
                move_count += 1
                
                # 1. Opening Choice (First 3 moves)
                if move_count <= 6:
                    if board.turn == color:
                        first_moves.append(board.san(move))

                # 2. Aggression: Flank Pawn Pushes (h4/h5 or g4/g5) in Opening
                if move_count <= 20: # First 10 full moves
                    if board.turn == color:
                        piece = board.piece_at(move.from_square)
                        if piece and piece.piece_type == chess.PAWN:
                            san = board.san(move)
                            if "h4" in san or "h5" in san: h_pawn_push = True
                            if "g4" in san or "g5" in san: g_pawn_push = True
                        
                        # 3. Aggression: Early Queen (Scandi/Wayward Queen style)
                        if piece and piece.piece_type == chess.QUEEN:
                            if move_count <= 6: # Queen out in first 3 moves
                                early_queen_move = True

                # Make move
                board.push(move)

                # 4. Trading Habits
                # Check if Queens just disappeared
                if queen_trade_move == 100:
                    wQ = len(board.pieces(chess.QUEEN, chess.WHITE))
                    bQ = len(board.pieces(chess.QUEEN, chess.BLACK))
                    if wQ == 0 and bQ == 0:
                        queen_trade_move = (move_count // 2) + 1

            # Store Data
            games_data.append({
                "Total_Moves": (move_count // 2),
                "Queen_Trade_Move": queen_trade_move,
                "Aggressive_h": h_pawn_push,
                "Aggressive_g": g_pawn_push,
                "Early_Queen": early_queen_move,
                "Opening_Signature": "-".join(first_moves) if first_moves else "None"
            })

    df = pd.DataFrame(games_data)
    
    # --- STATISTICAL REPORT ---
    if len(df) == 0:
        print("No games found.")
        return

    avg_game_len = df["Total_Moves"].mean()
    
    # Calculate Trade Rate
    # We only count trades that happened before move 40 (Endgame)
    traded_games = df[df["Queen_Trade_Move"] < 40]
    avg_trade_move = traded_games["Queen_Trade_Move"].mean() if len(traded_games) > 0 else 0
    trade_percentage = (len(traded_games) / len(df)) * 100
    
    # Aggression Rates
    h_push_rate = (len(df[df["Aggressive_h"]==True]) / len(df)) * 100
    g_push_rate = (len(df[df["Aggressive_g"]==True]) / len(df)) * 100
    early_queen_rate = (len(df[df["Early_Queen"]==True]) / len(df)) * 100

    print("\n=== STYLE PROFILE REPORT ===")
    print(f"Games Analyzed: {len(df)}")
    print(f"\n1. PACE & STAMINA")
    print(f"   Avg Game Length: {avg_game_len:.1f} moves")
    print(f"   (Short < 30: Headhunter | Long > 40: Grinder)")

    print(f"\n2. THE PRAGMATIST INDEX (Trading)")
    print(f"   Trades Queens Early (<40 moves): {trade_percentage:.1f}% of games")
    print(f"   Avg Trade Move: {avg_trade_move:.1f}")
    print(f"   (Low Move # = Risk Averse | High Move # = Complicator)")

    print(f"\n3. THE AGGRESSION INDEX")
    print(f"   Caveman h-pawn attacks: {h_push_rate:.1f}%")
    print(f"   Berserker g-pawn attacks: {g_push_rate:.1f}%")
    print(f"   Early Queen Sorties: {early_queen_rate:.1f}%")

    print(f"\n4. OPENING REPERTOIRE")
    print("   Most Common Opening Lines:")
    print(df["Opening_Signature"].value_counts().head(5))

if __name__ == "__main__":
    analyze_style()